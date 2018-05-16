//
//  GJInviteHasGiftView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/9.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJInviteHasGiftView.h"

@interface GJInviteHasGiftView ()
@property (nonatomic, strong) UIView *backV;
@property (nonatomic, strong) UIView *centerLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *inviteFriendBtn;
@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic, strong) UILabel *showInviteListLB;
@property (nonatomic, strong) UIView *showInviteLeftLine;
@property (nonatomic, strong) UIImageView *showInviteRight;

@property (nonatomic, strong) UILabel *introLB;
@property (nonatomic, strong) UILabel *inviteLB;
@property (nonatomic, strong) UILabel *inviteDetLB;
@property (nonatomic, strong) UILabel *hasInviteLB;
@property (nonatomic, strong) UILabel *hasInvite;
@property (nonatomic, strong) UILabel *gainScoreLB;
@property (nonatomic, strong) UILabel *gainScore;
@end

@implementation GJInviteHasGiftView

- (void)bottomBtnClick {
    BLOCK_SAFE(_blockFriendList)();
}

- (void)inviteFriendBtnClick {
    BLOCK_SAFE(_blockInviteFriend)();
}

- (void)setNumber:(NSInteger)num score:(NSInteger)score {
    NSString *str1 = [NSString stringWithFormat:@"已邀请%ld位好友", (long)num];
    NSMutableAttributedString *muStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [muStr1 addAttribute:NSForegroundColorAttributeName value:APP_CONFIG.darkTextColor range:[str1 rangeOfString:@"已邀请"]];
    [muStr1 addAttribute:NSForegroundColorAttributeName value:APP_CONFIG.darkTextColor range:[str1 rangeOfString:@"位好友"]];
    _hasInvite.attributedText = muStr1;
    
    NSString *str2 = [NSString stringWithFormat:@"奖励总额%ld积分", (long)score];
    NSMutableAttributedString *muStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [muStr2 addAttribute:NSForegroundColorAttributeName value:APP_CONFIG.darkTextColor range:[str2 rangeOfString:@"奖励总额"]];
    [muStr2 addAttribute:NSForegroundColorAttributeName value:APP_CONFIG.darkTextColor range:[str2 rangeOfString:@"积分"]];
    _gainScore.attributedText = muStr2;
}

