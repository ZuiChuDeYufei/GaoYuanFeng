//
//  GJGrayBackView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/4.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJGrayBackView.h"

@implementation GJGrayBackView

- (void)commonInit {
    self.hidden = YES;
    
}

- (void)showSelfAplha:(CGFloat)alpha {
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:alpha];
    }];
}

- (void)hideSelf {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end
