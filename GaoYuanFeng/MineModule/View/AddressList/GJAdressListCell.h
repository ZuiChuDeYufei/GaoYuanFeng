//
//  GJAdressListCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"

@class GJAddressListData;

@interface GJAdressListCell : GJBaseTableViewCell
@property (nonatomic, strong) GJAddressListData *model;
@property (nonatomic, strong) UIViewController *context;
@property (nonatomic, copy) void(^blockDelete)(void);
@property (nonatomic, copy) void(^blockSetDefault)(void);
@end
