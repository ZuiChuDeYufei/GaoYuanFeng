//
//  GJAMapView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAMapView.h"

static const NSInteger RoutePadding = 20;
static const NSInteger defaultMapZoomLevel = 14;

@interface GJAMapView () <MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) GJMAAnnotationView *currentAnnotationView;
@property (nonatomic, strong) MAPointAnnotation *centerAnnotation;

/* 用于显示当前路线方案. */
@property (nonatomic, strong) MANaviRoute *naviRoute;
@property (nonatomic, strong) AMapRoute *route;
@property (nonatomic, assign) BOOL isNavigating;
@property (nonatomic, assign) BOOL isAfterNavigateZooming;
@property (nonatomic, assign) BOOL isSearchPageNavi;
@property (nonatomic, assign) NSUInteger pinsCount;
@property (nonatomic, assign) CLLocationCoordinate2D numberShopLocation;
@property (nonatomic, strong) NSArray <GJLocationCoordinateData *> *arrNumberShopTemp;
@property (nonatomic, assign) CLLocationCoordinate2D movingPinCenter;
@property (nonatomic, strong) GJMAAnnotationView *userLocation;
@end

@implementation GJAMapView

#pragma mark - Iniitalization methods
- (void)commonInit {
    _aMapManager = [[GJAMapManager alloc] init];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    [self addSubview:self.mapView];
    
    // 中心固定的大头针
    _centerAnnotation = [[MAPointAnnotation alloc] init];
    _centerAnnotation.lockedToScreen = YES;
    if (SCREEN_H >= kGJIphoneX) {
        _centerAnnotation.lockedScreenPoint = CGPointMake(self.mapView.centerX, self.mapView.centerY-AdaptatSize(23));
    }else {
        _centerAnnotation.lockedScreenPoint = CGPointMake(self.mapView.centerX, self.mapView.centerY-AdaptatSize(18));
    }
    [self.mapView addAnnotation:_centerAnnotation];
    
    self.mapView.centerCoordinate = _currentLocation;
    [self updateLocation];
    [self blockHandle];
}

+ (GJAMapView *)install {
   GJAMapView *map = [[GJAMapView alloc] initWithFrame:CGRectMake(0, NavBar_H, SCREEN_W, SCREEN_H-NavBar_H)];
    return map;
}

#pragma mark - private methods
- (void)updateLocation {
    // location with icon
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)searchPageAddPin:(CLLocationCoordinate2D)coor {
    _isSearchPageNavi = YES;
    [_mapView selectAnnotation:_userLocation.annotation animated:YES];
}

- (void)addBigHeadPins:(CLLocationCoordinate2D)movingPin locations:(NSArray<GJLocationCoordinateData *> *)locations {
    if (JudgeContainerCountIsNull(locations)) return;
    _movingPinCenter = movingPin;
    _arrNumberShopTemp = locations;
    NSMutableArray <GJPointAnnotation *> *annotations = @[].mutableCopy;
    [locations enumerateObjectsUsingBlock:^(GJLocationCoordinateData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GJPointAnnotation *pointAnnotation = [[GJPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(obj.latitude, obj.longitude);
        pointAnnotation.annoIndex = idx;
        [annotations addObject:pointAnnotation];
    }];
    _numberShopLocation = annotations[0].coordinate;
    _pinsCount = annotations.count;
    [self removeAllPins];
    
    // simulator test code
    if (TARGET_IPHONE_SIMULATOR) {
        movingPin.latitude = 26.569151;
        movingPin.longitude = 106.691741;
    }
    
    self.mapView.centerCoordinate = movingPin;
    [self.aMapManager.arrAnnoViews removeAllObjects];
    [self.mapView addAnnotations:annotations];
}

// remove old annotations.
- (void)removeAllPins {
    [self.mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[MAUserLocation class]] && ![obj isEqual:_centerAnnotation]) {
            [self.mapView removeAnnotation:obj];
        }
    }];
}

- (NSString *)secondToTime:(NSInteger)second distance:(NSInteger)distance {
    NSInteger h, m;
    h = second / 3600;
    second %= 3600;
    m = second / 60;
    second %= 60;
    if (h > 0) {
        return [NSString stringWithFormat:@"%ld小时%ld分钟· %f公里", (long)h, (long)m, (long)distance/1000.0];
    }else {
        return [NSString stringWithFormat:@"%ld分钟 · %.2f公里", (long)m, (long)distance/1000.0];
    }
}

// 步行导航路线绘制
- (void)walkNaviRoute:(AMapRouteSearchResponse *)response destinate:(CLLocationCoordinate2D)destinate {
    /* 展示当前路线方案. */
    MANaviAnnotationType type = MANaviAnnotationTypeWalking;
    AMapPath *path = response.route.paths[0];
    [self clearNaviLine];
    self.naviRoute = [MANaviRoute naviRouteForPath:path withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude] endPoint:[AMapGeoPoint locationWithLatitude:destinate.latitude longitude:destinate.longitude]];
    [self.naviRoute addToMapView:self.mapView];
    _currentAnnotationView.title = [self secondToTime:path.duration distance:path.distance];
    self.isNavigating =YES;
    
    /* 缩放地图使其适应polylines的展示. */
    CGFloat topPadding = NavBar_H+RoutePadding;
    if (APP_USER.isLoginStatus) topPadding += AdaptatSize(20);
    else topPadding += AdaptatSize(80);
    CGFloat lPadding, rPadding;
    if (_userLocation.center.x < _currentAnnotationView.center.x) {
        lPadding = RoutePadding;
        rPadding = RoutePadding+AdaptatSize(55);
    }else {
        lPadding = RoutePadding+AdaptatSize(55);
        rPadding = RoutePadding;
    }
    [self.mapView showOverlays:self.naviRoute.routePolylines
                   edgePadding:UIEdgeInsetsMake(topPadding, lPadding, RoutePadding+AdaptatSize(160), rPadding)
                      animated:YES];
    [GJSProgressHUD dismiss];
}

