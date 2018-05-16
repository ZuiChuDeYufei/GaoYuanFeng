//
//  GJLoginView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"
#import "GJVerifyButton.h"

@protocol GJLoginViewDelegate <NSObject>
@optional
- (void)submitBtnClick;
- (void)getVerifyCodeBtnClick;
@end

@interface GJLoginView : GJBaseView
@property (nonatomic, weak) id <GJLoginViewDelegate> myDelegate;
@property (nonatomic, strong) UITextField *phoneNumTF;
@property (nonatomic, strong) UITextField *verifyCodeTF;
@property (nonatomic, strong) GJVerifyButton *getVerifyCodeBtn;
- (void)resignKeyboard;
@end
