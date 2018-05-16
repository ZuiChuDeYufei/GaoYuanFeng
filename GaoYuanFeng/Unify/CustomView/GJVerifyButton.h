//
//  GJVerifyButton.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJVerifyButton : UIButton

@property (copy, nonatomic) void(^clickBtnHandle)(void);

- (id)initWithFrame:(CGRect)frame verifyTitle:(NSString *)title;
- (void)showActive:(BOOL)show;
- (void)startEndTime;

- (void)settingEnable:(BOOL)enable;

@end
