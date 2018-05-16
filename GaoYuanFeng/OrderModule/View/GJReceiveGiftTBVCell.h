//
//  GJReceiveGiftTBVCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/25.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"
#import "GJGiftListSelectData.h"

@protocol GJReceiveGiftCellDelegate <NSObject>
@optional
- (void)selectWithData:(GJGiftListSelectDataList *)data isSelect:(BOOL)isSelect;
- (void)addOrDevideCount:(NSInteger)count data:(GJGiftListSelectDataList *)data isAdd:(BOOL)isAdd;
@end

@interface GJReceiveGiftTBVCell : GJBaseTableViewCell

@property (nonatomic, weak) id <GJReceiveGiftCellDelegate> myDelegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) GJGiftListSelectDataList *model;

@property (nonatomic, assign) NSInteger labelCount;

@end
