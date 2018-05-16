//
//  GJWeChatPayModel.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJWeChatPayModel.h"


@implementation GJWeChatPayModel

-(void)jumpToPayWithOrder:(GJOrderPaymentData *)order {
    if (order != nil) {
        if (![WXApi isWXAppInstalled]) {
            ShowWaringAlertHUD(@"请安装微信客户端", nil);
            return;
        }
        
        PayReq *req = [[PayReq alloc] init];
        req.partnerId = order.partnerid;
        req.prepayId = order.prepayid;
        req.nonceStr = order.noncestr;
        req.timeStamp = (UInt32)[order.timestamp longLongValue];;
        req.package = order.packages;
        req.sign = order.sign;
        [WXApi sendReq:req];
    }else {
        ShowWaringAlertHUD(@"订单生成失败", nil);
    }
}

- (GJPaymentType)payType {
    return GJPaymentTypeWexin;
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        GJPaymentResultType type;
        switch (resp.errCode) {
            case WXSuccess:
                type = GJPaymentResultSuccess;
                break;
            case WXErrCodeUserCancel:
                type = GJPaymentResultCancleType;
                break;
            case WXErrCodeSentFail:
                type = GJPaymentResultError;
                break;
            default:
                type = GJPaymentResultNoneType;
                break;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:WeChatPaySucessNotice object:@{@"result":@(type)}];
    }
}

- (void)onReq:(BaseReq *)req
{
    
}

@end
