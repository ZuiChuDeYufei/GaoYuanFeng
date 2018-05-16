//
//  GJCashDeskController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJCashDeskController.h"
#import "GJPayCompleteController.h"
#import "GJCashDeskTopView.h"
#import "GJCashDeskMiddleView.h"
#import "GJOrderManager.h"
#import "GJWeChatPayModel.h"
#import "GJAlipayModel.h"

@interface GJCashDeskController ()
@property (nonatomic, strong) GJCashDeskTopView *topView;
@property (nonatomic, strong) GJCashDeskMiddleView *middleView;
@property (nonatomic, strong) GJOrderManager *orderManager;
@property (nonatomic, strong) GJOrderPaymentData *payData;
@end

@implementation GJCashDeskController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _topView.frame = CGRectMake(15, NavBar_H+15, SCREEN_W-30, SCREEN_H/2-NavBar_H-15);
    _middleView.frame = CGRectMake(15, _topView.y+_topView.height+15, _topView.width, SCREEN_H-_topView.y-_topView.height-30);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    [self bindPayNotification];
}

- (void)initializationSubView {
    self.title = @"收银台";
    [self allowBack];
    [self showShadorOnNaviBar:YES];
    self.view.backgroundColor = [UIColor colorWithRGB:247 g:247 b:247];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.middleView];
    _orderManager = [[GJOrderManager alloc] init];
}

- (void)initializationNetWorking {
    _topView.storeName = @"高原风";
}

#pragma mark - Request Handle
- (void)requestPayWithMoney:(NSString *)money type:(PayTypes)type supplier_id:(NSString *)supplier_id {
    [self.view.loadingView startAnimation];
    [_orderManager requestPayWithMoney:money type:type supplier_id:[self getSupplierIDFromWRCode] success:^(GJOrderPaymentData *data) {
        [self.view.loadingView stopAnimation];
        _payData = data;
        // 去支付
        if (type == ZhiFuBaoPay) {
            [[GJAlipayModel new] jumpToPayWithOrder:data];
        }else if (type == WeChatPay) {
            [[GJWeChatPayModel new] jumpToPayWithOrder:data];
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
    }];
}

- (NSString *)getSupplierIDFromWRCode {
    return @"13";
    // TODO  _resultURL
}

- (void)requestOrderPaySuccess {
    ShowSucceedAlertHUD(@"支付成功", self.view);
    // 支付回调处理，回调中调到支付完成
    [_orderManager requestPayOrderStatus:_payData.pay_sn success:^(GJOrderPaymentSuccessData *data) {
        if (data) {
            GJPayCompleteController *payC = [[GJPayCompleteController alloc] init];
            payC.data = data;
            payC.interactivePopDisabled = YES;
            [payC pushPageWith:self];
        }else {
            ShowWaringAlertHUD(@"查询订单支付状态失败", nil);
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        
    }];
}

#pragma mark - Private methods
- (void)bindPayNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alipayResultNotification:) name:AliPaySucessNotice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxResultNotification:) name:WeChatPaySucessNotice object:nil];
}

- (void)alipayResultNotification:(NSNotification *)notification {
    GJPaymentResultType resultType;
    NSDictionary *resultDic = notification.object;
    NSString *result = [NSString stringWithFormat:@"%@",resultDic[@"result"]];
    NSInteger code = [resultDic[@"resultStatus"] integerValue];
    if ([result isKindOfClass:[NSNull class]] || result.length == 0) {
        resultType = GJPaymentResultError;
    }else {
        [self requestOrderPaySuccess];
    }
    if (code == 6001) {
        ShowWaringAlertHUD(@"已取消支付", self.view);
    }
}

- (void)wxResultNotification:(NSNotification *)notification {
    NSDictionary *resultDic = notification.object;
    NSInteger type = [resultDic[@"result"] integerValue];
    if (type == GJPaymentResultCancleType) {
        ShowWaringAlertHUD(@"已取消支付", self.view);
    }
    else if (type == GJPaymentResultError) {
        ShowWaringAlertHUD(@"支付失败", self.view);
    }
    else if (type == GJPaymentResultSuccess) {
        [self requestOrderPaySuccess];
    }
}

#pragma mark - Public methods

#pragma mark - Event response
- (void)payButtonClick {
    if ([_topView.priceTF.text doubleValue] != 0) {
        [_topView.priceTF resignFirstResponder];
        [self requestPayWithMoney:_topView.priceTF.text type:_middleView.payType supplier_id:_resultURL];
    }else {
        ShowWaringAlertHUD(@"请输入正确的金额", nil);
    }
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (GJCashDeskTopView *)topView {
    if (!_topView) {
        _topView = [[GJCashDeskTopView alloc] init];
        _topView.payBtn = self.middleView.payButton;
    }
    return _topView;
}

- (GJCashDeskMiddleView *)middleView {
    if (!_middleView) {
        _middleView = [[GJCashDeskMiddleView alloc] init];
        _middleView.backgroundColor = self.view.backgroundColor;
        [_middleView.payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
