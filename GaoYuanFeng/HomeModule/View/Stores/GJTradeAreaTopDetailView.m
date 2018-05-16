//
//  GJTradeAreaTopDetailView.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/30.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJTradeAreaTopDetailView.h"
#import "GJTradeAreaTopDetailCell.h"

typedef enum : NSInteger {
    AllTypeType,
    RegionType,
    AutoType
} TableTypes;

@interface GJTradeAreaTopDetailView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView                                                             *leftTableView;
@property (nonatomic, strong) GJBaseTableView *centerTableView;
@property (nonatomic, strong) GJBaseTableView *rightTableView;
@property (nonatomic, assign) TableTypes tableType;
@property (nonatomic, strong) GJFilterZoneDataType *selectType;
@property (nonatomic, strong) GJFilterZoneDataRegion *selectRegion;
@property (nonatomic, strong) NSString *selectDetailID;
@end

@implementation GJTradeAreaTopDetailView

- (void)setFilterTypes:(NSArray<GJFilterZoneDataType *> *)filterTypes {
    _filterTypes = filterTypes;
    _tableType = AllTypeType;
    [self resetTable];
}

- (void)setFilterRegions:(NSArray<GJFilterZoneDataRegion *> *)filterRegions {
    _filterRegions = filterRegions;
    _tableType = RegionType;
    [self resetTable];
}

- (void)resetTable {
    _selectType = nil;
    _selectRegion = nil;
    [_leftTableView reloadData];
    [_centerTableView reloadData];
}

- (void)commonInit {
    self.backgroundColor = self.superview.backgroundColor;
    [self addSubview:self.leftTableView];
    [self addSubview:self.centerTableView];
    [self addSubview:self.rightTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo((SCREEN_W-30)/3);
    }];
    [self.centerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(_leftTableView.mas_width);
    }];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(_leftTableView.mas_width);
    }];
}

#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        if (_tableType == AllTypeType) {
            return _filterTypes.count;
        }else if (_tableType == RegionType) {
            return _filterRegions.count;
        }else return 0;
    }else if (tableView == _centerTableView) {
        if (_tableType == AllTypeType) {
            return _selectType.list.count;
        }else if (_tableType == RegionType) {
            return _selectRegion.list.count;
        }else return 0;
    }else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AdaptatSize(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJTradeAreaTopDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJTradeAreaTopDetailCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJTradeAreaTopDetailCell alloc] initWithStyle:[GJTradeAreaTopDetailCell expectingStyle] reuseIdentifier:[GJTradeAreaTopDetailCell reuseIndentifier]];
    }
    cell.textLabel.textColor = [UIColor lightTextColor];
    
    if (tableView == _leftTableView) {
        if (_tableType == AllTypeType) {
            cell.textLabel.text = _filterTypes[indexPath.row].cat_name;
        }else if (_tableType == RegionType) {
            cell.textLabel.text = _filterRegions[indexPath.row].region_name;
        }
    }else if (tableView == _centerTableView) {
        if (_tableType == AllTypeType) {
            cell.textLabel.text = _selectType.list[indexPath.row].cat_name;
        }else if (_tableType == RegionType) {
            cell.textLabel.text = _selectRegion.list[indexPath.row].region_name;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GJTradeAreaTopDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = APP_CONFIG.appMainColor;
    
    if (tableView == _leftTableView) {
        if (_tableType == AllTypeType) {
            _selectType = _filterTypes[indexPath.row];
        }else if (_tableType == RegionType) {
            _selectRegion = _filterRegions[indexPath.row];
        }
        [_centerTableView reloadData];
    }else if (tableView == _centerTableView) {
        if (_tableType == AllTypeType) {
            _selectDetailID = _selectType.list[indexPath.row].catid;
        }else if (_tableType == RegionType) {
            _selectDetailID = _selectRegion.list[indexPath.row].region_id;
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    GJTradeAreaTopDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor lightTextColor];
}

#pragma mark - Getter/Setter
- (GJBaseTableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain view:self];
        _leftTableView.backgroundColor = self.backgroundColor;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _leftTableView;
}

- (GJBaseTableView *)centerTableView {
    if (!_centerTableView) {
        _centerTableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain view:self];
        _centerTableView.backgroundColor = self.backgroundColor;
        _centerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _centerTableView;
}

- (GJBaseTableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain view:self];
        _rightTableView.backgroundColor = self.backgroundColor;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rightTableView;
}

@end
