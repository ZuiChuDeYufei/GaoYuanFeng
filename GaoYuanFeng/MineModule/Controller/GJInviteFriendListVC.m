//
//  GJInviteFriendListVC.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJInviteFriendListVC.h"
#import "GJInviteFriendListCell.h"
#import "GJMineManager.h"

@interface GJInviteFriendListVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJMineManager *mineManager;
@property (nonatomic, strong) NSArray <GJInviteFriendListData *> *friendList;
@end

@implementation GJInviteFriendListVC

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
    _mineManager = [[GJMineManager alloc] init];
}

- (void)initializationSubView {
    self.title = @"受邀好友列表";
    [self allowBack];
    [self.view addSubview:self.tableView];
}

- (void)initializationNetWorking {
    [self.view.loadingView startAnimation];
    [_mineManager requestInviteFriendsListWithType:0 success:^(NSArray<GJInviteFriendListData *> *data) {
        [self.view.loadingView stopAnimation];
        _friendList = data;
        if (data.count == 0) {
            ShowWaringAlertHUD(@"暂无受邀好友", nil);
        }else [_tableView reloadData];
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
    return _friendList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJInviteFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJInviteFriendListCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJInviteFriendListCell alloc] initWithStyle:[GJInviteFriendListCell expectingStyle] reuseIdentifier:[GJInviteFriendListCell reuseIndentifier]];
    }
    cell.friends = _friendList[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AdaptatSize(104);
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.backgroundColor = [UIColor colorWithRGB:236 g:236 b:236];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
