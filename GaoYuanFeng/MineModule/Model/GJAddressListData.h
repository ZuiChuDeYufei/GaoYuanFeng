//
//  GJAddressListData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJAddressListData : GJBaseModel
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) BOOL is_default;
@property (nonatomic, strong) NSString *created_at;
+ (GJAddressListData *)modelWithID:(NSString *)ID uid:(NSString *)uid name:(NSString *)name phone:(NSString *)phone province:(NSString *)province city:(NSString *)city district:(NSString *)district address:(NSString *)address is_default:(BOOL)is_default created_at:(NSString *)created_at;
@end
