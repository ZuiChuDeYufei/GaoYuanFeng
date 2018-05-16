//
//  GJInfoSettingsController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJInfoSettingsController.h"
#import "GJInfoSettingCell.h"
#import "GJInfoSettingTopCell.h"
#import "GJNormalCellModel.h"
#import "GJModifyNicknameVC.h"
#import "GJModifyRealnameVC.h"
#import "GJAdressPickerController.h"
#import "AlertManager.h"
#import "GJSystemHelper.h"
#import "GJMineManager.h"

@interface GJInfoSettingsController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJNormalCellModel *> *models;
@property (nonatomic, strong) NSArray <GJNormalCellModel *> *models_2;
@property (nonatomic, strong) GJInfoSettingTopCell *topCell;
@property (nonatomic, strong) GJNormalCellModel *model1;
@property (nonatomic, strong) GJNormalCellModel *model2;
@property (nonatomic, strong) GJNormalCellModel *model3;
@property (nonatomic, strong) GJAdressPickerController *pickerVC;
@property (nonatomic, strong) GJSystemHelper *systemHelper;
@property (nonatomic, strong) GJMineManager *mineManager;
@end

@implementation GJInfoSettingsController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showShadorOnNaviBar:NO];
    
    _model1.detail = APP_USER.userInfo.nickname;
    _model2.detail = APP_USER.userInfo.username;
    _model3.detail = [APP_USER.userInfo.sex integerValue] == 1?@"男":@"女";
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _topCell = [[GJInfoSettingTopCell alloc] initWithStyle:[GJInfoSettingTopCell expectingStyle] reuseIdentifier:[GJInfoSettingTopCell reuseIndentifier]];
    
    //////////
    NSString *nick = JudgeContainerCountIsNull(APP_USER.userInfo.nickname)?@"去修改":APP_USER.userInfo.nickname;
    _model1 = [GJNormalCellModel cellModelTitle:@"昵称" detail:nick imageName:nil acessoryType:1];
    
    NSString *name = JudgeContainerCountIsNull(APP_USER.userInfo.username)?@"未填写":APP_USER.userInfo.username;
    _model2 = [GJNormalCellModel cellModelTitle:@"姓名" detail:name  imageName:nil acessoryType:1];
    
    NSString *sex = [APP_USER.userInfo.sex intValue]?@"男":@"女";
    _model3 = [GJNormalCellModel cellModelTitle:@"性别" detail:sex imageName:nil acessoryType:1];
    _models = @[_model1, _model2, _model3];
    
    //////////
    GJNormalCellModel *_model_2_1 = [GJNormalCellModel cellModelTitle:@"手机号" detail:APP_USER.userInfo.phone imageName:nil acessoryType:0];
    
    NSString *weixin;
    if ([APP_USER.userInfo.isWX integerValue]) weixin = @"已绑定";
    else weixin = @"未绑定";
    GJNormalCellModel *_model_2_2 = [GJNormalCellModel cellModelTitle:@"微信" detail:weixin imageName:nil acessoryType:0];
    
    NSString *qicq;
    if ([APP_USER.userInfo.isQQ integerValue]) qicq = @"已绑定";
    else qicq = @"未绑定";
    GJNormalCellModel *_model_2_3 = [GJNormalCellModel cellModelTitle:@"QQ" detail:qicq imageName:nil acessoryType:0];
    
    _models_2 = @[_model_2_1, _model_2_2, _model_2_3];
    
    //////////
    _pickerVC = [[GJAdressPickerController alloc] init];
    _pickerVC.regionType = RegionNone;
    
    self.systemHelper = [GJSystemHelper system];
}

- (void)initializationSubView {
    self.title = @"个人信息";
    [self allowBack];
    [self.view addSubview:self.tableView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    _mineManager = [[GJMineManager alloc] init];
}

#pragma mark - Request Handle
- (void)updatePortrait:(UIImage *)image {
    [self.view.loadingView startAnimation];
    [_mineManager uploadPortraitFile:image success:^(NSString *imgURL) {
        [self.view.loadingView stopAnimation];
        ShowSucceedAlertHUD(@"修改成功", nil);
        APP_USER.userInfo.avatarImage = nil;
        [_topCell updatePortrait:imgURL];
        APP_USER.userInfo.avatar = imgURL;
        [APP_USER saveLoginUserInfo:APP_USER.userInfo];
        BLOCK_SAFE(_portraitHasUpdated)();
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
        ShowWaringAlertHUD(error.localizedDescription, nil);
    }];
}

- (void)requestUpdateSex:(NSString *)sex {
    [_mineManager requestEditUserInfoWithSex:sex context:self];
}

#pragma mark - Private methods
- (void)modifyHeaderPortrait {
    [AlertManager showAcctionSheetMessage:@"更新头像" chooseTakePhoto:^{
        [self chooseTakePhoto];
    } album:^{
        [self chooseAlbum];
    }];
}
- (void)chooseTakePhoto {
    __weak typeof(self)weakSelf = self;
    [_systemHelper vistiSystemTakePhoto:^(UIImage *image) {
        [weakSelf updatePortrait:image];
    } failure:^{
    } presentController:self];
}

- (void)chooseAlbum {
    __weak typeof(self)weakSelf = self;
    [_systemHelper vistiSystemAlbum:^(UIImage *image) {
        [weakSelf updatePortrait:image];
    } failure:^{} presentController:self];
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _model1.didSelectBlock = ^(NSIndexPath *indexPath) {
        GJModifyNicknameVC *vc = [[GJModifyNicknameVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    _model2.didSelectBlock = ^(NSIndexPath *indexPath) {
        GJModifyRealnameVC *vc = [[GJModifyRealnameVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    _model3.didSelectBlock = ^(NSIndexPath *indexPath) {
        [weakSelf.pickerVC presentSelf:weakSelf];
    };
    _pickerVC.selectRow = ^(NSInteger row) {
        NSInteger sexI = row+1;
        [weakSelf requestUpdateSex:[NSString stringWithFormat:@"%ld", (long)sexI]];
        if (sexI==1) {
            weakSelf.model3.detail = @"男";
        }
        if (sexI==2) {
            weakSelf.model3.detail = @"女";
        }
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    };
}

#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _models.count + 1;
    }else {
        return _models_2.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [_topCell updatePortrait:APP_USER.userInfo.avatar];
        return _topCell;
    }else {
        GJInfoSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJInfoSettingCell reuseIndentifier]];
        if (!cell) cell = [[GJInfoSettingCell alloc] initWithStyle:[GJInfoSettingCell expectingStyle] reuseIdentifier:[GJInfoSettingCell reuseIndentifier]];
        if (indexPath.section == 0) {
            cell.cellModel = _models[indexPath.row-1];
        }else {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cellModel = _models_2[indexPath.row];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return AdaptatSize(80);
    }else {
        return [GJInfoSettingCell cellHeight];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self modifyHeaderPortrait];
        }else {
            BLOCK_SAFE(_models[indexPath.row-1].didSelectBlock)(indexPath);
        }
    }else {
        BLOCK_SAFE(_models_2[indexPath.row].didSelectBlock)(indexPath);
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0;
    }else {
        return 20;
    }
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
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
