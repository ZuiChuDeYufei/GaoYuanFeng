//
//  GJLoginView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJLoginView.h"

#define TAG_PHONE_TF 123456
#define TAG_SMSCODE_TF 123465

@interface GJLoginView () <UITextFieldDelegate>
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UILabel *bottomLB;
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, assign) BOOL phoneIsEmpty;
@property (nonatomic, assign) BOOL verifyCodeIsEmpty;
@property (nonatomic, assign) BOOL getVerifyCodeBtnClicked;
@end

@implementation GJLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _phoneIsEmpty = YES;
        _verifyCodeIsEmpty = YES;
        _getVerifyCodeBtnClicked = NO;
        
        [self addSubViews];
    }
    return self;
}

#pragma mark - buttons click
- (void)getVerifyCodeBtnClick {
    if (![_phoneNumTF.text isValidMobileNumber]) {
        ShowWaringAlertHUD(@"请输入正确的手机号码", nil);
        return ;
    }
    if ([self.myDelegate respondsToSelector:@selector(getVerifyCodeBtnClick)]) {
        _getVerifyCodeBtnClicked = YES;
        [self.myDelegate getVerifyCodeBtnClick];
    }
}

- (void)submitBtnClick {
    if (![self verifyInputLegal]) return;
    if ([self.myDelegate respondsToSelector:@selector(submitBtnClick)]) {
        [self resignKeyboard];
        [self.myDelegate submitBtnClick];
    }
}

- (void)bottomBtnClick {
    [self resignKeyboard];
    
}

- (void)resignKeyboard {
    [_phoneNumTF resignFirstResponder];
    [_verifyCodeTF resignFirstResponder];
}

#pragma mark -  <UITextFieldDelegate>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self checkInputing:textField textStr:textField.text];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL ret = YES;
    NSString *textStr = [textField.text changeCharactersInRange:range replacementString:string];
    if (textField.tag == TAG_PHONE_TF) {
        // 手机号
        if (textStr.length <= 11) {
            if (textStr.length == 11) {
                _getVerifyCodeBtn.layer.borderColor = APP_CONFIG.appMainColor.CGColor;
                _getVerifyCodeBtn.enabled = YES;
            }else {
                _getVerifyCodeBtn.layer.borderColor = APP_CONFIG.separatorLineColor.CGColor;
                _getVerifyCodeBtn.enabled = NO;
            }
            ret = YES;
        }else {
            // solve copy and paste
            textField.text = textStr = [textStr substringToIndex:11];
            ret = _phoneIsEmpty = NO;
        }
    }
    else if (textField.tag == TAG_SMSCODE_TF) {
        // 验证码
        if (textStr.length > 4) {
            ret = NO;
        }else {
            ret = YES;
        }
    }
    [self checkInputing:textField textStr:textStr];
    return ret;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField.tag == TAG_PHONE_TF) _phoneIsEmpty = YES;
    _submitBtn.enabled = NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == TAG_SMSCODE_TF) {
        [_verifyCodeTF resignFirstResponder];
    }
    return YES;
}

// checkInputing
- (void)checkInputing:(UITextField *)textField textStr:(NSString *)textStr {
    if (textField.tag == TAG_PHONE_TF) {
        if (textStr.length != 11) _phoneIsEmpty = YES;
        else _phoneIsEmpty = NO;
    }
    else {
        if ([textStr isEqualToString:@""]) _verifyCodeIsEmpty = YES;
        else _verifyCodeIsEmpty = NO;
    }

    if (!_phoneIsEmpty && !_verifyCodeIsEmpty && _getVerifyCodeBtnClicked) {
        _submitBtn.enabled = YES;
    }
    else _submitBtn.enabled = NO;
}

// verifyInputLegal
- (BOOL)verifyInputLegal {
    BOOL ret = YES;
    if (![_phoneNumTF.text isValidMobileNumber]) {
        ShowWaringAlertHUD(@"请输入正确的手机号码", nil);
        return NO;
    }
    return ret;
}

