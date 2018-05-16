//
//  GJScoreListCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJScoreListCell.h"

@interface GJScoreListCell ()
@property (strong, nonatomic) UILabel *rightLB;
@end

@implementation GJScoreListCell

- (void)commonInit {
    [self showBottomLine];
    
    _rightLB = [[UILabel alloc] init];
    _rightLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _rightLB.textColor = APP_CONFIG.appMainRedColor;
    [_rightLB sizeToFit];
    [self.contentView addSubview:_rightLB];
    [_rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-10);
    }];
    
    self.detailTextLabel.textColor = APP_CONFIG.grayTextColor;
    self.textLabel.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    self.textLabel.textColor = APP_CONFIG.blackTextColor;
}

- (void)setModel:(GJScoreModelList *)model {
    _model = model;
    self.accessoryType = 0;
    self.detailTextLabel.text = model.created_at;
    _rightLB.text = model.credits;
    self.textLabel.text = model.beizhu;
}

+ (CGFloat)height {
    return AdaptatSize(60);
}

+ (UITableViewCellStyle)expectingStyle {
    return UITableViewCellStyleSubtitle;
}

@end
