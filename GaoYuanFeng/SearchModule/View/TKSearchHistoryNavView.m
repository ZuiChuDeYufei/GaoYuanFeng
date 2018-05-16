//
//  TKSearchHistoryNavView.m
//  TongKe
//
//  Created by hsrd on 2018/5/11.
//  Copyright © 2018年 hsrd. All rights reserved.
//

#import "TKSearchHistoryNavView.h"

@interface TKSearchHistoryNavView ()
@property (nonatomic, strong) UIButton *leftBtnInTF;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation TKSearchHistoryNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = [UIColor clearColor];
    _searchTF = [[UITextField alloc] init];
    _searchTF.layer.cornerRadius = (self.height-11)/2;
    _searchTF.layer.masksToBounds = YES;
    _searchTF.backgroundColor = [APP_CONFIG.whiteGrayColor colorWithAlphaComponent:0.9];
    _searchTF.font = AdapFont([APP_CONFIG appFontOfSize:13]);
    _searchTF.textColor = [UIColor colorWithHexRGB:@"#333333"];
    _searchTF.tintColor= [UIColor blueColor];
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.returnKeyType = UIReturnKeySearch;
    _searchTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _searchTF.backgroundColor = [UIColor colorWithRGB:242 g:242 b:242];
    _leftBtnInTF = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 40, self.height - 24)];
    [_leftBtnInTF setImage:[UIImage imageNamed:@"search_magnifier"] forState:UIControlStateNormal];
    [_leftBtnInTF setImage:[UIImage imageNamed:@"search_magnifier"] forState:UIControlStateHighlighted];
    _leftBtnInTF.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索实体门店" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexRGB:@"999999"]}];
    _searchTF.leftView = _leftBtnInTF;
    
    [self addSubview:_searchTF];
    [self updateFrameWithLeftBtn];
}

- (void)updateFrameWithLeftBtn {
    [_leftBtnInTF layoutIfNeeded];
    CGSize titleSize = _leftBtnInTF.titleLabel.bounds.size;
    CGSize imageSize = _leftBtnInTF.imageView.bounds.size;
    
    CGFloat interval = 1.f;
    _leftBtnInTF.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    _leftBtnInTF.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _searchTF.frame = CGRectMake(0, 4, self.width, self.height - 11);
}

- (CGSize)intrinsicContentSize {
    //    return CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    return UILayoutFittingExpandedSize;
}

@end
