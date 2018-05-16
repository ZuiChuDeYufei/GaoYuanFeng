//
//  GJHomeGotoLoginView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJHomeGotoLoginView : GJBaseView
@property (nonatomic, copy) void (^rightClickBlock)(void);
+ (GJHomeGotoLoginView *)install;
@end
