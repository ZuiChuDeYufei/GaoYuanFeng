//
//  GJUseGuideController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJUseGuideController.h"
#import "GJUseGuideCell.h"

@interface GJUseGuideController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <GJUseGuideData *> *models;
@end

@implementation GJUseGuideController

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
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    GJUseGuideData *cell1 = [GJUseGuideData dataWithTitle:@"如何获得积分？" detail:@"1）根据每次3而海南购房还是法国女人千万抱歉让您更强化。\n\n2）分享光和热让他为难和青年网然后去儿童认识他建议你和确认给你。"];
    GJUseGuideData *cell2 = [GJUseGuideData dataWithTitle:@"如何使用积分？" detail:@"全智易联积分商城，汇聚实力礼品工厂。每次消费买单以后，领取好礼的同事可使用积分。"];
    GJUseGuideData *cell3 = [GJUseGuideData dataWithTitle:@"在积分商城领取的礼品支持退货吗？" detail:@"详情请见我们的"];
    _models = @[cell1, cell2, cell3];
}

- (void)initializationSubView {
    self.title = @"新手指南";
    [self allowBack];
    [self.view addSubview:self.tableView];
}

- (void)initializationNetWorking {}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJUseGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJUseGuideCell reuseIndentifier]];
    if (!cell) cell = [[GJUseGuideCell alloc] initWithStyle:[GJUseGuideCell expectingStyle] reuseIdentifier:[GJUseGuideCell reuseIndentifier]];
    cell.model = _models[indexPath.row];
    if (indexPath.row == _models.count-1) {
        [cell setBottomButton];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_models[indexPath.row] getCellHeight:AdapFont([APP_CONFIG appFontOfSize:14]) width:SCREEN_W-55];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        [_tableView registerClass:GJUseGuideCell.class forCellReuseIdentifier:[GJUseGuideCell reuseIndentifier]];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
