//
//  GJReceiveGiftBottomView.m
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJReceiveGiftBottomView.h"

@interface GJReceiveGiftBottomView ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *leftLB;
@property (nonatomic, strong) UILabel *scoreLB;
@end

@implementation GJReceiveGiftBottomView

+ (GJReceiveGiftBottomView *)install {
    GJReceiveGiftBottomView *btn = [[GJReceiveGiftBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_H-AdaptatSize(49), SCREEN_W, AdaptatSize(49))];
    return btn;
}

- (void)receiveBtnClick {
    BLOCK_SAFE(_receiveClick)();
}

- (void)setNumberOfSelect:(NSString *)numberOfSelect {
    _numberOfSelect = numberOfSelect;
    if ([_numberOfSelect integerValue] == 0) {
        [_button setTitle:@"领取" forState:UIControlStateNormal];
        return;
    }
    [_button setTitle:[NSString stringWithFormat:@"领取（%@）", numberOfSelect] forState:UIControlStateNormal];
}

- (void)setScore:(NSString *)score {
    _score = score;
    _scoreLB.text = score;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4.f;
    self.layer.shadowOffset = CGSizeMake(0,0);
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*2/3, 0, SCREEN_W/3, self.height)];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setTitle:@"领取" forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor colorWithRGB:255 g:38 b:0];
    [_button addTarget:self action:@selector(receiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
    _leftLB = [[UILabel alloc] init];
    _leftLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _leftLB.textColor = [UIColor grayColor];
    [_leftLB sizeToFit];
    _leftLB.text = @"可用积分";
    [self addSubview:_leftLB];
    [_leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.centerY.equalTo(_button);
    }];
    
    _scoreLB = [[UILabel alloc] init];
    _scoreLB.font = AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:22]);
    _scoreLB.textColor = APP_CONFIG.appMainRedColor;
    [_scoreLB sizeToFit];
    [self addSubview:_scoreLB];
    [_scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLB.mas_right).with.offset(5);
        make.centerY.equalTo(_button);
    }];
}

@end
