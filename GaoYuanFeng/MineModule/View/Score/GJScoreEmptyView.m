//
//  GJScoreEmptyView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJScoreEmptyView.h"

@interface GJScoreEmptyView ()
@property (nonatomic, strong) UIImageView *emptyImage;
@property (nonatomic, strong) UILabel *bottomLB;
@end

@implementation GJScoreEmptyView

+ (GJScoreEmptyView *)install {
    GJScoreEmptyView *v = [[GJScoreEmptyView alloc] initWithFrame:CGRectMake(0, 0, AdaptatSize(100), AdaptatSize(150))];
    return v;
}

- (void)commonInit {
    _emptyImage = [[UIImageView alloc] init];
    _emptyImage.contentMode = UIViewContentModeScaleAspectFit;
    _emptyImage.image = [UIImage imageNamed:@"none11"];
    [self addSubview:_emptyImage];
    [_emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.width.height.equalTo(self.mas_width);
    }];
    _bottomLB = [[UILabel alloc] init];
    _bottomLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _bottomLB.textColor = [UIColor lightGrayColor];
    _bottomLB.text = @"暂时还没有积分\n快去买单获取积分吧~";
    _bottomLB.numberOfLines = 2;
    _bottomLB.textAlignment = NSTextAlignmentCenter;
    [_bottomLB sizeToFit];
    [self addSubview:_bottomLB];
    [_bottomLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self);
    }];
}

@end
