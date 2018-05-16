//
//  GJSubmitOrderTopCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/26.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSubmitOrderTopCell.h"

@interface GJSubmitOrderTopCell ()
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UIImageView *logoImage;
@end

@implementation GJSubmitOrderTopCell

-(void)setGiftData:(GJGiftListSelectDataList *)giftData {
    _giftData = giftData;
    _detailLB.text = [NSString stringWithFormat:@"数量：x%ld", (long)giftData.count];
    _titleLB.text = giftData.title;
    [_logoImage sd_setImageWithURL:[NSURL URLWithString:giftData.thumb]];
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showBottomLine];
    
    _logoImage = [[UIImageView alloc] init];
    _logoImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _titleLB.textColor = [UIColor blackColor];
    _titleLB.numberOfLines = 2;
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _detailLB.textColor = [UIColor grayColor];
    [_detailLB sizeToFit];
    
    [self.contentView addSubview:_logoImage];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_detailLB];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.contentView).with.offset(-15);
        make.top.equalTo(self.contentView).with.offset(15);
        make.width.equalTo(_logoImage.mas_height);
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(15);
        make.right.equalTo(_logoImage.mas_left).with.offset(-30);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLB.mas_bottom).with.offset(5);
        make.left.equalTo(_titleLB);
    }];
}

@end
