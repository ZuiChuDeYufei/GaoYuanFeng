//
//  GJAdressListFooter.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAdressListFooter.h"

@implementation GJAdressListFooter

- (void)addBtnClick {
    BLOCK_SAFE(_blockAddNewAddress)();
}

- (void)commonInit {
    UIButton *addBtn = [[UIButton alloc] init];
    addBtn.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:17]);
    [addBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor blackColor]];
    addBtn.layer.cornerRadius = 5;
    addBtn.clipsToBounds = YES;
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).with.offset(AdaptatSize(15));
        make.right.equalTo(self).with.offset(-AdaptatSize(15));
        make.bottom.equalTo(self);
    }];
}

@end
