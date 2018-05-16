//
//  GJCashDeskTopView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCashDeskTopView.h"

@interface GJCashDeskTopView () <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *topLB;
@property (nonatomic, strong) UILabel *tfLeftLB;
@property (nonatomic, strong) UIView *tfLine;
@property (nonatomic, strong) UILabel *lShopLB;
@property (nonatomic, strong) UILabel *rShopLB;
@property (nonatomic, strong) UILabel *shopLB;
@end

@implementation GJCashDeskTopView

- (void)setStoreName:(NSString *)storeName {
    _storeName = storeName;
    
    _lShopLB.text = @"收款商家";
    _rShopLB.text = @"认证商家（GNM12345）";
    _shopLB.text = storeName;
    _topLB.text = @"付款金额";
    _tfLeftLB.text = @"¥";
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    _topLB = [[UILabel alloc] init];
    _topLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _topLB.textColor = [UIColor blackColor];
    [_topLB sizeToFit];
    _tfLeftLB = [[UILabel alloc] init];
    _tfLeftLB.font = AdapFont([APP_CONFIG appBoldFontOfSize:30]);
    _tfLeftLB.textColor = [UIColor blackColor];
    _priceTF = [[UITextField alloc] init];
    _priceTF.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:44]);
    _priceTF.textColor = [UIColor blackColor];
    _priceTF.delegate = self;
    _priceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _priceTF.keyboardType = UIKeyboardTypeDecimalPad;
    _tfLine = [[UIView alloc] init];
    _tfLine.backgroundColor = [UIColor colorWithRGB:233 g:233 b:233];
    
    _lShopLB = [[UILabel alloc] init];
    _lShopLB.font = _topLB.font;
    _lShopLB.textColor = [UIColor blackColor];
    [_lShopLB sizeToFit];
    _rShopLB = [[UILabel alloc] init];
    _rShopLB.font = _topLB.font;
    _rShopLB.textColor = [UIColor colorWithRGB:255 g:75 b:17];
    [_rShopLB sizeToFit];
    _shopLB = [[UILabel alloc] init];
    _shopLB.font = [UIFont boldSystemFontOfSize:15];
    _shopLB.textColor = [UIColor blackColor];
    [_shopLB sizeToFit];
    
    [self addSubview:self.lShopLB];
    [self addSubview:self.rShopLB];
    [self addSubview:self.shopLB];
    [self addSubview:self.topLB];
    [self addSubview:self.tfLeftLB];
    [self addSubview:self.priceTF];
    [self addSubview:self.tfLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_lShopLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(25));
        make.top.equalTo(self).with.offset(AdaptatSize(25));
    }];
    [_rShopLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lShopLB);
        make.left.equalTo(_lShopLB.mas_right).with.offset(AdaptatSize(25));
    }];
    [_shopLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rShopLB.mas_bottom).with.offset(10);
        make.left.equalTo(_rShopLB);
    }];
    [_topLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lShopLB);
        make.centerY.equalTo(self);
    }];
    [_tfLeftLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLB);
        make.top.equalTo(_topLB.mas_bottom).with.offset(AdaptatSize(30));
        make.size.mas_equalTo((CGSize){30, 30});
    }];
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tfLeftLB.mas_right).with.offset(5);
        make.top.equalTo(_topLB.mas_bottom).with.offset(AdaptatSize(25));
        make.right.equalTo(self).with.offset(-AdaptatSize(25));
        make.height.mas_equalTo(AdaptatSize(50));
    }];
    [_tfLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLB);
        make.right.equalTo(_priceTF);
        make.bottom.equalTo(_priceTF).with.offset(3);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL ret = YES;
    NSString *textStr = [self changeCharactersInRange:range replacementString:string text:textField.text];
    if (textStr.length > 0) {
        if ([textStr isValidMoneyCharge]) {
            ret = YES;
        }else {
            ret = NO;
        }
    }else {
        ret = YES;
    }
    return ret;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _payBtn.enabled = NO;
    return YES;
}

- (NSString *)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string text:(NSString *)text  {
    NSMutableString * futureString = [NSMutableString stringWithString:text];
    if (range.length == 0) {
        [futureString insertString:string atIndex:range.location];
    } else {
        [futureString deleteCharactersInRange:range];
    }
    return futureString;
}

@end
