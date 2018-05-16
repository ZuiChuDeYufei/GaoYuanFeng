//
//  GJTradeAreaController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseViewController.h"
#import "GJStoreDetailController.h"
#import "GJGrayBackView.h"

@class GJHomeSearchPointData;
@class GJAMapManager;
@class GJFilterZoneData;

@interface GJTradeAreaController : GJBaseViewController
@property (nonatomic, strong) NSArray<GJHomeSearchPointData *> *dataSources;
@property (nonatomic, strong) GJGrayBackView *superBackView;
@property (nonatomic, strong) GJAMapManager *aMapManager;
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;
@property (nonatomic, copy) void (^naviRouteCCBlock)(CLLocationCoordinate2D location, NSInteger index);
@property (nonatomic, copy) void (^dismissSelfBlock)(void);
@property (nonatomic, strong) GJFilterZoneData *filterZoneData;
@end
