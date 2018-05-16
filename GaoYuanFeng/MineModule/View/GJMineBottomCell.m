//
//  GJMineBottomCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMineBottomCell.h"

@implementation GJMineBottomCell

- (void)commonInit {
    [super commonInit];
    [self settingShowSpeatLine:NO];
}

+ (CGFloat)cellHeight {
    return AdaptatSize(48.5);
}

@end
