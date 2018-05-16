//
//  GJStoreDetailController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJStoreDetailController.h"
#import "GJStoreDetailTopCell.h"
#import "GJStoreSDetailBottomCell.h"
#import "GJQRCodeController.h"
#import "GJHomeSearchPointData.h"
#import "GJCashDeskController.h"

@interface GJStoreDetailController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJBaseTableViewCell *> *cellArr;
@property (nonatomic, assign) CGFloat showY;
@property (nonatomic, strong) GJStoreDetailTopCell *topCell;
@property (nonatomic, strong) GJStoreSDetailBottomCell *bottomCell;
@property (nonatomic, strong) GJQRCodeController *qrCode;
@end

@implementation GJStoreDetailController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _backView.frame = CGRectMake(15, _showY, SCREEN_W-30, SCREEN_H-NavBar_H-AdaptatSize(40));
    _tableView.frame = _backView.bounds;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationPageSheet;
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return self;
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
    _topCell.backBlock = ^{
        [weakSelf back];
    };
    _bottomCell = [[GJStoreSDetailBottomCell alloc] init];
    _bottomCell.naviRouteBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
        BLOCK_SAFE(weakSelf.naviRouteCBlock)(CLLocationCoordinate2DMake([weakSelf.pointData.wd doubleValue], [weakSelf.pointData.jd doubleValue]));
    };
    
    _qrCode = [[GJQRCodeController alloc] init];
    _qrCode.blockQRCodeScanResultURL = ^(NSString *resultURL) {
        GJCashDeskController *cashDesk = [[GJCashDeskController alloc] init];
        cashDesk.resultURL = resultURL;
        cashDesk.interactivePopDisabled = YES;
        [cashDesk pushPageWith:weakSelf.qrCode];
        BLOCK_SAFE(weakSelf.dismissAfterBlock)();
    };
    _bottomCell.scanBtnBlock = ^{
        [GJLoginRegisterController needLoginPresentWithVC:weakSelf loginSucessBlcok:^{
            [weakSelf.qrCode pushPageWith:weakSelf];
        }];
    };
    _cellArr = @[_topCell, _bottomCell];
}

- (void)initializationSubView {
    _showY = (int)(NavBar_H+AdaptatSize(15));
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.tableView];
}

- (void)initializationNetWorking {}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
    BLOCK_SAFE(_dismissAfterBlock)();
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self back];
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.clipsToBounds = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.layer.cornerRadius = 8;
    }
    return _tableView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.shadowColor = [UIColor blackColor].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0, 0);
        _backView.layer.shadowOpacity = 0.6;
        _backView.layer.shadowRadius = 8;
        _backView.layer.cornerRadius = 8;
    }
    return _backView;
}

- (void)setPointData:(GJHomeSearchPointData *)pointData {
    _pointData = pointData;
    _topCell.pointData = _pointData;
    _bottomCell.pointData = _pointData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
