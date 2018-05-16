//
//  GJTradeAreaTopDetailView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/30.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"
#import "GJFilterZoneData.h"

@interface GJTradeAreaTopDetailView : GJBaseView
@property (nonatomic, strong) NSArray <GJFilterZoneDataType *> *filterTypes;
@property (nonatomic, strong) NSArray <GJFilterZoneDataRegion *> *filterRegions;

@property (nonatomic, copy) void (^blockClickRowIn)(void);
@end
