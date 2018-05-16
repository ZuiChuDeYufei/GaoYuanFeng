//
//  MANaviPolyline.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/22.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MANaviAnnotation.h"

@interface MANaviPolyline : NSObject <MAOverlay>

@property (nonatomic, assign) MANaviAnnotationType type;
@property (nonatomic, strong) MAPolyline *polyline;

- (id)initWithPolyline:(MAPolyline *)polyline;

@end
