//
//  GJHomeFilterButton.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJHomeFilterButton : UIView
@property (nonatomic, copy) void (^filterClickBlock)(void);
+ (GJHomeFilterButton *)install;
@end
