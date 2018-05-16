//
//  GJTabBar.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJTabBar.h"

#define MiddleOfTabbarBtn_Width 50.0

@interface GJTabBar ()

@property (nonatomic, strong) UIButton *middleOfTabbarBtn;
@property (nonatomic, assign) CGPoint demandBtnCenterPoint;
@property (strong, nonatomic) UIView * whiteMaskView;
@end

@implementation GJTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.whiteMaskView];
//        [self settingMidBtn];
        [self setShadowImage:[[UIImage alloc] init]];
        [self setBackgroundImage:[[UIImage alloc] init]];
        
        UIImageView *red = [[UIImageView alloc] init];
        red.image = [UIImage imageNamed:@"tabbarTopImg"];
        red.size = CGSizeMake(SCREEN_W, 40.5);
        red.center = _whiteMaskView.boundsCenter;
        red.centerY = _whiteMaskView.y - 4;
        [self addSubview:red];
    }
    
    return self;
}

- (void)settingMidBtn {
    _middleOfTabbarBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W/2-MiddleOfTabbarBtn_Width/2, -20, MiddleOfTabbarBtn_Width, MiddleOfTabbarBtn_Width)];
    _middleOfTabbarBtn.titleLabel.font = [APP_CONFIG appFontOfSize:40];
    _middleOfTabbarBtn.layer.cornerRadius = MiddleOfTabbarBtn_Width/2;
    _middleOfTabbarBtn.layer.masksToBounds = YES;
    _middleOfTabbarBtn.backgroundColor = APP_CONFIG.appMainColor;
    [_middleOfTabbarBtn setTitle:@"+" forState:UIControlStateNormal];
    [_middleOfTabbarBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
    [_middleOfTabbarBtn addTarget:self action:@selector(middleOfTabbarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_middleOfTabbarBtn];
    
    _demandBtnCenterPoint = _middleOfTabbarBtn.center;
}

- (void)middleOfTabbarBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [self.myDelegate tabBarPlusBtnClick:self];
    }
}

// Rewrite hitTest:withEvent: method.
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    return [super hitTest:point withEvent:event];
    
//    if (self.isHidden == NO) {
//        CGRectContainsPoint(_middleOfTabbarBtn.frame, point);
//        double dx = fabs(fabs(point.x) - fabs(_demandBtnCenterPoint.x));
//        double dy = fabs(fabs(point.y) - fabs(_demandBtnCenterPoint.y));
//        double dis = sqrt(pow(dx, 2) + pow(dy, 2));
//
//        if(dis <= MiddleOfTabbarBtn_Width/2.0) return _middleOfTabbarBtn;
//
//        else return [super hitTest:point withEvent:event];
//    }
//    else return [super hitTest:point withEvent:event];
}

- (UIView *)whiteMaskView {
    if (!_whiteMaskView) {
        _whiteMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 50)];
        
// _whiteMaskView.backgroundColor = [UIColor colorWithString:@"#f7f6f6"];
        _whiteMaskView.layer.shadowColor = [UIColor whiteColor].CGColor;
//        _whiteMaskView.layer.shadowOpacity = 1;
//        _whiteMaskView.layer.shadowRadius = 4.f;
//        _whiteMaskView.layer.shadowOffset = CGSizeMake(0,0);
        _whiteMaskView.backgroundColor = APP_CONFIG.whiteGrayColor;
        
        
    }
    return _whiteMaskView;
}

@end
