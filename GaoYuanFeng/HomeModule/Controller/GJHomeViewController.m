//
//  GJHomeViewController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJHomeViewController.h"
#import "GJHomeNaviView.h"
#import "GJHomeBottomView.h"
#import "GJAMapView.h"
#import "GJSearchController.h"
#import "GJMessageController.h"
#import "GJMineCenterController.h"
#import "GJLocateButton.h"
#import "GJTradeAreaController.h"
#import "GJHomeGotoLoginView.h"
#import "GJLoginRegisterController.h"
#import "GJHomeFilterButton.h"
#import "GJStorePointInfoView.h"
#import "GJQRCodeController.h"
#import "GJHomeManager.h"
#import "GJStoreDetailController.h"
#import "GJRadarView.h"
#import "GJCashDeskController.h"

@interface GJHomeViewController ()
@property (nonatomic, strong) GJHomeNaviView *naviItemBar;
@property (nonatomic, strong) GJHomeBottomView *bottomView;
@property (nonatomic, strong) GJAMapView *aMapView;
@property (nonatomic, strong) GJLocateButton *locateButton;
@property (nonatomic, strong) GJHomeFilterButton *filterButton;
@property (nonatomic, strong) GJGrayBackView *grayFullBackView;
@property (nonatomic, strong) GJHomeGotoLoginView *gotoLoginView;
@property (nonatomic, strong) GJStorePointInfoView *pointInfoView;
@property (nonatomic, strong) GJHomeManager *homeManager;
@property (nonatomic, strong) NSArray<GJHomeSearchPointData *> *dataSources;
@property (nonatomic, assign) BOOL fixAreaDetailNaviSelectPresentDetail;
@property (nonatomic, strong) GJRadarView *radarView;
@property (nonatomic, strong) GJQRCodeController *qrCode;
@property (nonatomic, strong) GJFilterZoneData *filterZoneData;
@end

@implementation GJHomeViewController

#pragma mark - View controller life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self hiddenGotoLoginView:[APP_USER isLoginStatus]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_homeManager requestRegionData];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _homeManager = [[GJHomeManager alloc] init];
    _qrCode = [[GJQRCodeController alloc] init];
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:YES];
    [self.view addSubview:self.aMapView];
    [self.view addSubview:self.radarView];
    [self.view addSubview:self.naviItemBar];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.locateButton];
    [self.view addSubview:self.filterButton];
    [self.view addSubview:self.grayFullBackView];
    [self.view addSubview:self.gotoLoginView];
    [self.view addSubview:self.pointInfoView];
    [self blockHandle];
}

- (void)initializationNetWorking {
    __weak typeof(self)weakSelf = self;
    [self.aMapView.aMapManager.locationManager startUpdatingLocation];
    self.aMapView.aMapManager.handleLocationBlock = ^(CLLocationCoordinate2D current) {
        [weakSelf requestMovingMapPinGetShops:current];
    };
    [_homeManager requestFilterZoneListCityID:nil success:^(GJFilterZoneData *models) {
        _filterZoneData = models;
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        
    }];
}

#pragma mark - Request Handle
// 请求大头针附近店铺数据
- (void)requestMovingMapPinGetShops:(CLLocationCoordinate2D)moving {
    [_radarView startRadar];
    [_homeManager requestSupplierListWithLataLongi:moving success:^(NSArray<GJHomeSearchPointData *> *models, NSArray<GJLocationCoordinateData *> *points) {
        _dataSources = models;
        [self.aMapView addBigHeadPins:moving locations:points];
        [_radarView stopRadar];
        _locateButton.isSelected = NO;
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        ShowWaringAlertHUD(error.localizedDescription, nil);
        [_radarView stopRadar];
        _locateButton.isSelected = NO;
    }];
}

#pragma mark - Private methods
- (void)gotoUser {
    if ([APP_USER isLoginStatus]) {
        GJMineCenterController *mineVC = [[GJMineCenterController alloc] init];
        mineVC.context = self;
        mineVC.backView = _grayFullBackView;
        mineVC.mineView.dismissBlock = ^{
            [_grayFullBackView hideSelf];
            [self hiddenGotoLoginView:[APP_USER isLoginStatus]];
        };
        [_grayFullBackView showSelfAplha:0.2];
        [self presentViewController:mineVC animated:YES completion:nil];
    }else {
        [GJLoginRegisterController needLoginPresentWithVC:self loginSucessBlcok:^{
            [self hiddenGotoLoginView:YES];
        }];
    }
}

