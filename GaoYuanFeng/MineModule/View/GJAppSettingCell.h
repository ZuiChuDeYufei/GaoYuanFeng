//
//  GJAppSettingCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/2.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"

@interface GJAppSettingCell : GJBaseTableViewCell

@property (nonatomic, copy) void(^logoutClick)(void);

@end
