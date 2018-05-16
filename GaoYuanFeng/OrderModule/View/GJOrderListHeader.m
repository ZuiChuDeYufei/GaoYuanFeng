//
//  GJOrderListHeader.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJOrderListHeader.h"
#import "GJOrderListData.h"

@interface GJOrderListHeader ()
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *priceLB;
@property (nonatomic, strong) UILabel *score;
@property (nonatomic, strong) UILabel *scoreLB;
@property (nonatomic, strong) UILabel *gifts;
@property (nonatomic, strong) UILabel *giftsLB;

@property (nonatomic, strong) UIView *backV1;
@property (nonatomic, strong) UIView *backV2;
@end

@implementation GJOrderListHeader

- (void)setModel:(GJOrderListData *)model {
    _model = model;
    _price.text = [NSString stringWithFormat:@"¥%@", JudgeContainerCountIsNull(model.total_pay)?@"0.00":model.total_pay];
    _score.text = [NSString stringWithFormat:@"+%@", JudgeContainerCountIsNull(model.total_credits)?@"0":model.total_credits];
    _gifts.text = [NSString stringWithFormat:@"%@", JudgeContainerCountIsNull(model.lqhl_num)?@"0":model.lqhl_num];
}

- (void)commonInit {
    self.backgroundColor = [UIColor colorWithRGB:51 g:51 b:51];
    
    _backV1 = [[UIView alloc] init];
    _backV2 = [[UIView alloc] init];
    
    _price = [[UILabel alloc] init];
    _price.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:20]);
    _price.textColor = APP_CONFIG.whiteGrayColor;
    [_price sizeToFit];
    
    _priceLB = [[UILabel alloc] init];
    _priceLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _priceLB.textColor = APP_CONFIG.lightTextColor;
    _priceLB.text = @"消费买单";
    [_priceLB sizeToFit];
    
    _score = [[UILabel alloc] init];
    _score.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:24]);
    _score.textColor = APP_CONFIG.appMainRedColor;
    [_score sizeToFit];
    
    _scoreLB = [[UILabel alloc] init];
    _scoreLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _scoreLB.textColor = APP_CONFIG.lightTextColor;
    _scoreLB.text = @"积分收益";
    [_scoreLB sizeToFit];
    
    _gifts = [[UILabel alloc] init];
    _gifts.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:20]);
    _gifts.textColor = APP_CONFIG.whiteGrayColor;
    [_gifts sizeToFit];
    
    _giftsLB = [[UILabel alloc] init];
    _giftsLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _giftsLB.textColor = APP_CONFIG.lightTextColor;
    _giftsLB.text = @"领取好礼";
    [_giftsLB sizeToFit];
    
    [self addSubview:_backV1];
    [self addSubview:_backV2];
    [self addSubview:_price];
    [self addSubview:_priceLB];
    [self addSubview:_score];
    [self addSubview:_scoreLB];
    [self addSubview:_gifts];
    [self addSubview:_giftsLB];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_backV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_W/3);
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = APP_CONFIG.lightTextColor;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backV1);
        make.top.equalTo(_backV1).with.offset(AdaptatSize(30));
        make.bottom.equalTo(_backV1).with.offset(AdaptatSize(-30));
        make.width.mas_equalTo(1);
    }];
    [_backV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.bottom.equalTo(self);
        make.height.width.equalTo(_backV1);
    }];
    UIView *backV3 = [[UIView alloc] init];
    [self addSubview:backV3];
    [backV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self);
        make.width.equalTo(_backV1);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = APP_CONFIG.lightTextColor;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backV2);
        make.top.bottom.width.equalTo(line1);
    }];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backV1);
        make.bottom.equalTo(_backV1.mas_centerY);
    }];
    [_priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backV1);
        make.top.equalTo(_backV1.mas_centerY);
    }];
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backV2);
        make.bottom.equalTo(_backV2.mas_centerY);
    }];
    [_scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backV2);
        make.top.equalTo(_backV2.mas_centerY);
    }];
    [_gifts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backV3);
        make.bottom.equalTo(backV3.mas_centerY);
    }];
    [_giftsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backV3);
        make.top.equalTo(backV3.mas_centerY);
    }];
}

@end
