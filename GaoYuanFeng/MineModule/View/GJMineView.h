//
//  GJMineView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"
#import "GJMineCenterTBVCell.h"
#import "GJMoneyOrderCell.h"
#import "GJMineBottomCell.h"

@protocol GJMineViewDelegate <NSObject>

- (UITableViewCell *)minePage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)minePage_heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)minePage_numberOfSectionsInTableView;
- (void)minePage:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GJMineView : GJBaseView

@property (nonatomic, weak) id <GJMineViewDelegate> myDelegate;
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJMineCenterTBVCell *top_cell;
@property (nonatomic, strong) GJMoneyOrderCell *center_cell;
@property (nonatomic, copy) void (^dismissBlock)(void);
@property (nonatomic, copy) void (^blockSettingPage)(void);
@property (nonatomic, copy) void (^blockContactPage)(void);

- (void)dismissSelf;
- (void)presentSelf:(UIViewController *)fromVC;

@end
