//
//  GJInfoSettingsController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCustomPresentController.h"

@interface GJInfoSettingsController : GJCustomPresentController
@property (nonatomic, strong) void (^portraitHasUpdated)(void);
@end
