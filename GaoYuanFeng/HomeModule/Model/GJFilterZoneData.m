//
//  GJFilterZoneData.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/12.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJFilterZoneData.h"

@implementation GJFilterZoneDataRegion
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : GJFilterZoneDataRegion.class};
}
@end

@implementation GJFilterZoneDataType
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : GJFilterZoneDataType.class};
}
@end

@implementation GJFilterZoneData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"type" : GJFilterZoneDataType.class,
             @"region" : GJFilterZoneDataRegion.class};
}
@end
