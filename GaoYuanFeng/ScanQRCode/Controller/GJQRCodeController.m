
//
//  GJQRCodeController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJQRCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "GJSystemHelper.h"

static int const lineTag = 234567;

static NSString * const lineColor = @"#FF5133";

@interface GJQRCodeController () <AVCaptureMetadataOutputObjectsDelegate, CAAnimationDelegate>
{
    CGFloat scaningEdgeDis;
    CGFloat scaningLeft;
}

@property (strong,nonatomic) AVCaptureDevice * device;
@property (strong,nonatomic) AVCaptureDeviceInput * input;
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
@property (strong,nonatomic) AVCaptureSession * session;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * preview;
@property (strong,nonatomic) GJSystemHelper *system;
@property (strong,nonatomic) UIButton *cameraBtn , *lighBtn;
@property (strong,nonatomic) UILabel *cameraLab , *lighLab;

@end

@implementation GJQRCodeController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_cameraLab sizeToFit];
    [_lighLab sizeToFit];
    [_lighBtn sizeToFit];
    [_cameraBtn sizeToFit];
    
    _cameraBtn.x = SCREEN_W/2 - 35 - _cameraBtn.width;
    _cameraBtn.y = self.view.height - AdaptatSize(56) - _cameraBtn.height;
    _lighBtn.center = _cameraBtn.center;
    _lighBtn.x = SCREEN_W/2 + 35;
    _lighLab.center = _lighBtn.center;
    _cameraLab.center = _cameraBtn.center;
    _cameraLab.y = _lighLab.y = _cameraBtn.maxY + 13;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [_system openLightNeed:NO];
    [self stopScaning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    if (_session) {
        [_session startRunning];
        [self scanAnimantionShow:YES];
    }
}

// Stop scan
- (void)stopScaning {
    [_session stopRunning];
    ShowProgressHUD(NO, self.view);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allowBack];
    self.title = @"扫一扫";
    scaningEdgeDis = SCREEN_W*5/7;
    scaningLeft = SCREEN_W/7;
    
    [self scaningEdgeUISettings];
    [[NSOperationQueue new] addOperationWithBlock:^{
        [self initQRCode];
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        // To do background task
        self.system = [GJSystemHelper system];
    });
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] > 0){
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        [self playScanSound];
        [self scanAnimantionShow:NO];
        
        //        [self dismissViewControllerAnimated:YES completion:nil];
        [self stopScaning];
        if (_blockQRCodeScanResultURL) {
            _blockQRCodeScanResultURL(stringValue);
        }
    }
}

- (void)initQRCode {
    @try {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        _output = [[AVCaptureMetadataOutput alloc] init];
        _session = [[AVCaptureSession alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        // Connect to input & output
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
        
        // Set bar-code types
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self qrCodeScan];
        }];
    } @catch (NSException *exception) {
    }
}

- (void)qrCodeScan {
    @try {
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        // Add scanning interface
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
        _preview.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-64);
        [self.view.layer addSublayer:_preview];
        
        // Regional scanning
        [self scaningEdgeUISettings];
        
        // Limit scaning region, contrary to the usual coordinate system, X&Y swap, W&H swap
        CGRect outputRect = CGRectMake((scaningLeft/2+128+30)/SCREEN_H, ((SCREEN_W-scaningEdgeDis)/2)/SCREEN_W, scaningEdgeDis/SCREEN_H, scaningEdgeDis/SCREEN_W);
        [_output setRectOfInterest:outputRect];
        
        // Start scan
        [_session startRunning];
        [self scanAnimantionShow:YES];
        
    } @catch (NSException *exception) {
    }
}

