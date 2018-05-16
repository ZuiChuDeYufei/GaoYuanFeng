//
//  GJSearchStoreDetalVC.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSearchStoreDetalVC.h"
#import "GJStoreDetailTopCell.h"
#import "GJStoreSDetailBottomCell.h"
#import "GJQRCodeController.h"
#import "GJHomeSearchPointData.h"
#import "GJCashDeskController.h"

@interface GJSearchStoreDetalVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJBaseTableViewCell *> *cellArr;
@property (nonatomic, strong) GJStoreDetailTopCell *topCell;
@property (nonatomic, strong) GJStoreSDetailBottomCell *bottomCell;
@property (nonatomic, strong) GJQRCodeController *qrCode;
@end

@implementation GJSearchStoreDetalVC

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

#pragma mark - Iniitalization methods
- (void)initializationData {
    __weak typeof(self)weakSelf = self;
    
    _topCell = [[GJStoreDetailTopCell alloc] init];
    _topCell.closePageBtn.hidden = YES;
    _bottomCell = [[GJStoreSDetailBottomCell alloc] init];
    _bottomCell.naviRouteBlock = ^{
        [weakSelf backToRoot:YES];
        BLOCK_SAFE(weakSelf.naviRouteCBlock)(CLLocationCoordinate2DMake([weakSelf.pointData.wd doubleValue], [weakSelf.pointData.jd doubleValue]), weakSelf.pointData);
    };
    
    _qrCode = [[GJQRCodeController alloc] init];
    _qrCode.blockQRCodeScanResultURL = ^(NSString *resultURL) {
        GJCashDeskController *cashDesk = [[GJCashDeskController alloc] init];
        cashDesk.resultURL = resultURL;
        cashDesk.interactivePopDisabled = YES;
        [cashDesk pushPageWith:weakSelf.qrCode];
    };
    _bottomCell.scanBtnBlock = ^{
        [GJLoginRegisterController needLoginPresentWithVC:weakSelf loginSucessBlcok:^{
            [weakSelf.qrCode pushPageWith:weakSelf];
        }];
    };
    _cellArr = @[_topCell, _bottomCell];
    _topCell.pointData = _pointData;
    _bottomCell.pointData = _pointData;
}

- (void)initializationSubView {
    self.title = @"店铺详情";
    [self allowBack];
    [self.view addSubview:self.tableView];
}

- (void)initializationNetWorking {}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)backToRoot:(BOOL)root {
    if (root) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellArr[indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellArr[indexPath.row].height;
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
