//
//  GJAMapManager.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonUtility.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "MAAnnotationView+GJAMapCustomLocationIcon.h"
#import "GJMAAnnotationView.h"
#import "MANaviRoute.h"

@interface GJAMapManager : NSObject

@property (nonatomic, strong) NSString *locateCurrCity;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray <GJMAAnnotationView *> *arrAnnoViews;
@property (copy, nonatomic) void (^walkRouteResponse)(AMapRouteSearchResponse *response, CLLocationCoordinate2D destinate);
@property (copy, nonatomic) void (^handleLocationBlock)(CLLocationCoordinate2D current);

// poi
//- (void)poiSearchAdress;
//- (void)poiSearchAroundWithCurrentLocation;

- (void)updateLocation:(CLLocationCoordinate2D)coordinate update:(void (^)(NSString *data))updating;

// route
- (void)walkingNavigateWithOrgin:(CLLocationCoordinate2D)orgin destination:(CLLocationCoordinate2D)destinate;

// views
- (GJMAAnnotationView *)bigHeadPinAnnoView:(id<MAAnnotation>)annotation mapView:(MAMapView *)mapView isCenter:(BOOL)isCenter;
- (GJMAAnnotationView *)userLocateAnnoView:(id<MAAnnotation>)annotation mapView:(MAMapView *)mapView;

@end
