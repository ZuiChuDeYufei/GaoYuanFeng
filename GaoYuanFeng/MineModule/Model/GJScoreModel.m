//
//  GJScoreModel.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJScoreModel.h"

@implementation GJScoreModelList

@end

@implementation GJScoreModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : GJScoreModelList.class};
}
@end

