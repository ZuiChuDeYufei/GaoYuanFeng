//
//  GJAppSettingCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/2.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAppSettingCell.h"

@interface GJAppSettingCell ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation GJAppSettingCell

- (void)buttonBtnClick {
    BLOCK_SAFE(_logoutClick)();
}

- (void)commonInit {
    self.backgroundColor = APP_CONFIG.appBackgroundColor;
    
    _button = [[UIButton alloc] init];
    _button.layer.cornerRadius = 7;
    _button.clipsToBounds = YES;
    _button.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:16]);
    _button.backgroundColor = APP_CONFIG.appMainRedColor;
    [_button setTitle:@"退出登录" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_button];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).with.offset(20);
        make.right.equalTo(self.contentView).with.offset(-20);
        make.bottom.equalTo(self.contentView);
    }];
}

- (CGFloat)height {
    return AdaptatSize(70);
}

@end
