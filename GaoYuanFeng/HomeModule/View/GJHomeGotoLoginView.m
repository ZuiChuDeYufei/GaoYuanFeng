//
//  GJHomeGotoLoginView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJHomeGotoLoginView.h"

@interface GJHomeGotoLoginView ()
@property (nonatomic, strong) UILabel *leftLB;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation GJHomeGotoLoginView

+ (GJHomeGotoLoginView *)install {
    GJHomeGotoLoginView *v = [[GJHomeGotoLoginView alloc] initWithFrame:CGRectMake(0, NavBar_H, SCREEN_W, AdaptatSize(50))];
    return v;
}

- (void)rightBtnClick {
    BLOCK_SAFE(_rightClickBlock)();
}

- (void)commonInit {
    self.backgroundColor = APP_CONFIG.appMainColor;
    
    _leftLB = [[UILabel alloc] init];
    _leftLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    _leftLB.text = @"您尚未注册账号，暂时无法买单";
    _leftLB.textColor = [UIColor whiteColor];
    [_leftLB sizeToFit];
    
    _rightBtn = [[UIButton alloc] init];
    _rightBtn.layer.cornerRadius = (self.height - 20) / 2;
    _rightBtn.clipsToBounds = YES;
    _rightBtn.backgroundColor = [UIColor whiteColor];
    _rightBtn.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:15]);
    [_rightBtn setTitle:@"注册登录" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:APP_CONFIG.appMainColor forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_leftLB];
    [self addSubview:_rightBtn];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.centerY.equalTo(self);
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-15);
        make.centerY.equalTo(self);
        make.top.equalTo(self).with.offset(10);
        make.bottom.equalTo(self).with.offset(-10);
        make.width.mas_equalTo(AdaptatSize(80));
    }];
}

@end
