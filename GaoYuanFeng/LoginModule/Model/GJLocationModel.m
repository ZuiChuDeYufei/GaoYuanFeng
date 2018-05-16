//
//  GJLocationModel.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJLocationModel.h"

@implementation GJLocationModel

+(GJLocationModel *)installCityId:(NSString *)cityId name:(NSString *)cityName pinyinName:(NSString *)pinyinName {
    GJLocationModel *model = [GJLocationModel new];
    model.cityId = cityId;
    model.cityName = cityName;
    model.pinyinName = pinyinName;
    return model;
}


static NSDictionary *locationPlist;

// 获取cityID
- (NSString *)cityId {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationPlist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LocationCityList" ofType:@"plist"]];
    });
    
    // 如果cityId 为空 从本地获取出来
    if (JudgeContainerCountIsNull(_cityId)) {
        _cityId = JudgeContainerCountIsNull([locationPlist objectForKey:_cityName]) ? @"" : locationPlist[_cityName];
    }
    return _cityId;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.cityId forKey:@"cityId"];
    [encoder encodeObject:self.cityName forKey:@"cityName"];
    [encoder encodeObject:self.pinyinName forKey:@"pinyinName"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.cityId = [decoder decodeObjectForKey:@"cityId"];
        self.cityName = [decoder decodeObjectForKey:@"cityName"];
        self.pinyinName = [decoder decodeObjectForKey:@"pinyinName"];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    GJLocationModel *new = (GJLocationModel *)object;
    if ([new.cityId isEqualToString:self.cityId] || [new.cityName isEqualToString:self.cityName]) {
        return YES;
    }
    return NO;
}

@end
