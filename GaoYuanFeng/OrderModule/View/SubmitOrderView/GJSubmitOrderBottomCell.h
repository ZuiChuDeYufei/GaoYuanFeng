//
//  GJSubmitOrderBottomCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"
#import "GJSubmitOrderAdressData.h"

@interface GJSubmitOrderBottomCell : GJBaseTableViewCell
@property (nonatomic, strong) GJSubmitOrderAdressData *model;
@property (nonatomic, strong) NSString *cellText;
- (void)canEdit:(BOOL)can;
-(void)setTitleBlack:(NSString *)text;
@end
