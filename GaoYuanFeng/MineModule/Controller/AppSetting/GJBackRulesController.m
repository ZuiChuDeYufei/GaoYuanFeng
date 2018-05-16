//
//  GJBackRulesController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBackRulesController.h"

@interface GJBackRulesController ()

@end

@implementation GJBackRulesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退换货规则";
    [self allowBack];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showShadorOnNaviBar:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
