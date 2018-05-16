//
//  GJCustomCalloutView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCustomCalloutView.h"

@interface GJCustomCalloutView ()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, assign) CGFloat width;
@end

@implementation GJCustomCalloutView

+ (GJCustomCalloutView *)calloutInstall {
    GJCustomCalloutView *callout = [[GJCustomCalloutView alloc] init];
    return callout;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRGB:52 g:60 b:75];
        _iconImg = [[UIImageView alloc] init];
        _iconImg.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_iconImg];
        _titleLB = [[UILabel alloc] init];
        _titleLB.font  =AdapFont([APP_CONFIG appFontOfSize:14]);
        _titleLB.textColor = [UIColor whiteColor];
        [_titleLB sizeToFit];
        [self addSubview:_titleLB];
        
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(10);
            make.centerY.equalTo(self).with.offset(-1);
        }];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-10);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _width = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_titleLB.font,NSFontAttributeName,nil]].width + 37;
    self.frame = CGRectZero;
    CGRect frame = CGRectMake(-AdaptatSize(_width)/2+AdaptatSize(20), -AdaptatSize(37), AdaptatSize(_width), AdaptatSize(30));
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = frame;
    }];
    self.layer.cornerRadius = self.height/2;
    self.clipsToBounds = YES;
    _titleLB.text = title;
    _iconImg.image = [UIImage imageNamed:@"walking_man"];
}

-(void)removeFromSuperview {
    [UIView animateWithDuration:0.2 animations:^{
        self.bounds = CGRectZero;
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

@end
