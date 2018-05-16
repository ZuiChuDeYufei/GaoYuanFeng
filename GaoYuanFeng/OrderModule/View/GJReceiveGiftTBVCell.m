//
//  GJReceiveGiftTBVCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/25.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJReceiveGiftTBVCell.h"

@interface GJReceiveGiftTBVCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *iconImageV;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *devideBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *addDevideLB;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *needScoreLB;
@property (nonatomic, strong) UILabel *scoreLB;
@property (nonatomic, strong) UIView *line;
@end

@implementation GJReceiveGiftTBVCell

- (void)setContent {
    [_iconImageV sd_setImageWithURL:[NSURL URLWithString:_model.thumb]];
    _titleLB.text = _model.title;
    _needScoreLB.text = @"所需积分：";
    _scoreLB.text = [NSString stringWithFormat:@"%.0f", _model.goods_price];
}

- (void)setModel:(GJGiftListSelectDataList *)model {
    _model = model;
    _selectBtn.selected = _model.isSelect;
    [self setContent];
}

- (void)selectBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if ([self.myDelegate respondsToSelector:@selector(selectWithData:isSelect:)]) {
        _model.isSelect = YES;
        _model.count = [_addDevideLB.text integerValue];
        [self.myDelegate selectWithData:_model isSelect:btn.selected];
    }
}

- (void)addDevideBtnClick:(UIButton *)btn {
    NSUInteger number = [_addDevideLB.text integerValue];
    BOOL labelCanAdd;
    if (btn == _addBtn) {
        labelCanAdd = YES;
        ++ number;
    }else {
        labelCanAdd = NO;
        -- number;
    }
    if (number == 0) return ;
    if ([self.myDelegate respondsToSelector:@selector(addOrDevideCount:data:isAdd:)]) {
        _model.isSelect = NO;
        [self.myDelegate addOrDevideCount:number data:_model isAdd:labelCanAdd];
    }
}

- (void)setLabelCount:(NSInteger)labelCount {
    _labelCount = labelCount;
    if (labelCount >= 1) {
        if (labelCount > 10) {
            ShowWaringAlertHUD(@"已达到最大库存量", nil);
            return;
        }
        _addDevideLB.text = [NSString stringWithFormat:@"%ld", (long)labelCount];
    }
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = APP_CONFIG.separatorLineColor;
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    
    _iconImageV = [self createImageV];
    _addBtn = [self createButtonImgNormal:@"add" select:@"add" hilight:@"add"];
    [_addBtn addTarget:self action:@selector(addDevideBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _devideBtn = [self createButtonImgNormal:@"minus" select:@"minus" hilight:@"minus"];
    [_devideBtn addTarget:self action:@selector(addDevideBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _selectBtn = [self createButtonImgNormal:@"choose21" select:@"choose22" hilight:@"choose21"];
    [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _addDevideLB  = [self createLabel:16 color:[UIColor blackColor]];
    _addDevideLB.backgroundColor = [UIColor colorWithRGB:244 g:244 b:244];
    _addDevideLB.textAlignment = NSTextAlignmentCenter;
    _addDevideLB.text = @"1";
    _titleLB = [self createLabel:14 color:[UIColor blackColor]];
    _titleLB.numberOfLines = 3;
    _needScoreLB = [self createLabel:14 color:[UIColor grayColor]];
    _scoreLB = [self createLabel:14 color:APP_CONFIG.appMainRedColor];
    _scoreLB.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:20]);
    _line = [[UIView alloc] init];
    _line.backgroundColor = APP_CONFIG.separatorLineColor;
    
    [self.contentView addSubview:_backView];
    [self.contentView addSubview:_iconImageV];
    [self.contentView addSubview:_addBtn];
    [self.contentView addSubview:_devideBtn];
    [self.contentView addSubview:_selectBtn];
    [self.contentView addSubview:_addDevideLB];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_needScoreLB];
    [self.contentView addSubview:_scoreLB];
    [self.contentView addSubview:_line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateFrames];
}

- (void)updateFrames {
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.top.bottom.equalTo(self.contentView);
    }];
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(_backView);
        make.width.equalTo(_iconImageV.mas_height);
    }];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView).with.offset(-10);
        make.top.equalTo(_iconImageV).with.offset(AdaptatSize(23));
        make.height.mas_equalTo(AdaptatSize(30));
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageV.mas_right).with.offset(10);
        make.top.equalTo(_iconImageV).with.offset(AdaptatSize(15));
        make.right.equalTo(_selectBtn.mas_left).with.offset(-5);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.right.equalTo(_backView);
        make.top.equalTo(_selectBtn.mas_bottom).with.offset(AdaptatSize(15));
        make.height.mas_equalTo(1);
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_selectBtn);
        make.top.equalTo(_line).with.offset(AdaptatSize(7));
        make.size.mas_equalTo((CGSize){20, 30});
    }];
    [_addDevideLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_addBtn.mas_left).with.offset(-7);
        make.centerY.equalTo(_addBtn);
        make.size.mas_equalTo((CGSize){AdaptatSize(45), AdaptatSize(27)});
    }];
    [_devideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_addDevideLB.mas_left).with.offset(-7);
        make.centerY.equalTo(_addBtn);
        make.size.equalTo(_addBtn);
    }];
    [_needScoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line);
        make.centerY.equalTo(_addBtn);
    }];
    [_scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_needScoreLB.mas_right).with.offset(2);
        make.centerY.equalTo(_addBtn);
    }];
}

- (UIImageView *)createImageV {
    UIImageView *v = [[UIImageView alloc] init];
    v.contentMode = UIViewContentModeScaleAspectFit;
    return v;
}

- (UIButton *)createButtonImgNormal:(NSString *)normal select:(NSString *)select hilight:(NSString *)hilight {
    UIButton *b = [[UIButton alloc] init];
    [b setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [b setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
    [b setImage:[UIImage imageNamed:hilight] forState:UIControlStateHighlighted];
    return b;
}

- (UILabel *)createLabel:(CGFloat)font color:(UIColor *)color {
    UILabel *lb = [[UILabel alloc] init];
    lb.font = AdapFont([APP_CONFIG appFontOfSize:font]);
    lb.textColor = color;
    [lb sizeToFit];
    return lb;
}

@end
