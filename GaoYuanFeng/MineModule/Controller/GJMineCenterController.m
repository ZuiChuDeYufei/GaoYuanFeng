//
//  GJMineCenterController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMineCenterController.h"
#import "GJMineNaviBar.h"
#import "GJNormalCellModel.h"
#import "GJDismissTransitionAnimated.h"
#import "GJPresentTransitionAnimated.h"
#import "GJMyOrderListController.h"
#import "GJInfoSettingsController.h"
#import "GJUseGuideController.h"
#import "GJAppSettingsController.h"
#import "GJReceiveGiftController.h"
#import "GJAboutUSController.h"
#import "GJScoreController.h"
#import "GJContactController.h"
#import "GJInviteHasGiftVC.h"
#import "GJMineManager.h"

@interface GJMineCenterController () <GJMineViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, assign) MineMoveDirection direction;
@property (nonatomic, strong) NSArray <GJBaseTableViewCell *> *cells;
@property (nonatomic, strong) NSArray <GJNormalCellModel *> *models;
@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, strong) GJMineManager *mineManager;
@property (nonatomic, strong) GJNormalCellModel *payRecord;
@property (nonatomic, strong) GJMyOrderListController *myOrder;
@end

@implementation GJMineCenterController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mineView presentSelf:self];
    [self.mineView.top_cell setNickName];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    GJNormalCellModel *model1 = [GJNormalCellModel cellModelTitle:@"领取好礼" detail:@"汇聚全球实力工厂" imageName:@"gift_mall" acessoryType:0];
    _payRecord = [GJNormalCellModel cellModelTitle:@"全部买单" detail:@"" imageName:@"menu" acessoryType:0];
    GJNormalCellModel *model3 = [GJNormalCellModel cellModelTitle:@"新手指南" detail:@"" imageName:@"guide" acessoryType:0];
    GJNormalCellModel *model4 = [GJNormalCellModel cellModelTitle:@"关于我们" detail:@"" imageName:@"aboutus" acessoryType:0];
    GJNormalCellModel *model5 = [GJNormalCellModel cellModelTitle:@"邀请有礼" detail:@"" imageName:@"share" acessoryType:0];
    
    __weak typeof(self)weakSelf = self;
    model1.didSelectBlock = ^(NSIndexPath *indexPath) {
        GJReceiveGiftController *gift = [GJReceiveGiftController new];
        [gift pushPageWith:self];
    };
    _myOrder = [GJMyOrderListController new];
    _payRecord.didSelectBlock = ^(NSIndexPath *indexPath) {
        [weakSelf.myOrder pushPageWith:weakSelf];
    };
    model3.didSelectBlock = ^(NSIndexPath *indexPath) {
        GJUseGuideController *purse = [GJUseGuideController new];
        [purse pushPageWith:weakSelf];
    };
    model4.didSelectBlock = ^(NSIndexPath *indexPath) {
        GJAboutUSController *about = [GJAboutUSController new];
        [about pushPageWith:self];
    };
    model5.didSelectBlock = ^(NSIndexPath *indexPath) {
        GJInviteHasGiftVC *vc = [GJInviteHasGiftVC new];
        [vc pushPageWith:self];
    };
    _models = @[model1, _payRecord, model3, model4, model5];
    _cells = @[self.mineView.top_cell, self.mineView.center_cell];
}

- (void)initializationSubView {
    self.mineView.myDelegate = self;
    [self.view addSubview:self.mineView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    _mineManager = [[GJMineManager alloc] init];
}

#pragma mark - Request Handle

#pragma mark - Private methods
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _mineView.blockSettingPage = ^{
        GJAppSettingsController *vc = [GJAppSettingsController new];
        vc.logouting = ^{
            BLOCK_SAFE(weakSelf.mineView.dismissBlock)();
        };
        vc.clearSuccess = ^{
            [weakSelf.mineView.top_cell getPortrait];
        };
        [vc pushPageWith:weakSelf];
    };
    _mineView.blockContactPage = ^{
        GJContactController *vc = [GJContactController new];
        [vc pushPageWith:weakSelf];
    };
    [_myOrder requestPayList:^(NSInteger count) {
        _payRecord.detail = [NSString stringWithFormat:@"共%ld单", (long)count];
        [weakSelf.mineView.tableView reloadData];
    }];
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)upDrag:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    CGFloat dis = _mineView.tableView.width-self.view.width/2;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _isPush = NO;
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        _mineView.x = translation.x;
        if (_mineView.x > 0) {
            _mineView.x = 0;
        }
        if (fabs(_mineView.x) >= dis) {
            _isPush = YES;
        }else {
            _isPush = NO;
        }
    }else if (gesture.state == UIGestureRecognizerStateEnded) {
        if (_isPush) {
            [self.mineView dismissSelf];
        }else {
            [self.mineView presentSelf:_context];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self.mineView) {
        return YES;
    }else{
        return NO;
    }
}

- (void)tapClick {
    [self.mineView dismissSelf];
}

#pragma mark - Custom delegate
// GJMineViewDelegate - UITableView
- (UITableViewCell *)minePage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _cells.count) {
        return _cells[indexPath.row];
    }
    GJMineBottomCell *bottom_cells = [tableView dequeueReusableCellWithIdentifier:[GJMineBottomCell reuseIndentifier]];
    if (!bottom_cells) bottom_cells = [[GJMineBottomCell alloc] initWithStyle:[GJMineBottomCell expectingStyle] reuseIdentifier:[GJMineBottomCell reuseIndentifier]];
    bottom_cells.cellModel = _models[indexPath.row-_cells.count];
    return bottom_cells;
}

- (CGFloat)minePage_heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _cells.count) {
        return _cells[indexPath.row].height;
    }
    return [GJMineBottomCell cellHeight];
}

- (NSInteger)minePage_numberOfSectionsInTableView {
    return _cells.count + _models.count;
}

- (void)minePage:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= _cells.count) {
        BLOCK_SAFE(_models[indexPath.row-_cells.count].didSelectBlock)(indexPath);
    }else if (indexPath.row == 0) {
        GJInfoSettingsController *info = [GJInfoSettingsController new];
        info.portraitHasUpdated = ^{
            [_mineView.top_cell getPortrait];
        };
        [info pushPageWith:self];
    }else {
        GJScoreController *vc = [GJScoreController new];
        [vc pushPageWith:self];
    }
}

#pragma mark - Getter/Setter
- (GJMineView *)mineView {
    if (!_mineView) {
        _mineView = [[GJMineView alloc] init];
        UIPanGestureRecognizer *upDragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(upDrag:)];
        upDragGesture.maximumNumberOfTouches = 1;
        [_mineView addGestureRecognizer:upDragGesture];
    }
    return _mineView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
