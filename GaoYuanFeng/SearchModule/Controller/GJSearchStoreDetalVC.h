//
//  GJSearchStoreDetalVC.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@class GJHomeSearchPointData;

@interface GJSearchStoreDetalVC : GJBaseViewController
@property (nonatomic, strong) GJHomeSearchPointData *pointData;
@property (nonatomic, copy) void (^naviRouteCBlock)(CLLocationCoordinate2D location, GJHomeSearchPointData *data);
@end
