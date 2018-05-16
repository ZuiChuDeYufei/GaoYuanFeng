//
//  GJMyOrderListController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMyOrderListController.h"
#import "GJOrderListCell.h"
#import "GJOrderListHeader.h"
#import "GJOrderManager.h"

@interface GJMyOrderListController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJOrderListData *model;
@property (nonatomic, strong) GJOrderManager *orderManager;
@end

@implementation GJMyOrderListController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-NavBar_H);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _orderManager = [[GJOrderManager alloc] init];
}

- (void)initializationSubView {
    self.navigationItem.title = @"全部买单";
    [self allowBack];
    [self.view addSubview:self.tableView];
}

- (void)initializationNetWorking {
    [self.view.loadingView startAnimation];
    [_orderManager requestUserPayRecordSuccess:^(GJOrderListData *data) {
        [self.view.loadingView stopAnimation];
        _model = data;
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
    }];
}

#pragma mark - Request Handle
- (void)requestPayList:(void (^)(NSInteger))block {
    _orderManager = [[GJOrderManager alloc] init];
    [_orderManager requestUserPayRecordSuccess:^(GJOrderListData *data) {
        BLOCK_SAFE(block)(data.data.count);
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
    }];
}

#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJOrderListCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJOrderListCell alloc] initWithStyle:[GJOrderListCell expectingStyle] reuseIdentifier:[GJOrderListCell reuseIndentifier]];
    }
    cell.model = _model.data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GJOrderListHeader *header = [GJOrderListHeader new];
    header.model = _model;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptatSize(100);
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
