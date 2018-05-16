//
//  GJHomeSearchPointData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/4.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJHomeSearchPointData : GJBaseModel
@property (nonatomic, strong) NSString *supplier_id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *supplier_name;
@property (nonatomic, strong) NSString *english_name;
@property (nonatomic, strong) NSString *streetname;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSArray *company_images;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *jd;
@property (nonatomic, strong) NSString *wd; //latitude
@property (nonatomic, strong) NSString *shop_hours;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *addr_img;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSArray *tagArr;
@end
