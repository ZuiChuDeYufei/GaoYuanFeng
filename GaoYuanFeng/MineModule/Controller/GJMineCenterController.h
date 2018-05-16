//
//  GJMineCenterController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseViewController.h"
#import "GJMineView.h"

@interface GJMineCenterController : GJBaseViewController

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) GJMineView *mineView;
@property (nonatomic, strong) UIViewController *context;

@end
