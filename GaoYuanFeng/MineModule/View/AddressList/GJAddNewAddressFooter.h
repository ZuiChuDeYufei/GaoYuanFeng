//
//  GJAddNewAddressFooter.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/10.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJAddNewAddressFooter : GJBaseView
@property (nonatomic, copy) void (^blockSwitchStatus)(BOOL status);
- (void)setDefaultBtnStatus:(BOOL)status;
@end
