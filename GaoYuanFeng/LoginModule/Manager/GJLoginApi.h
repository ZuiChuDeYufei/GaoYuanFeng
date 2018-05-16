//
//  GJLoginApi.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJLoginApi : NSObject

/**
 验证码登录获取验证码
 
 @param telePhone 手机号
 */
-(void)loginGetSmsCode:(NSString *)telePhone
               success:(HTTPTaskSuccessBlock)successBlock
               failure:(HTTPTaskFailureBlock)failureBlock;

/**
 通过手机号、验证码登录
 
 @param telePhone 手机号
 @param smsCode 手机收到的验证码
 */
- (void)loginByTelePhone:(NSString *)telePhone
                 smsCode:(NSString *)smsCode
                 success:(HTTPTaskSuccessBlock)successBlock
                 failure:(HTTPTaskFailureBlock)failureBlock;

@end
