//
//  GJPayCompleteController.h
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCustomPresentController.h"

@class GJOrderPaymentSuccessData;

@interface GJPayCompleteController : GJCustomPresentController
@property (nonatomic, strong) GJOrderPaymentSuccessData *data;
@end
