//
//  GJFilterZoneData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/12.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJFilterZoneDataRegion : GJBaseModel
@property (nonatomic, strong) NSString *cityid;
@property (nonatomic, strong) NSString *districtid;
@property (nonatomic, strong) NSString *region_id;
@property (nonatomic, strong) NSString *region_name;
@property (nonatomic, strong) NSArray <GJFilterZoneDataRegion *> *list;     // 子集仅有 region_id、region_name，无 list 等
@end

@interface GJFilterZoneDataType : GJBaseModel
@property (nonatomic, strong) NSString *catid;
@property (nonatomic, strong) NSString *cat_name;
@property (nonatomic, assign) BOOL child;
@property (nonatomic, strong) NSArray <GJFilterZoneDataType *> *list;       // 子集里面无 list
@end

@interface GJFilterZoneData : GJBaseModel
@property (nonatomic, strong) NSArray <GJFilterZoneDataType *> *type;
@property (nonatomic, strong) NSArray <GJFilterZoneDataRegion *> *region;
@end
