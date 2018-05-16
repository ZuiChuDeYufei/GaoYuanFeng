//
//  GJSearchManager.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class GJHomeSearchPointData;

@interface GJSearchManager : NSObject

/**
 搜索店铺列表

 @param keyword 关键字
 @param successBlock 成功
 @param failureBlock 失败
 */
- (void)requestSupplierDetailWithKW:(NSString *)keyword
                          latalongi:(CLLocationCoordinate2D)latalongi
                            success:(void (^)(NSArray <GJHomeSearchPointData *> *models))successBlock
                            failure:(HTTPTaskFailureBlock)failureBlock;

@end
