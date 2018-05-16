//
//  GJTradeAreaTBVCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJNormalTBVCell.h"
#import "GJHomeSearchPointData.h"

@interface GJTradeAreaTBVCell : GJNormalTBVCell

@property (nonatomic, strong) GJHomeSearchPointData *listData;

+ (CGFloat)height;

@end
