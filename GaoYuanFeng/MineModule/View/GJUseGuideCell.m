//
//  GJUseGuideCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJUseGuideCell.h"
#import "GJBackRulesController.h"

@interface GJUseGuideCell ()
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@end

@implementation GJUseGuideCell

- (void)btnClick {
    GJBackRulesController *vc = [GJBackRulesController new];
    [[GJFunctionManager CurrentTopViewcontroller].navigationController pushViewController:vc animated:YES];
}

- (void)setBottomButton {
    [_detailLB sizeToFit];
    [_detailLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(12);
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = _detailLB.font;
    [btn setTitleColor:APP_CONFIG.appMainColor forState:UIControlStateNormal];
    [btn setTitle:@"退换货规则 >" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    [btn sizeToFit];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_detailLB);
        make.left.equalTo(_detailLB.mas_right).with.offset(5);
    }];
}

- (void)setModel:(GJUseGuideData *)model {
    _model = model;
    _titleLB.text = _model.title;
    _detailLB.text = _model.detail;
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _imageV = [[UIImageView alloc] init];
    _imageV.contentMode = UIViewContentModeScaleAspectFit;
    _imageV.image = [UIImage imageNamed:@"title3"];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = AdapFont([APP_CONFIG appBoldFontOfSize:15]);
    _titleLB.textColor = APP_CONFIG.blackTextColor;
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _detailLB.textColor = APP_CONFIG.grayTextColor;
    _detailLB.numberOfLines = 0;
    
    [self.contentView addSubview:_imageV];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_detailLB];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(10);
        make.left.equalTo(self.contentView).with.offset(15);
        make.top.equalTo(self.contentView).with.offset(40);
        
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageV.mas_right).with.offset(15);
        make.centerY.equalTo(_imageV);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.right.equalTo(self.contentView).with.offset(-15);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(12);
    }];
}

@end
