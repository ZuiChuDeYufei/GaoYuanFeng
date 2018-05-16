//
//  GJTypeFile.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ScanCenterType1 = 200
} ScanCenterType; // 扫码类型

typedef enum : NSInteger {
    kMineMoveDirectionNone,
    kMineMoveDirectionUp,
    kMineMoveDirectionDown,
    kMineMoveDirectionRight,
    kMineMoveDirectionLeft
} MineMoveDirection;

typedef enum : NSInteger {
    WeChatPay,
    ZhiFuBaoPay,
    UnionPay
} PayTypes;

typedef enum : NSInteger {
    RegionNone,
    RegionProvince,
    RegionCity,
    RegionDistrict
} RegionTypes;

@interface GJTypeFile : NSObject

@end
