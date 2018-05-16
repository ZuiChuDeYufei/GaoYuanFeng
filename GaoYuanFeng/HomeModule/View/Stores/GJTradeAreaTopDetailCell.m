//
//  GJTradeAreaTopDetailCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/2.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJTradeAreaTopDetailCell.h"

@interface GJTradeAreaTopDetailCell ()

@end

@implementation GJTradeAreaTopDetailCell

- (void)commonInit {
    self.backgroundColor = self.superview.backgroundColor;
    self.textLabel.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    self.textLabel.textColor = [UIColor lightTextColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
