//
//  GJAdressPickerController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/28.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCustomPresentController.h"
#import "GJTypeFile.h"

@interface GJAdressPickerController : GJCustomPresentController
@property (nonatomic, assign) RegionTypes regionType;
@property (nonatomic, strong) Province *currProvince;
@property (nonatomic, strong) City *currCity;
@property (nonatomic, copy) void (^selectRow)(NSInteger row);
- (void)presentSelf:(UIViewController *)context;
@end
