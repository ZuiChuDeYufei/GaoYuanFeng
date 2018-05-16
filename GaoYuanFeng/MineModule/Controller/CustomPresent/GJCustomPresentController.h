//
//  GJCustomPresentController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseViewController.h"

@interface GJCustomPresentController : GJBaseViewController

@property (nonatomic, assign) BOOL interactivePopDisabled;

- (void)pushPageWith:(UIViewController *)context;

@end
