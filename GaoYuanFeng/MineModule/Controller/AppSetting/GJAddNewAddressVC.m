//
//  GJAddNewAddressVC.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAddNewAddressVC.h"
#import "GJSubmitOrderBottomCell.h"
#import "GJAdressPickerController.h"
#import "GJAddNewAddressFooter.h"
#import "GJMineManager.h"
#import "GJAddressListData.h"

@interface GJAddNewAddressVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJSubmitOrderAdressData *> *labelSource;
@property (nonatomic, strong) GJAdressPickerController *pickerVC;
@property (nonatomic, assign) NSInteger selectAdressRow;
@property (nonatomic, assign) RegionTypes currentType;
@property (nonatomic, strong) Province *currProvince;
@property (nonatomic, strong) City *currCity;
@property (nonatomic, strong) District *currDistrict;
@property (nonatomic, strong) GJAddNewAddressFooter *footer;
@property (nonatomic, strong) GJMineManager *mineManager;
@property (nonatomic, assign) BOOL isDefaultAddress;
@end

@implementation GJAddNewAddressVC

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_data) {
        [[self getBottomCellRow:0] setTitleBlack:_data.name];
        [[self getBottomCellRow:1] setTitleBlack:_data.phone];
        [_footer setDefaultBtnStatus:_data.is_default];
    }
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
}

- (void)initializationSubView {
    self.title = _data ? @"编辑地址" :@"添加新地址";
    [self allowBack];
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, APP_CONFIG.appMainColor,NSForegroundColorAttributeName, nil];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateHighlighted];
    
    _footer = [[GJAddNewAddressFooter alloc] init];
    _pickerVC = [[GJAdressPickerController alloc] init];
    _mineManager = [[GJMineManager alloc] init];
    [self blockHanddle];
}

- (void)initializationNetWorking {}

#pragma mark - Request Handle
- (void)requestSubmitOrderWithName:(NSString *)name phone:(NSString *)phone detail:(NSString *)detail {
    GJAddressListData *data = [GJAddressListData modelWithID:nil uid:nil name:name phone:phone province:_currProvince.province_id city:_currCity.city_id district:_currDistrict.district_id address:detail is_default:_isDefaultAddress created_at:nil];
    if (_data) {
        [self requestUpdateAddress:data];
    }else {
        [self requestAddAddress:data];
    }
}

- (void)requestAddAddress:(GJAddressListData *)data {
    [_mineManager requestAddUserAddressWithData:data success:^(NSURLResponse *urlResponse, id response) {
        ShowSucceedAlertHUD(@"添加成功", nil);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        ShowWaringAlertHUD(error.localizedDescription, nil);
    }];
}

- (void)requestUpdateAddress:(GJAddressListData *)data {
    data.uid = _data.uid;
    data.ID = _data.ID;
    [_mineManager requestUpdateUserAddressWithData:data success:^(NSURLResponse *urlResponse, id response) {
        ShowSucceedAlertHUD(@"修改成功", nil);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        ShowWaringAlertHUD(error.localizedDescription, nil);
    }];
}

#pragma mark - Private methods
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
    _footer.blockSwitchStatus = ^(BOOL status) {
        weakSelf.isDefaultAddress = status;
    };
}

#pragma mark - Public methods
- (GJSubmitOrderBottomCell *)getBottomCellRow:(NSInteger)row {
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    GJSubmitOrderBottomCell *cell = [self.tableView cellForRowAtIndexPath:path];
    return cell;
}

- (void)clearCellsAdress {
    if (_currProvince == nil) {
        return;
    }
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];;
    GJSubmitOrderBottomCell *cell = [self getBottomCellRow:3];
    [cell setTitleBlack:@""];
    NSIndexPath *path1 = [NSIndexPath indexPathForRow:3 inSection:0];
    GJSubmitOrderBottomCell *cell1 = [self getBottomCellRow:4];
    [cell1 setTitleBlack:@""];
    _currCity = nil;
    _currDistrict = nil;
    [_tableView reloadRowsAtIndexPaths:@[path, path1] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Event response
- (void)rightBtnClick {
    NSString *name = [self getBottomCellRow:0].cellText;
    NSString *phone = [self getBottomCellRow:1].cellText;
    NSString *detailAddress = [self getBottomCellRow:5].cellText;
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

#pragma mark - Custom delegate

#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _labelSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJSubmitOrderBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJSubmitOrderBottomCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJSubmitOrderBottomCell alloc] initWithStyle:[GJSubmitOrderBottomCell expectingStyle] reuseIdentifier:[GJSubmitOrderBottomCell reuseIndentifier]];
    }
    if (indexPath.row >= 2 && indexPath.row <= 4) {
        [cell canEdit:NO];
    }else {
        [cell canEdit:YES];
    }
    cell.model = _labelSource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AdaptatSize(61);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 2 && indexPath.row <= 4) { // 地址选择器
        [self.view endEditing:YES];
        if (indexPath.row == 3 && !_currProvince) {
            ShowWaringAlertHUD(@"请先选择省", nil);
            return;
        }else if (indexPath.row == 4 && !_currCity) {
            ShowWaringAlertHUD(@"请先选择市", nil);
            return ;
        }
        _selectAdressRow = indexPath.row;
        _pickerVC.currProvince = _currProvince;
        _pickerVC.currCity = _currCity;
        _currentType = _pickerVC.regionType = _selectAdressRow-1;
        [_pickerVC presentSelf:self];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return _footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AdaptatSize(61);
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRGB:247 g:247 b:250];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
