//
//  GJAboutUSController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/28.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAboutUSController.h"
#import "GJNormalCellModel.h"
#import "GJAboutUSCell.h"
#import "GJAppInfoData.h"
#import "GJMineManager.h"

@interface GJAboutUSController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJMineManager *mineManager;
@property (nonatomic, strong) NSArray <GJNormalCellModel *> *models;
@end

@implementation GJAboutUSController

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
    _models = @[];
    _mineManager = [[GJMineManager alloc] init];
}

- (void)initializationSubView {
    self.title = @"关于我们";
    [self allowBack];
    [self.view addSubview:self.tableView];
}

- (void)initializationNetWorking {
    [self.view.loadingView startAnimation];
    [_mineManager requestAppInfoSuccess:^(GJAppInfoData *data) {
        [self.view.loadingView stopAnimation];
        GJNormalCellModel *model1 = [GJNormalCellModel cellModelTitle:@"微信公众号" detail:data.weixinhao imageName:@"wechat11" acessoryType:0];
        GJNormalCellModel *model2 = [GJNormalCellModel cellModelTitle:@"联系电话" detail:data.phone imageName:@"phone11" acessoryType:0];
        GJNormalCellModel *model3 = [GJNormalCellModel cellModelTitle:@"电子邮箱" detail:data.email imageName:@"mail11" acessoryType:0];
        GJNormalCellModel *model4 = [GJNormalCellModel cellModelTitle:@"官方网站" detail:data.gfwz imageName:@"web11" acessoryType:0];
        GJNormalCellModel *model5 = [GJNormalCellModel cellModelTitle:@"广告合作" detail:data.gghz imageName:@"AD11" acessoryType:0];
        _models = @[model1, model2, model3, model4, model5];
        [_tableView reloadData];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
    }];
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJAboutUSCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJAboutUSCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJAboutUSCell alloc] initWithStyle:[GJAboutUSCell expectingStyle] reuseIdentifier:[GJAboutUSCell reuseIndentifier]];
    }
    if (indexPath.row == 0) {
        [cell setLogoView];
    }else {
        cell.cellModel = _models[indexPath.row-1];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return AdaptatSize(210);
    }else {
        return AdaptatSize(47);
    }
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
