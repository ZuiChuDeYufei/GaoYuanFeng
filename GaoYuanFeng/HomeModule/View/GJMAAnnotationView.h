//
//  GJMAAnnotationView.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/21.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface GJMAAnnotationView : MAAnnotationView

@property (nonatomic, assign) NSUInteger numberOfShopsInLocation;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isCenter;
@property (nonatomic, assign) BOOL isNaviIcon;

+ (NSString *)reuseIndentifier;
- (void)setCustomCalloutHidden:(BOOL)is;
- (void)viewAnimatingFinished:(void (^)(void))block;
- (void)viewAnimating;

@end
