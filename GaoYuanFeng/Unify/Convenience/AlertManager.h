//
//  AlertManager.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertManager : NSObject

+(void)showAlertTitle:(NSString *)title content:(NSString *)content viecontroller:(UIViewController *)vc cancel:(NSString *)cancelTitle cancelHandle:(void (^)(void))cancelBlock;

+(void)showAlertTitle:(NSString *)title content:(NSString *)content viecontroller:(UIViewController *)vc cancel:(NSString *)cancelTitle sure:(NSString *)sureTitle  cancelHandle:(void (^)(void))cancelBlock sureHandle:(void (^)(void))sureBlock;

// 弹出图片选择
+ (void)showAcctionSheetMessage:(NSString *)message chooseTakePhoto:(void(^)(void))takePhototBlock album:(void(^)(void))albumBlock;


/**
 弹出通用的ActionSheet

 @param message 内容
 @param firstTitle 第一行文字
 @param secondTitle 第二行文字
 @param chooseFirstBlock 第一行回调
 @param chooseSecondBlock 第二行回调
 */
+ (void)showActionSheetMessage:(NSString *)message firstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle chooseFirst:(void(^)(void))chooseFirstBlock chooseSecond:(void(^)(void))chooseSecondBlock;
@end
