//
//  GJSubmitOrderAdressData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/27.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJSubmitOrderAdressData : GJBaseModel
@property (nonatomic, strong) NSString *leftText;
@property (nonatomic, strong) NSString *rightText;

+ (GJSubmitOrderAdressData *)dataLeft:(NSString *)left right:(NSString *)right;
@end
