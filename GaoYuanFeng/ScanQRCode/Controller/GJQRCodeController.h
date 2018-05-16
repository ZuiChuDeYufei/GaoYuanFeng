//
//  GJQRCodeController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCustomPresentController.h"
#import "GJTypeFile.h"

@interface GJQRCodeController : GJCustomPresentController
@property (nonatomic, copy) void (^blockQRCodeScanResultURL) (NSString *resultURL);
//@property (assign,nonatomic) ScanCenterType scantype;
@property (strong,nonatomic) NSDictionary *parameter;
@end
