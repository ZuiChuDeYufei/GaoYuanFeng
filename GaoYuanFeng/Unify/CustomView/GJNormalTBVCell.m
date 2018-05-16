//
//  GJNormalTBVCell.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJNormalTBVCell.h"

@interface GJNormalTBVCell ()
@property (nonatomic,strong) UIView *bottomLine;
@end

@implementation GJNormalTBVCell

+ (UITableViewCellStyle)expectingStyle
{
    return UITableViewCellStyleValue1;
}

- (void)commonInit {
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.font = [APP_CONFIG appFontOfSize:14];
    self.textLabel.textColor = [APP_CONFIG darkTextColor];
    self.detailTextLabel.textColor = [APP_CONFIG grayTextColor];
    self.detailTextLabel.font =[APP_CONFIG appFontOfSize:14];
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.hidden = YES;
    [self addSubview:self.bottomLine];
}

- (void)setCellModel:(GJNormalCellModel *)cellModel {
    _cellModel = cellModel;
    self.accessoryType = _cellModel.acessoryType;
    self.detailTextLabel.text = _cellModel.detail;
    self.textLabel.text = _cellModel.title;
    if (!JudgeContainerCountIsNull(cellModel.imgName)) self.imageView.image = [UIImage imageNamed:cellModel.imgName];
}

- (void)settingShowSpeatLine:(BOOL)show {
    self.bottomLine.backgroundColor = APP_CONFIG.appBackgroundColor;
    self.bottomLine.hidden = !show;
}

- (void)settingShowSpeatLine:(BOOL)show withColor:(UIColor *)color {
    self.bottomLine.hidden = !show;
    self.bottomLine.backgroundColor = color;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bottomLine.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
}

@end
