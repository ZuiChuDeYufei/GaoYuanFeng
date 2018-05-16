//
//  GJStoreSDetailBottomCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJStoreSDetailBottomCell.h"
#import "GJHomeSearchPointData.h"

@interface GJStoreSDetailBottomCell ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) UILabel *acvitityBottomLB;
@property (nonatomic, strong) UILabel *storeAdress;
@property (nonatomic, strong) UILabel *storeAdressLB;
@property (nonatomic, strong) UIButton *naviRouteBtn;
@property (nonatomic, strong) UIImageView *naviRouteImg;
@end

@implementation GJStoreSDetailBottomCell

- (CGFloat)height {
    if (SCREEN_H >= kGJIphoneX) {
        return SCREEN_H-120-AdaptatSize(380);
    }else {
        return SCREEN_H-120-AdaptatSize(325);
    }
}

- (void)bottomBtnClick {
    BLOCK_SAFE(_scanBtnBlock)();
}

- (void)naviRouteBtnClick {
    BLOCK_SAFE(_naviRouteBlock)();
}

- (void)setPointData:(GJHomeSearchPointData *)pointData {
    _acvitityBottomLB.text = [NSString stringWithFormat:@"买多少送多少！人获礼"];
    _storeAdress.text = pointData.address;
    _storeAdressLB.text = @"商家地址";
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubview];
    }
    return self;
}

- (void)setupSubview {
    self.backgroundColor = [UIColor colorWithRGB:250 g:250 b:250];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    _bottomBtn = [[UIButton alloc] init];
    _bottomBtn.backgroundColor = [UIColor colorWithRGB:52 g:60 b:75];
    _bottomBtn.layer.cornerRadius = AdaptatSize(40)/2;
    _bottomBtn.clipsToBounds = YES;
    _bottomBtn.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:16]);
    [_bottomBtn setTitle:@"买一送一" forState:UIControlStateNormal];
    [_bottomBtn setImage:[UIImage imageNamed:@"sacn"] forState:UIControlStateNormal];
    [_bottomBtn setImage:[UIImage imageNamed:@"sacn"] forState:UIControlStateHighlighted];
    [_bottomBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
    [_bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _acvitityBottomLB = [[UILabel alloc] init];
    _acvitityBottomLB.textColor = APP_CONFIG.grayTextColor;
    _acvitityBottomLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    [_acvitityBottomLB sizeToFit];
    
    _storeAdress = [[UILabel alloc] init];
    _storeAdress.textColor = APP_CONFIG.grayTextColor;
    _storeAdress.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    
    _storeAdressLB = [[UILabel alloc] init];
    _storeAdressLB.textColor = APP_CONFIG.blackTextColor;
    _storeAdressLB.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    [_storeAdressLB sizeToFit];
    
    _naviRouteBtn = [[UIButton alloc] init];
    _naviRouteBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:14]);
    [_naviRouteBtn setTitle:@"导航" forState:UIControlStateNormal];
    [_naviRouteBtn setTitleColor:[UIColor colorWithRGB:255 g:40 b:0] forState:UIControlStateNormal];
    [_naviRouteBtn addTarget:self action:@selector(naviRouteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_naviRouteBtn sizeToFit];
    _naviRouteBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    _naviRouteImg = [[UIImageView alloc] init];
    _naviRouteImg.contentMode = UIViewContentModeScaleAspectFit;
    _naviRouteImg.image = [UIImage imageNamed:@"guide11"];
    
    [self.contentView addSubview:_bottomView];
    [self.contentView addSubview:_bottomBtn];
    [self.contentView addSubview:_acvitityBottomLB];
    [self.contentView addSubview:_storeAdress];
    [self.contentView addSubview:_storeAdressLB];
    [self.contentView addSubview:_naviRouteBtn];
    [self.contentView addSubview:_naviRouteImg];
    
    [self updateFrames];
}

- (void)updateFrames {
    CGFloat dis, btmH;
    if (SCREEN_H >= kGJIphoneX) {
        btmH = AdaptatSize(200);
        dis = AdaptatSize(30);
    }else {
        btmH = AdaptatSize(130);
        dis = AdaptatSize(20);
    }
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(btmH);
    }];
    [_storeAdressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.top.equalTo(self.contentView).with.offset(dis);
    }];
    [_storeAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_storeAdressLB);
        make.bottom.equalTo(_bottomView.mas_top).with.offset(-dis);
    }];
    [_naviRouteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10);
        make.top.equalTo(_storeAdressLB);
        make.width.mas_equalTo(AdaptatSize(50));
        make.bottom.equalTo(_storeAdress).with.offset(AdaptatSize(5));
    }];
    [_naviRouteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_naviRouteBtn);
        make.centerX.equalTo(_naviRouteBtn);
        make.size.mas_equalTo((CGSize){AdaptatSize(25), AdaptatSize(25)});
    }];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView).with.offset(-20);
        make.left.equalTo(_bottomView).with.offset(AdaptatSize(40));
        make.right.equalTo(_bottomView).with.offset(-AdaptatSize(40));
        make.height.mas_equalTo(AdaptatSize(40));
    }];
    [_acvitityBottomLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomBtn);
        make.top.equalTo(_bottomBtn.mas_bottom).with.offset(10);
    }];
}

@end
