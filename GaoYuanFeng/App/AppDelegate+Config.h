//
//  AppDelegate+Config.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//


#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate (Config)

- (void)setupMainInterface;
- (void)setupThirdApy;
- (void)setupUnify;
- (BOOL)handelThirePayOpenURL:(NSURL *)url;

@end
