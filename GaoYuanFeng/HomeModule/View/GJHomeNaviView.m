//
//  GJHomeNaviView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJHomeNaviView.h"

@interface GJHomeNaviView ()
@property (nonatomic, strong) UIButton *nearbyShop;
//@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *btnImage;
@end

@implementation GJHomeNaviView

+ (GJHomeNaviView *)install {
    GJHomeNaviView *navBar = [[GJHomeNaviView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, NavBar_H)];
    return navBar;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    _backgroundView = [[UIView alloc] init];
    [self addSubview:_backgroundView];
    
    _nearbyShop = [[UIButton alloc] init];
    _nearbyShop.adjustsImageWhenHighlighted = NO;
    [_nearbyShop setTitleColor:APP_CONFIG.blackTextColor forState:UIControlStateNormal];
    [_nearbyShop setTitle:@"附近好店" forState:UIControlStateNormal];
    _nearbyShop.titleLabel.font = AdapFont([APP_CONFIG appBoldFontOfSize:17]);
    [_nearbyShop addTarget:self action:@selector(clickNearbyShop) forControlEvents:UIControlEventTouchUpInside];
    _btnImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_arrow"]];
    _btnImage.userInteractionEnabled = NO;
    
    _messageItem = [[GJMessageItem alloc] initImageName:@"home_messages" title:nil];
    _messageItem.messageBtn.titleLabel.font = [APP_CONFIG appFontOfSize:15];
    _messageItem.buttonType = ButtonContentTypeLeftRight;
    _messageItem.userInteractionEnabled = YES;
    [_messageItem.messageBtn addTarget:self action:@selector(clickMessage) forControlEvents:UIControlEventTouchUpInside];
    
    _userItem = [[GJMessageItem alloc] initImageName:@"home_user_profile" title:nil];
    _messageItem.buttonType = ButtonContentTypeLeftRight;
    _userItem.userInteractionEnabled = YES;
    [_userItem.messageBtn addTarget:self action:@selector(clickUser) forControlEvents:UIControlEventTouchUpInside];
    
//    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _searchBtn.adjustsImageWhenHighlighted = NO;
//    [_searchBtn setImage:[[UIImage imageNamed:@"seach"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    _searchBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:13]);
//    [_searchBtn addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_nearbyShop];
    [self addSubview:_btnImage];
    [self addSubview:_messageItem];
    [self addSubview:_userItem];
//    [self addSubview:_searchBtn];
}

- (void)clickNearbyShop {
    
}

- (void)clickMessage {
    BLOCK_SAFE(_goMessage)();
}

- (void)clickUser {
    BLOCK_SAFE(_goUser)();
}

- (void)clickSearch {
    BLOCK_SAFE(_goSearch)();
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _backgroundView.frame = self.bounds;
    
    _btnImage.size = (CGSize){15,7};
    _btnImage.centerX = self.centerX;
    _btnImage.y = self.height-10;
    
    _nearbyShop.size = (CGSize){85,40};
    _nearbyShop.centerX = _btnImage.centerX;
    _nearbyShop.y =  _btnImage.y-_nearbyShop.height+5;
    
    _userItem.size = (CGSize){50,40};
    _userItem.centerY = _nearbyShop.centerY;
    _userItem.x = 5;
    
//    _searchBtn.size = (CGSize){50,40};
//    _searchBtn.centerX = _messageItem.x-30;
//    _searchBtn.centerY = _nearbyShop.centerY;

    _messageItem.size = (CGSize){50,40};
    _messageItem.centerY = _nearbyShop.centerY;
    _messageItem.x = self.width - _messageItem.width - 5;
}

@end
