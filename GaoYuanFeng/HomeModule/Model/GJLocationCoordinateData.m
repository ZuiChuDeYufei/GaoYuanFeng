//
//  GJLocationCoordinateData.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/28.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJLocationCoordinateData.h"

@implementation GJLocationCoordinateData

+ (GJLocationCoordinateData *)modelWithLati:(CLLocationDegrees)lati longi:(CLLocationDegrees)longi {
    GJLocationCoordinateData *data = [GJLocationCoordinateData new];
    data.latitude = lati;
    data.longitude = longi;
    return data;
}

+ (NSArray<GJLocationCoordinateData *> *)arrayWithLatis:(NSArray *)latis longis:(NSArray *)longis {
    if (latis.count != longis.count) {
        return nil;
    }
    NSMutableArray <GJLocationCoordinateData *> *arrMu = @[].mutableCopy;
    for (int i = 0; i < latis.count; i ++) {
        GJLocationCoordinateData *data = [GJLocationCoordinateData modelWithLati:[latis[i] doubleValue] longi:[longis[i] doubleValue]];
        [arrMu addObject:data];
    }
    return arrMu;
}

@end
