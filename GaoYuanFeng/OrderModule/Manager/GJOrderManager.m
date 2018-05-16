//
//  GJOrderManager.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/4.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJOrderManager.h"
#import "GJGiftListSelectData.h"
#import "GJOrderListData.h"

@implementation GJOrderManager

- (void)requestPayOrderStatus:(NSString *)pay_sn success:(void (^)(GJOrderPaymentSuccessData *))success failure:(HTTPTaskFailureBlock)failureBlock {
    NSDictionary *para = @{@"pay_sn":pay_sn,
                           @"pay_status":[NSNumber numberWithInteger:9000]
                           };
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Order_Payment_QueryStatus andParaDic:para andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJOrderPaymentSuccessData *data = [GJOrderPaymentSuccessData yy_modelWithJSON:response];
        success(data);
    } andFailedCallback:failureBlock];
}

- (void)requestPayWithMoney:(NSString *)money type:(PayTypes)type supplier_id:(NSString *)supplier_id success:(void (^)(GJOrderPaymentData *))success failure:(HTTPTaskFailureBlock)failureBlock {
    // pay_leixing - 0 - 店铺扫码消费支付
    NSDictionary *para = @{@"money":money,
                           @"pay_type":[NSNumber numberWithInteger:(NSInteger)type],
                           @"api_token":APP_USER.userInfo.api_token,
                           @"supplier_id":supplier_id,
                           @"pay_leixing":[NSNumber numberWithInt:0]
                           };
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Order_Payment_Scan andParaDic:para andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJOrderPaymentData *data = [GJOrderPaymentData yy_modelWithJSON:response];
        success(data);
    } andFailedCallback:failureBlock];
}

- (void)requestUserPayRecordSuccess:(void (^)(GJOrderListData *))success failure:(HTTPTaskFailureBlock)failureBlock{
    [[GJHttpNetworkingManager sharedInstance] requestAllDataPostWithPathUrl:Mine_User_PayRecord andParaDic:@{@"api_token":APP_USER.userInfo.api_token} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJOrderListData *data = [GJOrderListData yy_modelWithJSON:response];
        success(data);
    } andFailedCallback:failureBlock];
}

- (void)requestScoreGiftListWithCatid:(NSString *)catid success:(void (^)(GJGiftListSelectData *))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSDictionary *para = @{@"catid":JudgeContainerCountIsNull(catid)?@"":catid,
                           @"api_token":APP_USER.userInfo.api_token,
                           @"lq_type":@"0"
                           };
    [[GJHttpNetworkingManager sharedInstance] requestAllDataPostWithPathUrl:Mine_Score_List andParaDic:para andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJGiftListSelectData *data = [[GJGiftListSelectData alloc] init];
        data.list = [NSArray yy_modelArrayWithClass:GJGiftListSelectDataList.class json:response[@"data"]].mutableCopy;
        data.user_credits = [response[@"user_credits"] floatValue];
        successBlock(data);
    } andFailedCallback:failureBlock];
}

@end
