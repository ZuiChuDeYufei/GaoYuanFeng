//
//  GJOrderManager.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/4.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJOrderPaymentData.h"

@class GJGiftListSelectData;
@class GJOrderListData;

@interface GJOrderManager : NSObject

/**
 支付成功查询订单状态

 @param pay_sn 支付编号
 @param success 成功
 @param failureBlock 失败
 */
- (void)requestPayOrderStatus:(NSString *)pay_sn
                      success:(void (^)(GJOrderPaymentSuccessData *data))success
                      failure:(HTTPTaskFailureBlock)failureBlock;

/**
 请求支付：微信、支付宝

 @param money 价格
 @param type 类型
 @param supplier_id 店铺ID
 @param success 成功
 @param failureBlock 失败
 */
- (void)requestPayWithMoney:(NSString *)money
                       type:(PayTypes)type
                supplier_id:(NSString *)supplier_id
                    success:(void (^)(GJOrderPaymentData *data))success
                    failure:(HTTPTaskFailureBlock)failureBlock;

/**
 用户买单记录

 @param success 成功
 @param failureBlock 失败
 */
- (void)requestUserPayRecordSuccess:(void (^)(GJOrderListData *data))success failure:(HTTPTaskFailureBlock)failureBlock;

/**
 获取积分商品列表
 
 @param catid 栏目（类型）ID
 @param successBlock 成功
 @param failureBlock 失败
 */
- (void)requestScoreGiftListWithCatid:(NSString *)catid
                              success:(void (^)(GJGiftListSelectData *data))successBlock
                              failure:(HTTPTaskFailureBlock)failureBlock;

@end
