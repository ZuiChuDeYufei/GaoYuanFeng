//
//  GJOrderListData.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJOrderListData.h"

@implementation GJOrderList

@end

@implementation GJOrderListData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : GJOrderList.class};
}

- (CGFloat)cellHeight {
    return AdaptatSize(110);
}

@end
