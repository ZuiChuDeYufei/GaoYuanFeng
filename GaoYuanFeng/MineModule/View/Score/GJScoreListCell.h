//
//  GJScoreListCell.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJNormalTBVCell.h"
#import "GJScoreModel.h"

@interface GJScoreListCell : GJNormalTBVCell

@property (nonatomic, strong) GJScoreModelList *model;
+ (CGFloat)height;

@end
