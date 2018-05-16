//
//  GJLocateButton.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJLocateButton : UIView

@property (nonatomic, copy) void (^searchClickBlock)(void);
@property (nonatomic, assign) BOOL isSelected;

+ (GJLocateButton *)install;

@end
