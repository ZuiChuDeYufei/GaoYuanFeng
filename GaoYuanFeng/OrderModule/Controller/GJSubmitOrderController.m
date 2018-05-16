//
//  GJSubmitOrderController.m
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSubmitOrderController.h"
#import "GJReceiveCompleteController.h"
#import "GJBaseTableView.h"
#import "GJSubmitOrderBottomCell.h"
#import "GJSubmitOrderMiddleCell.h"
#import "GJSubmitOrderTopCell.h"
#import "GJSubmitOrderMoreCell.h"
#import "GJAdressPickerController.h"

@interface GJSubmitOrderController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJSubmitOrderAdressData *> *labelSource;
@property (nonatomic, assign) NSInteger defaultTopCells;
@property (nonatomic, assign) BOOL canLoadMore;
@property (nonatomic, strong) GJSubmitOrderMoreCell *moreCell;
@property (nonatomic, strong) GJAdressPickerController *pickerVC;
@property (nonatomic, assign) NSInteger selectAdressRow;
@property (nonatomic, assign) RegionTypes currentType;
@property (nonatomic, strong) Province *currProvince;
@property (nonatomic, strong) City *currCity;
@property (nonatomic, strong) District *currDistrict;
@end

@implementation GJSubmitOrderController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (SCREEN_H >= kGJIphoneX) {
        _bottomBtn.frame = CGRectMake(0, self.view.height-AdaptatSize(49)-25, SCREEN_W, AdaptatSize(49));
        _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-NavBar_H-AdaptatSize(49)-25);
    }else {
        _bottomBtn.frame = CGRectMake(0, self.view.height-AdaptatSize(49), SCREEN_W, AdaptatSize(49));
        _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-NavBar_H-AdaptatSize(49));
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    GJSubmitOrderAdressData *d1 = [GJSubmitOrderAdressData dataLeft:@"收货人" right:@"请填写您的中文姓名"];
    GJSubmitOrderAdressData *d2 = [GJSubmitOrderAdressData dataLeft:@"联系电话" right:@"电话号码"];
    GJSubmitOrderAdressData *d3 = [GJSubmitOrderAdressData dataLeft:@"省" right:@"请选择省"];
    GJSubmitOrderAdressData *d4 = [GJSubmitOrderAdressData dataLeft:@"市" right:@"请选择市"];
    GJSubmitOrderAdressData *d5 = [GJSubmitOrderAdressData dataLeft:@"区" right:@"请选择区"];
    GJSubmitOrderAdressData *d6 = [GJSubmitOrderAdressData dataLeft:@"详细地址" right:@"请输入详细地址"];
    _labelSource = @[d1, d2, d3, d4, d5, d6];
    _defaultTopCells = 3;
}

- (void)initializationSubView {
    self.title = @"提交订单";
    [self allowBack];
    _pickerVC = [[GJAdressPickerController alloc] init];
    self.view.backgroundColor = [UIColor colorWithRGB:247 g:247 b:247];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.bottomBtn];
    [self.view addSubview:self.tableView];
    [self blockHanddle];
}

- (void)initializationNetWorking {}

#pragma mark - Request Handle
- (void)requestSubmitOrderWithName:(NSString *)name phone:(NSString *)phone detail:(NSString *)detail {
    
    // TODO
    
    GJReceiveCompleteController *vc = [[GJReceiveCompleteController alloc] init];
    vc.interactivePopDisabled = YES;
    [vc pushPageWith:self];
}

#pragma mark - Private methods
- (void)clearCellsAdress {
    if (_currProvince == nil) {
        return;
    }
    NSIndexPath *path = [NSIndexPath indexPathForRow:4 inSection:1];
    GJSubmitOrderBottomCell *cell = [self getBottomCellRow:4];
    [cell setTitleBlack:@""];
    NSIndexPath *path1 = [NSIndexPath indexPathForRow:5 inSection:1];
    GJSubmitOrderBottomCell *cell1 = [self getBottomCellRow:5];
    [cell1 setTitleBlack:@""];
    _currCity = nil;
    _currDistrict = nil;
    [_tableView reloadRowsAtIndexPaths:@[path, path1] withRowAnimation:UITableViewRowAnimationNone];
}

- (BOOL)isLastCellBackStatus:(NSIndexPath *)indexPath {
    if (_seleteArr.count > _defaultTopCells && ((!_canLoadMore && indexPath.row == _defaultTopCells) || (_canLoadMore && indexPath.row == _seleteArr.count))) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - Public methods
- (GJSubmitOrderBottomCell *)getBottomCellRow:(NSInteger)row {
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:1];
    GJSubmitOrderBottomCell *cell = [self.tableView cellForRowAtIndexPath:path];
    return cell;
}

#pragma mark - Event response
- (void)bottomBtnClick {
    NSString *name = [self getBottomCellRow:1].cellText;
    NSString *phone = [self getBottomCellRow:2].cellText;
    NSString *detailAddress = [self getBottomCellRow:6].cellText;
    if (name.length == 0) {
        ShowWaringAlertHUD(@"请输入您的姓名", nil);
        return ;
    }
    if (![phone isValidMobileNumber]) {
        ShowWaringAlertHUD(@"请输入正确的手机号", nil);
        return ;
    }
    if (phone.length != 11) {
        ShowWaringAlertHUD(@"手机号过长", nil);
        return ;
    }
    if (!_currProvince || !_currCity || !_currDistrict) {
        ShowWaringAlertHUD(@"请选择完整地址", nil);
        return ;
    }
    if (detailAddress.length == 0) {
        ShowWaringAlertHUD(@"请输入详细地址", nil);
        return ;
    }
    [self requestSubmitOrderWithName:name phone:phone detail:detailAddress];
}

- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _pickerVC.selectRow = ^(NSInteger row) {
        GJSubmitOrderBottomCell *cell = [weakSelf getBottomCellRow:weakSelf.selectAdressRow];
        
        if (_currentType == RegionProvince) {
            Province *prov = APP_USER.regionData.data[row];
            [cell setTitleBlack:prov.province_name];
            if (weakSelf.currProvince != prov) {
                [weakSelf clearCellsAdress];
            }
            _currProvince = prov;
        }
        if (_currentType == RegionCity) {
            _currCity = _currProvince.city[row];
            [cell setTitleBlack:weakSelf.currCity.city_name];
        }
        if (_currentType == RegionDistrict) {
            _currDistrict = _currCity.district[row];
            [cell setTitleBlack:weakSelf.currDistrict.district_name];
        }
    };
}

#pragma mark - Custom delegate

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([self isLastCellBackStatus:indexPath]) {
            return [self moreCell:tableView];
        }else {
            return [self topCell:tableView index:indexPath];
        }
    }else {
        if (indexPath.row == 0) {
            return [self middleCell:tableView];
        }else {
            return [self bottomCell:tableView indexP:indexPath];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_seleteArr.count > _defaultTopCells && !_canLoadMore) {
            return _defaultTopCells + 1;
        }else {
            if (_seleteArr.count > _defaultTopCells) {
                return _seleteArr.count + 1;
            }else {
                return _seleteArr.count;
            }
        }
    }else {
        return _labelSource.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([self isLastCellBackStatus:indexPath]) {
            return AdaptatSize(40);
        }else {
            return AdaptatSize(95);
        }
    }else {
        if (indexPath.row == 0) {
            return AdaptatSize(47);
        }else {
            return AdaptatSize(61);
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([self isLastCellBackStatus:indexPath]) {    // 更多
            _canLoadMore = !_canLoadMore;
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            _moreCell.moreStatus = _canLoadMore;
        }
    }else {
        if (indexPath.row >= 3 && indexPath.row <= 5) { // 地址选择器
            [self.view endEditing:YES];
            if (indexPath.row == 4 && !_currProvince) {
                ShowWaringAlertHUD(@"请先选择省", nil);
                return;
            }else if (indexPath.row == 5 && !_currCity) {
                ShowWaringAlertHUD(@"请先选择市", nil);
                return ;
            }
            _selectAdressRow = indexPath.row;
            _pickerVC.currProvince = _currProvince;
            _pickerVC.currCity = _currCity;
            _currentType = _pickerVC.regionType = _selectAdressRow-2;
            [_pickerVC presentSelf:self];
        }
    }
}

// cells
// 选择的礼品
- (GJSubmitOrderTopCell *)topCell:(UITableView *)tableView index:(NSIndexPath *)indexPath {
    GJSubmitOrderTopCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJSubmitOrderTopCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJSubmitOrderTopCell alloc] initWithStyle:[GJSubmitOrderTopCell expectingStyle] reuseIdentifier:[GJSubmitOrderTopCell reuseIndentifier]];
    }
    cell.giftData = _seleteArr[indexPath.row];
    return cell;
}

// 收货信息
- (GJSubmitOrderMiddleCell *)middleCell:(UITableView *)tableView {
    GJSubmitOrderMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJSubmitOrderMiddleCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJSubmitOrderMiddleCell alloc] initWithStyle:[GJSubmitOrderMiddleCell expectingStyle] reuseIdentifier:[GJSubmitOrderMiddleCell reuseIndentifier]];
    }
    return cell;
}

// 信息填写
- (GJSubmitOrderBottomCell *)bottomCell:(UITableView *)tableView indexP:(NSIndexPath *)indexP {
    GJSubmitOrderBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJSubmitOrderBottomCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJSubmitOrderBottomCell alloc] initWithStyle:[GJSubmitOrderBottomCell expectingStyle] reuseIdentifier:[GJSubmitOrderBottomCell reuseIndentifier]];
    }
    if (indexP.row >= 3 && indexP.row <= 5) {
        [cell canEdit:NO];
    }else {
        [cell canEdit:YES];
    }
    cell.model = _labelSource[indexP.row-1];
    return cell;
}

- (GJSubmitOrderMoreCell *)moreCell:(UITableView *)tableView {
    if (!_moreCell) {
        _moreCell = [[GJSubmitOrderMoreCell alloc] initWithStyle:[GJSubmitOrderMoreCell expectingStyle] reuseIdentifier:[GJSubmitOrderMoreCell reuseIndentifier]];
    }
    return _moreCell;
}

#pragma mark - Getter/Setter
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] init];
        _bottomBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:15]);
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:[UIColor colorWithRGB:255 g:38 b:0]];
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = APP_CONFIG.separatorLineColor;
    }
    return _tableView;
}

@end
