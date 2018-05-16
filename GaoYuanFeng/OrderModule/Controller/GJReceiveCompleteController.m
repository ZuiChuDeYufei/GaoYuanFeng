//
//  GJReceiveCompleteController.m
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJReceiveCompleteController.h"
#import "GJPayCompleteButton.h"
#import "GJBaseTableView.h"
#import "GJBaseTableViewCell.h"
#import "GJBottomCell.h"
#import "GJTopCell.h"
#import "GJMineCenterController.h"

@interface GJReceiveCompleteController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJPayCompleteButton *bottomBtn;
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJBaseTableViewCell *> *cells;
@end

@implementation GJReceiveCompleteController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-NavBar_H-AdaptatSize(80));
    _bottomBtn.frame = CGRectMake(20, self.view.height-AdaptatSize(79), SCREEN_W-40, AdaptatSize(59));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    GJTopCell *topCell = [[GJTopCell alloc] init];
    GJBottomCell *bottom = [[GJBottomCell alloc] init];
    _cells = @[topCell, bottom];
}

- (void)initializationSubView {
    self.title = @"领取完成";
    [self allowBack];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomBtn];
    [self.view addSubview:self.tableView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _bottomBtn.buttonClick = ^{
        [weakSelf backAction];
    };
}

- (void)backAction {
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        if ([vc isKindOfClass:GJMineCenterController.class]) {
            break ;
        }
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cells[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cells[indexPath.row].height;
}

#pragma mark - Getter/Setter
- (GJPayCompleteButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [GJPayCompleteButton installTitle:@"返回首页"];
    }
    return _bottomBtn;
}

- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

@end
