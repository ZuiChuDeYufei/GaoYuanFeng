//
//  GJStoreSDetailBottomCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"

@class GJHomeSearchPointData;

@interface GJStoreSDetailBottomCell : GJBaseTableViewCell
@property (nonatomic, strong) GJHomeSearchPointData *pointData;
@property (nonatomic, copy) void (^naviRouteBlock)(void);
@property (nonatomic, copy) void (^scanBtnBlock)(void);
@end
