//
//  GJAlipayModel.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJPayBaseModel.h"
#import <AlipaySDK/AlipaySDK.h>

@interface GJAlipayModel : GJPayBaseModel

-(void)jumpToPayWithOrder:(GJOrderPaymentData *)order;

@end
