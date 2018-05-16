//
//  GJOrderListCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJOrderListCell.h"

@interface GJOrderListCell ()
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UILabel *priceLB;
@property (nonatomic, strong) UILabel *scoreLB;
@property (nonatomic, strong) UILabel *score;
@end

@implementation GJOrderListCell

- (void)setModel:(GJOrderList *)model {
    _model = model;
    _titleLB.text = model.supplier_name;
    _timeLB.text = model.created_at;
    _priceLB.text = [NSString stringWithFormat:@"%.2f", [model.money doubleValue]];
    _scoreLB.text = @"积分收益";
    _score.text = model.credits;
}

- (void)commonInit {
    [self showBottomLine];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _titleLB.textColor = APP_CONFIG.blackTextColor;
    [_titleLB sizeToFit];
    
    _timeLB = [[UILabel alloc] init];
    _timeLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _timeLB.textColor = APP_CONFIG.grayTextColor;
    [_timeLB sizeToFit];
    
    _priceLB = [[UILabel alloc] init];
    _priceLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _priceLB.textColor = APP_CONFIG.blackTextColor;
    _priceLB.textAlignment = NSTextAlignmentRight;
    [_priceLB sizeToFit];
    
    _scoreLB = [[UILabel alloc] init];
    _scoreLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _scoreLB.textColor = APP_CONFIG.grayTextColor;
    [_scoreLB sizeToFit];
    
    _score = [[UILabel alloc] init];
    _score.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:18]);
    _score.textColor = APP_CONFIG.appMainRedColor;
    [_score sizeToFit];
    
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_timeLB];
    [self.contentView addSubview:_priceLB];
    [self.contentView addSubview:_scoreLB];
    [self.contentView addSubview:_score];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(12);
        make.right.equalTo(self.contentView).with.offset(-15);
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.top.equalTo(self.contentView).with.offset(12);
        make.right.equalTo(_priceLB.mas_left).with.offset(-10);
    }];
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(2);
    }];
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).with.offset(-AdaptatSize(22));
        make.right.equalTo(_priceLB);
    }];
    [_scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_score);
        make.left.equalTo(self.contentView.mas_right).with.offset(-SCREEN_W/3);
    }];
}

- (void)showBottomLine {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APP_CONFIG.appBackgroundColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = APP_CONFIG.separatorLineColor;
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

@end
