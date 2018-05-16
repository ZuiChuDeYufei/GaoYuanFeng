//
//  GJPayCompleteController.m
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJPayCompleteController.h"
#import "GJReceiveGiftController.h"
#import "GJPayCompleteView.h"
#import "GJPayCompleteButton.h"

@interface GJPayCompleteController ()
@property (nonatomic, strong) GJPayCompleteView *topView;
@property (nonatomic, strong) GJPayCompleteButton *bottomBtn;
@end

@implementation GJPayCompleteController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _topView.frame = CGRectMake(20, 20, SCREEN_W-40, SCREEN_H-AdaptatSize(79)-NavBar_H-40);
    _bottomBtn.frame = CGRectMake(20, self.view.height-AdaptatSize(79), SCREEN_W-40, AdaptatSize(59));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {}

- (void)initializationSubView {
    self.title = @"支付完成";
    [self allowBack];
    self.view.backgroundColor = [UIColor colorWithRGB:247 g:247 b:247];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomBtn];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    _topView.data = _data;
}

#pragma mark - Request Handle

#pragma mark - Private methods

#pragma mark - Public methods

#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _bottomBtn.buttonClick = ^{
        GJReceiveGiftController *vc = [[GJReceiveGiftController alloc] init];
        [vc pushPageWith:weakSelf];
    };
}

- (void)backAction {
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Custom delegate

#pragma mark - Getter/Setter
- (GJPayCompleteView *)topView {
    if (!_topView) {
        _topView = [[GJPayCompleteView alloc] init];
    }
    return _topView;
}

- (GJPayCompleteButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [GJPayCompleteButton installTitle:@"领取好礼"];
    }
    return _bottomBtn;
}

@end
