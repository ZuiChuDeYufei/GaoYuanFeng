//
//  GJOrderPaymentData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJOrderPaymentData : GJBaseModel
@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *partnerid;
@property (nonatomic, strong) NSString *prepayid;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *noncestr;
@property (nonatomic, strong) NSString *packages;
@property (nonatomic, strong) NSString *sign;

@property (nonatomic, strong) NSString *pay_sn;
@property (nonatomic, strong) NSString *payid;

@property (nonatomic, strong) NSString *paycode;
@end

@interface GJOrderPaymentSuccessData : GJBaseModel
@property (nonatomic, strong) NSString *supplier_name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *paytime;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *credits;
@end
