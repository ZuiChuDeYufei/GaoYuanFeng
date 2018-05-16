//
//  GJLoginApi.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJLoginApi.h"

@implementation GJLoginApi

- (void)loginGetSmsCode:(NSString *)telePhone success:(HTTPTaskSuccessBlock)successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSDictionary *para = @{@"phone":telePhone};
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Login_Get_SMSCode andParaDic:para andSucceedCallback:successBlock andFailedCallback:failureBlock];
}

- (void)loginByTelePhone:(NSString *)telePhone smsCode:(NSString *)smsCode success:(HTTPTaskSuccessBlock)successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSDictionary *para = @{@"phone":telePhone, @"code":smsCode};
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Login_By_TelePhone andParaDic:para andSucceedCallback:successBlock andFailedCallback:failureBlock];
}

@end
