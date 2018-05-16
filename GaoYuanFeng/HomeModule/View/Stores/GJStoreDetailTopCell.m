//
//  GJStoreDetailTopCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJStoreDetailTopCell.h"
#import "GJHomeSearchPointData.h"

@interface GJStoreDetailTopCell ()
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UIImageView *coverImageV;
@property (nonatomic, strong) UILabel *perPersonPriceLB;
@property (nonatomic, strong) UIButton *storeTelePhone;
@end

@implementation GJStoreDetailTopCell

- (void)closePageBtnClick {
    BLOCK_SAFE(_backBlock)();
}

- (CGFloat)height {
    if (SCREEN_H >= kGJIphoneX) {
        return AdaptatSize(380);
    }else {
        return AdaptatSize(325);
    }
}

- (void)setPointData:(GJHomeSearchPointData *)pointData {
    _pointData = pointData;
    _titleLB.text = pointData.supplier_name;
    _detailLB.text = [NSString stringWithFormat:@"%@ | %@", pointData.typeName, pointData.shop_hours];
    [_coverImageV sd_setImageWithURL:[NSURL URLWithString:pointData.logo]];
    
//    [self addSubViewMarks:pointData.tagArr];
    
    NSString *price = JudgeContainerCountIsNull(pointData.price)?@"0.00":pointData.price;
    NSString *str = [NSString stringWithFormat:@"%@ 元/人均", price];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muStr addAttribute:NSForegroundColorAttributeName value:APP_CONFIG.grayTextColor range:[str rangeOfString:@"元/人均"]];
    [muStr addAttribute:NSFontAttributeName value:AdapFont([APP_CONFIG appBoldFontOfSize:15]) range:[str rangeOfString:@"元/人均"]];
    [muStr addAttribute:NSFontAttributeName value:AdapFont([APP_CONFIG appBahnschriftSemiBoldFontOfSize:25]) range:[str rangeOfString:price]];
    _perPersonPriceLB.attributedText = muStr;
    [_storeTelePhone setTitle:pointData.tel forState:UIControlStateNormal];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)storeTelePhoneClick {
    if (JudgeContainerCountIsNull(_pointData.tel)) {
        return;
    }
    callAPhone(_pointData.tel);
}

- (void)addSubviews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _closePageBtn = [[UIButton alloc] init];
    [_closePageBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closePageBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateHighlighted];
    [_closePageBtn addTarget:self action:@selector(closePageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.textColor = APP_CONFIG.blackTextColor;
    _titleLB.font = AdapFont([APP_CONFIG appBoldFontOfSize:17]);
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.textColor = APP_CONFIG.grayTextColor;
    _detailLB.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    [_detailLB sizeToFit];
    
    _coverImageV = [[UIImageView alloc] init];
    _coverImageV.contentMode = UIViewContentModeScaleAspectFit;
    
    _perPersonPriceLB = [[UILabel alloc] init];
    _perPersonPriceLB.textColor = APP_CONFIG.appMainRedColor;
    _perPersonPriceLB.font = AdapFont([APP_CONFIG appFontOfSize:25]);
    [_perPersonPriceLB sizeToFit];
    
    _storeTelePhone = [[UIButton alloc] init];
    _storeTelePhone.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    _storeTelePhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_storeTelePhone setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_storeTelePhone addTarget:self action:@selector(storeTelePhoneClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_closePageBtn];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_detailLB];
    [self.contentView addSubview:_coverImageV];
    [self.contentView addSubview:_perPersonPriceLB];
    [self.contentView addSubview:_storeTelePhone];
    
    [self updateFrames];
}

- (void)updateFrames {
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.top.equalTo(self.contentView).with.offset(15);
        make.width.mas_equalTo(SCREEN_W-AdaptatSize(90));
    }];
    [_closePageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-15);
        make.top.equalTo(self.contentView).with.offset(15);
        make.size.mas_equalTo((CGSize){40, 40});
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(5);
    }];
    [_perPersonPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.bottom.equalTo(self.contentView).with.offset(-13);
    }];
    [_coverImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB);
        make.right.equalTo(self.contentView).with.offset(-15);
        make.top.equalTo(_detailLB.mas_bottom).with.offset(15);
        make.bottom.equalTo(_perPersonPriceLB.mas_top).with.offset(-AdaptatSize(20));
    }];
    [_storeTelePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_perPersonPriceLB);
        make.right.equalTo(self.contentView).with.offset(-AdaptatSize(15));
        make.size.mas_equalTo((CGSize){AdaptatSize(100), 30});
    }];
}

- (void)addSubViewMarks:(NSArray *)array {
    if (array.count == 0) return;
    NSMutableArray <UILabel *> *lbArr = @[].mutableCopy;
    
    for (int i = 0; i < array.count; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = AdapFont([APP_CONFIG appFontOfSize:10]);
        label.textColor = APP_CONFIG.grayTextColor;
        label.layer.borderWidth = 1;
        label.layer.borderColor = label.textColor.CGColor;
        label.text = [NSString stringWithFormat:@" %@ ", array[i]];
        [label sizeToFit];
        [self.contentView addSubview:label];
        [lbArr addObject:label];
    }
    
    NSUInteger c = lbArr.count - 1;
    UILabel *label = lbArr[c];
    for (NSUInteger i = c; i <= c; i --) {
        [lbArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_perPersonPriceLB).with.offset(3);
            if (i == c) {
                make.right.equalTo(self.contentView).with.offset(-15);
            }else {
                make.right.equalTo(label.mas_left).with.offset(-5);
            }
        }];
        label = lbArr[i];
    }
}

@end