- (void)commonInit {
    _backV = [[UIView alloc] init];
    _backV.layer.cornerRadius = 4;
    _backV.backgroundColor = [UIColor whiteColor];
    _backV.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _backV.layer.shadowOffset = CGSizeMake(0, 0);
    _backV.layer.shadowOpacity = 0.2;
    _backV.layer.shadowRadius = 6;
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor colorWithRGB:218 g:220 b:221];
    _centerLine = [[UIView alloc] init];
    _centerLine.backgroundColor = _bottomLine.backgroundColor;
    
    _inviteFriendBtn = [[UIButton alloc] init];
    _inviteFriendBtn.backgroundColor = [UIColor colorWithRGB:235 g:75 b:0];
    [_inviteFriendBtn addTarget:self action:@selector(inviteFriendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _inviteFriendBtn.layer.cornerRadius = 5;
    _inviteFriendBtn.clipsToBounds = YES;
    
    _bottomBtn = [[UIButton alloc] init];
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _showInviteListLB = [self createLabelWith:@"查看受邀好友列表" color:[UIColor darkGrayColor] font:AdapFont([APP_CONFIG appFontOfSize:14])];
    _showInviteLeftLine = [[UIView alloc] init];
    _showInviteLeftLine.backgroundColor = APP_CONFIG.appMainColor;
    _showInviteRight = [[UIImageView alloc] init];
    _showInviteRight.contentMode = UIViewContentModeScaleAspectFit;
    _showInviteRight.image = [UIImage imageNamed:@"next11"];
    
    _introLB = [self createLabelWith:@"" color:[UIColor lightGrayColor] font:AdapFont([APP_CONFIG appFontOfSize:12])];
    _introLB.numberOfLines = 0;
    NSString *str = @"点击呼朋唤友按钮即默认为您阅读并同意《邀好友买一送一协议》，知悉返积分不可提现。查看协议详情";
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:@"查看协议详情"];
    [muStr addAttribute:NSForegroundColorAttributeName value:APP_CONFIG.darkTextColor range:range];
    [muStr addAttributes:@{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:range];
    _introLB.attributedText = muStr;
    
    _inviteLB = [self createLabelWith:@"呼朋唤友" color:APP_CONFIG.whiteGrayColor font:AdapFont([APP_CONFIG appBoldFontOfSize:17])];
    _inviteDetLB = [self createLabelWith:@"每成功要求一位好友即可获得10奖励积分" color:APP_CONFIG.whiteGrayColor font:AdapFont([APP_CONFIG appFontOfSize:12])];
    
    _hasInviteLB = [self createLabelWith:@"请再接再厉" color:APP_CONFIG.grayTextColor font:AdapFont([APP_CONFIG appFontOfSize:13])];
    _hasInvite = [self createLabelWith:@"" color:APP_CONFIG.appMainRedColor font:AdapFont([APP_CONFIG appFontOfSize:15])];
    
    _gainScoreLB = [self createLabelWith:@"1积分等于1元" color:APP_CONFIG.grayTextColor font:AdapFont([APP_CONFIG appFontOfSize:13])];
    _gainScore = [self createLabelWith:@"" color:APP_CONFIG.appMainRedColor font:AdapFont([APP_CONFIG appFontOfSize:15])];
    
    [self addSubview:_backV];
    [self addSubview:_bottomLine];
    [self addSubview:_bottomBtn];
    [self addSubview:_inviteFriendBtn];
    [self addSubview:_centerLine];
    [self addSubview:_showInviteListLB];
    [self addSubview:_showInviteLeftLine];
    [self addSubview:_showInviteRight];
    [self addSubview:_introLB];
    [self addSubview:_inviteLB];
    [self addSubview:_inviteDetLB];
    [self addSubview:_hasInviteLB];
    [self addSubview:_hasInvite];
    [self addSubview:_gainScoreLB];
    [self addSubview:_gainScore];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).with.offset(15);
        make.right.equalTo(self).with.offset(-15);
        make.height.mas_equalTo(AdaptatSize(180));
    }];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self).with.offset(-30);
        make.left.equalTo(self).with.offset(AdaptatSize(30));
        make.height.mas_equalTo(AdaptatSize(45));
    }];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(30));
        make.right.equalTo(self).with.offset(AdaptatSize(-30));
        make.height.mas_equalTo(1);
        make.bottom.equalTo(_bottomBtn.mas_top).with.offset(AdaptatSize(-10));
    }];
    [_inviteFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(_backV).with.offset(-AdaptatSize(20));
        make.left.equalTo(_backV).with.offset(AdaptatSize(20));
        make.height.mas_equalTo(AdaptatSize(60));
    }];
    [_centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backV);
        make.width.mas_equalTo(1);
        make.top.equalTo(_backV).with.offset(AdaptatSize(27));
        make.bottom.equalTo(_inviteFriendBtn.mas_top).with.offset(-AdaptatSize(27));
    }];
    [_showInviteLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(_bottomBtn);
        make.size.mas_equalTo((CGSize){2, 18});
    }];
    [_showInviteListLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomBtn);
        make.left.equalTo(_showInviteLeftLine.mas_right).with.offset(15);
    }];
    [_showInviteRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(_bottomBtn);
    }];
    [_introLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bottomBtn);
        make.top.equalTo(_backV.mas_bottom).with.offset(10);
    }];
    [_inviteLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_inviteFriendBtn);
        make.top.equalTo(_inviteFriendBtn).with.offset(8);
    }];
    [_inviteDetLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_inviteFriendBtn);
        make.bottom.equalTo(_inviteFriendBtn).with.offset(-8);
    }];
    [_hasInviteLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_centerLine).with.offset(-AdaptatSize(53));
        make.bottom.equalTo(_centerLine);
    }];
    [_hasInvite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_hasInviteLB);
        make.top.equalTo(_centerLine);
    }];
    [_gainScoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_centerLine).with.offset(AdaptatSize(50));
        make.bottom.equalTo(_centerLine);
    }];
    [_gainScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_gainScoreLB);
        make.top.equalTo(_centerLine);
    }];
}

- (UILabel *)createLabelWith:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    UILabel *lb = [[UILabel alloc] init];
    lb.font = font;
    lb.textColor = color;
    lb.text = title;
    [lb sizeToFit];
    return lb;
}

@end
