//
//  GJCustomCalloutView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface GJCustomCalloutView : MACustomCalloutView
@property (nonatomic, strong) NSString *title;
+ (GJCustomCalloutView *)calloutInstall;
@end
