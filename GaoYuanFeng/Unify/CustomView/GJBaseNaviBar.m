//
//  GJBaseNaviBar.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseNaviBar.h"

@interface GJBaseNaviBar ()
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation GJBaseNaviBar

+(GJBaseNaviBar *)installNavBar {
    GJBaseNaviBar *navBar = [[GJBaseNaviBar alloc] initWithFrame:CGRectMake(0, 0,  SCREEN_W,NavBar_H)];
    return navBar;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, NavBar_H-44, 60, 44)];
    [_backBtn setImage:[UIImage imageNamed:@"arrow_left_back"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
}

- (void)backClick {
    BLOCK_SAFE(_backBtnClick)();
}

@end
