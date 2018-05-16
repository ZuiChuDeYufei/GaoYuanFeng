//
//  GJMineCenterTBVCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMineCenterTBVCell.h"

@interface GJMineCenterTBVCell ()
@property (nonatomic, strong) UIImageView *portraitIV;
@property (nonatomic, strong) UIButton *infoBtn;
@property (nonatomic, strong) UIButton *phoneBtn;
@end

@implementation GJMineCenterTBVCell

- (void)getPortrait {
    if (APP_USER.userInfo.avatarImage) {
        _portraitIV.image = APP_USER.userInfo.avatarImage;
        return;
    }
    [_portraitIV sd_setImageWithURL:[NSURL URLWithString:APP_USER.userInfo.avatar] placeholderImage:[UIImage imageNamed:@"portrait"]];
}

- (void)setNickName {
    NSString *nick = JudgeContainerCountIsNull(APP_USER.userInfo.nickname)?@"昵称":APP_USER.userInfo.nickname;
    [_phoneBtn setTitle:nick forState:UIControlStateNormal];
}

- (void)commonInit {
    self.backgroundColor = [UIColor colorWithRGB:245 g:248 b:247];
    
    _portraitIV = [[UIImageView alloc] init];
    _portraitIV.contentMode = UIViewContentModeScaleAspectFit;
    [self getPortrait];
    
    _portraitIV.layer.cornerRadius = 30;
    _portraitIV.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protraitTap)];
    tap.numberOfTapsRequired = 1;
    [_portraitIV addGestureRecognizer:tap];
    
    _infoBtn = [[UIButton alloc] init];
    _infoBtn.layer.cornerRadius = 12;
    _infoBtn.clipsToBounds = YES;
    _infoBtn.layer.borderWidth = 1;
    _infoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _infoBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:11]);
    [_infoBtn setTitle:@"初级买单会员" forState:UIControlStateNormal];
    [_infoBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_infoBtn addTarget:self action:@selector(infoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _phoneBtn = [[UIButton alloc] init];
    _phoneBtn.titleLabel.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:24]);
    _phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _portraitIV.userInteractionEnabled = NO;
    _infoBtn.userInteractionEnabled = NO;
    _phoneBtn.userInteractionEnabled = NO;
    
    [self.contentView addSubview:_portraitIV];
    [self.contentView addSubview:_phoneBtn];
    [self.contentView addSubview:_infoBtn];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_portraitIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo((CGSize){60, 60});
    }];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_portraitIV).with.offset(3);
        make.left.equalTo(_portraitIV.mas_right).with.offset(15);
        make.size.mas_equalTo((CGSize){AdaptatSize(120), 20});
    }];
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneBtn);
        make.bottom.equalTo(_portraitIV).with.offset(-3);
        make.size.mas_equalTo((CGSize){AdaptatSize(90), 24});
    }];
}

- (CGFloat)height {
    return AdaptatSize(80);
}

- (void)phoneBtnClick {
    
}

- (void)protraitTap {
    
}

- (void)infoBtnClick {
    
}

@end
