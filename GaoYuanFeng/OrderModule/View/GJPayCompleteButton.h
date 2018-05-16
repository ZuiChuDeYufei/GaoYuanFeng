//
//  GJPayCompleteButton.h
//  GaoYuanFeng
//
//  Created by Arlenly on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJPayCompleteButton : GJBaseView
+ (GJPayCompleteButton *)installTitle:(NSString *)title;
@property (nonatomic, copy) void (^buttonClick)(void);
@end
