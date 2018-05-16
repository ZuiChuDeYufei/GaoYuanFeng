//
//  GJHomeManager.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/4.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJHomeSearchPointData.h"
#import <CoreLocation/CoreLocation.h>

@class GJLocationCoordinateData;
@class GJFilterZoneData;

@interface GJHomeManager : NSObject

/**
 列表搜索筛选内容

 @param cityID 城市
 @param successBlock 成功
 @param failureBlock 失败
 */
- (void)requestFilterZoneListCityID:(NSString *)cityID
                            success:(void (^)(GJFilterZoneData *models))successBlock
                            failure:(HTTPTaskFailureBlock)failureBlock;

/**
 省市区数据
 */
- (void)requestRegionData;

/**
 店铺列表

 @param latalongi 经纬度
 @param successBlock 成功
 @param failureBlock 失败
 */
- (void)requestSupplierListWithLataLongi:(CLLocationCoordinate2D)latalongi
                                 success:(void (^)(NSArray <GJHomeSearchPointData *> *models, NSArray <GJLocationCoordinateData *> *points))successBlock
                                 failure:(HTTPTaskFailureBlock)failureBlock;

/**
 店铺详情

 @param businessID ID
 @param successBlock 成功
 @param failureBlock 失败
 */
- (void)requestSupplierDetailWithID:(NSString *)businessID
                            success:(void (^)(GJHomeSearchPointData *model))successBlock
                            failure:(HTTPTaskFailureBlock)failureBlock;

@end
