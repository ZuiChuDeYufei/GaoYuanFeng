//
//  GJTradeAreaTBVCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJTradeAreaTBVCell.h"

@interface GJTradeAreaTBVCell ()
@property (nonatomic, strong) UIImageView *logoImg;
@property (nonatomic, strong) UILabel *distanceLB;
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UILabel *markLB;
@end

@implementation GJTradeAreaTBVCell

- (void)setListData:(GJHomeSearchPointData *)listData {
    _listData = listData;
    [_logoImg sd_setImageWithURL:[NSURL URLWithString:_listData.logo]];
    _titleLB.text = _listData.supplier_name;
    
    // TODO
    NSString *str0 = [NSString stringWithFormat:@"人获礼/人均¥%@", _listData.price];
    NSString *str = [NSString stringWithFormat:@"%@%@", @"0", str0];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muStr addAttribute:NSFontAttributeName value:[APP_CONFIG appFontOfSize:12] range:[str rangeOfString:str0]];
    [muStr addAttribute:NSForegroundColorAttributeName value:APP_CONFIG.grayTextColor range:[str rangeOfString:str0]];
    _detailLB.attributedText = muStr;
    
    double dis = [_listData.distance doubleValue];
    NSString *disStr = dis < 1000 ? [NSString stringWithFormat:@"%ld m", (long)dis] : [NSString stringWithFormat:@"%.1f km", dis/1000];
    _distanceLB.text = disStr;
    _timeLB.text = [NSString stringWithFormat:@" %@ ", _listData.shop_hours];
    _markLB.text = [NSString stringWithFormat:@" %@ ", _listData.typeName];
}

+ (CGFloat)height {
    return AdaptatSize(90);
}

- (void)commonInit {
    [super commonInit];
    [self settingShowSpeatLine:YES];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _logoImg = [[UIImageView alloc] init];
    _logoImg.contentMode = UIViewContentModeScaleToFill;
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.textColor = APP_CONFIG.blackTextColor;
    _titleLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.textColor = APP_CONFIG.appMainColor;
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    [_detailLB sizeToFit];
    
    _distanceLB = [[UILabel alloc] init];
    _distanceLB.textColor = [UIColor colorWithRGB:254 g:74 b:0];
    _distanceLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    [_distanceLB sizeToFit];
    
    _timeLB = [[UILabel alloc] init];
    _timeLB.textColor = [UIColor grayColor];
    _timeLB.font = AdapFont([APP_CONFIG appFontOfSize:12]);
    _timeLB.layer.cornerRadius  =3;
    _timeLB.clipsToBounds = YES;
    _timeLB.layer.borderWidth = 1;
    _timeLB.layer.borderColor = _timeLB.textColor.CGColor;
    [_timeLB sizeToFit];
    
    _markLB = [[UILabel alloc] init];
    _markLB.textColor = [UIColor whiteColor];
    _markLB.font = AdapFont([APP_CONFIG appFontOfSize:12]);
    _markLB.layer.backgroundColor = [UIColor colorWithRGB:254 g:74 b:0].CGColor;
    [_markLB sizeToFit];
    
    [self.contentView addSubview:_logoImg];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_detailLB];
    [self.contentView addSubview:_distanceLB];
    [self.contentView addSubview:_timeLB];
    [self.contentView addSubview:_markLB];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(5);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo((CGSize){AdaptatSize(80), AdaptatSize(80)});
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SCREEN_H >= kGJIphoneX) {
            make.left.equalTo(self.contentView.mas_centerX).with.offset(AdaptatSize(37));
        }else {
            make.left.equalTo(self.contentView.mas_centerX).with.offset(AdaptatSize(30));
        }
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView).with.offset(-5);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(5);
    }];
    [_markLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLB);
        make.centerY.equalTo(_logoImg);
    }];
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logoImg.mas_right).with.offset(15);
        make.top.equalTo(_markLB.mas_bottom).with.offset(4);
    }];
    [_distanceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLB);
        make.bottom.equalTo(_markLB.mas_top).with.offset(-4);
    }];
}

@end
