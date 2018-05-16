//
//  GJTradeAreaTopView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJTradeAreaTopView.h"

@interface GJTradeAreaTopView ()
@property (nonatomic, strong) UIView *horizontalLine;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIButton *refreshBtn;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailTitleLB;
@property (nonatomic, strong) GJTradeAreaTopDetailView *detailTable;
@property (nonatomic, strong) UIButton *allTypeBtn;
@property (nonatomic, strong) UIButton *nearbyAreaBtn;
@property (nonatomic, strong) UIButton *autoSortBtn;
@property (nonatomic, assign) CGFloat headerInitHeight;
@end

@implementation GJTradeAreaTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)sortBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn == _allTypeBtn) {
        _nearbyAreaBtn.selected = _autoSortBtn.selected = NO;
        if (_allTypeBtn.isSelected) {
            _detailTable.filterTypes = _filterZoneData.type;
        }
    }
    if (btn == _nearbyAreaBtn) {
        _allTypeBtn.selected = _autoSortBtn.selected = NO;
        if (_nearbyAreaBtn.isSelected) {
            _detailTable.filterRegions = _filterZoneData.region;
        }
    }
    if (btn == _autoSortBtn) {
        _nearbyAreaBtn.selected = _allTypeBtn.selected = NO;
    }
    [self expandSelf:btn.isSelected];
}

- (void)fullViewBtnClick {
    BLOCK_SAFE(_fullViewBtnBlock)();
}

- (void)expandSelf:(BOOL)is {
    // move table with animastions.
    _isExpandSelf = is;
    CGFloat height;
    if (!is) height = _headerInitHeight;
    else  {
        height = AdaptatSize(400);
        BLOCK_SAFE(_searchPageClickPage)();
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.areaTable setY:height];
        [self.areaTable setHeight:self.superview.height-height];
    }];
}

- (void)recoverSelf {
    [self expandSelf:NO];
    _nearbyAreaBtn.selected = _autoSortBtn.selected = _allTypeBtn.selected = NO;
}

- (void)naviRouteBtnClick {
    BLOCK_SAFE(_naviRefreshLocateBlock)();
}

- (void)setCurrentLocation:(NSString *)location {
    _detailTitleLB.text = location ? location : @" ";
}

- (void)commonInit {
    _headerInitHeight = (SCREEN_H == kGJIphoneX) ? AdaptatSize(115) : AdaptatSize(110);
//    self.backgroundColor = [UIColor colorWithRGB:74 g:88 b:124];
    self.backgroundColor = [UIColor blackColor];
    
    _horizontalLine = [[UIView alloc] init];
    _horizontalLine.backgroundColor = [UIColor lightGrayColor];
    _leftLine = [[UIView alloc] init];
    _leftLine.backgroundColor = _horizontalLine.backgroundColor;
    _rightLine = [[UIView alloc] init];
    _rightLine.backgroundColor = _horizontalLine.backgroundColor;
    
    _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_refreshBtn addTarget:self action:@selector(naviRouteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.textColor = [UIColor lightTextColor];
    _titleLB.font = AdapFont([APP_CONFIG appFontOfSize:18]);
    [_titleLB sizeToFit];
    
    _detailTitleLB = [[UILabel alloc] init];
    _detailTitleLB.textColor = [UIColor whiteColor];
    _detailTitleLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    [_detailTitleLB sizeToFit];
    
    _allTypeBtn = [self getButtonsInSort:@"全部类型"];
    _nearbyAreaBtn = [self getButtonsInSort:@"附近区域"];
    _autoSortBtn = [self getButtonsInSort:@"智能排序"];
    
    _fullViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, _headerInitHeight)];
    [_fullViewBtn addTarget:self action:@selector(fullViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    /////// three table view
    _detailTable = [[GJTradeAreaTopDetailView alloc] init];
    
    [_refreshBtn setImage:[UIImage imageNamed:@"fresh"]
                 forState:UIControlStateNormal];
    [_refreshBtn setImage:[UIImage imageNamed:@"fresh"] forState:UIControlStateHighlighted];
    _titleLB.text = @"我的位置";
    _detailTitleLB.text = @" ";
    
    [self addSubview:_horizontalLine];
    [self addSubview:_leftLine];
    [self addSubview:_rightLine];
    [self addSubview:_refreshBtn];
    [self addSubview:_titleLB];
    [self addSubview:_detailTitleLB];
    [self addSubview:_allTypeBtn];
    [self addSubview:_nearbyAreaBtn];
    [self addSubview:_autoSortBtn];
    [self addSubview:_fullViewBtn];
    [self addSubview:_detailTable];
}

- (UIButton *)getButtonsInSort:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    button.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"filter_arrow_down"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"filter_arrow_up"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    return button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateFrames];
}

- (void)updateFrames {
    CGFloat height = (SCREEN_H == kGJIphoneX) ? AdaptatSize(24) : AdaptatSize(22);
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(_horizontalLine.mas_bottom).with.offset(10);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo((self.width)/3);
    }];
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(_horizontalLine.mas_bottom).with.offset(10);
        make.height.equalTo(_leftLine);
        make.left.mas_equalTo((self.width)*2/3);
    }];
    [_refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(15);
        make.right.equalTo(self).with.offset(-15);
        make.size.mas_equalTo((CGSize){40, 40});
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self).with.offset(AdaptatSize(12));
    }];
    [_detailTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(AdaptatSize(5));
        make.right.equalTo(_refreshBtn.mas_left);
    }];
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailTitleLB.mas_bottom).with.offset(AdaptatSize(5));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [_allTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).with.offset(-(SCREEN_W-30)/3);
        make.top.equalTo(_horizontalLine.mas_bottom).with.offset(AdaptatSize(7));
        make.size.mas_equalTo((CGSize){AdaptatSize(100), 30});
    }];
    [_nearbyAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_allTypeBtn);
        make.size.equalTo(_allTypeBtn);
    }];
    [_autoSortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).with.offset((SCREEN_W-30)/3);
        make.top.equalTo(_allTypeBtn);
        make.size.equalTo(_allTypeBtn);
    }];
    [_fullViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(_headerInitHeight);
    }];
    [_detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(self.height-_headerInitHeight);
    }];
}

@end
