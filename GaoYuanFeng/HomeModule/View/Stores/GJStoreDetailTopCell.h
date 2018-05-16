//
//  GJStoreDetailTopCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"

@class GJHomeSearchPointData;

@interface GJStoreDetailTopCell : GJBaseTableViewCell
@property (nonatomic, copy) void (^backBlock)(void);
@property (nonatomic, strong) GJHomeSearchPointData *pointData;
@property (nonatomic, strong) UIButton *closePageBtn;
@end
