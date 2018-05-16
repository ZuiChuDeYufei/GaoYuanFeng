//
//  GJAMapView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"
#import "GJAMapManager.h"
#import "GJLocationCoordinateData.h"
#import "GJPointAnnotation.h"

@interface GJAMapView : GJBaseView

@property (nonatomic, copy) void (^didSelectAnnotationViewBlock)(GJMAAnnotationView *view, MAMapView *mapView, GJAMapManager *aMapManager);
@property (nonatomic, copy) void (^didSelectDetailAnnotationBlock)(GJMAAnnotationView *view, MAMapView *mapView);
@property (nonatomic, copy) void (^didDeselectAnnotationViewBlock)(MAMapView *mapView);
@property (nonatomic, copy) void (^mapMoveByUserBlock)(MAMapView *mapView);
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;
@property (nonatomic, strong) GJAMapManager *aMapManager;

+ (GJAMapView *)install;
- (void)updateLocation;
- (void)addBigHeadPins:(CLLocationCoordinate2D)movingPin locations:(NSArray <GJLocationCoordinateData *> *)locations;
- (void)searchPageAddPin:(CLLocationCoordinate2D)coor;

@end
