//
//  GJLoginNaviBar.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJLoginNaviBar.h"

@interface GJLoginNaviBar ()
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation GJLoginNaviBar

- (void)backClick {
    BLOCK_SAFE(_backClickBlock)();
}

- (void)commonInit {
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, self.height)];
    [_closeBtn setImage:[UIImage imageNamed:@"close2"] forState:UIControlStateNormal];
    [_closeBtn setImage:[UIImage imageNamed:@"close2"] forState:UIControlStateHighlighted];
    [_closeBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_closeBtn];
    
    [self updateFrames];
}

- (void)updateFrames {
    
}

@end
