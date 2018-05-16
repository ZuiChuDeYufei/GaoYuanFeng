//
//  GJSubmitOrderAdressData.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/27.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSubmitOrderAdressData.h"

@implementation GJSubmitOrderAdressData

+(GJSubmitOrderAdressData *)dataLeft:(NSString *)left right:(NSString *)right {
    GJSubmitOrderAdressData *data = [[GJSubmitOrderAdressData alloc] init];
    data.leftText = left;
    data.rightText = right;
    return data;
}

@end