/* 清空地图上已有的路线. */
- (void)clearNaviRoute {
    [self clearNaviLine];
    [self.mapView addAnnotation:_centerAnnotation];
}

- (void)clearNaviLine {
    self.isNavigating = NO;
    [self.naviRoute removeFromMapView];
    [_mapView setZoomLevel:defaultMapZoomLevel animated:YES];
}

#pragma mark - Event response
- (void)blockHandle {
    __weak typeof(self)weakSelf = self;
    _aMapManager.walkRouteResponse = ^(AMapRouteSearchResponse *response, CLLocationCoordinate2D destinate) {
        weakSelf.isNavigating = YES;
        [weakSelf.mapView removeAnnotation:weakSelf.centerAnnotation];
        [weakSelf walkNaviRoute:response destinate:destinate];
    };
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    CLHeading *heading = userLocation.heading;
    GJMAAnnotationView *userView = (GJMAAnnotationView *)[mapView viewForAnnotation:userLocation];
    // rotate location icon
    [userView rotateWithHeading:heading];
    if (updatingLocation) {
        _currentLocation = userLocation.location.coordinate;
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    // 定位 icon
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        _userLocation = [_aMapManager userLocateAnnoView:annotation mapView:mapView];
        return _userLocation;
    }
    // 大头针
    GJMAAnnotationView *view = [_aMapManager bigHeadPinAnnoView:annotation mapView:mapView isCenter:[annotation isEqual:_centerAnnotation]];
    if (mapView.zoomLevel <= 12) {
        view.numberOfShopsInLocation = _pinsCount;
    }else {
        view.numberOfShopsInLocation = 0;
    }
    return view;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    _currentAnnotationView = (GJMAAnnotationView *)view;
    [_currentAnnotationView setCustomCalloutHidden:YES];
    if (mapView.zoomLevel <= 12) {
        mapView.centerCoordinate = CLLocationCoordinate2DMake(_arrNumberShopTemp[0].latitude, _arrNumberShopTemp[0].longitude);
        [mapView setZoomLevel:defaultMapZoomLevel animated:YES];
        BLOCK_SAFE(_didSelectAnnotationViewBlock)((GJMAAnnotationView *)view, mapView, _aMapManager);
    }else {
        if (![view.annotation isKindOfClass:[MAUserLocation class]] &&
            ![view.annotation isEqual:_centerAnnotation] && mapView.zoomLevel > 12) {
            [_currentAnnotationView viewAnimating];
            BLOCK_SAFE(_didSelectDetailAnnotationBlock)((GJMAAnnotationView *)view, mapView);
        }
    }
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    [self clearNaviRoute];
    if (mapView.zoomLevel > 12) {
        _isAfterNavigateZooming = YES;
        [_currentAnnotationView viewAnimating];
    }
    BLOCK_SAFE(_didDeselectAnnotationViewBlock)(mapView);
}

// 步行路线规划
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[LineDashPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 5;
        polylineRenderer.strokeColor = [UIColor redColor];
        return polylineRenderer;    //  walk can't goes road.
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]]) {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        polylineRenderer.lineWidth = 5;
        if (naviPolyline.type == MANaviAnnotationTypeWalking) {
            polylineRenderer.strokeColor = [UIColor colorWithRGB:0 g:157 b:237];
        }
        return polylineRenderer;    //  walk can goes road.
    }
    return nil;
}

// 拖拽地图
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    if (wasUserAction && !self.isNavigating && mapView.zoomLevel > 12) {
        BLOCK_SAFE(_mapMoveByUserBlock)(mapView);
    }
}

// 缩放地图
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction {
    if (wasUserAction && mapView.zoomLevel <= 12) {
        [self removeAllPins];
        _isAfterNavigateZooming = NO;
        [mapView removeAnnotation:_centerAnnotation];
        MAPointAnnotation *anno = [[MAPointAnnotation alloc] init];
        anno.coordinate = _numberShopLocation;
        [mapView addAnnotation:anno];
        [self.aMapManager.arrAnnoViews removeAllObjects];
    }else {
        if (_isAfterNavigateZooming || self.isNavigating || JudgeContainerCountIsNull(_arrNumberShopTemp)) {
            return ;
        }
        [mapView addAnnotation:_centerAnnotation];
        [self addBigHeadPins:_movingPinCenter locations:_arrNumberShopTemp];
    }
}

#pragma mark - Getter/Setter
- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        // delete amap logo
        [_mapView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIImageView class]]) [obj removeFromSuperview];
        }];
        _mapView.delegate = self;
        _mapView.mapType = MAMapTypeStandard;
        _mapView.showsScale = NO;
        _mapView.desiredAccuracy = kCLLocationAccuracyBest;
        _mapView.zoomEnabled = YES;
        _mapView.showsCompass = NO;
        _mapView.rotateEnabled = NO;
        _mapView.rotateCameraEnabled = NO;
        _mapView.zoomLevel = defaultMapZoomLevel;
    }
    return _mapView;
}

@end
