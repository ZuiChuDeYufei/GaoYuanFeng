//
//  GJHomeBottomView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJHomeBottomView.h"

@interface GJHomeBottomView ()
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation GJHomeBottomView

+ (GJHomeBottomView *)install {
    GJHomeBottomView *bottom = [[GJHomeBottomView alloc] initWithFrame:CGRectMake(15, SCREEN_H-AdaptatSize(80), SCREEN_W-30, AdaptatSize(59))];
    return bottom;
}

- (void)commonInit {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 7;
    
    _bottomBtn = [[UIButton alloc] initWithFrame:self.bounds];
    _bottomBtn.backgroundColor = [UIColor colorWithRGB:52 g:60 b:75];
    _bottomBtn.layer.cornerRadius = 8;
    _bottomBtn.clipsToBounds = YES;
    _bottomBtn.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:16]);
    [_bottomBtn setTitle:@"买一送一" forState:UIControlStateNormal];
    [_bottomBtn setImage:[UIImage imageNamed:@"sacn"] forState:UIControlStateNormal];
    [_bottomBtn setImage:[UIImage imageNamed:@"sacn"] forState:UIControlStateHighlighted];
    [_bottomBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
    [_bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bottomBtn];
}

- (void)bottomBtnClick {
    BLOCK_SAFE(_bottomScanBtnBlock)();
}

@end
