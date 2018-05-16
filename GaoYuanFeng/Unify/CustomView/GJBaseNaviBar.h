//
//  GJBaseNaviBar.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJBaseNaviBar : GJBaseView
@property (nonatomic, copy) void(^backBtnClick)(void);
+(GJBaseNaviBar *)installNavBar;
@end
