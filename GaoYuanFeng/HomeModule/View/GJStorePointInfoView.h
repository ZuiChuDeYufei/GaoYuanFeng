//
//  GJStorePointInfoView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJStorePointInfoView : GJBaseView
@property (nonatomic, strong) NSString *phone;
- (void)hiddenSelf:(BOOL)hidden;
+ (GJStorePointInfoView *)install;
@end
