//
//  GJSearchController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseViewController.h"
#import "GJAMapManager.h"

@class GJHomeSearchPointData;
@class GJFilterZoneData;

@interface GJSearchController : GJBaseViewController
@property (nonatomic, strong) NSString *currCity;
@property (nonatomic, strong) GJAMapManager *aMapManager;
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;
@property (nonatomic, copy) void (^naviRouteCCBlock)(CLLocationCoordinate2D location, GJHomeSearchPointData *data);
@property (nonatomic, strong) GJFilterZoneData *filterZoneData;
@end
