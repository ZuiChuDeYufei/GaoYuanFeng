//
//  GJMoneyOrderCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMoneyOrderCell.h"

@interface GJMoneyOrderCell ()
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIImageView *leftImageV;
@property (nonatomic, strong) UILabel *scoreLB;
@property (nonatomic, strong) UILabel *score;
@end

@implementation GJMoneyOrderCell

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor colorWithRGB:235 g:235 b:235];
    
    _scoreLB = [[UILabel alloc] init];
    [_scoreLB sizeToFit];
    _scoreLB.font = AdapFont([APP_CONFIG appBoldFontOfSize:14]);
    _scoreLB.textColor = [UIColor blackColor];
    _scoreLB.text = @"积分";
    
    _score = [[UILabel alloc] init];
    [_score sizeToFit];
    _score.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:18]);
    _score.textColor = APP_CONFIG.appMainRedColor;
    
    _score.text = [NSString stringWithFormat:@"%@", APP_USER.userInfo.credits];
    
    _leftImageV = [[UIImageView alloc] init];
    _leftImageV.contentMode = UIViewContentModeScaleAspectFit;
    _leftImageV.image = [UIImage imageNamed:@"integral"];
    
    [self.contentView addSubview:_line];
    [self.contentView addSubview:_scoreLB];
    [self.contentView addSubview:_score];
    [self.contentView addSubview:_leftImageV];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.right.equalTo(self.contentView).with.offset(-15);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1.5);
    }];
    [_leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo((CGSize){AdaptatSize(25), AdaptatSize(25)});
    }];
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageV.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    [_scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_score.mas_right).with.offset(5);
        make.centerY.equalTo(self.contentView);
    }];
}

- (CGFloat)height {
    return AdaptatSize(65);
}

@end