#pragma mark - add subviews
- (void)addSubViews {
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = AdapFont([APP_CONFIG appBoldFontOfSize:26]);
    _titleLB.text = @"手机验证";
    _titleLB.textColor = APP_CONFIG.blackTextColor;
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _detailLB.text = @"请输入您的手机号码，登录或注册您的会员账号";
    _detailLB.textColor = APP_CONFIG.grayTextColor;
    [_detailLB sizeToFit];
    
    _phoneNumTF = [[UITextField alloc] init];
    _phoneNumTF.tag = TAG_PHONE_TF;
    _phoneNumTF.delegate = self;
    _phoneNumTF.backgroundColor = [UIColor colorWithRGB:242 g:242 b:242];
    _phoneNumTF.font = [APP_CONFIG appFontOfSize:14];
    _phoneNumTF.placeholder = @"请输入手机号";
    _phoneNumTF.tintColor= [UIColor blueColor];
    _phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumTF.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [_phoneNumTF setValue:[APP_CONFIG appFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    UILabel *leftImgInTF1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    leftImgInTF1.text = @"   手机号";
    leftImgInTF1.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumTF.leftView = leftImgInTF1;
    
    _verifyCodeTF = [[UITextField alloc] init];
    _verifyCodeTF.tag = TAG_SMSCODE_TF;
    _verifyCodeTF.delegate = self;
    _verifyCodeTF.backgroundColor = [UIColor colorWithRGB:242 g:242 b:242];
    _verifyCodeTF.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _verifyCodeTF.placeholder = @"请输入验证码";
    _verifyCodeTF.tintColor= [UIColor blueColor];
    _verifyCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    _verifyCodeTF.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [_verifyCodeTF setValue:[APP_CONFIG appFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    UILabel *leftImgInTF2 = [[UILabel alloc] initWithFrame:leftImgInTF1.bounds];
    leftImgInTF2.text = @"   验证码";
    leftImgInTF2.font = leftImgInTF1.font;
    _verifyCodeTF.leftViewMode = UITextFieldViewModeAlways;
    _verifyCodeTF.leftView = leftImgInTF2;
    
    _getVerifyCodeBtn = [[GJVerifyButton alloc] initWithFrame:CGRectZero verifyTitle:@"获取验证码"];
    _getVerifyCodeBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:13]);
    _getVerifyCodeBtn.selected = NO;
    _getVerifyCodeBtn.enabled = NO;
    _getVerifyCodeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_getVerifyCodeBtn addTarget:self action:@selector(getVerifyCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _submitBtn = [[UIButton alloc] init];
    _submitBtn.titleLabel.font = [APP_CONFIG appFontOfSize:17];
    _submitBtn.clipsToBounds = YES;
    _submitBtn.layer.cornerRadius = 5;
    _submitBtn.enabled = NO;
    [_submitBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:CreatImageWithColor([UIColor colorWithRGB:216 g:216 b:216]) forState:UIControlStateDisabled];
    [_submitBtn setBackgroundImage:CreatImageWithColor([UIColor colorWithRGB:255 g:38 b:0]) forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:CreatImageWithColor([UIColor colorWithRGB:255 g:38 b:0]) forState:UIControlStateHighlighted];
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _bottomLB = [[UILabel alloc] init];
    _bottomLB.font = AdapFont([APP_CONFIG appFontOfSize:12]);
    _bottomLB.text = @"点击开始，即表示已阅读并同意";
    _bottomLB.textColor = APP_CONFIG.grayTextColor;
    [_bottomLB sizeToFit];
    
    _bottomBtn = [[UIButton alloc] init];
    _bottomBtn.titleLabel.font = _bottomLB.font;
    [_bottomBtn setTitle:@"《买单服务条款》" forState:UIControlStateNormal];
    [_bottomBtn setTitleColor:[UIColor colorWithRGB:253 g:38 b:0] forState:UIControlStateNormal];
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBtn sizeToFit];
    
    [self addSubview:_titleLB];
    [self addSubview:_detailLB];
    [self addSubview:_phoneNumTF];
    [self addSubview:_verifyCodeTF];
    [self addSubview:_getVerifyCodeBtn];
    [self addSubview:_submitBtn];
    [self addSubview:_bottomLB];
    [self addSubview:_bottomBtn];
    
    [self updateFrames];
}

- (void)updateFrames {
    CGFloat height = AdaptatSize(45);
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(self).with.offset(10);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(10);
    }];
    [_phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(_detailLB.mas_bottom).with.offset(AdaptatSize(30));
        make.height.mas_equalTo(height);
        make.right.equalTo(self).with.offset(-15);
    }];
    [_getVerifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_verifyCodeTF);
        make.size.mas_equalTo((CGSize){AdaptatSize(85), height});
        make.right.equalTo(_phoneNumTF);
    }];
    [_verifyCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(_phoneNumTF.mas_bottom).with.offset(12);
        make.height.mas_equalTo(height);
        make.right.equalTo(_getVerifyCodeBtn.mas_left).with.offset(-10);
    }];
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(self).with.offset(-15);
        make.top.equalTo(_getVerifyCodeBtn.mas_bottom).with.offset(AdaptatSize(40));
        make.height.mas_equalTo(height);
    }];
    [_bottomLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_submitBtn.mas_bottom).with.offset(10);
        make.right.equalTo(_submitBtn.mas_centerX).with.offset(AdaptatSize(35));
    }];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomLB);
        make.left.equalTo(_submitBtn.mas_centerX).with.offset(AdaptatSize(35));
    }];
}

@end
