//
//  UIViewController+Extension.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (BOOL)shouldPopback {
    return YES;
}

- (void)addSubview:(UIView *)aView
{
    [self.view addSubview:aView];
}


- (void)addDismissButtonForNavigationItem
{
    UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left_back"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissNavigationViewController)];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)dismissNavigationViewController
{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)removeNavigationChildControllerAtIndex:(NSInteger)index {
    NSArray *controllerList = self.navigationController.viewControllers;
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:controllerList];
    UIViewController *removeVC = temp[index];
    [temp removeObjectAtIndex:index];
    [removeVC willMoveToParentViewController:nil];
    [removeVC.view removeFromSuperview];
    [removeVC removeFromParentViewController];
    [self.navigationController setViewControllers:temp];
    
}

@end
