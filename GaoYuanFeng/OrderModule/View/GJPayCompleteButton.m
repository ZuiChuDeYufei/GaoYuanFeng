//
//  GJPayCompleteButton.m
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJPayCompleteButton.h"

@interface GJPayCompleteButton ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation GJPayCompleteButton

+ (GJPayCompleteButton *)installTitle:(NSString *)title {
    GJPayCompleteButton *btn = [[GJPayCompleteButton alloc] initWithFrame:CGRectMake(20, SCREEN_H-AdaptatSize(79), SCREEN_W-40, AdaptatSize(59))];
    [btn.button setTitle:title forState:UIControlStateNormal];
    return btn;
}

- (void)bottomBtnClick {
    BLOCK_SAFE(_buttonClick)();
}

- (void)commonInit {
    _button = [[UIButton alloc] initWithFrame:self.bounds];
    _button.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:17]);
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [_button.layer insertSublayer:gradient atIndex:0];
    gradient.colors = @[
                        (__bridge id)[UIColor colorWithRGB:253 g:73 b:46].CGColor,(__bridge id)[UIColor colorWithRGB:248 g:141 b:0].CGColor];
    gradient.locations = @[@0,@1];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    gradient.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 6;
}

@end
