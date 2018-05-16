//
//  GJAdressPickerController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/28.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJAdressPickerController.h"
#import "GJSubmitOrderPickerView.h"

@interface GJAdressPickerController ()
@property (nonatomic, strong) GJSubmitOrderPickerView *pickerView;
@property (nonatomic, assign) NSInteger currentRow;
@end

@implementation GJAdressPickerController

- (void)presentSelf:(UIViewController *)context {
    [context presentViewController:self animated:YES completion:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    [self.view addSubview:self.pickerView];
    _pickerView.selectRow = ^(NSInteger row) {
        weakSelf.currentRow = row;
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        BLOCK_SAFE(weakSelf.selectRow)(row);
    };
    _pickerView.dismissSelf = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)setRegionType:(RegionTypes)regionType {
    _regionType = regionType;
    if (_regionType == RegionProvince) {
        _pickerView.adressArr = [APP_USER getProvinces];
    }
    else if (_regionType == RegionCity) {
        _pickerView.adressArr = [APP_USER getCityInProvince:_currProvince];
    }
    else if (_regionType == RegionDistrict) {
        _pickerView.adressArr = [APP_USER getDistrictInCity:_currCity];
    }else {
        _pickerView.adressArr = @[@"男", @"女"];
    }
}

- (GJSubmitOrderPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[GJSubmitOrderPickerView alloc] initWithFrame:CGRectMake(0, self.view.height-self.view.height/4, SCREEN_W, self.view.height/4)];
    }
    return _pickerView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_currentRow == 0) {
        BLOCK_SAFE(self.selectRow)(_currentRow);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
