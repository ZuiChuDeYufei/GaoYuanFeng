//
//  GJAddNewAddressFooter.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAddNewAddressFooter.h"

@interface GJAddNewAddressFooter ()
@property (nonatomic, strong) UISwitch *switchBtn;
@end

@implementation GJAddNewAddressFooter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubview];
    }
    return self;
}

- (void)scoreSwitchClick:(UISwitch *)sender {
    if (_blockSwitchStatus) {
        _blockSwitchStatus(sender.on);
    }
}

- (void)setDefaultBtnStatus:(BOOL)status {
    _switchBtn.on = status;
}

- (void)setupSubview {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *defaultLB = [[UILabel alloc] init];
    defaultLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    defaultLB.textColor = [UIColor grayColor];
    defaultLB.text = @"设为默认地址";
    [defaultLB sizeToFit];
    [self addSubview:defaultLB];
    [defaultLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.centerY.equalTo(self);
    }];
    _switchBtn = [[UISwitch alloc] init];
    _switchBtn.on = NO;
    [_switchBtn addTarget:self action:@selector(scoreSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_switchBtn];
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-15);
        make.centerY.equalTo(self);
    }];
}

@end
