//
//  GJAddressListController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAddressListController.h"
#import "GJAdressListCell.h"
#import "GJAdressListFooter.h"
#import "GJAddNewAddressVC.h"
#import "GJMineManager.h"
#import "GJAddressListData.h"

@interface GJAddressListController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJAddressListData *> *listModel;
@property (nonatomic, strong) GJAdressListFooter *footer;
@property (nonatomic, strong) GJMineManager *mineManager;
@end

@implementation GJAddressListController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestAddressList];
}

#pragma mark - Iniitalization methods
- (void)initializationData {}

- (void)initializationSubView {
    self.title = @"收货地址";
    [self allowBack];
    [self.view addSubview:self.tableView];
    _footer = [[GJAdressListFooter alloc] init];
    _mineManager = [[GJMineManager alloc] init];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle
- (void)requestAddressList {
    [_mineManager requestAddressListSuccess:^(NSArray<GJAddressListData *> *data) {
        _listModel = data;
        if (_listModel.count == 0) {
            ShowWaringAlertHUD(@"暂无地址", nil);
        }else {
            [_tableView reloadData];
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
    }];
}

- (void)requestSetDefault:(GJAddressListData *)data {
    [self.view.loadingView startAnimation];
    [_mineManager requestAddressSetDefaultWithID:data.ID uid:data.uid success:^(NSURLResponse *urlResponse, id response) {
        [self.view.loadingView stopAnimation];
        [self requestAddressList];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
    }];
}

- (void)requestDelete:(GJAddressListData *)data {
    [self.view.loadingView startAnimation];
    [_mineManager requestAddressDeleteWithID:data.ID uid:data.uid success:^(NSURLResponse *urlResponse, id response) {
        [self.view.loadingView stopAnimation];
        [self requestAddressList];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
    }];
}

#pragma mark - Private methods
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _footer.blockAddNewAddress = ^{
        [weakSelf pushAddPage];
    };
}

- (void)blockHanddleCell:(GJAdressListCell *)cell {
    __weak typeof(self)weakSelf = self;
    GJAddressListData *model = cell.model;
    cell.blockDelete = ^{
        [weakSelf requestDelete:model];
    };
    cell.blockSetDefault = ^{
        [weakSelf requestSetDefault:model];
    };
}

#pragma mark - Public methods
- (void)pushAddPage {
    GJAddNewAddressVC *vc = [GJAddNewAddressVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJAdressListCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJAdressListCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJAdressListCell alloc] initWithStyle:[GJAdressListCell expectingStyle] reuseIdentifier:[GJAdressListCell reuseIndentifier]];
    }
    cell.context = self;
    cell.model = _listModel[indexPath.row];
    [self blockHanddleCell:cell];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AdaptatSize(175);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AdaptatSize(65);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return _footer;
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.backgroundColor = [UIColor colorWithRGB:247 g:248 b:250];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
