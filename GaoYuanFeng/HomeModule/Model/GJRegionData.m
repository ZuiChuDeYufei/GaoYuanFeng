//
//  GJRegionData.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/8.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJRegionData.h"

@implementation District

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.district_id forKey:@"district_id"];
    [encoder encodeObject:self.district_name forKey:@"district_name"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.district_id = [decoder decodeObjectForKey:@"district_id"];
        self.district_name = [decoder decodeObjectForKey:@"district_name"];
    }
    return self;
}

@end

@implementation City

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"district" : District.class};
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.district forKey:@"district"];
    [encoder encodeObject:self.city_id forKey:@"city_id"];
    [encoder encodeObject:self.city_name forKey:@"city_name"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.district = [decoder decodeObjectForKey:@"district"];
        self.city_id = [decoder decodeObjectForKey:@"city_id"];
        self.city_name = [decoder decodeObjectForKey:@"city_name"];
    }
    return self;
}
@end

@implementation Province

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"city" : City.class};
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.province_id forKey:@"province_id"];
    [encoder encodeObject:self.province_name forKey:@"province_name"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.city = [decoder decodeObjectForKey:@"city"];
        self.province_id = [decoder decodeObjectForKey:@"province_id"];
        self.province_name = [decoder decodeObjectForKey:@"province_name"];
    }
    return self;
}

@end

@implementation GJRegionData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : Province.class};
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.data forKey:@"data"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.data = [decoder decodeObjectForKey:@"data"];
    }
    return self;
}

@end
