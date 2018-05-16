//
//  LineDashPolyline.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/22.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "LineDashPolyline.h"

@implementation LineDashPolyline

@synthesize coordinate;

@synthesize boundingMapRect;

- (id)initWithPolyline:(MAPolyline *)polyline
{
    self = [super init];
    if (self)
    {
        self.polyline = polyline;
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate
{
    return [_polyline coordinate];
}

- (MAMapRect) boundingMapRect
{
    return [_polyline boundingMapRect];
}

@end
