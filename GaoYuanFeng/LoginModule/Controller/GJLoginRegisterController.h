//
//  GJLoginRegisterController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseViewController.h"

typedef void(^LoginSuccessBlcok)(void);
typedef void(^LogoutSuccessBlcok)(void);

@interface GJLoginRegisterController : GJBaseViewController

/**
 需要登录的地方使用此方法检测 并弹出登录界面 业务逻辑在sucess 处理
 */
+ (BOOL)needLoginPresentWithVC:(UIViewController *)controller loginSucessBlcok:(LoginSuccessBlcok)success;

+ (void)logOutPresentLoginControllerByVC:(UIViewController *)controller loginSucessBlcok:(LogoutSuccessBlcok)success;

@end
