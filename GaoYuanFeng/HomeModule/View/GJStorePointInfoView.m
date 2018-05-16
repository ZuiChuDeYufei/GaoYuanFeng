//
//  GJStorePointInfoView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJStorePointInfoView.h"

@interface GJStorePointInfoView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UIButton *callBtn;
@end

@implementation GJStorePointInfoView

+ (GJStorePointInfoView *)install {
    GJStorePointInfoView *v = [[GJStorePointInfoView alloc] initWithFrame:CGRectMake(20, NavBar_H+AdaptatSize(62), SCREEN_W-40, 70)];
    return v;
}

- (void)callBtnClick {
    callAPhone(_phone);
}

- (void)hiddenSelf:(BOOL)hidden {
    if (hidden) {
        _backView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        [UIView animateWithDuration:0.3 animations:^{
            _backView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
            _callBtn.backgroundColor = _titleLB.textColor = _detailLB.textColor = _backView.backgroundColor;
            [_callBtn setTitleColor:_backView.backgroundColor forState:UIControlStateNormal];
            [self setY:self.y+30];
        } completion:^(BOOL finished) {
            self.hidden = hidden;
        }];
    }else {
        self.hidden = hidden;
        [self setY:self.y+30];
        _backView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _callBtn.backgroundColor = _titleLB.textColor = _detailLB.textColor = _backView.backgroundColor;
        [_callBtn setTitleColor:_backView.backgroundColor forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            _backView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
            _callBtn.backgroundColor = [UIColor colorWithRGB:228 g:234 b:238];
            _titleLB.textColor = [UIColor blackColor];
            _detailLB.textColor = [UIColor grayColor];
            [_callBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self setY:self.y-30];
        }];
    }
}

- (void)commonInit {
    self.hidden = YES;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 6;
    _backView = [[UIView alloc] initWithFrame:self.bounds];
    _backView.layer.cornerRadius = 8;
    _backView.clipsToBounds  = YES;
    [self addSubview:_backView];
    
    _callBtn = [[UIButton alloc] init];
    _callBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    _callBtn.layer.cornerRadius = (self.height-30) / 2;
    _callBtn.clipsToBounds = YES;
    [_callBtn setTitle:@"电话预约" forState:UIControlStateNormal];
    [_callBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_callBtn addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_callBtn];
    [_callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-15);
        make.centerY.equalTo(self);
        make.top.equalTo(self).with.offset(15);
        make.bottom.equalTo(self).with.offset(-15);
        make.width.mas_equalTo(AdaptatSize(100));
    }];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    _titleLB.text = @"贵阳诺富特酒店";
    [_titleLB sizeToFit];
    [_backView addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(_callBtn.mas_left).with.offset(-10);
        make.bottom.equalTo(self.mas_centerY);
    }];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
//    _detailLB.textColor = [UIColor grayColor];
    _detailLB.text = @"9.5折买单";
    [_detailLB sizeToFit];
    [_backView addSubview:_detailLB];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(_callBtn.mas_left).with.offset(-10);
        make.top.equalTo(self.mas_centerY);
    }];
}

@end