- (void)didSelectAnnotationView:(GJMAAnnotationView *)view :(MAMapView *)mapView :(GJAMapManager *)aMapManager {
    if (JudgeContainerCountIsNull(self.dataSources)) return ;
    GJTradeAreaController *_areaVC = [[GJTradeAreaController alloc] init];
    _areaVC.filterZoneData = _filterZoneData;
    _areaVC.aMapManager = self.aMapView.aMapManager;
    _areaVC.currentLocation = self.aMapView.currentLocation;
    _areaVC.dataSources = self.dataSources;
    _areaVC.superBackView = self.grayFullBackView;
    _areaVC.naviRouteCCBlock = ^(CLLocationCoordinate2D location, NSInteger index) {
        if (_aMapView.aMapManager.arrAnnoViews.count > 0) {
            _fixAreaDetailNaviSelectPresentDetail = YES;
            GJMAAnnotationView *v = _aMapView.aMapManager.arrAnnoViews[index];
            [mapView selectAnnotation:v.annotation animated:YES];
        }
        _pointInfoView.phone = self.dataSources[index].tel;
        [self navigating:location];
    };
    _areaVC.dismissSelfBlock = ^{
        [self dismissListOrDetail:view.annotation map:mapView];
    };
    [self presentViewController:_areaVC animated:YES completion:^{
        [self hiddenBottomViews:YES];
    }];
}

- (void)didSelectDetailAnnotation:(GJMAAnnotationView *)view :(MAMapView *)mapView {
    if (self.dataSources.count == 0) return;
    if (_fixAreaDetailNaviSelectPresentDetail) {
        _fixAreaDetailNaviSelectPresentDetail = NO;
        return;
    }
    GJStoreDetailController *storeDetail = [[GJStoreDetailController alloc] init];
    storeDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    storeDetail.modalPresentationStyle = UIModalPresentationOverFullScreen;
    GJPointAnnotation *point = (GJPointAnnotation *)view.annotation;
    storeDetail.pointData = self.dataSources[point.annoIndex];
    _pointInfoView.phone = storeDetail.pointData.tel;
    storeDetail.naviRouteCBlock = ^(CLLocationCoordinate2D location) {
        [self navigating:location];
    };
    storeDetail.dismissAfterBlock = ^{
        [self dismissListOrDetail:point map:mapView];
    };
    [self presentViewController:storeDetail animated:YES completion:nil];
    [self hiddenBottomViews:YES];
    [_grayFullBackView showSelfAplha:0.1];
}

- (void)navigating:(CLLocationCoordinate2D)location {
    [GJSProgressHUD showStatusWithString:@"路线规划中"];
    [self hiddenPointInfoView:NO];
    [self hiddenBottomViews:NO];
    [_grayFullBackView hideSelf];
    [self.aMapView.aMapManager walkingNavigateWithOrgin:self.aMapView.currentLocation destination:location];
}

- (void)dismissListOrDetail:(id<MAAnnotation>)point map:(MAMapView *)mapView {
    [self hiddenPointInfoView:YES];
    [_grayFullBackView hideSelf];
    [self hiddenBottomViews:NO];
    [mapView deselectAnnotation:point animated:YES];
}

