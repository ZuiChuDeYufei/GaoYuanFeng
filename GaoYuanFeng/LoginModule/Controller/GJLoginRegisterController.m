//
//  GJLoginRegisterController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJLoginRegisterController.h"
#import "GJLoginNaviBar.h"
#import "GJLoginView.h"
#import "GJLoginApi.h"

@interface GJLoginRegisterController () <GJLoginViewDelegate>
@property (nonatomic, strong) GJLoginNaviBar *naviBar;
@property (nonatomic, strong) GJLoginView *loginView;
@property (strong, nonatomic) GJLoginApi *loginApi;
@property (strong, nonatomic) NSString *tempTelePhoneNum;
@property (copy,nonatomic)  NSString *oldTelPhone;
@property (nonatomic, copy) LoginSuccessBlcok loginBlock;
@property (nonatomic, copy) LogoutSuccessBlcok logoutBlock;
@end

@implementation GJLoginRegisterController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BLOCK_SAFE(self.logoutBlock)();
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _loginApi = [GJLoginApi new];
}

- (void)initializationSubView {
    [self.view addSubview:self.naviBar];
    [self.view addSubview:self.loginView];
}

- (void)initializationNetWorking {}

#pragma mark - event response
- (void)clickViewResignKeyboard {
    [_loginView resignKeyboard];
}

#pragma mark - Class Function
+ (BOOL)needLoginPresentWithVC:(UIViewController *)controller loginSucessBlcok:(LoginSuccessBlcok)success {
    if ([APP_USER isLoginStatus]) {
        BLOCK_SAFE(success)();
        return NO;
    }
    [APP_USER loginOut];
    GJLoginRegisterController *loginController = [[GJLoginRegisterController alloc] init];
    loginController.loginBlock = success;
    UIViewController *fromVc = controller ? controller : [GJFunctionManager CurrentTopViewcontroller];
    [fromVc presentViewController:loginController animated:YES completion:nil];
    return YES;
}

+ (void)logOutPresentLoginControllerByVC:(UIViewController *)controller loginSucessBlcok:(LogoutSuccessBlcok)success {
    [APP_USER loginOut];
    GJLoginRegisterController *loginController = [[GJLoginRegisterController alloc] init];
    loginController.logoutBlock = success;
    
    while (controller.presentingViewController) {
        controller = controller.presentingViewController;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    [controller presentViewController:loginController animated:YES completion:^{
        ShowWaringAlertHUD(@"已退出登录", nil);
    }];
}

#pragma mark - Custom delegate
// GJLoginViewDelegate
- (void)submitBtnClick {
    if (!_tempTelePhoneNum) {
        ShowWaringAlertHUD(@"请先获取验证码", nil);
        return ;
    }
    if (![_loginView.phoneNumTF.text isEqualToString:self.oldTelPhone]) {
        ShowWaringAlertHUD(@"手机号和验证码不匹配", nil);
        return;
    }
    ShowProgressHUDWithText(YES, nil, @"登录中");

    [self.loginApi loginByTelePhone:_tempTelePhoneNum smsCode:_loginView.verifyCodeTF.text success:^(NSURLResponse *urlResponse, id response) {
        ShowProgressHUDWithText(NO, nil, nil);
        ShowSucceedAlertHUD(@"登录成功", nil);
        [APP_USER loginSucess:response];
        BLOCK_SAFE(_loginBlock)();
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        ShowProgressHUDWithText(NO, nil, nil);
        ShowWaringAlertHUD(error.localizedDescription, nil);
    }];
}

- (void)getVerifyCodeBtnClick {
    _tempTelePhoneNum = _loginView.phoneNumTF.text;
    if (!_tempTelePhoneNum) return ;
    [_loginView.getVerifyCodeBtn showActive:YES];
    [_loginView.phoneNumTF resignFirstResponder];
    [self.loginApi loginGetSmsCode:_tempTelePhoneNum success:^(NSURLResponse *urlResponse, id response) {
        self.oldTelPhone = _tempTelePhoneNum;
        [_loginView.getVerifyCodeBtn showActive:NO];
        ShowSucceedAlertHUD(@"验证码发送成功", self.view);
        [_loginView.verifyCodeTF becomeFirstResponder];
        if (!_loginView.getVerifyCodeBtn.enabled) {
            return;
        }
        [_loginView.getVerifyCodeBtn startEndTime];

    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [_loginView.getVerifyCodeBtn showActive:NO];
        ShowWaringAlertHUD(error.localizedDescription, nil);
    }];
}

#pragma mark - Getter/Setter
- (GJLoginNaviBar *)naviBar {
    if (!_naviBar) {
        _naviBar = [[GJLoginNaviBar alloc] initWithFrame:CGRectMake(0, NavBar_H-44,  SCREEN_W, 44)];
        __weak typeof(self)weakSelf = self;
        _naviBar.backClickBlock = ^{
            [weakSelf.loginView resignKeyboard];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return _naviBar;
}

- (GJLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[GJLoginView alloc] initWithFrame:CGRectMake(0, NavBar_H, SCREEN_W, self.view.height)];
        _loginView.backgroundColor = self.view.backgroundColor;
        _loginView.myDelegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickViewResignKeyboard)];
        tap.numberOfTapsRequired = 1;
        [_loginView addGestureRecognizer:tap];
    }
    return _loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
