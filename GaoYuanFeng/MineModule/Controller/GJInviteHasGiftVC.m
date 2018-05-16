//
//  GJInviteHasGiftVC.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/9.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJInviteHasGiftVC.h"
#import "GJInviteHasGiftView.h"
#import "GJInviteFriendListVC.h"

@interface GJInviteHasGiftVC ()
@property (nonatomic, strong) UIImageView *bgImageV;
@property (nonatomic, strong) GJInviteHasGiftView *bottomView;
@end

@implementation GJInviteHasGiftVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _bgImageV.frame = CGRectMake(0, 0, self.view.width, AdaptatSize(228));
    _bottomView.frame = CGRectMake(0, AdaptatSize(228), SCREEN_W, self.view.height-AdaptatSize(228));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    self.title = @"邀请有礼";
}

- (void)initializationSubView {
    [self allowBack];
    [self.view addSubview:self.bgImageV];
    [self.view addSubview:self.bottomView];
    self.view.backgroundColor = [UIColor colorWithRGB:247 g:248 b:250];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    [_bottomView setNumber:0 score:0];
}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _bottomView.blockInviteFriend = ^{
        // TODO 分享成功后 打开http://www.qzylcn.com/page/1
        
    };
    _bottomView.blockFriendList = ^{
        GJInviteFriendListVC *vc = [GJInviteFriendListVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (UIImageView *)bgImageV {
    if (!_bgImageV) {
        _bgImageV = [[UIImageView alloc] init];
        _bgImageV.image = [UIImage imageNamed:@"inviteHasGift"];
        _bgImageV.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgImageV;
}

- (GJInviteHasGiftView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[GJInviteHasGiftView alloc] init];
    }
    return _bottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
