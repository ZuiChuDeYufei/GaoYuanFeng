//
//  GJLocationCoordinateData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/28.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"
#import <CoreLocation/CoreLocation.h>

@interface GJLocationCoordinateData : GJBaseModel
@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;

+ (GJLocationCoordinateData *)modelWithLati:(CLLocationDegrees)lati longi:(CLLocationDegrees)longi;

+ (NSArray <GJLocationCoordinateData *> *)arrayWithLatis:(NSArray *)latis longis:(NSArray *)longis;

@end
