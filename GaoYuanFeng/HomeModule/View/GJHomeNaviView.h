//
//  GJHomeNaviView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"
#import "GJMessageItem.h"

@interface GJHomeNaviView : GJBaseView
@property (nonatomic, strong) GJMessageItem *messageItem;
@property (nonatomic, strong) GJMessageItem *userItem;
@property (copy,nonatomic) void(^goUser)(void);
@property (copy,nonatomic) void(^goMessage)(void);
@property (copy,nonatomic) void(^goSearch)(void);
+ (GJHomeNaviView *)install;
@end
