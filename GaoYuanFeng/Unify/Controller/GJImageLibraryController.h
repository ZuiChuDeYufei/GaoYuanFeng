//
//  GJImageLibraryController.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJImageLibraryController : UIImagePickerController

@property (nonatomic ,copy) void(^imageBlock)(UIImage *image);

- (id)initWithPickerType:(UIImagePickerControllerSourceType )sourceType andScale:(CGFloat )scale;

@end
