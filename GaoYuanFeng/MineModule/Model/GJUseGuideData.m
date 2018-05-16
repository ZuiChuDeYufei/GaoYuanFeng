//
//  GJUseGuideData.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJUseGuideData.h"

@implementation GJUseGuideData
+ (GJUseGuideData *)dataWithTitle:(NSString *)title detail:(NSString *)detail {
    GJUseGuideData *data = [GJUseGuideData new];
    data.title = title;
    data.detail = detail;
    return data;
}

- (CGFloat)getCellHeight:(UIFont *)font width:(CGFloat)width {
    CGFloat h = getStringContentSize(font, CGSizeMake(width, MAXFLOAT), _detail).size.height;
    h += 110;
    return h;
}
@end
