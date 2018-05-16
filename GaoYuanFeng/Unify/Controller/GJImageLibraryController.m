//
//  GJImageLibraryController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJImageLibraryController.h"
#import "CustomClipImageViewController.h"

@interface GJImageLibraryController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate ,CustomClipImageViewControllerDelegate>
@property (nonatomic, assign) UIImagePickerControllerSourceType pickerSourceType;
@property (nonatomic, assign) CGFloat heightScale;
@end

@implementation GJImageLibraryController

- (id)initWithPickerType:(UIImagePickerControllerSourceType )sourceType andScale:(CGFloat )scale;
{
    self = [super init];
    if (self) {
        self.pickerSourceType = sourceType;
        self.sourceType = sourceType;
        if (scale > 1 || scale == 0) {
            scale = 1;
        }
        _heightScale = scale;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate                     = self;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (!image)
    {
        return;
    }
    
    CustomClipImageViewController *controller = [[CustomClipImageViewController alloc] initWithImage:image andScale:_heightScale];
    controller.fromTakePhoto = self.sourceType == UIImagePickerControllerSourceTypeCamera ? YES : NO;
    controller.delegate = self;
    [picker pushViewController:controller animated:YES];
}

- (void)imageCropViewControllerDidCancelCrop:(CustomClipImageViewController *)controller
{
    if (self.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [controller.navigationController popViewControllerAnimated:YES];
    
}

- (void)imageCropViewController:(CustomClipImageViewController *)controller didCropImage:(UIImage *)croppedImage
{
    if (croppedImage) {
        
        if (_imageBlock) {
            
            self.imageBlock(croppedImage);
        }
    }
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

