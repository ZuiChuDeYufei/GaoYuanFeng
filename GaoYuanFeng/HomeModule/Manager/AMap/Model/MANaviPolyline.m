//
//  MANaviPolyline.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/22.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "MANaviPolyline.h"

@implementation MANaviPolyline

- (id)initWithPolyline:(MAPolyline *)polyline
{
    self = [super init];
    if (self)
    {
        self.polyline = polyline;
        self.type = MANaviAnnotationTypeDrive;
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
