//
//  GJInviteFriendListData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJInviteFriendListData : GJBaseModel
@property (nonatomic, strong) NSString *syr_uid;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *beizhu;
@end
