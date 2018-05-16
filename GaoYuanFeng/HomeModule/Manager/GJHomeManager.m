//
//  GJHomeManager.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/4.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJHomeManager.h"
#import "GJLocationCoordinateData.h"
#import "GJFilterZoneData.h"

@implementation GJHomeManager

- (void)requestFilterZoneListCityID:(NSString *)cityID success:(void (^)(GJFilterZoneData *))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSString *cityId = JudgeContainerCountIsNull(cityID)?@"111":cityID;
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Home_Filter_ZoneList andParaDic:@{@"cityid":cityId} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJFilterZoneData *data  =[GJFilterZoneData yy_modelWithJSON:response];
        successBlock(data);
    } andFailedCallback:failureBlock];
}

- (void)requestRegionData {
    if (APP_USER.regionData) return ;
    [[GJHttpNetworkingManager sharedInstance] requestAllDataPostWithPathUrl:Home_Region_List andParaDic:nil andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJRegionData *data = [GJRegionData yy_modelWithJSON:response];
        [APP_USER saveRegionData:data];
    } andFailedCallback:^(NSURLResponse *urlResponse, NSError *error) {
        ShowWaringAlertHUD(@"获取省市区数据失败", nil);
    }];
}

- (void)requestSupplierListWithLataLongi:(CLLocationCoordinate2D)latalongi success:(void (^)(NSArray<GJHomeSearchPointData *> *, NSArray<GJLocationCoordinateData *> *))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    double lati = latalongi.latitude;
    double longi = latalongi.longitude;
    if (lati == 0 || longi == 0) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"定位失败"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LactionFailureError" code:500 userInfo:userInfo];
        BLOCK_SAFE(failureBlock)(nil, error);
        return ;
    }
    NSDictionary *para = @{@"lat":[NSString stringWithFormat:@"%.6f", lati], @"lng":[NSString stringWithFormat:@"%.6f", longi]};
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:SupplierList_Latalongi andParaDic:para andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        NSArray <GJHomeSearchPointData *> *models = [NSArray yy_modelArrayWithClass:GJHomeSearchPointData.class json:response];
        NSMutableArray <GJLocationCoordinateData *> *arr = @[].mutableCopy;
        [models enumerateObjectsUsingBlock:^(GJHomeSearchPointData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject:[GJLocationCoordinateData modelWithLati:[obj.wd doubleValue] longi:[obj.jd doubleValue]]];
        }];
        successBlock(models, arr);
    } andFailedCallback:failureBlock];
}

- (void)requestSupplierDetailWithID:(NSString *)businessID success:(void (^)(GJHomeSearchPointData *))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSDictionary *para = @{@"supplier_id":businessID};
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:SupplierDetail_ID andParaDic:para andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJHomeSearchPointData *data = [GJHomeSearchPointData yy_modelWithJSON:response];
        successBlock(data);
    } andFailedCallback:failureBlock];
}

@end
