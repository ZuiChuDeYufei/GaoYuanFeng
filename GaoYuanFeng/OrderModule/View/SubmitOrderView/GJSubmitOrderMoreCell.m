//
//  GJSubmitOrderMoreCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/27.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSubmitOrderMoreCell.h"

@interface GJSubmitOrderMoreCell ()
@property (nonatomic, strong) UILabel *moreLB;
@end

@implementation GJSubmitOrderMoreCell

- (void)setMoreStatus:(BOOL)moreStatus {
    if (moreStatus) {
        _moreLB.text = @"收起";
    }else {
        _moreLB.text = @"更多";
    }
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _moreLB = [[UILabel alloc] init];
    _moreLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _moreLB.text = @"更多";
    _moreLB.textColor = [UIColor grayColor];
    [_moreLB sizeToFit];
    [self.contentView addSubview:_moreLB];
    [_moreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

@end
