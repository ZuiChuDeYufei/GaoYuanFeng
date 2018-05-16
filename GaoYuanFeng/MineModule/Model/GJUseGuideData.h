//
//  GJUseGuideData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJUseGuideData : GJBaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
- (CGFloat)getCellHeight:(UIFont *)font width:(CGFloat)width;
+ (GJUseGuideData *)dataWithTitle:(NSString *)title detail:(NSString *)detail;
@end
