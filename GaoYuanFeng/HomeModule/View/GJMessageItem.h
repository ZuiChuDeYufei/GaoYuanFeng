//
//  GJMessageItem.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

typedef enum : NSUInteger {
    ButtonContentTypeTopBottom,
    ButtonContentTypeLeftRight
}ButtonContentType;

@interface GJMessageItem : GJBaseView
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, assign) ButtonContentType buttonType;
- (id)initImageName:(NSString *)imageName title:(NSString *)title;

@end
