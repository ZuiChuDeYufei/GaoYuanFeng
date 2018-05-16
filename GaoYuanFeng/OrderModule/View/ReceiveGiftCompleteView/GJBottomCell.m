//
//  GJBottomCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/27.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBottomCell.h"

@interface GJBottomCell ()
@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIView *backView3;

@property (nonatomic, strong) UILabel *topTitleLB;
@property (nonatomic, strong) UILabel *topDetailLB;
@property (nonatomic, strong) UILabel *topBottomLB;

@property (nonatomic, strong) UILabel *midTitleLB;
@property (nonatomic, strong) UILabel *midAddressLB;
@property (nonatomic, strong) UILabel *midPhoneLB;
@property (nonatomic, strong) UILabel *midNameLB;

@property (nonatomic, strong) UILabel *btmTitleLB;
@property (nonatomic, strong) UILabel *btmTimeLB;
@property (nonatomic, strong) UILabel *btmTime;
@property (nonatomic, strong) UILabel *btmNumLB;
@property (nonatomic, strong) UILabel *btmNum;
@end

@implementation GJBottomCell

- (void)setContent {
    _topTitleLB.text = @"好礼信息";
    _midTitleLB.text = @"收货信息";
    _btmTitleLB.text = @"订单信息";
    _topDetailLB.text = @"让他骇人听闻你认为让他请你果不其然热情体内人文关怀";
    _topBottomLB.text = @"数量：x1";
    _midAddressLB.text = @"贵州省贵阳市南明区热毯委托人个摊位天恒";
    _midPhoneLB.text = @"18799997777";
    _midNameLB.text = @"问过我";
    _btmTimeLB.text = @"创建时间：";
    _btmTime.text = @"2018-03-09 12：14";
    _btmNumLB.text = @"订单编号";
    _btmNum.text = @"20132123546";
}

- (void)commonInit {
    _backView1 = [[UIView alloc] init];
    _backView2 = [[UIView alloc] init];
    _backView3 = [[UIView alloc] init];
    [self.contentView addSubview:_backView1];
    [self.contentView addSubview:_backView2];
    [self.contentView addSubview:_backView3];
    
    CGFloat font1 = 17;
    CGFloat font2 = 14;
    
    _topTitleLB = [self createLabel:font1 color:[UIColor colorWithRGB:150 g:150 b:150]];
    _midTitleLB = [self createLabel:font1 color:_topTitleLB.textColor];
    _btmTitleLB = [self createLabel:font1 color:_topTitleLB.textColor];
    
    _topDetailLB = [self createLabel:font2 color:[UIColor colorWithRGB:192 g:192 b:192]];
    _topDetailLB.numberOfLines = 2;
    _topBottomLB = [self createLabel:font2 color:_topDetailLB.textColor];
    
    _midAddressLB = [self createLabel:font2 color:_topDetailLB.textColor];
    _midPhoneLB = [self createLabel:font2 color:_topDetailLB.textColor];
    _midNameLB = [self createLabel:font2 color:_topDetailLB.textColor];
    
    _btmTimeLB = [self createLabel:font2 color:_topDetailLB.textColor];
    _btmTime = [self createLabel:font2 color:_topDetailLB.textColor];
    _btmNumLB = [self createLabel:font2 color:_topDetailLB.textColor];
    _btmNum = [self createLabel:font2 color:_topDetailLB.textColor];
    
    [self setContent];
    [self updateFrames];
}

- (void)updateFrames {
    [_backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(self.height/3);
    }];
    [_backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(self.height/3);
    }];
    [_backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_backView1.mas_bottom);
        make.bottom.equalTo(_backView3.mas_top);
    }];
    [_topTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_backView1).with.offset(20);
    }];
    [_topDetailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTitleLB);
        make.top.equalTo(_topTitleLB.mas_bottom).with.offset(10);
        make.right.equalTo(_backView1).with.offset(-15);
    }];
    [_topBottomLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTitleLB);
        make.top.equalTo(_topDetailLB.mas_bottom).with.offset(5);
    }];
    [_midTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_backView2).with.offset(20);
    }];
    [_midAddressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTitleLB);
        make.top.equalTo(_midTitleLB.mas_bottom).with.offset(10);
        make.right.equalTo(_backView2).with.offset(-15);
    }];
    [_midPhoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTitleLB);
        make.top.equalTo(_midAddressLB.mas_bottom).with.offset(5);
    }];
    [_midNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTitleLB);
        make.top.equalTo(_midPhoneLB.mas_bottom).with.offset(5);
    }];
    [_btmTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_backView3).with.offset(20);
    }];
    [_btmTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTitleLB);
        make.top.equalTo(_btmTitleLB.mas_bottom).with.offset(10);
    }];
    [_btmTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_btmTimeLB);
        make.left.equalTo(_backView3.mas_centerX).with.offset(-AdaptatSize(40));
    }];
    [_btmNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTitleLB);
        make.top.equalTo(_btmTimeLB.mas_bottom).with.offset(5);
    }];
    [_btmNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_btmNumLB);
        make.left.equalTo(_backView3.mas_centerX).with.offset(-AdaptatSize(40));
    }];
}

- (UILabel *)createLabel:(CGFloat)font color:(UIColor *)color {
    UILabel *lb = [[UILabel alloc] init];
    lb.font = AdapFont([APP_CONFIG appBoldFontOfSize:font]);
    lb.textColor = color;
    [lb sizeToFit];
    [self.contentView addSubview:lb];
    return lb;
}

- (CGFloat)height {
    return AdaptatSize(390);;
}

@end
