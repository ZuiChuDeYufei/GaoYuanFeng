//
//  GJScoreTopCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJScoreTopCell.h"

@interface GJScoreTopCell ()
@property (nonatomic, strong) UILabel *detailLB;
@end

@implementation GJScoreTopCell

- (void)setScore:(NSString *)score {
    _score = score;
    NSString *str = [NSString stringWithFormat:@"%@ 积分", _score];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muStr addAttribute:NSForegroundColorAttributeName value:APP_CONFIG.blackTextColor range:[str rangeOfString:@"积分"]];
    [muStr addAttribute:NSFontAttributeName value:AdapFont([APP_CONFIG appBoldFontOfSize:15]) range:[str rangeOfString:@"积分"]];
    self.textLabel.attributedText = muStr;
    _detailLB.text = @"积分商城";
}

- (void)commonInit {
    self.accessoryType = 1;
    self.textLabel.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:45]);
    self.textLabel.textColor = APP_CONFIG.appMainRedColor;
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    _detailLB.textColor = APP_CONFIG.darkTextColor;
    [_detailLB sizeToFit];
    [self.contentView addSubview:_detailLB];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(0);
    }];
}

+ (UITableViewCellStyle)expectingStyle {
    return UITableViewCellStyleValue1;
}

@end
