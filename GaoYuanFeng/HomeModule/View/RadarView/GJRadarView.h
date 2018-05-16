//
//  GJRadarView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJRadarView : UIView

+ (GJRadarView *)installOn:(UIView *)view;
- (void)startRadar;
- (void)stopRadar;

@end
