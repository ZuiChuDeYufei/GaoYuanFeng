//
//  GJSubmitOrderPickerView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/27.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseView.h"

@interface GJSubmitOrderPickerView : GJBaseView
@property (nonatomic, strong) NSArray *adressArr;
@property (nonatomic, copy) void (^selectRow)(NSInteger row);
@property (nonatomic, copy) void (^dismissSelf)(void);
@end
