//
//  GJConfigureManager.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJAppConfigure.h"

#define APP_CONFIG [GJConfigureManager sharedManager].config

@interface GJConfigureManager : NSObject

@property (nonatomic, strong) GJAppConfigure * config;  ///< 项目基本配置


+ (GJConfigureManager *)sharedManager;

@end
