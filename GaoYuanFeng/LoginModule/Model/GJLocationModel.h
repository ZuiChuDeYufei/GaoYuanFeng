//
//  GJLocationModel.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJLocationModel : NSObject

@property (strong,nonatomic) NSString *cityId;
@property (strong,nonatomic) NSString *cityName;
@property (strong,nonatomic) NSString *pinyinName;

+(GJLocationModel *)installCityId:(NSString *)cityId name:(NSString *)cityName pinyinName:(NSString *)pinyinName;

@end
