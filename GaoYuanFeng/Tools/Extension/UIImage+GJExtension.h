//
//  UIImage+GJExtension.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/2.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GJExtension)

#pragma mark 图片质量和对象转换处理

/*!
 *  @brief  把UIImage转换成NSData(默认显示大小：500KB，压缩质量比：0.5)
 *
 *  @param originImage        原始图片
 *
 *  @return NSData
 */
+ (NSData *)imageObjectToData:(UIImage *)originImage;

@end
