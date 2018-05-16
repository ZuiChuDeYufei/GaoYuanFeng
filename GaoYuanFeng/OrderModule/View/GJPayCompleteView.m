//
//  GJPayCompleteView.m
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJPayCompleteView.h"

@interface GJPayCompleteView ()
@property (nonatomic, strong) UIImageView *leftImg1;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UIImageView *leftImg2;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UILabel *timelLB;
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UILabel *orderPriceLB;
@property (nonatomic, strong) UILabel *orderPrice;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UILabel *orderScoreLB;
@property (nonatomic, strong) UILabel *orderScore;
@end

@implementation GJPayCompleteView

- (void)setData:(GJOrderPaymentSuccessData *)data {
    _data = data;
    _titleLB.text = _data.supplier_name;
    _detailLB.text = _data.address;
    _timeLB.text = _data.paytime;
    _orderPrice.text = [NSString stringWithFormat:@"¥ %@元", _data.money];
    _orderScore.text = [NSString stringWithFormat:@"+%@", _data.credits];
}

- (void)commonInit {
    _leftImg1 = [[UIImageView alloc] init];
    _leftImg1.contentMode = UIViewContentModeScaleAspectFit;
    _leftImg1.image = [UIImage imageNamed:@"complete"];
    
    _leftImg2 = [[UIImageView alloc] init];
    _leftImg2.contentMode = UIViewContentModeScaleAspectFit;
    _leftImg2.image = [UIImage imageNamed:@"notice11"];
    
    _label1 = [[UILabel alloc] init];
    _label1.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    _label1.textColor = [UIColor colorWithRGB:30 g:180 b:132];
    [_label1 sizeToFit];
    _label1.text = @"支付成功！";
    
    _label2 = [[UILabel alloc] init];
    _label2.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    _label2.textColor = [UIColor lightGrayColor];
    [_label2 sizeToFit];
    _label2.numberOfLines = 0;
    _label2.text = @"买多少送多少积分，领取可选好礼后，扣除好礼相应的积分，剩余积分存入账户。";
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    _titleLB.textColor = [UIColor blackColor];
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _detailLB.textColor = [UIColor grayColor];
    _detailLB.numberOfLines = 2;
    [_detailLB sizeToFit];
    
    _timelLB = [[UILabel alloc] init];
    _timelLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _timelLB.textColor = [UIColor grayColor];
    [_timelLB sizeToFit];
    _timelLB.text = @"买单时间：";
    
    _timeLB = [[UILabel alloc] init];
    _timeLB.font = AdapFont([APP_CONFIG appFontOfSize:16]);
    _timeLB.textColor = [UIColor blackColor];
    [_timeLB sizeToFit];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = APP_CONFIG.separatorLineColor;
    
    _orderPriceLB = [[UILabel alloc] init];
    _orderPriceLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _orderPriceLB.textColor = [UIColor grayColor];
    [_orderPriceLB sizeToFit];
    _orderPriceLB.text = @"买单金额（已支付）";
    
    _orderPrice = [[UILabel alloc] init];
    _orderPrice.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _orderPrice.textColor = [UIColor darkGrayColor];
    [_orderPrice sizeToFit];
    
    _line2 = [[UIView alloc] init];
    _line2.backgroundColor = APP_CONFIG.separatorLineColor;
    
    _orderScoreLB = [[UILabel alloc] init];
    _orderScoreLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    _orderScoreLB.textColor = [UIColor blackColor];
    [_orderScoreLB sizeToFit];
    _orderScoreLB.text = @"买单奖励积分";
    
    _orderScore = [[UILabel alloc] init];
    _orderScore.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:19]);
    _orderScore.textColor = [UIColor redColor];
    [_orderScore sizeToFit];
    
    [self addSubview:_leftImg1];
    [self addSubview:_label1];
    [self addSubview:_leftImg2];
    [self addSubview:_label2];
    [self addSubview:_backView];
    [self addSubview:_titleLB];
    [self addSubview:_detailLB];
    [self addSubview:_timelLB];
    [self addSubview:_timeLB];
    [self addSubview:_line1];
    [self addSubview:_orderPriceLB];
    [self addSubview:_orderPrice];
    [self addSubview:_line2];
    [self addSubview:_orderScoreLB];
    [self addSubview:_orderScore];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateFrames];
}

- (void)updateFrames {
    [_leftImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self);
        make.size.mas_equalTo((CGSize){20, 20});
    }];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftImg1);
        make.left.equalTo(_leftImg1.mas_right).with.offset(10);
    }];
    [_leftImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImg1.mas_bottom).with.offset(10);
        make.left.equalTo(_leftImg1);
        make.size.mas_equalTo((CGSize){20, 20});
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImg2);
        make.left.equalTo(_leftImg2.mas_right).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
    }];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label2.mas_bottom).with.offset(10);
        make.right.left.equalTo(self);
        make.height.mas_equalTo(AdaptatSize(300));
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImg1);
        make.top.equalTo(_backView).with.offset(AdaptatSize(35));
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImg1);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(5);
        make.right.equalTo(_backView.mas_centerX).with.offset(AdaptatSize(40));
    }];
    [_timelLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImg1);
        make.top.equalTo(_detailLB.mas_bottom).with.offset(AdaptatSize(25));
    }];
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timelLB.mas_right).with.offset(5);
        make.centerY.equalTo(_timelLB);
    }];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_label2);
        make.left.equalTo(_leftImg1);
        make.height.mas_equalTo(1);
        make.top.equalTo(_timeLB.mas_bottom).with.offset(AdaptatSize(25));
    }];
    [_orderPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImg1);
        make.top.equalTo(_line1).with.offset(AdaptatSize(25));
    }];
    [_orderPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_line1);
        make.centerY.equalTo(_orderPriceLB);
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_line1);
        make.left.equalTo(_line1);
        make.height.mas_equalTo(1);
        make.top.equalTo(_orderPrice.mas_bottom).with.offset(AdaptatSize(25));
    }];
    [_orderScoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImg1);
        make.top.equalTo(_line2).with.offset(AdaptatSize(20));
    }];
    [_orderScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_line2);
        make.centerY.equalTo(_orderScoreLB);
    }];
}

@end
