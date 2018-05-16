//
//  GJAboutUSCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAboutUSCell.h"

@interface GJAboutUSCell ()

@end

@implementation GJAboutUSCell

- (void)commonInit {
    [super commonInit];
    self.detailTextLabel.textColor = [APP_CONFIG appMainColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self settingShowSpeatLine:YES];
}

- (void)setLogoView {
    self.backgroundColor = APP_CONFIG.appBackgroundColor;
    
    UIView *back = [UIView new];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 15;
    back.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    back.layer.shadowOffset = CGSizeMake(0, 0);
    back.layer.shadowOpacity = 0.4;
    back.layer.shadowRadius = 7;
    [self.contentView addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).with.offset(-AdaptatSize(20));
        make.centerX.equalTo(self.contentView);
        make.width.height.mas_equalTo(AdaptatSize(80));
    }];
    
    UIImageView *logo= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppIcon"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    logo.layer.cornerRadius = 15;
    logo.clipsToBounds = YES;
    [self.contentView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back);
    }];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.font = AdapFont([APP_CONFIG appBoldFontOfSize:16]);
    titleLB.textColor = [UIColor darkGrayColor];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.numberOfLines = 2;
    titleLB.text = [NSString stringWithFormat:@"全智易联\nv%@", GetAppVersionCodeInfo()];
    [titleLB sizeToFit];
    [self.contentView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logo.mas_bottom).with.offset(10);
        make.centerX.equalTo(logo);
    }];
}

@end
