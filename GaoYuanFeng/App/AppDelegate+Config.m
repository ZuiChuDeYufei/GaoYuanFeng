//
//  AppDelegate+Config.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "AppDelegate+Config.h"
#import "GJRootViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "GJWeChatPayModel.h"
#import "GJAlipayModel.h"

@implementation AppDelegate (Config)

- (void)setupMainInterface {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    UIViewController *rootVC;
    rootVC = [[GJRootViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
}

- (void)setupThirdApy {
    [AMapServices sharedServices].apiKey = AMap_APPKEY;
    
    /* UMSocial */
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMeng_APPKEY];
    [self configUSharePlatforms];
    
    /* IQKeyboardManager */
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [WXApi registerApp:WeChat_APPKEY];
}

- (void)setupUnify {
    APP_CONFIG = [[GJAppConfigure alloc] init];
}

#pragma mark - UMSocial paltform settings.
- (void)configUSharePlatforms {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:WeChat_APPKEY
                                       appSecret:WeChat_SECRET
                                     redirectURL:WeChat_REDIRECT];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine
                                          appKey:WeChat_APPKEY
                                       appSecret:WeChat_SECRET
                                     redirectURL:WeChat_REDIRECT];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:QQ_APPID
                                       appSecret:QQ_APPKEY
                                     redirectURL:QQ_REDIRECT];
}

- (BOOL)handelThirePayOpenURL:(NSURL *)url {
    BOOL ret = NO;
    if ([url.host isEqualToString:@"safepay"]) {
        // Jump to Alipay and handle pay result.
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:AliPaySucessNotice object:resultDic];
        }];
        ret = YES;
    }
    if ([url.host isEqualToString:@"pay"]) {
        ret = [WXApi handleOpenURL:url delegate:[[GJWeChatPayModel alloc] init]];
    }
    
    return ret;
}

@end

