//
//  GJMessageItem.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMessageItem.h"

@interface GJMessageItem ()
@property (nonatomic,strong) NSString *imageName;
@end

@implementation GJMessageItem

- (id)initImageName:(NSString *)imageName title:(NSString *)title {
    self = [super init];
    if (self) {
        _imageName = imageName;
        _title = title;
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews {
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _messageBtn.adjustsImageWhenHighlighted = NO;
    [_messageBtn setImage:[UIImage imageNamed:_imageName] forState:UIControlStateNormal];
    
    [_messageBtn setTitle:_title forState:UIControlStateNormal];
    [_messageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _messageBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    _messageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _messageBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self addSubview:_messageBtn];
    _messageBtn.titleLabel.font  = [UIFont boldSystemFontOfSize:10];
    UILabel *lable = [[UILabel alloc] init];
    lable.backgroundColor = [UIColor redColor];
    lable.layer.cornerRadius = 2;
    lable.clipsToBounds = YES;
    self.tipsLabel = lable;
    // self.tipsLable.text = @"5";
    self.tipsLabel.hidden = YES;
    [self addSubview:self.tipsLabel];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [_messageBtn setTitle:_title forState:UIControlStateNormal];
    [_messageBtn layoutIfNeeded];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //CGFloat offset = 8.0f;
    _messageBtn.frame = self.bounds;
    [_messageBtn layoutIfNeeded];
    if (_buttonType == ButtonContentTypeLeftRight) {
        
        CGSize titleSize = _messageBtn.titleLabel.bounds.size;
        CGSize imageSize = _messageBtn.imageView.bounds.size;
        CGFloat interval = 3.f;
        _messageBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        _messageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
    }
    
//    }else {
//        _messageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_messageBtn.imageView.frame.size.width , -_messageBtn.imageView.frame.size.height-offset/2, 0);
//        _messageBtn.imageEdgeInsets = UIEdgeInsetsMake(-_messageBtn.titleLabel.intrinsicContentSize.height-offset/2, 0, 0, -_messageBtn.titleLabel.intrinsicContentSize.width);
//    }
    
    self.tipsLabel.frame = CGRectMake(CGRectGetMaxX(self.bounds) - 10, 8, 4, 4);
}

@end
