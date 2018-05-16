//
//  GJSubmitOrderMiddleCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSubmitOrderMiddleCell.h"
#import "GJAddressListController.h"

@interface GJSubmitOrderMiddleCell ()

@end

@implementation GJSubmitOrderMiddleCell

- (void)adressBtnClick {
    GJAddressListController *vc = [GJAddressListController new];
    [[GJFunctionManager CurrentTopViewcontroller].navigationController pushViewController:vc animated:YES];
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APP_CONFIG.separatorLineColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *_topLB = [[UILabel alloc] init];
    _topLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _topLB.textColor = [UIColor blackColor];
    _topLB.text = @"收货信息";
    [_topLB sizeToFit];
    [self.contentView addSubview:_topLB];
    [_topLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.bottom.equalTo(self);
    }];
    
    UIButton *adressBtn = [[UIButton alloc] init];
    adressBtn.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:13]);
    [adressBtn setImage:[UIImage imageNamed:@"red_arrow"] forState:UIControlStateNormal];
    [adressBtn setImageEdgeInsets:UIEdgeInsetsMake(0, AdaptatSize(60), 0, 0)];
    [adressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -AdaptatSize(30), 0, 0)];
    [adressBtn setTitleColor:[UIColor colorWithRGB:255 g:49 b:0] forState:UIControlStateNormal];
    [adressBtn setTitle:@"选择地址" forState:UIControlStateNormal];
    [adressBtn addTarget:self action:@selector(adressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:adressBtn];
    [adressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topLB);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.size.mas_equalTo((CGSize){AdaptatSize(80), AdaptatSize(25)});
    }];
}

@end