- (void)scaningEdgeUISettings {
    
    CGFloat shadowAlpha = 0.6f;
    UIView *topShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, scaningLeft+64+30)];
    topShadow.backgroundColor = [UIColor blackColor];
    topShadow.alpha = shadowAlpha;
    [self.view addSubview:topShadow];
    
    UIView *leftShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 64+30+scaningLeft, scaningLeft, scaningEdgeDis)];
    leftShadow.backgroundColor = [UIColor blackColor];
    leftShadow.alpha = shadowAlpha;
    [self.view addSubview:leftShadow];
    UIView *rightShadow = [[UIView alloc] initWithFrame:CGRectMake(scaningLeft+scaningEdgeDis, 64+30+scaningLeft, scaningLeft, scaningEdgeDis)];
    rightShadow.backgroundColor = [UIColor blackColor];
    rightShadow.alpha = shadowAlpha;
    [self.view addSubview:rightShadow];
    
    UIView *bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 64+30+scaningLeft+scaningEdgeDis, SCREEN_W, SCREEN_H-scaningEdgeDis-scaningLeft-64)];
    bottomShadow.backgroundColor = [UIColor blackColor];
    bottomShadow.alpha = shadowAlpha;
    [self.view addSubview:bottomShadow];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"";
    label2.textColor = APP_CONFIG.whiteGrayColor;
    label2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    label2.clipsToBounds = YES;
    label2.layer.cornerRadius = 20;
    label2.font = AdapFont([APP_CONFIG appFontOfSize:13]);
    label2.textAlignment = NSTextAlignmentCenter;
    [label2 sizeToFit];
    label2.hidden = YES;
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(label2.width + 18, 40));
        make.bottom.equalTo(topShadow).with.offset(-20);
        make.centerX.equalTo(self.view);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftShadow.mas_right);
        make.right.equalTo(rightShadow.mas_left);
        make.top.equalTo(topShadow.mas_bottom);
        make.bottom.equalTo(bottomShadow.mas_top);
    }];
    [self drawLineOnView:lineView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_biankuang"]];
    imageView.layer.borderColor = [UIColor colorWithHexRGB:lineColor].CGColor;
    imageView.layer.borderWidth = 0.5;
    imageView.frame = CGRectMake(scaningLeft, 64+30+scaningLeft, scaningEdgeDis, scaningEdgeDis);
    [self.view addSubview:imageView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(scaningLeft, CGRectGetMaxY(topShadow.frame), scaningEdgeDis, 2)];
    line.tag = lineTag;
    line.image = [UIImage imageNamed:@"QRCodeScaningLine"];
    line.contentMode = UIViewContentModeScaleAspectFill;
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
    
    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cameraBtn.adjustsImageWhenHighlighted = NO;
    [_cameraBtn setImage:[UIImage imageNamed:@"dakaixiangce"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(scanPhotoLib) forControlEvents:UIControlEventTouchUpInside];
    [_cameraBtn sizeToFit];
    
    _lighBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lighBtn.adjustsImageWhenHighlighted = NO;
    [_lighBtn setImage:[UIImage imageNamed:@"shoudiantong"] forState:UIControlStateNormal];
    [_lighBtn addTarget:self action:@selector(openLight:) forControlEvents:UIControlEventTouchUpInside];
    [_lighBtn sizeToFit];
    
    _cameraLab = [UILabel new];
    _lighLab = [UILabel new];
    _cameraLab.textColor = _lighLab.textColor = [UIColor whiteColor];
    _cameraLab.font = _lighLab.font = [APP_CONFIG appFontOfSize:12];
    _lighLab.text = @"打开手电筒";
    _cameraLab.text = @"打开相册";
    
    [self.view addSubview:_cameraBtn];
    [self.view addSubview:_lighBtn];
    [self.view addSubview:_lighLab];
    [self.view addSubview:_cameraLab];
    
}

- (void)openLight:(UIButton *)sender {
    BOOL switchLight =  _system.device.torchMode == AVCaptureTorchModeOff ? YES : NO;
    [_system openLightNeed:switchLight];
}

- (void)scanPhotoLib {
    [_system vistiSystemAlbum:^(UIImage *image) {
        ShowProgressHUD(YES, self.view);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
            // To do background task
            [_system scanImageQRCodeWithImage:image handel:^(NSString *qr, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    ShowProgressHUD(NO, self.view);
                    if (error) {
                        ShowWaringAlertHUD(@"图片中未识别到二维码", nil);
                    }else {
                        //                        [self dismissViewControllerAnimated:YES completion:nil];
                        [self stopScaning];
                        if (_blockQRCodeScanResultURL) {
                            _blockQRCodeScanResultURL(qr);
                        }
                    }
                });
                
            }];
        });
    } failure:^{
        ShowWaringAlertHUD(@"图片选取失败", nil);
    } presentController:self];
}

- (void)scanAnimantionShow:(BOOL)yesOrNo {
    UIView *line = [self.view viewWithTag:lineTag];
    
    if (yesOrNo) {
        line.hidden = NO;
        CABasicAnimation *animation = [self moveYTime:2 fromY:[NSNumber numberWithFloat:0] toY:[NSNumber numberWithFloat:scaningEdgeDis-2] rep:OPEN_MAX];
        [line.layer addAnimation:animation forKey:@"LineAnimation"];
    }else {
        UIView *line = [self.view viewWithTag:lineTag];
        [line.layer removeAnimationForKey:@"LineAnimation"];
        line.hidden = YES;
    }
}

- (void)drawLineOnView:(UIView *)lineView {
    CGFloat edgeWidth = 5;
    CGFloat aplha = 0.3f;
    int numberOfLines = scaningEdgeDis / 5;
    
    for (int i = 0; i < numberOfLines; i ++) {
        CGFloat x = edgeWidth * (i + 1);
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(x, 0)];
        [linePath addLineToPoint:CGPointMake(x, scaningEdgeDis)];
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.lineWidth = 1;
        lineLayer.strokeColor = [UIColor colorWithHexRGB:lineColor alpha:aplha].CGColor;
        lineLayer.path = linePath.CGPath;
        lineLayer.fillColor = nil;
        [lineView.layer addSublayer:lineLayer];
        
        CGFloat y = edgeWidth * (i + 1);
        UIBezierPath *linePathY = [UIBezierPath bezierPath];
        [linePathY moveToPoint:CGPointMake(0, y)];
        [linePathY addLineToPoint:CGPointMake(scaningEdgeDis, y)];
        CAShapeLayer *lineLayerY = [CAShapeLayer layer];
        lineLayerY.lineWidth = 1;
        lineLayerY.strokeColor = [UIColor colorWithHexRGB:lineColor alpha:aplha].CGColor;
        lineLayerY.path = linePathY.CGPath;
        lineLayerY.fillColor = nil;
        [lineView.layer addSublayer:lineLayerY];
    }
}

- (CABasicAnimation *)moveYTime:(float)time fromY:(NSNumber *)fromY toY:(NSNumber *)toY rep:(int)rep {
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    [animationMove setFromValue:fromY];
    [animationMove setToValue:toY];
    animationMove.duration = time;
    animationMove.delegate = self;
    animationMove.repeatCount  = rep;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animationMove;
}

#pragma mark -
- (void)playScanSound{
    SystemSoundID scanSound;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"scanSound"ofType:@"mp3"]], &scanSound);
    AudioServicesPlaySystemSound(scanSound);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

