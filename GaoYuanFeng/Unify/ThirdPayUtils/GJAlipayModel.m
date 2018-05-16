//
//  GJAlipayModel.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAlipayModel.h"

@implementation GJAlipayModel

-(void)jumpToPayWithOrder:(GJOrderPaymentData *)order {
    if (order != nil) {
        [[AlipaySDK defaultService] payOrder:order.paycode fromScheme:APP_SCHEMES callback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:AliPaySucessNotice object:resultDic];
            }
         ];
    }
}

- (GJPaymentType)payType {
    return GJPaymentTypeAlipay;
}

@end
