//
//  GJMineNaviBar.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJMineNaviBar : GJBaseView
@property (nonatomic, copy) void(^back)(void);
+(GJMineNaviBar *)installNavBar;
@end
