//
//  GJNearbyController.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/23.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJTradeAreaController.h"
#import "GJTradeAreaTBVCell.h"
#import "GJTradeAreaTopView.h"
#import "GJAMapManager.h"
#import "GJHomeManager.h"

CGFloat const gestureMiniTranslation = 2.0;

@interface GJTradeAreaController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJTradeAreaTopView *tradeareaTopView;
@property (nonatomic, assign) CGFloat showH;
@property (nonatomic, assign) CGFloat showY;
@property (nonatomic, assign) CGFloat headerInitHeight;
@property (nonatomic, assign) MineMoveDirection direction;
@property (nonatomic, assign) BOOL isLocateClick;
@property (nonatomic, strong) GJHomeManager *homeManager;
@end

@implementation GJTradeAreaController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (_isLocateClick) return;
    _backView.frame = CGRectMake(15, SCREEN_H-_showH, SCREEN_W-30, SCREEN_H-NavBar_H-AdaptatSize(40));
    _tradeareaTopView.frame = CGRectMake(0, 0, _backView.width, AdaptatSize(410));
    _tableView.frame = CGRectMake(0, _headerInitHeight, _backView.width, _backView.height-_headerInitHeight);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _showH = (int)((SCREEN_H == kGJIphoneX) ? AdaptatSize(220) : AdaptatSize(220));
    _showY = (int)(NavBar_H+AdaptatSize(15));
    _headerInitHeight = (SCREEN_H == kGJIphoneX) ? AdaptatSize(115) : AdaptatSize(110);
    _isLocateClick = NO;
}

- (void)initializationSubView {
    __weak typeof(self)weakSelf = self;
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.tradeareaTopView];
    self.tradeareaTopView.naviRefreshLocateBlock = ^{
        [weakSelf setLocation];
    };
    [self.backView addSubview:self.tableView];
    [self blockHandle];
}

- (void)initializationNetWorking {
    if (!_filterZoneData) {
        _homeManager = [[GJHomeManager alloc] init];
        [_homeManager requestFilterZoneListCityID:nil success:^(GJFilterZoneData *models) {
            _tradeareaTopView.filterZoneData = models;
        } failure:^(NSURLResponse *urlResponse, NSError *error) {
        }];
    }else _tradeareaTopView.filterZoneData = _filterZoneData;
}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)setCurrentLocation:(CLLocationCoordinate2D)currentLocation {
    _currentLocation = currentLocation;
    [self setLocation];
}

- (void)setLocation {
    [self.tradeareaTopView setCurrentLocation:nil];
    [self.aMapManager updateLocation:self.currentLocation update:^(NSString *data) {
        [self.tradeareaTopView setCurrentLocation:data];
        _isLocateClick = YES;
    }];
}

- (void)setViewFullShow:(BOOL)is {
    self.tradeareaTopView.fullViewBtn.hidden = is;
    if (is) {
        [_superBackView showSelfAplha:0.1];
        [UIView animateWithDuration:0.3 animations:^{
            [_backView setY:_showY];
        }];
    }else {
        if (self.tradeareaTopView.isExpandSelf) {
            [self.tradeareaTopView recoverSelf];
        }
        [_superBackView hideSelf];
        [UIView animateWithDuration:0.3 animations:^{
            [_backView setY:SCREEN_H-_showH];
        }];
    }
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHandle {
    __weak typeof(self)weakSelf = self;
    _tradeareaTopView.fullViewBtnBlock = ^{
        [weakSelf setViewFullShow:YES];
    };
}

- (void)upDrag:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    if (gesture.state == UIGestureRecognizerStateBegan ){
        _direction = kMineMoveDirectionNone;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged && _direction == kMineMoveDirectionNone) {
        _direction = [ self determineMineDirectionIfNeeded:translation];
        
        switch (_direction) {
            case kMineMoveDirectionUp:
                [self setViewFullShow:YES];
                break ;
            case kMineMoveDirectionDown:
                [self setViewFullShow:NO];
                break ;
            default :
                break ;
        }
    }else if (gesture.state == UIGestureRecognizerStateEnded ){
    }
}

// 根据手势判断方向
- ( MineMoveDirection )determineMineDirectionIfNeeded:( CGPoint )translation {
    if (_direction != kMineMoveDirectionNone) return _direction;
    
    if (fabs(translation.x) > gestureMiniTranslation) {
        BOOL gestureHorizontal = NO;
        if (translation.y == 0.0 ) gestureHorizontal = YES;
        else
            gestureHorizontal = (fabs(translation.x / translation.y) > 5.0 );
        if (gestureHorizontal) {
            if (translation.x > 0.0 ) return kMineMoveDirectionRight;
            else return kMineMoveDirectionLeft;
        }
    }
    else if (fabs(translation.y) > gestureMiniTranslation) {
        BOOL gestureVertical = NO;
        if (translation.x == 0.0 ) gestureVertical = YES;
        else
            gestureVertical = (fabs(translation.y / translation.x) > 5.0 );
        if (gestureVertical) {
            if (translation.y > 0.0 ) return kMineMoveDirectionDown;
            else return kMineMoveDirectionUp;
        }
    }
    return _direction;
}

#pragma mark - Custom delegate


#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJTradeAreaTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJTradeAreaTBVCell reuseIndentifier]];
    if (!cell) cell = [[GJTradeAreaTBVCell alloc] initWithStyle:[GJTradeAreaTBVCell expectingStyle] reuseIdentifier:[GJTradeAreaTBVCell reuseIndentifier]];
    cell.listData = _dataSources[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GJTradeAreaTBVCell height];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_backView.y == _showY) {
        if (self.tradeareaTopView.isExpandSelf) {
            [self.tradeareaTopView recoverSelf];
            return ;
        }
        GJStoreDetailController *storeDetail = [[GJStoreDetailController alloc] init];
        storeDetail.pointData = _dataSources[indexPath.row];
        __weak typeof(self)weakSelf = self;
        storeDetail.naviRouteCBlock = ^(CLLocationCoordinate2D location) {
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
            BLOCK_SAFE(weakSelf.naviRouteCCBlock)(location, indexPath.row);
        };
        storeDetail.dismissAfterBlock = ^{
            [weakSelf setViewFullShow:NO];
        };
        [self presentViewController:storeDetail animated:YES completion:nil];
    }else {
        [self setViewFullShow:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_backView.y == _showY) {
        [self setViewFullShow:NO];
    }else {
        BLOCK_SAFE(_dismissSelfBlock)();
        [UIView animateWithDuration:0.5 animations:^{
            [_backView setY:SCREEN_H];
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.layer.cornerRadius = 8;
        _tableView.clipsToBounds = YES;
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _tableView;
}

- (GJTradeAreaTopView *)tradeareaTopView {
    if (!_tradeareaTopView) {
        _tradeareaTopView = [[GJTradeAreaTopView alloc] init];
        _tradeareaTopView.areaTable = self.tableView;
        _tradeareaTopView.layer.cornerRadius = 8;
        _tradeareaTopView.clipsToBounds = YES;
        UIPanGestureRecognizer *upDragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(upDrag:)];
        upDragGesture.maximumNumberOfTouches = 1;
        [_tradeareaTopView addGestureRecognizer:upDragGesture];
    }
    return _tradeareaTopView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.shadowColor = [UIColor blackColor].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0, 0);
        _backView.layer.shadowOpacity = 0.6;
        _backView.layer.shadowRadius = 8;
        _backView.layer.cornerRadius = 8;
    }
    return _backView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
