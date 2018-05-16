//
//  GJTabBar.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJTabBar;

@protocol LGJTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(GJTabBar *)tabBar;
@end

@interface GJTabBar : UITabBar

@property (nonatomic, weak) id<LGJTabBarDelegate> myDelegate;

@end
