//
//  GJGiftListSelectData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJGiftListSelectDataList : GJBaseModel
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) CGFloat total;

@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_sn;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, assign) CGFloat goods_price;
@property (nonatomic, strong) NSString *goods_number;
@property (nonatomic, strong) NSString *url;
@end

@interface GJGiftListSelectData : GJBaseModel
@property (nonatomic, assign) CGFloat user_credits;
@property (nonatomic, strong) NSMutableArray <GJGiftListSelectDataList *> *list;
@end

