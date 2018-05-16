//
//  GJHomeFilterButton.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJHomeFilterButton.h"

@interface GJHomeFilterButton ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation GJHomeFilterButton

+ (GJHomeFilterButton *)install {
    GJHomeFilterButton *btn = [[GJHomeFilterButton alloc] initWithFrame:CGRectMake(SCREEN_W-AdaptatSize(64), SCREEN_H-AdaptatSize(151), 42, 42)];
    return btn;
}

- (void)filterButtonClick {
    BLOCK_SAFE(_filterClickBlock)();
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[UIButton alloc] initWithFrame:self.bounds];
        [_button setImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor whiteColor];
        _button.layer.cornerRadius = self.height/2;
        _button.clipsToBounds = YES;
        [_button addTarget:self action:@selector(filterButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.4;
        self.layer.shadowRadius = 6;
    }
    return self;
}

@end
