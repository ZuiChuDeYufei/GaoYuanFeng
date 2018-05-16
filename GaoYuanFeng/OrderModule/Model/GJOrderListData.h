//
//  GJOrderListData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJOrderList : GJBaseModel
@property (nonatomic, strong) NSString *supplier_name;
@property (nonatomic, strong) NSString *payid;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *credits;
@property (nonatomic, strong) NSString *created_at;

@end

@interface GJOrderListData : GJBaseModel
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSArray <GJOrderList *> *data;
@property (nonatomic, strong) NSString *lqhl_num;
@property (nonatomic, strong) NSString *total_pay;
@property (nonatomic, strong) NSString *total_credits;
@end

