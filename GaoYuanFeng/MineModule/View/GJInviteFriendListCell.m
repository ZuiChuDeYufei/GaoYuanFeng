//
//  GJInviteFriendListCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJInviteFriendListCell.h"

@interface GJInviteFriendListCell ()
@property (nonatomic, strong) UIImageView *iconImageV;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UILabel *statusLB;
@end

@implementation GJInviteFriendListCell

- (void)setFriends:(GJInviteFriendListData *)friends {
    _friends = friends;
    [self setContents];
}

- (void)setContents {
    [_iconImageV sd_setImageWithURL:[NSURL URLWithString:_friends.avatar]];
    _titleLB.text = _friends.created_at;
    _detailLB.text = [NSString stringWithFormat:@"微信昵称：%@", _friends.nickname];
    _statusLB.text = _friends.beizhu;
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithRGB:236 g:236 b:236];
    
    _iconImageV = [[UIImageView alloc] init];
    _iconImageV.contentMode  =UIViewContentModeScaleAspectFit;
    _iconImageV.layer.cornerRadius = AdaptatSize(70)/2;
    _iconImageV.clipsToBounds = YES;
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _titleLB.textColor = APP_CONFIG.grayTextColor;
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _detailLB.textColor = APP_CONFIG.blackTextColor;
    [_detailLB sizeToFit];
    
    _statusLB = [[UILabel alloc] init];
    _statusLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _statusLB.textColor = APP_CONFIG.appMainRedColor;
    [_statusLB sizeToFit];
    
    [self.contentView addSubview:_iconImageV];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_detailLB];
    [self.contentView addSubview:_statusLB];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(AdaptatSize(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo((CGSize){AdaptatSize(70), AdaptatSize(70)});
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageV.mas_right).with.offset(10);
        make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-5);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.top.equalTo(self.contentView.mas_centerY).with.offset(5);
    }];
    [_statusLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLB);
        make.right.equalTo(self.contentView).with.offset(-AdaptatSize(50));
    }];
}

@end
