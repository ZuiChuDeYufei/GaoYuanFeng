//
//  GJSubmitOrderController.h
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCustomPresentController.h"

@class GJGiftListSelectDataList;

@interface GJSubmitOrderController : GJCustomPresentController
@property (nonatomic, strong) NSMutableArray <GJGiftListSelectDataList *> *seleteArr;
@end
