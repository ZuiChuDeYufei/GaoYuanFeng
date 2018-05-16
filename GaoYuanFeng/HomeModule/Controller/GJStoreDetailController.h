//
//  GJStoreDetailController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@class GJHomeSearchPointData;

@interface GJStoreDetailController : GJBaseViewController
@property (nonatomic, strong) GJHomeSearchPointData *pointData;
@property (nonatomic, copy) void (^naviRouteCBlock)(CLLocationCoordinate2D location);
@property (nonatomic, copy) void (^dismissAfterBlock)(void);
@end
