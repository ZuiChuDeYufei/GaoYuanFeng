//
//  GJAMapManager.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAMapManager.h"
#import "GJCustomCalloutView.h"

@interface GJAMapManager ()  <AMapSearchDelegate, AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;
@property (assign, nonatomic) CLLocationCoordinate2D destinateLocation;

@end

@implementation GJAMapManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        _arrAnnoViews = @[].mutableCopy;
    }
    return self;
}

//- (void)poiSearchAdress {
//    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
//    request.keywords            = @"北京大学";
//    request.city                = @"北京";
//    request.types               = @"高等院校";
//    request.requireExtension    = YES;
//    //  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。
//    request.cityLimit           = YES;
//    request.requireSubPOIs      = YES;
//    [self.search AMapPOIKeywordsSearch:request];
//}

//- (void)poiSearchAroundWithCurrentLocation {
//    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
//    request.location            = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
//    request.keywords            = @"电影院";
//    // 按照距离排序.
//    request.sortrule            = 0;
//    request.requireExtension    = YES;
//    [self.search AMapPOIAroundSearch:request];
//}

//#pragma mark - AMapSearchDelegate
//// POI 搜索回调.
//- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
//    if (response.pois.count == 0) {
//        return;
//    }
//
//    //解析response获取POI信息，具体解析见 Demo
//    NSLog(@"=====%@", response.pois);
//}

//- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
//    NSLog(@"AMap search Error: %@", error);
//}

- (void)updateLocation:(CLLocationCoordinate2D)coordinate update:(void (^)(NSString *))updating {
    //反向地理编码
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLLocation *cl = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [clGeoCoder reverseGeocodeLocation:cl completionHandler: ^(NSArray *placemarks,NSError *error) {
        for (CLPlacemark *placeMark in placemarks) {
            NSDictionary *addressDic = placeMark.addressDictionary;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            NSString *currentLocationStr = [NSString stringWithFormat:@"%@%@%@%@", state, city, subLocality, street];
            _locateCurrCity = city;
            updating(currentLocationStr);
        }
    }];
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    [self updateLocation:location.coordinate update:^(NSString *data) {
    }];
    [self.locationManager stopUpdatingLocation];
    BLOCK_SAFE(_handleLocationBlock)(location.coordinate);
}

#pragma mark - route
- (void)walkingNavigateWithOrgin:(CLLocationCoordinate2D)orgin destination:(CLLocationCoordinate2D)destinate {
    // navigate for walk.
    _destinateLocation = destinate;
    AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
    navi.origin = [AMapGeoPoint locationWithLatitude:orgin.latitude
                                           longitude:orgin.longitude];
    navi.destination = [AMapGeoPoint locationWithLatitude:destinate.latitude
                                                longitude:destinate.longitude];
    [self.search AMapWalkingRouteSearch:navi];
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    if (response.route == nil) {
        return;
    }
    // callback to draw line on map.
    BLOCK_SAFE(_walkRouteResponse)(response, _destinateLocation);
}

#pragma mark - views
- (GJMAAnnotationView *)bigHeadPinAnnoView:(id<MAAnnotation>)annotation mapView:(MAMapView *)mapView isCenter:(BOOL)isCenter {
    GJMAAnnotationView * annotationView = (GJMAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[GJMAAnnotationView reuseIndentifier]];
    if (!annotationView) {
        annotationView = [[GJMAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[GJMAAnnotationView reuseIndentifier]];
    }
    if ([annotation isKindOfClass:[MANaviAnnotation class]]) {
        annotationView.isNaviIcon = YES;
    }else if (!isCenter) {
        if (mapView.zoomLevel > 12) [annotationView viewAnimating];
        annotationView.customCalloutView = [GJCustomCalloutView calloutInstall];
        [_arrAnnoViews addObject:annotationView];
    }
    annotationView.isCenter = isCenter;
    annotationView.canShowCallout = YES;
    annotationView.draggable = NO;
    return annotationView;
}

- (GJMAAnnotationView *)userLocateAnnoView:(id<MAAnnotation>)annotation mapView:(MAMapView *)mapView {
    GJMAAnnotationView *userView = (GJMAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[GJMAAnnotationView reuseIndentifier]];
    if (!userView) userView = [[GJMAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[GJMAAnnotationView reuseIndentifier]];
    userView.image = [UIImage imageNamed:@"common_map_my_location"];
    return userView;
}

#pragma mark - Getter/Setter
- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locationManager.locationTimeout = 3;
        _locationManager.reGeocodeTimeout = 3;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

@end
