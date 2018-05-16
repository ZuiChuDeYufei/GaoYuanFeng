//
//  GJMineView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMineView.h"

@interface GJMineView ()  <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIViewController *dismissVC;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIButton *contactBtn;
@end

@implementation GJMineView

#pragma mark - View controller life circle
- (void)commonInit {
    self.frame = CGRectMake(-SCREEN_W, 0, SCREEN_W, SCREEN_H);
    [self initializationSubView];
}

#pragma mark - Iniitalization methods
- (void)initializationSubView {
    _top_cell = [[GJMineCenterTBVCell alloc] init];
    _center_cell = [[GJMoneyOrderCell alloc] init];
    
    CGRect backRect = CGRectMake(0, 0, self.width-AdaptatSize(90), SCREEN_H);
    UIButton *_backView = [[UIButton alloc] initWithFrame:backRect];
    [_backView setBackgroundColor:[UIColor colorWithRGB:245 g:248 b:247]];
    [self addSubview:_backView];
    
    CGFloat btmH;
    if (SCREEN_H >= kGJIphoneX) {
        btmH = AdaptatSize(80);
    }else {
        btmH = AdaptatSize(50);
    }
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H-btmH, _backView.width, btmH)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.layer.borderColor = APP_CONFIG.separatorLineColor.CGColor;
    _bottomView.borderWhich = LGJViewBorderTop;
    [_backView addSubview:_bottomView];
    
    self.tableView.frame = CGRectMake(0, NavBar_H, _backView.width, SCREEN_H-NavBar_H-btmH);
    [_backView addSubview:self.tableView];
    
    _settingBtn = [self createBottomButton:@"设置"];
    _settingBtn.frame = CGRectMake(0, 0, _bottomView.width/2, _bottomView.height);
    _settingBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _contactBtn = [self createBottomButton:@"客服中心"];
    _contactBtn.frame = CGRectMake(_bottomView.width/2, 0, _bottomView.width/2, _bottomView.height);
    [_contactBtn addTarget:self action:@selector(contactBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Private methods
- (void)dismissSelf {
    BLOCK_SAFE(_dismissBlock)();
    [UIView animateWithDuration:0.3 animations:^{
        self.x = -SCREEN_W;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_dismissVC dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)presentSelf:(UIViewController *)fromVC {
    [UIView animateWithDuration:0.3 animations:^{
        self.x = 0;
    } completion:^(BOOL finished) {
        _dismissVC = fromVC;
    }];
}

#pragma mark - Event response
- (void)settingBtnClick {
    BLOCK_SAFE(_blockSettingPage)();
}

- (void)contactBtnClick {
    BLOCK_SAFE(_blockContactPage)();
}

#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.myDelegate respondsToSelector:@selector(minePage_numberOfSectionsInTableView)]) {
        return [self.myDelegate minePage_numberOfSectionsInTableView];
    }else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.myDelegate respondsToSelector:@selector(minePage:cellForRowAtIndexPath:)]) {
        return [self.myDelegate minePage:tableView cellForRowAtIndexPath:indexPath];
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.myDelegate respondsToSelector:@selector(minePage_heightForRowAtIndexPath:)]) {
        return [self.myDelegate minePage_heightForRowAtIndexPath:indexPath];
    }else {
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.myDelegate respondsToSelector:@selector(minePage:didSelectRowAtIndexPath:)]) {
        [self.myDelegate minePage:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain view:self];
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)createBottomButton:(NSString *)title {
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [_bottomView addSubview:btn];
    return btn;
}

@end

