//
//  GJSubmitOrderPickerView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/27.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJSubmitOrderPickerView.h"

@interface GJSubmitOrderPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, assign) NSInteger tempSelectRow;
@end

@implementation GJSubmitOrderPickerView

- (void)setAdressArr:(NSArray *)adressArr {
    _adressArr = adressArr;
    _tempSelectRow = 0;
    
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:0 inComponent:0 animated:NO];
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    _backView = [[UIView alloc] initWithFrame:self.bounds];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _backView.layer.shadowOpacity = 1;
    _backView.layer.shadowRadius = 4.f;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    
    _pickerView = [[UIPickerView alloc] initWithFrame:_backView.frame];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AdaptatSize(80), AdaptatSize(50))];
    _leftBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    [_leftBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:APP_CONFIG.blackTextColor forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W-_leftBtn.width, 0, _leftBtn.width, _leftBtn.height)];
    _rightBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:15]);
    [_rightBtn setTitle:@"完 成" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:APP_CONFIG.blackTextColor forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_backView];
    [self addSubview:_pickerView];
    [self addSubview:_rightBtn];
    [self addSubview:_leftBtn];
}

- (void)leftBtnClick {
    BLOCK_SAFE(_dismissSelf)();
}

- (void)rightBtnClick {
    BLOCK_SAFE(_selectRow)(_tempSelectRow);
}

#pragma mark - PickerView function
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _adressArr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.0f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 20)];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = [_adressArr objectAtIndex:row];
    [view addSubview:text];
    
    //隐藏上下直线
    [self.pickerView.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    [self.pickerView.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _tempSelectRow = row;
}

@end
