//
//  GJSubmitOrderBottomCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSubmitOrderBottomCell.h"

@interface GJSubmitOrderBottomCell ()
@property (nonatomic, strong) UILabel *leftLB;
@property (nonatomic, strong) UILabel *starLB;
@property (nonatomic, strong) UITextField *rightTF;
@property (nonatomic, assign) BOOL isSelecting;
@end

@implementation GJSubmitOrderBottomCell

- (void)setModel:(GJSubmitOrderAdressData *)model {
    _model = model;
    _leftLB.text = model.leftText;
    _rightTF.placeholder = model.rightText;
}

- (void)canEdit:(BOOL)can {
    [_rightTF setEnabled:can];
}

-(void)setTitleBlack:(NSString *)text {
    _rightTF.text = text;
}

- (NSString *)cellText {
    return _rightTF.text;
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showBottomLine];
    
    _leftLB = [[UILabel alloc] init];
    _leftLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _leftLB.textColor = [UIColor grayColor];
    [_leftLB sizeToFit];
    
    _starLB = [[UILabel alloc] init];
    _starLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _starLB.textColor = [UIColor colorWithRGB:253 g:43 b:0];
    _starLB.text = @"*";
    [_starLB sizeToFit];
    
    _rightTF = [[UITextField alloc] init];
    _rightTF.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _rightTF.textColor = [UIColor blackColor];
    _rightTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.contentView addSubview:_leftLB];
    [self.contentView addSubview:_starLB];
    [self.contentView addSubview:_rightTF];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    [_starLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLB.mas_right).with.offset(5);
        make.centerY.equalTo(_leftLB);
    }];
    [_rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).with.offset(-AdaptatSize(70));
        make.centerY.equalTo(_leftLB);
        make.right.equalTo(self.contentView).with.offset(-15);
    }];
}

@end
