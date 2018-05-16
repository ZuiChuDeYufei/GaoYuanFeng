//
//  GJInfoSettingCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/2.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJInfoSettingCell.h"

@implementation GJInfoSettingCell

- (void)commonInit {
    [super commonInit];
    [self settingShowSpeatLine:YES withColor:APP_CONFIG.separatorLineColor];
}

+ (CGFloat)cellHeight {
    return AdaptatSize(45);
}

@end
