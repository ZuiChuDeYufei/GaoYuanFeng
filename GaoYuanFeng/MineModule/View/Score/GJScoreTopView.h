//
//  GJScoreTopView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@class GJScoreModel;

@interface GJScoreTopView : GJBaseView
@property (nonatomic, strong) GJScoreModel *model;
@property (nonatomic, copy) void (^blockRightBtn)(void);
@end
