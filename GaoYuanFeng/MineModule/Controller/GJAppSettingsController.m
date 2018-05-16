//
//  GJAppSettingsController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAppSettingsController.h"
#import "GJAppSettingCell.h"
#import "GJInfoSettingCell.h"
#import "GJNormalCellModel.h"
#import "GJLoginRegisterController.h"
#import "GJAddressListController.h"
#import "GJProtocolController.h"
#import "GJMineManager.h"

@interface GJAppSettingsController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJNormalCellModel *> *models;
@property (nonatomic, strong) GJNormalCellModel *model1;
@property (nonatomic, strong) GJNormalCellModel *model2;
@property (nonatomic, strong) GJNormalCellModel *model3;
@property (nonatomic, strong) GJAppSettingCell *bottomCell;
@property (nonatomic, strong) GJMineManager *mineManager;
@end

@implementation GJAppSettingsController

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
    _bottomCell = [[GJAppSettingCell alloc] initWithStyle:[GJAppSettingCell expectingStyle] reuseIdentifier:[GJAppSettingCell reuseIndentifier]];
    
    _model1 = [GJNormalCellModel cellModelTitle:@"收货地址" detail:nil imageName:nil acessoryType:1];
    _model2 = [GJNormalCellModel cellModelTitle:@"清理缓存" detail:nil imageName:nil acessoryType:1];
    _model3 = [GJNormalCellModel cellModelTitle:@"用户协议" detail:nil imageName:nil acessoryType:1];
    _models = @[_model1, _model2, _model3];
}

- (void)initializationSubView {
    self.title = @"设置";
    [self allowBack];
    [self.view addSubview:self.tableView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    _mineManager = [[GJMineManager alloc] init];
}

#pragma mark - Request Handle
- (void)clearCache {
    [_mineManager requestUserInfoSuccess:^{
        APP_USER.userInfo.avatarImage = nil;
        [APP_USER saveLoginUserInfo:APP_USER.userInfo];
        ShowSucceedAlertHUD(@"Success", nil);
        BLOCK_SAFE(_clearSuccess)();
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        
    }];
}

#pragma mark - Private methods
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _bottomCell.logoutClick = ^{
        [APP_USER loginOut];
        BLOCK_SAFE(weakSelf.logouting)();
        [GJLoginRegisterController logOutPresentLoginControllerByVC:weakSelf loginSucessBlcok:nil];
    };
    _model1.didSelectBlock = ^(NSIndexPath *indexPath) {
        GJAddressListController *vc = [GJAddressListController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    _model2.didSelectBlock = ^(NSIndexPath *indexPath) {
        [weakSelf clearCache];
    };
    _model3.didSelectBlock = ^(NSIndexPath *indexPath) {
        GJProtocolController *vc = [GJProtocolController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _models.count) {
        return _bottomCell;
    }else {
        GJInfoSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJInfoSettingCell reuseIndentifier]];
        if (!cell) cell = [[GJInfoSettingCell alloc] initWithStyle:[GJInfoSettingCell expectingStyle] reuseIdentifier:[GJInfoSettingCell reuseIndentifier]];
        cell.cellModel = _models[indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _models.count) {
        return [_bottomCell height];
    }else {
        return [GJInfoSettingCell cellHeight];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BLOCK_SAFE(_models[indexPath.row].didSelectBlock)(indexPath);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = APP_CONFIG.appBackgroundColor;
    return v;
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = APP_CONFIG.appBackgroundColor;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
