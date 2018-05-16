//
//  GJAddressListData.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAddressListData.h"

@implementation GJAddressListData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

+(GJAddressListData *)modelWithID:(NSString *)ID uid:(NSString *)uid name:(NSString *)name phone:(NSString *)phone province:(NSString *)province city:(NSString *)city district:(NSString *)district address:(NSString *)address is_default:(BOOL)is_default created_at:(NSString *)created_at {
    GJAddressListData *data = [[GJAddressListData alloc] init];
    data.ID = ID;
    data.uid = uid;
    data.name = name;
    data.phone = phone;
    data.province = province;
    data.city = city;
    data.district = district;
    data.address = address;
    data.is_default = is_default;
    data.created_at = created_at;
    return data;
}
@end
