//
//  GJScoreTopView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJScoreTopView.h"
#import "GJScoreModel.h"
#import "GJScoreTopCell.h"

@interface GJScoreTopView ()
@property (strong, nonatomic) GJScoreTopCell *cell;
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UIButton *rightBtn;
@end

@implementation GJScoreTopView

- (void)rightBtnClick {
    BLOCK_SAFE(_blockRightBtn)();
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    _cell = [[GJScoreTopCell alloc] initWithStyle:[GJScoreTopCell expectingStyle] reuseIdentifier:[GJScoreTopCell reuseIndentifier]];
    [self addSubview:_cell];
    [_cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self).with.offset(-10);
    }];
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = APP_CONFIG.appBackgroundColor;
    [self addSubview:_bottomLine];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(AdaptatSize(10));
    }];
    
    _rightBtn = [[UIButton alloc] init];
    [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-5);
        make.centerY.equalTo(self);
        make.size.mas_equalTo((CGSize){AdaptatSize(90), AdaptatSize(30)});
    }];
}

- (void)setModel:(GJScoreModel *)model {
    _model = model;
    _cell.score = JudgeContainerCountIsNull(model.user_credits)?@"0":model.user_credits;
}

@end
