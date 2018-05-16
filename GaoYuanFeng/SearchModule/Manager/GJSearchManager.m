//
//  GJSearchManager.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSearchManager.h"
#import "GJHomeSearchPointData.h"

@implementation GJSearchManager

- (void)requestSupplierDetailWithKW:(NSString *)keyword latalongi:(CLLocationCoordinate2D)latalongi success:(void (^)(NSArray<GJHomeSearchPointData *> *))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    if (!keyword) return;
    double lati = latalongi.latitude;
    double longi = latalongi.longitude;
    [[GJHttpNetworkingManager sharedInstance] requestAllDataPostWithPathUrl:Home_Search_StoreList andParaDic:@{@"kw":keyword, @"lat":[NSNumber numberWithDouble:lati], @"lng":[NSNumber numberWithDouble:longi]} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        NSArray *datas = [NSArray yy_modelArrayWithClass:GJHomeSearchPointData.class json:response[@"data"]];
        successBlock(datas);
    } andFailedCallback:failureBlock];
}

@end
