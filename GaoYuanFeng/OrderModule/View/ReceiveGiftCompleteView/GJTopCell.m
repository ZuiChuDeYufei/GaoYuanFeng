//
//  GJTopCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/27.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJTopCell.h"

@interface GJTopCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UILabel *scoreLB;
@property (nonatomic, strong) UILabel *score;
@property (nonatomic, strong) UIButton *contactBtn;
@end

@implementation GJTopCell

- (void)contactBtnCLick {
    
}

- (void)commonInit {
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor colorWithRGB:247 g:248 b:250];
    _backView2 = [[UIView alloc] init];
    _backView2.backgroundColor = APP_CONFIG.whiteGrayColor;
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = AdapFont([APP_CONFIG appBoldFontOfSize:19]);
    _titleLB.textColor = [UIColor blackColor];
    [_titleLB sizeToFit];
    _titleLB.text = @"提交成功";
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:12]);
    _detailLB.textColor = [UIColor colorWithRGB:81 g:186 b:249];
    [_detailLB sizeToFit];
    _detailLB.text = @"提交完成后注意查收短信";
    
    _scoreLB = [[UILabel alloc] init];
    _scoreLB.font = AdapFont([APP_CONFIG appFontOfSize:12]);
    _scoreLB.textColor = [UIColor blackColor];
    [_scoreLB sizeToFit];
    _scoreLB.text = @"本次使用积分";
    
    _score = [[UILabel alloc] init];
    _score.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:21]);
    _score.textColor = [UIColor colorWithRGB:255 g:44 b:0];
    [_score sizeToFit];
    _score.text = @"298";
    
    _contactBtn = [[UIButton alloc] init];
    _contactBtn.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:16]);
    [_contactBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_contactBtn setTitle:@"联系我们" forState:UIControlStateNormal];
    [_contactBtn setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
    [_contactBtn addTarget:self action:@selector(contactBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [_contactBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    
    [self.contentView addSubview:_backView];
    [self.contentView addSubview:_backView2];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_detailLB];
    [self.contentView addSubview:_scoreLB];
    [self.contentView addSubview:_score];
    [self.contentView addSubview:_contactBtn];
    [self showBottomLine];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_centerY).with.offset(5);
    }];
    [_backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_centerY).with.offset(5);
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).with.offset(25);
        make.top.equalTo(_backView).with.offset(12);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(3);
    }];
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_titleLB);
        make.right.equalTo(self.contentView).with.offset(-15);
    }];
    [_scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_score);
        make.right.equalTo(_score.mas_left).with.offset(-5);
    }];
    [_contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_backView2);
        make.size.mas_equalTo((CGSize){150, 40});
    }];
}

- (CGFloat)height {
    return AdaptatSize(130);
}

@end
