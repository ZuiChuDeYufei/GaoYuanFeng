//
//  GJInfoSettingTopCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/2.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJInfoSettingTopCell.h"

@interface GJInfoSettingTopCell ()
@property (nonatomic, strong) UIImageView *portraitImg;
@end

@implementation GJInfoSettingTopCell

- (void)updatePortrait:(NSString *)imageStr {
    if (APP_USER.userInfo.avatarImage) {
        _portraitImg.image = APP_USER.userInfo.avatarImage;
        return;
    }
    [_portraitImg sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"portrait"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        APP_USER.userInfo.avatarImage = image;
        [APP_USER saveLoginUserInfo:APP_USER.userInfo];
    }];
    [self reloadInputViews];
}

- (void)commonInit {
    [super commonInit];
    [self showBottomLine];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.textLabel.text = @"头像";
    self.textLabel.font = [APP_CONFIG appFontOfSize:14];
    self.textLabel.textColor = [APP_CONFIG darkTextColor];

    _portraitImg = [[UIImageView alloc] init];
    _portraitImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_portraitImg];
    _portraitImg.layer.cornerRadius = AdaptatSize(60)/2;
    _portraitImg.clipsToBounds = YES;
    [_portraitImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-AdaptatSize(10));
        make.size.mas_equalTo((CGSize){AdaptatSize(60), AdaptatSize(60)});
    }];
}

+ (CGFloat)cellHeight {
    return AdaptatSize(48.5);
}

@end
