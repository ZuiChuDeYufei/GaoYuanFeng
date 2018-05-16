//
//  GJLocateButton.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJLocateButton.h"

@interface GJLocateButton ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation GJLocateButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubview];
    }
    return self;
}

+ (GJLocateButton *)install {
    GJLocateButton *btn = [[GJLocateButton alloc] initWithFrame:CGRectMake(20, SCREEN_H-AdaptatSize(150), AdaptatSize(150), 40)];
    return btn;
}

- (void)locateBtnClick {
    if (self.isSelected) return ;
    _isSelected = YES;
    BLOCK_SAFE(_searchClickBlock)();
}

- (void)searchBtnClick {
    if (self.isSelected) return ;
    _isSelected = YES;
    BLOCK_SAFE(_searchClickBlock)();
}

- (void)setupSubview {
    _backView = [[UIView alloc] initWithFrame:self.bounds];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = self.height/2;
    _backView.clipsToBounds = YES;
    [self addSubview:_backView];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 6;
    
    _leftBtn = [[UIButton alloc] init];
    [_leftBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(locateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_leftBtn];
    
    _rightBtn = [[UIButton alloc] init];
    _rightBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBtn setTitle:@"搜索当前区域" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_rightBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    _leftBtn.frame = CGRectMake(10, 10, size.height-20, size.height-20);
    _rightBtn.frame = CGRectMake(size.height-7, 2, size.width-size.height, size.height-4);
}

@end
