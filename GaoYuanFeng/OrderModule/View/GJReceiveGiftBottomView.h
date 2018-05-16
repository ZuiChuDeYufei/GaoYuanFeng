//
//  GJReceiveGiftBottomView.h
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJReceiveGiftBottomView : GJBaseView

@property (nonatomic, copy) void (^receiveClick)(void);

+ (GJReceiveGiftBottomView *)install;

@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *numberOfSelect;

@end
