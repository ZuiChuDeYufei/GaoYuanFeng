//
//  GJPayBaseModel.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJOrderPaymentData.h"

typedef enum : NSUInteger {
    GJPaymentTypeAlipay,
    GJPaymentTypeWexin,
    GJPaymentTypeUnionpay,
    GJPaymentTypeOffLine
} GJPaymentType;

@interface GJPayBaseModel : NSObject

@end
