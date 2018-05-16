//
//  GJMAAnnotationView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMAAnnotationView.h"
#import "GJCustomCalloutView.h"
#import "MANaviRoute.h"

@interface GJMAAnnotationView ()
@property (nonatomic, strong) UILabel *textLB;
@end

@implementation GJMAAnnotationView

+ (NSString *)reuseIndentifier {
    return [NSString stringWithFormat:@"com.lgj.%@",[self class]];
}

- (void)setNumberOfShopsInLocation:(NSUInteger)numberOfShopsInLocation {
    _numberOfShopsInLocation = numberOfShopsInLocation;
    if (_isCenter) {
        self.image = [UIImage imageNamed:@"common_map_pin"];
        self.canShowCallout = NO;
        self.layer.zPosition = MAXFLOAT;
        return ;
    }
    if (_isNaviIcon) {
        self.image = [UIImage imageNamed:@"man"];
    }
    else if (numberOfShopsInLocation > 0) {
        _textLB = [[UILabel alloc] init];
        _textLB.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:18]);
        _textLB.textColor  =[UIColor whiteColor];
        _textLB.textAlignment = NSTextAlignmentCenter;
        _textLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)_numberOfShopsInLocation];
        [self addSubview:_textLB];
        self.image = [UIImage imageNamed:@"location_pin"];
    }else {
        self.image = [UIImage imageNamed:@"location_gift"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_isCenter && !_isNaviIcon && _numberOfShopsInLocation > 0) {
        _textLB.bounds = CGRectMake(0, 0, AdaptatSize(40), AdaptatSize(40));
        _textLB.center = self.imageView.center;
    }
}

- (void)setCustomCalloutHidden:(BOOL)is {
    self.customCalloutView.hidden = is;
}

- (void)setTitle:(NSString *)title {
    GJCustomCalloutView *callout = (GJCustomCalloutView *)self.customCalloutView;
    [self viewAnimatingFinished:^{
        callout.title = title;
        [self setCustomCalloutHidden:NO];
    }];
}

- (void)viewAnimating {
    [self viewAnimatingFinished:nil];
}

- (void)viewAnimatingFinished:(void (^)(void))block {
    CGFloat y = self.imageView.y;
    [UIView animateWithDuration:0.1 animations:^{
        [self.imageView setY:y-20];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            [self.imageView setY:y];
        } completion:^(BOOL finished) {
            BLOCK_SAFE(block)();
        }];
    }];
}

@end
