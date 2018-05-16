//
//  GJInviteHasGiftView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/9.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJInviteHasGiftView : GJBaseView
@property (nonatomic, copy) void (^blockInviteFriend)(void);
@property (nonatomic, copy) void (^blockFriendList)(void);
- (void)setNumber:(NSInteger)num score:(NSInteger)score;
@end
