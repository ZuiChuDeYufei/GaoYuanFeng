//
//  GJTabBarController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJTabBarController.h"
#import "GJTabBar.h"
#import "GJHomeViewController.h"

@interface GJTabBarController () <LGJTabBarDelegate, UITabBarControllerDelegate>
@property (strong, nonatomic) GJHomeViewController *homePageVC;

@end

@implementation GJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    // Create owner-tabbar, use KVC repleace system-tabbar  with owner-tabbar.
    GJTabBar *tabbar = [[GJTabBar alloc] init];
    tabbar.myDelegate = self;
//    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    
    _homePageVC = [[GJHomeViewController alloc] init];
    
    
    GJBaseNavigationController *firstTab = [[GJBaseNavigationController alloc] initWithRootViewController:_homePageVC];
//    firstTab.tabBarItem.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    firstTab.tabBarItem.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    firstTab.tabBarItem.title = @"首页";
    
    
    self.viewControllers = @[firstTab];
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
