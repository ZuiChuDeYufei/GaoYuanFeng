//
//  GJReceiveGiftController.m
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJReceiveGiftController.h"
#import "GJSubmitOrderController.h"
#import "GJReceiveGiftBottomView.h"
#import "GJBaseTableView.h"
#import "GJReceiveGiftTBVCell.h"
#import "GJOrderManager.h"

@interface GJReceiveGiftController () <UITableViewDelegate, UITableViewDataSource, GJReceiveGiftCellDelegate>
@property (nonatomic, strong) GJReceiveGiftBottomView *bottomView;
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray <GJGiftListSelectDataList *> *seleteArr;
@property (nonatomic, strong) GJGiftListSelectData *data;
@property (nonatomic, strong) GJOrderManager *orderManager;
@end

@implementation GJReceiveGiftController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (SCREEN_H >= kGJIphoneX) {
        _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-NavBar_H-AdaptatSize(56)-25);
        _bottomView.frame = CGRectMake(0, self.view.height-AdaptatSize(49)-25, SCREEN_W, AdaptatSize(49+25));
    }else {
        _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-NavBar_H-AdaptatSize(56));
        _bottomView.frame = CGRectMake(0, self.view.height-AdaptatSize(49), SCREEN_W, AdaptatSize(49));
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
    _seleteArr = @[].mutableCopy;
    _data = [[GJGiftListSelectData alloc] init];
    _orderManager = [[GJOrderManager alloc] init];
}

- (void)initializationSubView {
    self.title = @"领取好礼";
    [self allowBack];
    self.view.backgroundColor = [UIColor colorWithRGB:247 g:247 b:247];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    [self.view.loadingView startAnimation];
    [_orderManager requestScoreGiftListWithCatid:@"" success:^(GJGiftListSelectData *data) {
        [self.view.loadingView stopAnimation];
        _data = data;
        [_tableView reloadData];
        _bottomView.score = [NSString stringWithFormat:@"%.0f", _data.user_credits];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
        ShowWaringAlertHUD(error.localizedDescription, nil);
    }];
}

#pragma mark - Request Handle


#pragma mark - Private methods
- (CGFloat)calculateTotalSelectedScore {
    __block CGFloat score = 0;
    [_seleteArr enumerateObjectsUsingBlock:^(GJGiftListSelectDataList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        score += obj.total;
    }];
    return score;
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _bottomView.receiveClick = ^{
        if ([weakSelf calculateTotalSelectedScore] == 0) {
            ShowWaringAlertHUD(@"请选择礼品", nil);
        }else {
            GJSubmitOrderController *VC= [[GJSubmitOrderController alloc] init];
            VC.seleteArr = weakSelf.seleteArr;
            [VC pushPageWith:weakSelf];
        }
    };
}

#pragma mark - Custom delegate
// GJReceiveGiftCellDelegate
- (void)selectWithData:(GJGiftListSelectDataList *)data isSelect:(BOOL)isSelect {
    if (isSelect) {
        [_seleteArr addObject:data];
        if ([self calculateTotalSelectedScore] > _data.user_credits) {
            ShowWaringAlertHUD([NSString stringWithFormat:@"剩余可用积分为 %@", _bottomView.score], nil);
            data.isSelect = NO;
            [_seleteArr removeObject:data];
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:data.section] withRowAnimation:UITableViewRowAnimationFade];
        }
    }else {
        [_seleteArr enumerateObjectsUsingBlock:^(GJGiftListSelectDataList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.section == data.section) {
                [_seleteArr removeObjectAtIndex:idx];
            }
        }];
    }
    [_bottomView setScore:[NSString stringWithFormat:@"%.0f", _data.user_credits - [self calculateTotalSelectedScore]]];
    [_bottomView setNumberOfSelect:[NSString stringWithFormat:@"%lu", (unsigned long)_seleteArr.count]];
}

- (void)addOrDevideCount:(NSInteger)count data:(GJGiftListSelectDataList *)data isAdd:(BOOL)isAdd {
    GJReceiveGiftTBVCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:data.section]];
    if (isAdd) {
        if (([self calculateTotalSelectedScore]+data.goods_price) > _data.user_credits) {
            ShowWaringAlertHUD([NSString stringWithFormat:@"剩余可用积分为 %@", _bottomView.score], nil);
            return ;
        }
        [_seleteArr enumerateObjectsUsingBlock:^(GJGiftListSelectDataList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj == data) {
                cell.labelCount = obj.count = count;
            }
        }];
    }else {
        [_seleteArr enumerateObjectsUsingBlock:^(GJGiftListSelectDataList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj == data) {
                cell.labelCount = obj.count = count;
            }
        }];
    }
    [_bottomView setScore:[NSString stringWithFormat:@"%.0f", _data.user_credits - [self calculateTotalSelectedScore]]];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJReceiveGiftTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJReceiveGiftTBVCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJReceiveGiftTBVCell alloc] initWithStyle:[GJReceiveGiftTBVCell expectingStyle] reuseIdentifier:[GJReceiveGiftTBVCell reuseIndentifier]];
    }
    cell.myDelegate = self;
    _data.list[indexPath.section].section = indexPath.section;
    cell.model = _data.list[indexPath.section];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AdaptatSize(110);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _data.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = APP_CONFIG.separatorLineColor;
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [TKWebMedia commonWebViewJumpUrl:_data.list[indexPath.row].url title:@"好礼详情" controller:self];
}

#pragma mark - Getter/Setter
- (GJReceiveGiftBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [GJReceiveGiftBottomView install];
    }
    return _bottomView;
}

- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
