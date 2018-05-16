//  CustomClipImageViewController.h
//  LoveHome
//
//  Created by MRH-MAC on 14/12/4.
//  Copyright (c) 2014年 卡莱博尔. All rights reserved.
//


#import <UIKit/UIKit.h>




@class CustomClipImageViewController;

@protocol CustomClipImageViewControllerDelegate <NSObject>

/*!
 *  @brief  取消选择
 *
 *  @param controller 当前控制器
 */
- (void)imageCropViewControllerDidCancelCrop:(CustomClipImageViewController *)controller;


/*!
 *  @brief  确定选择
 *
 *  @param controller   当前控制器
 *  @param croppedImage 获取到得图片
 */
- (void)imageCropViewController:(CustomClipImageViewController *)controller didCropImage:(UIImage *)croppedImage;



@end

@interface CustomClipImageViewController : UIViewController

@property (assign,nonatomic) BOOL fromTakePhoto;
/*!
 *  @brief  编辑的图片
 */
@property (strong, nonatomic) UIImage *originalImage;

/*!
 *  @brief  点击实现代理
 */
@property (weak, nonatomic) id<CustomClipImageViewControllerDelegate> delegate;


- (instancetype)initWithImage:(UIImage *)originalImage;



/*!
 *  @brief  设置图片剪裁控制界面
 *
 *  @param originalImage 被剪裁的图片
 *  @param heightScale   图片剪裁的比例1:heightScale:0~1
 *
 *  
 */
- (instancetype)initWithImage:(UIImage *)originalImage andScale:(CGFloat )heightScale;


@end
