//
//  GJWeChatPayModel.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJPayBaseModel.h"
#import "WXApi.h"

typedef enum : NSUInteger {
    GJPaymentResultNoneType = 0,
    GJPaymentResultSuccess = 1,
    GJPaymentResultError = 2,
    GJPaymentResultOffLine = 3,
    GJPaymentResultCancleType
} GJPaymentResultType;

@interface GJWeChatPayModel : GJPayBaseModel <WXApiDelegate>

-(void)jumpToPayWithOrder:(GJOrderPaymentData *)order;

@end
