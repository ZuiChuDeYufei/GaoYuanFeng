//
//  GJTradeAreaTopView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJTradeAreaTopDetailView.h"

@interface GJTradeAreaTopView : UIButton
@property (nonatomic, copy) void (^searchPageClickPage)(void);
@property (nonatomic, copy) void (^naviRefreshLocateBlock)(void);
@property (nonatomic, copy) void (^fullViewBtnBlock)(void);
@property (nonatomic, strong) UITableView *areaTable;
@property (nonatomic, strong) UIButton *fullViewBtn;
@property (nonatomic, assign) BOOL isExpandSelf;
@property (nonatomic, strong) GJFilterZoneData *filterZoneData;
- (void)setCurrentLocation:(NSString *)location;
- (void)recoverSelf;
@end
