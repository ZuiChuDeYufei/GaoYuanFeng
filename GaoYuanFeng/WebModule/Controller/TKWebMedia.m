//
//  TKWebMedia.m
//  TongKe
//
//  Created by arlen on 2017/7/23.
//  Copyright © 2017年 BBD. All rights reserved.
//

#import "TKWebMedia.h"
#import "TKWebViewController.h"
#import "TKWKBaseWebController.h"
@implementation TKWebMedia

+(void)commonWebViewJumpUrl:(NSString *)url  title:(NSString *)title controller:(UIViewController *)controller {
    dispatch_async(dispatch_get_main_queue(), ^{
        TKWebViewController *web = [[TKWebViewController alloc] init];
        web.webUrl = url;
        web.isSetTitle = !JudgeContainerCountIsNull(title);
        web.navigationItem.title = title;
        web.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [controller presentViewController:[[GJBaseNavigationController alloc] initWithRootViewController:web] animated:NO completion:nil];
        [controller.navigationController pushViewController:web animated:YES];
    });

}

+(void)openWKWebWithJumpUrl:(NSString *)url title:(NSString *)title controller:(UIViewController *)controller {
    TKWKBaseWebController *wk = [[TKWKBaseWebController alloc] init];
    wk.url = url;
    dispatch_async(dispatch_get_main_queue(), ^{
        // To do UI
        wk.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [controller presentViewController:[[GJBaseNavigationController alloc] initWithRootViewController:wk] animated:YES completion:nil];
    });
}

@end
