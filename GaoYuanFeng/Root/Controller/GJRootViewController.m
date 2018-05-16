//
//  GJRootViewController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJRootViewController.h"
#import "GJLaunchViewController.h"
#import "GJTabBarController.h"

@interface GJRootViewController ()
@property (nonatomic, strong) GJLaunchViewController *launchVC;
@end

@implementation GJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInterfaceAppearence];
    [self setLauncher];
}

- (void)setInterfaceAppearence {
    
}

- (void)setLauncher {
    __weak typeof(self)weakSelf = self;
    _launchVC = [[GJLaunchViewController alloc] init];
    [self addChildViewController:_launchVC];
    [self.view addSubview:_launchVC.view];
    _launchVC.finishBlock = ^{
        GJTabBarController *tabbar = [[GJTabBarController alloc] init];
        [tabbar didMoveToParentViewController:weakSelf];
        [weakSelf addChildViewController:tabbar];
        tabbar.selectedIndex = 0;
        tabbar.view.alpha = 0;
        [weakSelf.view addSubview:tabbar.view];
        [UIView animateWithDuration:0.7 animations:^{
            tabbar.view.alpha = 1;
        } completion:^(BOOL finished) {
            [weakSelf.launchVC.view removeFromSuperview];
            [weakSelf.launchVC removeFromParentViewController];
        }];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
