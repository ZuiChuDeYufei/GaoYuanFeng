//
//  GJUserInfoData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJUserInfoData : GJBaseModel <NSCoding>

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *api_token;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *tokenid;
@property (nonatomic, strong) NSString *wx_tokenid;
@property (nonatomic, strong) NSString *group_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *isphone;
@property (nonatomic, strong) NSString *isWX;
@property (nonatomic, strong) NSString *isQQ;
@property (nonatomic, strong) NSString *credits;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *sfz_card;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *bg_img;
@property (nonatomic, strong) NSString *autograph;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *freeze;
@property (nonatomic, strong) NSString *spend;
@property (nonatomic, strong) NSString *loginip;
@property (nonatomic, strong) NSString *updated_at;

@property (nonatomic, strong) UIImage *avatarImage;

@end
