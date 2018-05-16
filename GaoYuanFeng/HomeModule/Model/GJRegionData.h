//
//  GJRegionData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/8.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface District : GJBaseModel <NSCoding>
@property (nonatomic, strong) NSString *district_id;
@property (nonatomic, strong) NSString *district_name;
@end

@interface City : GJBaseModel <NSCoding>
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *city_name;
@property (nonatomic, strong) NSArray <District *> *district;
@end

@interface Province : GJBaseModel <NSCoding>
@property (nonatomic, strong) NSString *province_id;
@property (nonatomic, strong) NSString *province_name;
@property (nonatomic, strong) NSArray <City *> *city;
@end

@interface GJRegionData : GJBaseModel <NSCoding>
@property (nonatomic, strong) NSArray <Province *> *data;
@end
