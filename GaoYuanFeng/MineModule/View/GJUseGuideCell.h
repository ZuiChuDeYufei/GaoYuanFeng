//
//  GJUseGuideCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"
#import "GJUseGuideData.h"

@interface GJUseGuideCell : GJBaseTableViewCell
@property (nonatomic, strong) GJUseGuideData *model;
- (void)setBottomButton;
@end
