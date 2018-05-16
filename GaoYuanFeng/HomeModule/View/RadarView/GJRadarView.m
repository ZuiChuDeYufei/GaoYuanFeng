//
//  GJRadarView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJRadarView.h"
#import "AngleGradientLayer.h"
#import "GJHomeNaviView.h"

@interface GJRadarView ()
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) CABasicAnimation *animation;
@end

@implementation GJRadarView

+ (GJRadarView *)installOn:(UIView *)view {
    CGFloat h = sqrt(SCREEN_H*SCREEN_H+SCREEN_H*SCREEN_H);
    GJRadarView *radarView = [[GJRadarView alloc] initWithFrame:CGRectMake(0, 0, h, h)];
    radarView.superView = view;
    if (SCREEN_H >= kGJIphoneX) {
        radarView.center = CGPointMake(view.centerX, view.centerY+9);
    }
    else if (SCREEN_H >= kGJIphone6pHeight) {
        radarView.center = CGPointMake(view.centerX, view.centerY);
    }
    else if (SCREEN_H >= kGJIphone6Height) {
        radarView.center = CGPointMake(view.centerX, view.centerY+4);
    }
    else {
        radarView.center = CGPointMake(view.centerX, view.centerY+7);
    }
    return radarView;
}

- (void)startRadar {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.68;
    }];
}

- (void)stopRadar {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
}

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self setOpaque:NO];
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.alpha = 0;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    
//    UIColor *color = [UIColor colorWithRGB:0 g:205 b:205];
    UIColor *color = APP_CONFIG.appMainColor;
    NSArray *colors = @[
                        (id)[color colorWithAlphaComponent:0].CGColor,
                        (id)[color colorWithAlphaComponent:0].CGColor,
                        (id)[color colorWithAlphaComponent:1].CGColor
                        ];
    
    // AngleGradientLayer by Pavel Ivashkov
    AngleGradientLayer *l = (AngleGradientLayer *)self.layer;
    l.colors = colors;
    // NOTE: Since our gradient layer is built as an image,
    // we need to scale it to match the display of the device.
    l.contentsScale = [UIScreen mainScreen].scale; // Retina
    
    _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    _animation.duration = 1;
    _animation.toValue = [NSNumber numberWithFloat:-M_PI];
    _animation.cumulative = YES;
    _animation.removedOnCompletion = NO; // this is to keep on animating after application pause-resume
    _animation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:_animation forKey:@"spinRadarView"];
    
    CGFloat centerPointViewL;
    if (SCREEN_H >= kGJIphoneX) {
        centerPointViewL = AdaptatSize(25);
    }
    else if (SCREEN_H >= kGJIphone6pHeight) {
        centerPointViewL = AdaptatSize(22);
    }
    else if (SCREEN_H >= kGJIphone6Height) {
        centerPointViewL = AdaptatSize(18);
    }
    else centerPointViewL = AdaptatSize(22);
    
    UIView *centerPointView = [[UIView alloc] init];
    [self addSubview:centerPointView];
    centerPointView.backgroundColor = [UIColor whiteColor];
    centerPointView.layer.borderWidth = centerPointViewL/3;
    centerPointView.layer.borderColor = color.CGColor;
    centerPointView.layer.cornerRadius = centerPointViewL/2;
    [centerPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(centerPointViewL);
    }];
    return self;
}

+ (Class)layerClass
{
    return [AngleGradientLayer class];
}

@end
