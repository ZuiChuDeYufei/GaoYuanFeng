//
//  GJAdressListCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAdressListCell.h"
#import "GJAddressListData.h"
#import "GJAddNewAddressVC.h"

@interface GJAdressListCell ()
@property (nonatomic, strong) UIButton *setDefaultBtn;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIView *sepaLine;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UILabel *phoneLB;
@end

@implementation GJAdressListCell

- (void)setDefaultBtnClick:(UIButton *)btn {
    BLOCK_SAFE(_blockSetDefault)();
}

- (void)editBtnClick {
    GJAddNewAddressVC *vc = [GJAddNewAddressVC new];
    vc.data = _model;
    [_context.navigationController pushViewController:vc animated:YES];
}

- (void)deleteBtnClick {
    BLOCK_SAFE(_blockDelete)();
}

- (void)setModel:(GJAddressListData *)model {
    _model = model;
    _titleLB.text = model.name;
    _phoneLB.text = model.phone;
    _detailLB.text = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.address];
    _setDefaultBtn.selected = model.is_default;
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _setDefaultBtn = [self createButtonTitle:@"设为默认" normalImg:@"choose12" seleteImg:@"choose11"];
    [_setDefaultBtn addTarget:self action:@selector(setDefaultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _setDefaultBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_setDefaultBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    
    _editBtn = [self createButtonTitle:@"编辑" normalImg:@"edit11" seleteImg:@"edit11"];
    [_editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn = [self createButtonTitle:@"删除" normalImg:@"delete11" seleteImg:@"delete11"];
    [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _sepaLine = [[UIView alloc] init];
    _sepaLine.backgroundColor = APP_CONFIG.separatorLineColor;
    
    _titleLB = [self createLabelFont:17 color:APP_CONFIG.blackTextColor];
    _phoneLB = [self createLabelFont:17 color:APP_CONFIG.blackTextColor];
    _detailLB = [self createLabelFont:14 color:APP_CONFIG.grayTextColor];
    _detailLB.numberOfLines = 3;
    
    [self.contentView addSubview:_setDefaultBtn];
    [self.contentView addSubview:_editBtn];
    [self.contentView addSubview:_deleteBtn];
    [self.contentView addSubview:_sepaLine];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_phoneLB];
    [self.contentView addSubview:_detailLB];
    
    [self showBottomLine];
    [self updateFrames];
}

- (void)updateFrames {
    [_setDefaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(15));
        make.bottom.equalTo(self).with.offset(-AdaptatSize(20));
        make.size.mas_equalTo((CGSize){AdaptatSize(90), AdaptatSize(25)});
    }];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-AdaptatSize(10));
        make.centerY.equalTo(_setDefaultBtn);
        make.size.mas_equalTo((CGSize){AdaptatSize(60), AdaptatSize(25)});
    }];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_deleteBtn.mas_left).with.offset(-AdaptatSize(10));
        make.centerY.equalTo(_setDefaultBtn);
        make.size.mas_equalTo((CGSize){AdaptatSize(60), AdaptatSize(25)});
    }];
    [_sepaLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_setDefaultBtn);
        make.bottom.equalTo(_setDefaultBtn.mas_top).with.offset(-AdaptatSize(11));
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(15));
        make.top.equalTo(self).with.offset(AdaptatSize(30));
    }];
    [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-AdaptatSize(10));
        make.centerY.equalTo(_titleLB);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.right.equalTo(_phoneLB);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(5);
    }];
}

- (UIButton *)createButtonTitle:(NSString *)title normalImg:(NSString *)normalImg seleteImg:(NSString *)selectImg {
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImg] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:normalImg] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    return btn;
}

- (UILabel *)createLabelFont:(CGFloat)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.font = AdapFont([APP_CONFIG appFontOfSize:font]);
    label.textColor = color;
    [label sizeToFit];
    return label;
}

- (void)showBottomLine {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APP_CONFIG.separatorLineColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(10);
    }];
}

@end
