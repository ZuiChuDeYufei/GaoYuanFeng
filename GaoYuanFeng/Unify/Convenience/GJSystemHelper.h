//
//  GJSystemHelper.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVCaptureDevice.h>
@interface GJSystemHelper : NSObject

/**
 摄像设备
 */
@property (nonatomic, strong) AVCaptureDevice *device;
+(GJSystemHelper *)system;


/**
 访问系统相机并检测相册权限

 @param successful 选择图片成功
 @param failure 打开失败
 @param presentController 弹出Controller
 */
- (void)vistiSystemTakePhoto:(void(^)(UIImage *image))successful failure:(void(^)(void))failure presentController:(UIViewController *)presentController;



/**
 访问相册

 @param successful 成功
 @param failure 失败
 @param presentController 弹出Controller
 */
- (void)vistiSystemAlbum:(void(^)(UIImage *image))successful failure:(void(^)(void))failure presentController:(UIViewController *)presentController;



/**
 扫描识别图片二维码

 @param image 图片
 */
- (void)scanImageQRCodeWithImage:(UIImage *)image handel:(void(^)(NSString *qr,NSError *error))handel;


- (void)openLightNeed:(BOOL)open;

@end
