//
//  GJSearchController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSearchController.h"
#import "TKSearchHistoryNavView.h"
#import "GJTradeAreaTopView.h"
#import "GJTradeAreaTBVCell.h"
#import "GJSearchManager.h"
#import "GJSearchStoreDetalVC.h"
#import "GJHomeManager.h"

@interface GJSearchController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) GJTradeAreaTopView *tradeareaTopView;
@property (nonatomic, strong) TKSearchHistoryNavView *searchView;
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJSearchManager *searchManager;
@property (nonatomic, strong) NSArray<GJHomeSearchPointData *> *dataSources;
@property (nonatomic, assign) CGFloat showH;
@property (nonatomic, assign) CGFloat showY;
@property (nonatomic, assign) CGFloat headerInitHeight;
@property (nonatomic, assign) BOOL isLocateClick;
@property (nonatomic, strong) GJHomeManager *homeManager;
@end

@implementation GJSearchController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (_isLocateClick) return;
    _tradeareaTopView.frame = CGRectMake(0, 0, self.view.width, AdaptatSize(410));
    _tableView.frame = CGRectMake(0, _headerInitHeight, self.view.width, self.view.height-_headerInitHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_searchView.searchTF resignFirstResponder];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _showH = (int)((SCREEN_H == kGJIphoneX) ? AdaptatSize(220) : AdaptatSize(220));
    _showY = (int)(NavBar_H+AdaptatSize(15));
    _headerInitHeight = (SCREEN_H == kGJIphoneX) ? AdaptatSize(115) : AdaptatSize(110);
    _isLocateClick = NO;
    _searchManager = [[GJSearchManager alloc] init];
}

- (void)initializationSubView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    self.navigationItem.titleView = self.titleView;
    
    __weak typeof(self)weakSelf = self;
    [self.view addSubview:self.tradeareaTopView];
    self.tradeareaTopView.naviRefreshLocateBlock = ^{
        [weakSelf setLocation];
    };
    _tradeareaTopView.searchPageClickPage = ^{
        [weakSelf.searchView.searchTF resignFirstResponder];
    };
    [self.view addSubview:self.tableView];
}

- (void)initializationNetWorking {
    if (!_filterZoneData) {
        _homeManager = [[GJHomeManager alloc] init];
        [_homeManager requestFilterZoneListCityID:nil success:^(GJFilterZoneData *models) {
            _tradeareaTopView.filterZoneData = models;
        } failure:^(NSURLResponse *urlResponse, NSError *error) {
        }];
    }else _tradeareaTopView.filterZoneData = _filterZoneData;
}

#pragma mark - Request Handle
- (void)requestSearchKeyword:(NSString *)keyword {
    [self.view.loadingView startAnimation];
    [_searchManager requestSupplierDetailWithKW:keyword latalongi:_currentLocation success:^(NSArray<GJHomeSearchPointData *> *models) {
        [self.view.loadingView stopAnimation];
        _dataSources = models;
        if (_dataSources.count == 0) {
            ShowWaringAlertHUD(@"没有搜到匹配内容", nil);
        }
        [_tableView reloadData];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
    }];
}

#pragma mark - Private methods
- (void)setCurrentLocation:(CLLocationCoordinate2D)currentLocation {
    _currentLocation = currentLocation;
    [self setLocation];
}

- (void)setLocation {
    [_searchView.searchTF resignFirstResponder];
    [self.tradeareaTopView setCurrentLocation:nil];
    [self.aMapManager updateLocation:self.currentLocation update:^(NSString *data) {
        [self.tradeareaTopView setCurrentLocation:data];
        _isLocateClick = YES;
    }];
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)naviBarRightBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Custom delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (JudgeContainerCountIsNull(textField.text)) {
        ShowWaringAlertHUD(@"请输入搜索内容", nil);
        return NO;
    }
    [textField resignFirstResponder];
    [self requestSearchKeyword:textField.text];
    return YES;
}

#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJTradeAreaTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJTradeAreaTBVCell reuseIndentifier]];
    if (!cell) cell = [[GJTradeAreaTBVCell alloc] initWithStyle:[GJTradeAreaTBVCell expectingStyle] reuseIdentifier:[GJTradeAreaTBVCell reuseIndentifier]];
    cell.listData = _dataSources[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GJTradeAreaTBVCell height];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tradeareaTopView.isExpandSelf) {
        [self.tradeareaTopView recoverSelf];
        return ;
    }
    [_searchView.searchTF resignFirstResponder];
    GJSearchStoreDetalVC *storeDetail = [[GJSearchStoreDetalVC alloc] init];
    storeDetail.pointData = _dataSources[indexPath.row];
    __weak typeof(self)weakSelf = self;
    storeDetail.naviRouteCBlock = ^(CLLocationCoordinate2D location, GJHomeSearchPointData *data) {
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            BLOCK_SAFE(weakSelf.naviRouteCCBlock)(location, data);
    };
    [self.navigationController pushViewController:storeDetail animated:YES];
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _tableView;
}

- (GJTradeAreaTopView *)tradeareaTopView {
    if (!_tradeareaTopView) {
        _tradeareaTopView = [[GJTradeAreaTopView alloc] init];
        _tradeareaTopView.areaTable = self.tableView;
        _tradeareaTopView.fullViewBtn.hidden = YES;
    }
    return _tradeareaTopView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.width-50, 44)];
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(_titleView.width-70, 0, 40, 40)];
        cancelButton.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:16]);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:APP_CONFIG.blackTextColor forState:UIControlStateNormal];
        [cancelButton setTitleColor:APP_CONFIG.blackTextColor forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(naviBarRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:cancelButton];
        _searchView = [[TKSearchHistoryNavView alloc] initWithFrame:CGRectMake(10, 1, _titleView.width-90, 43)];
        _searchView.searchTF.delegate = self;
        [_searchView.searchTF becomeFirstResponder];
        [_titleView addSubview:_searchView];
    }
    return _titleView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        _leftButton.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:16]);
        if (JudgeContainerCountIsNull(_currCity)) {
            [_leftButton setTitle:@"贵阳" forState:UIControlStateNormal];
        }else {
            NSMutableString *str = _currCity.mutableCopy;
            [str deleteCharactersInRange:[str rangeOfString:@"市"]];
            [_leftButton setTitle:str forState:UIControlStateNormal];
        }
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
        [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    }
    return _leftButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