- (void)goToSearchPage {
    GJSearchController *searchVC = [[GJSearchController alloc] init];
    searchVC.filterZoneData = _filterZoneData;
    searchVC.currCity = _aMapView.aMapManager.locateCurrCity;
    searchVC.aMapManager = _aMapView.aMapManager;
    searchVC.currentLocation = _aMapView.currentLocation;
    searchVC.naviRouteCCBlock = ^(CLLocationCoordinate2D location, GJHomeSearchPointData *data) {
        [self navigating:location];
        _pointInfoView.phone = data.tel;
        [_aMapView searchPageAddPin:location];
    };
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - Public methods
- (void)hiddenBottomViews:(BOOL)hidden {
    self.bottomView.hidden = hidden;
    self.locateButton.hidden = hidden;
    self.filterButton.hidden = hidden;
}

- (void)hiddenPointInfoView:(BOOL)hidden {
    [_pointInfoView hiddenSelf:hidden];
    if (!hidden && _gotoLoginView.isHidden) {
        [_pointInfoView setY:NavBar_H+5];
    }
    if (!hidden && !_gotoLoginView.isHidden) {
        [_pointInfoView setY:NavBar_H+AdaptatSize(62)];
    }
}

- (void)hiddenGotoLoginView:(BOOL)hidden {
    _gotoLoginView.hidden = hidden;
    if (!hidden && !_pointInfoView.isHidden) {
        [_pointInfoView setY:NavBar_H+AdaptatSize(62)];
    }
    if (hidden && !_pointInfoView.isHidden) {
        [_pointInfoView setY:NavBar_H+5];
    }
}

#pragma mark - Event response
- (void)blockHandle {
    __weak typeof(self)weakSelf = self;
    _naviItemBar.goUser = ^{
        [weakSelf gotoUser];
    };
    _naviItemBar.goMessage = ^{
        GJMessageController *messageVC = [[GJMessageController alloc] init];
        [messageVC pushPageWith:weakSelf];
    };
    _gotoLoginView.rightClickBlock = ^{
        [GJLoginRegisterController needLoginPresentWithVC:weakSelf loginSucessBlcok:^{
            [weakSelf hiddenGotoLoginView:YES];
        }];
    };
    _aMapView.didSelectAnnotationViewBlock = ^(GJMAAnnotationView *view, MAMapView *mapView, GJAMapManager *aMapManager) {
        [weakSelf didSelectAnnotationView:view :mapView :aMapManager];
    };
    _aMapView.didSelectDetailAnnotationBlock = ^(GJMAAnnotationView *view, MAMapView *mapView) {
        [weakSelf didSelectDetailAnnotation:view :mapView];
    };
    _aMapView.didDeselectAnnotationViewBlock = ^(MAMapView *mapView) {
        [weakSelf hiddenPointInfoView:YES];
    };
    _aMapView.mapMoveByUserBlock = ^(MAMapView *mapView) {
        CLLocationCoordinate2D moving = mapView.region.center;
        [weakSelf requestMovingMapPinGetShops:moving];
    };
    _locateButton.searchClickBlock = ^{
        [weakSelf requestMovingMapPinGetShops:weakSelf.aMapView.currentLocation];
    };
    _qrCode.blockQRCodeScanResultURL = ^(NSString *resultURL) {
        GJCashDeskController *cashDesk = [[GJCashDeskController alloc] init];
        cashDesk.resultURL = resultURL;
        [cashDesk pushPageWith:weakSelf.qrCode];
    };
    _bottomView.bottomScanBtnBlock = ^{
        [GJLoginRegisterController needLoginPresentWithVC:weakSelf loginSucessBlcok:^{
            [weakSelf.qrCode pushPageWith:weakSelf];
        }];
    };
    _filterButton.filterClickBlock = ^{
        [weakSelf goToSearchPage];
    };
}

#pragma mark - Getter/Setter
- (GJHomeNaviView *)naviItemBar {
    if (!_naviItemBar) _naviItemBar = [GJHomeNaviView install];
    return _naviItemBar;
}
- (GJHomeBottomView *)bottomView {
    if (!_bottomView) _bottomView = [GJHomeBottomView install];
    return _bottomView;
}
- (GJAMapView *)aMapView {
    if (!_aMapView) _aMapView = [GJAMapView install];
    return _aMapView;
}
- (GJLocateButton *)locateButton {
    if (!_locateButton) _locateButton = [GJLocateButton install];
    return _locateButton;
}
- (GJHomeFilterButton *)filterButton {
    if (!_filterButton) _filterButton = [GJHomeFilterButton install];
    return _filterButton;
}
- (GJHomeGotoLoginView *)gotoLoginView {
    if (!_gotoLoginView) _gotoLoginView = [GJHomeGotoLoginView install];
    return _gotoLoginView;
}
- (GJStorePointInfoView *)pointInfoView {
    if (!_pointInfoView) _pointInfoView = [GJStorePointInfoView install];
    return _pointInfoView;
}
- (GJRadarView *)radarView {
    if (!_radarView) _radarView = [GJRadarView installOn:self.view];
    return _radarView;
}
- (GJGrayBackView *)grayFullBackView {
    if (!_grayFullBackView) {
        _grayFullBackView = [[GJGrayBackView alloc] initWithFrame:self.view.bounds];
    }
    return _grayFullBackView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
