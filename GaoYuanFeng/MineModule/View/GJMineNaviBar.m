//
//  GJMineNaviBar.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMineNaviBar.h"

@interface GJMineNaviBar ()
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation GJMineNaviBar

+(GJMineNaviBar *)installNavBar {
    GJMineNaviBar *navBar = [[GJMineNaviBar alloc] initWithFrame:CGRectMake(0, 10,  SCREEN_W,NavBar_H)];
    return navBar;
}

- (void)commonInit {
    _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, NavBar_H-44, 60, 44)];
    [_backBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
}

- (void)backClick {
    BLOCK_SAFE(_back)();
}

@end
