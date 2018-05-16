//
//  GJSystemHelper.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSystemHelper.h"

#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "GJImageLibraryController.h"
@interface GJSystemHelper ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong) GJImageLibraryController *imagePickerController;
@property (copy, nonatomic) void(^takePhoneImage)(UIImage *image);
@property (copy, nonatomic) void(^takePhoneError)(void);

@end

@implementation GJSystemHelper

+ (GJSystemHelper *)system {
    GJSystemHelper *helper = [[GJSystemHelper alloc] init];
    return helper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        [self performSelectorInBackground:@selector(initImagePicker) withObject:nil];
    }
    return self;
}

- (void)initImagePicker {
    //    self.imagePickerController = [[UIImagePickerController alloc] init];
    //    self.imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //    self.imagePickerController.delegate = self;
    //    self.imagePickerController.allowsEditing = YES;
    
}

- (void)vistiSystemTakePhoto:(void(^)(UIImage *image))successful failure:(void(^)(void))failure presentController:(UIViewController *)presentController {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机\n设置>隐私>相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
            return ;
        }else {
            _takePhoneImage = successful;
            __weak typeof (self) weakSelf = self;
            
//            UIImagePickerController *picker=[[UIImagePickerController alloc] init];
//            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
//            picker.allowsEditing=YES;
//            UIViewController *vc1 = [UIApplication sharedApplication].keyWindow.rootViewController;
//            [vc1 presentViewController:picker animated:YES completion:nil];
//            [[picker rac_imageSelectedSignal] subscribeNext:^(NSDictionary * _Nullable x) {
//                NSLog(@"");
//            }];
//            [[picker rac_imageSelectedSignal]
//            return;
            self.imagePickerController  = [[GJImageLibraryController alloc] initWithPickerType:UIImagePickerControllerSourceTypeCamera andScale:1];
            self.imagePickerController.imageBlock = ^(UIImage *image) {
                BLOCK_SAFE(weakSelf.takePhoneImage)(image);
            };
//            UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
            [presentController presentViewController:self.imagePickerController  animated:YES completion:nil];
        }
        
    }else {
        failure();
    }
}


- (void)vistiSystemAlbum:(void(^)(UIImage *image))successful failure:(void(^)(void))failure presentController:(UIViewController *)presentController {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相册\n设置>隐私>照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
        }else {
            self.imagePickerController = [[GJImageLibraryController alloc] initWithPickerType:UIImagePickerControllerSourceTypePhotoLibrary andScale:1];
            __weak typeof (self) weakSelf = self;
            self.imagePickerController.imageBlock = ^(UIImage *image) {
                BLOCK_SAFE(weakSelf.takePhoneImage)(image);
            };
            [presentController presentViewController: self.imagePickerController  animated:YES completion:nil];
            _takePhoneImage = successful;
        }
    }else {
        failure();
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    _takePhoneImage(img);
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)scanImageQRCodeWithImage:(UIImage *)image handel:(void(^)(NSString *qr,NSError *error))handel {
    //初始化  将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(image)]];
    if (features.count >= 1) {
        CIQRCodeFeature *feature = features[0];
        NSString *scannedResult = feature.messageString;
        BLOCK_SAFE(handel)(scannedResult,nil);
    }else{
        BLOCK_SAFE(handel)(nil,[NSError new]);
    }
}


- (void)openLightNeed:(BOOL)open {
    if (!_device.hasTorch) {
        return;
    }
    [_device lockForConfiguration:nil];
    
    [self.device setTorchMode:open ? AVCaptureTorchModeOn : AVCaptureTorchModeOff];
    [self.device unlockForConfiguration];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

