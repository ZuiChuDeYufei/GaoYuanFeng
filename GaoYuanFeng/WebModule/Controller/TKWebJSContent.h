//
//  TKWebJSContent.h
//  TongKe
//
//  Created by arlen on 2017/7/21.
//  Copyright © 2017年 BBD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface TKWebJSContent : NSObject
@property (nonatomic,strong) JSContext *context;
@property (strong,nonatomic) UIViewController *byController;

@property (nonatomic,strong,readonly) NSString *content;
@property (nonatomic,strong,readonly) NSString *title;
@property (nonatomic,strong,readonly) NSString *picUrl;
@property (nonatomic,strong,readonly) NSString *jumpUrl;


-(id)initWith:(JSContext *)context ;
- (void)configJsContentByController:(UIViewController *)controller webView:(UIWebView *)webView;
@end
