//
//  GJScoreController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJScoreController.h"
#import "GJScoreListCell.h"
#import "GJScoreTopView.h"
#import "GJScoreEmptyView.h"
#import "GJMineManager.h"
#import "GJReceiveGiftController.h"

@interface GJScoreController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJScoreModel *model;
@property (nonatomic, strong) GJScoreEmptyView *emptyView;
@property (nonatomic, strong) GJMineManager *mineManager;
@end

@implementation GJScoreController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-NavBar_H);
    _emptyView.center = _tableView.center;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _mineManager = [[GJMineManager alloc] init];
}

- (void)initializationSubView {
    [self allowBack];
    [self showShadorOnNaviBar:NO];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"guide2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.emptyView];
}

- (void)initializationNetWorking {
    [self.view.loadingView startAnimation];
    [_mineManager requestScoreUseListSuccess:^(GJScoreModel *model) {
        [self.view.loadingView stopAnimation];
        _model = model;
        [_tableView reloadData];
        if (JudgeContainerCountIsNull(_model.data)) {
            _emptyView.hidden = NO;
        }else {
            _emptyView.hidden = YES;
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        _emptyView.hidden = NO;
        [self.view.loadingView stopAnimation];
    }];
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)rightBarBtnClick {
    
}

#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJScoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJScoreListCell reuseIndentifier]];
    if (!cell) cell = [[GJScoreListCell alloc] initWithStyle:[GJScoreListCell expectingStyle] reuseIdentifier:[GJScoreListCell reuseIndentifier]];
    cell.model = _model.data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GJScoreListCell height];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptatSize(90);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GJScoreTopView *v = [GJScoreTopView new];
    v.blockRightBtn = ^{
        GJReceiveGiftController *gift = [GJReceiveGiftController new];
        [gift pushPageWith:self];
    };
    v.model = _model;
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

- (GJScoreEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [GJScoreEmptyView install];
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
