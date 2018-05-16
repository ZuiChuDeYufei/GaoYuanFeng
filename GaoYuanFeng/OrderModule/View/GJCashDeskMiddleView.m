//
//  GJCashDeskMiddleView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCashDeskMiddleView.h"

@interface GJCashDeskMiddleView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *payTypeLB;

@property (nonatomic, strong) UIButton *weixinBtn;
@property (nonatomic, strong) UIButton *weixinBtnR;

@property (nonatomic, strong) UIButton *zhifubaoBtn;
@property (nonatomic, strong) UIButton *zhifubaoBtnR;

//@property (nonatomic, strong) UIButton *yinlinaPayBtn;
//@property (nonatomic, strong) UIButton *yinlinaPayBtnR;
@end

@implementation GJCashDeskMiddleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self add];
    }
    return self;
}

- (void)add {
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5;
    _backView.clipsToBounds = YES;
    
    _payButton = [[UIButton alloc] init];
    _payButton.layer.cornerRadius = 5;
    _payButton.clipsToBounds = YES;
    _payButton.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:15]);
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payButton setTitle:@"去付款" forState:UIControlStateNormal];
    [_payButton setBackgroundColor:[UIColor blackColor]];
    
    _payTypeLB = [[UILabel alloc] init];
    _payTypeLB.font = _payButton.titleLabel.font;
    _payTypeLB.textColor = [UIColor blackColor];
    _payTypeLB.text = @"支付方式";
    
    [self addSubview:_backView];
    [self addSubview:_payButton];
    [self addSubview:_payTypeLB];
    
    _weixinBtn = [self createPayButton:@"微信支付" lImg:@"wechatpay" topMasView:_payTypeLB];
    _zhifubaoBtn = [self createPayButton:@"支付宝支付" lImg:@"alipay" topMasView:_weixinBtn];
//    _yinlinaPayBtn = [self createPayButton:@"银联支付" lImg:@"wechatpay" topMasView:_zhifubaoBtn];
}

- (void)buttonClick:(UIButton *)button {
    if (button == _weixinBtn) {
        _payType = WeChatPay;
        _weixinBtnR.selected = YES;
        _zhifubaoBtnR.selected = NO;
//        _yinlinaPayBtnR.selected = NO;
    }else if (button == _zhifubaoBtn) {
        _payType = ZhiFuBaoPay;
        _zhifubaoBtnR.selected = YES;
        _weixinBtnR.selected = NO;
//        _yinlinaPayBtnR.selected = NO;
    }else {
        _payType = UnionPay;
//        _yinlinaPayBtnR.selected = YES;
        _zhifubaoBtnR.selected = NO;
        _weixinBtnR.selected = NO;
    }
}

- (void)rBtnClick:(UIButton *)btn {
    btn.selected = YES;
    if (btn == _weixinBtnR) {
        _payType = WeChatPay;
        _zhifubaoBtnR.selected = NO;
//        _yinlinaPayBtnR.selected = NO;
    }else if (btn == _zhifubaoBtnR) {
        _payType = ZhiFuBaoPay;
        _weixinBtnR.selected = NO;
//        _yinlinaPayBtnR.selected = NO;
    }else {
        _payType = UnionPay;
        _zhifubaoBtnR.selected = NO;
        _weixinBtnR.selected = NO;
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(AdaptatSize(59));
        make.left.equalTo(self);
        make.right.equalTo(self);
        if (SCREEN_H >= kGJIphoneX) {
            make.bottom.equalTo(self).with.offset(-20);
        }else {
            make.bottom.equalTo(self);
        }
    }];
    [_payTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(25));
        make.top.equalTo(self).with.offset(20);
    }];
    
    [self addSubview:_weixinBtn];
    [self addSubview:_zhifubaoBtn];
//    [self addSubview:_yinlinaPayBtn];
    [_weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(25));
        make.right.equalTo(self).with.offset(AdaptatSize(-25));
        make.top.equalTo(_payTypeLB.mas_bottom).with.offset(AdaptatSize(5));
        make.height.mas_equalTo(AdaptatSize(44));
    }];
    [_zhifubaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(25));
        make.right.equalTo(self).with.offset(AdaptatSize(-25));
        make.top.equalTo(_weixinBtn.mas_bottom).with.offset(AdaptatSize(5));
        make.height.mas_equalTo(AdaptatSize(44));
    }];
//    [_yinlinaPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).with.offset(AdaptatSize(25));
//        make.right.equalTo(self).with.offset(AdaptatSize(-25));
//        make.top.equalTo(_zhifubaoBtn.mas_bottom).with.offset(AdaptatSize(5));
//        make.height.mas_equalTo(AdaptatSize(44));
//    }];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(_zhifubaoBtn).with.offset(AdaptatSize(10));
    }];
}

- (UIButton *)createPayButton:(NSString *)title lImg:(NSString *)lImg topMasView:(UIView *)masView {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *lImgV = [[UIImageView alloc] init];
    lImgV.contentMode = UIViewContentModeScaleAspectFit;
    lImgV.image = [UIImage imageNamed:lImg];
    UILabel *lb = [[UILabel alloc] init];
    lb.font = [UIFont systemFontOfSize:15];
    lb.textColor = [UIColor blackColor];
    lb.text = title;
    [lb sizeToFit];
    UIButton *rBtn = [[UIButton alloc] init];
    [rBtn setBackgroundImage:[UIImage imageNamed:@"choose12"] forState:UIControlStateNormal];
    [rBtn setBackgroundImage:[UIImage imageNamed:@"choose11"] forState:UIControlStateSelected];
    [rBtn addTarget:self action:@selector(rBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (masView == _weixinBtn) {
        _zhifubaoBtnR = rBtn;
//        [self createBottomLine:button];
    }else if (masView == _zhifubaoBtn) {
//        _yinlinaPayBtnR = rBtn;
    }else {
        _weixinBtnR = rBtn;
        _payType = WeChatPay;
        rBtn.selected = YES;
        [self createBottomLine:button];
    }
    
    [button addSubview:lImgV];
    [button addSubview:lb];
    [button addSubview:rBtn];
    
    [lImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button);
        make.centerY.equalTo(button);
        make.size.mas_equalTo((CGSize){22, 22});
    }];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lImgV.mas_right).with.offset(15);
        make.centerY.equalTo(button);
    }];
    [rBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(button);
        make.centerY.equalTo(button);
        make.size.mas_equalTo((CGSize){18, 18});
    }];
    
    return button;
}

- (void)createBottomLine:(UIView *)masV {
    UIView *l = [UIView new];
    l.backgroundColor = APP_CONFIG.separatorLineColor;
    [masV addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(masV);
        make.left.equalTo(masV);
        make.right.equalTo(masV);
        make.height.mas_equalTo(1);
    }];
}

@end
