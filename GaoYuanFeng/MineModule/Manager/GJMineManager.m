//
//  GJMineManager.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/4.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJMineManager.h"
#import "GJScoreModel.h"
#import "GJAppInfoData.h"
#import "GJInviteFriendListData.h"
#import "GJAddressListData.h"

@implementation GJMineManager

- (void)requestAddressDeleteWithID:(NSString *)ID uid:(NSString *)uid success:(HTTPTaskSuccessBlock)success failure:(HTTPTaskFailureBlock)failureBlock {
    NSDictionary *param = @{@"id":ID,
                            @"uid":uid
                            };
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_Address_Delete andParaDic:param andSucceedCallback:success andFailedCallback:failureBlock];
}

- (void)requestAddressSetDefaultWithID:(NSString *)ID uid:(NSString *)uid success:(HTTPTaskSuccessBlock)success failure:(HTTPTaskFailureBlock)failureBlock {
    NSDictionary *param = @{@"id":ID,
                            @"uid":uid,
                            @"is_default":[NSNumber numberWithBool:1]
                            };
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_Address_SetDefault andParaDic:param andSucceedCallback:success andFailedCallback:failureBlock];
}

- (void)requestUpdateUserAddressWithData:(GJAddressListData *)data success:(HTTPTaskSuccessBlock)success failure:(HTTPTaskFailureBlock)failureBlock {
    if (!data) return ;
    NSDictionary *param = @{@"api_token":APP_USER.userInfo.api_token,
                            @"id":data.ID,
                            @"uid":data.uid,
                            @"name":data.name,
                            @"phone":data.phone,
                            @"province":data.province,
                            @"city":data.city,
                            @"district":data.district,
                            @"address":data.address,
                            @"is_default":[NSNumber numberWithBool:data.is_default]
                            };
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_Address_Update andParaDic:param andSucceedCallback:success andFailedCallback:failureBlock];
}

- (void)requestAddUserAddressWithData:(GJAddressListData *)data success:(HTTPTaskSuccessBlock)success failure:(HTTPTaskFailureBlock)failureBlock {
    if (!data) return ;
    NSDictionary *param = @{@"api_token":APP_USER.userInfo.api_token,
                            @"name":data.name,
                            @"phone":data.phone,
                            @"province":data.province,
                            @"city":data.city,
                            @"district":data.district,
                            @"address":data.address,
                            @"is_default":[NSNumber numberWithBool:data.is_default]
                            };
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_Address_Add andParaDic:param andSucceedCallback:success andFailedCallback:failureBlock];
}

- (void)requestAddressListSuccess:(void (^)(NSArray<GJAddressListData *> *))success failure:(HTTPTaskFailureBlock)failureBlock {
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_Address_List andParaDic:@{@"api_token":APP_USER.userInfo.api_token} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        NSArray *data  = [NSArray yy_modelArrayWithClass:GJAddressListData.class json:response];
        success(data);
    } andFailedCallback:failureBlock];
}

- (void)requestInviteFriendsListWithType:(NSInteger)type success:(void (^)(NSArray<GJInviteFriendListData *> *))success failure:(HTTPTaskFailureBlock)failureBlock {
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_Invite_Friends andParaDic:@{@"type":[NSNumber numberWithInteger:type],@"api_token":APP_USER.userInfo.api_token} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        NSArray *data  = [NSArray yy_modelArrayWithClass:GJInviteFriendListData.class json:response];
        success(data);
    } andFailedCallback:failureBlock];
}

- (void)requestAppInfoSuccess:(void (^)(GJAppInfoData *))success failure:(HTTPTaskFailureBlock)failureBlock {
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_APP_Info andParaDic:nil andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJAppInfoData *data  = [GJAppInfoData yy_modelWithJSON:response];
        success(data);
    } andFailedCallback:failureBlock];
}

- (void)requestEditUserInfoWithNick:(NSString *)nick context:(UIViewController *)context {
    [self requestEditUserInfoWithName:APP_USER.userInfo.username sex:APP_USER.userInfo.sex nick:nick context:context success:^{
        [context.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)requestEditUserInfoWithName:(NSString *)name context:(UIViewController *)context {
    [self requestEditUserInfoWithName:name sex:APP_USER.userInfo.sex nick:APP_USER.userInfo.nickname context:context success:^{
        [context.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)requestEditUserInfoWithSex:(NSString *)sex context:(UIViewController *)context {
    // （1：男，2：女）
    [self requestEditUserInfoWithName:APP_USER.userInfo.username sex:sex nick:APP_USER.userInfo.nickname context:context success:^{
    }];
}

- (void)requestEditUserInfoWithName:(NSString *)name sex:(NSString *)sex nick:(NSString *)nick context:(UIViewController *)context success:(void (^)(void))successBlock {
    NSString *token = APP_USER.userInfo.api_token;
    NSDictionary *param = @{@"api_token":token, @"username":name, @"sex":sex, @"nickname":nick};
    [context.view.loadingView startAnimation];
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_Edit_Userinfo andParaDic:param andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJUserInfoData *userInfo  = [GJUserInfoData yy_modelWithJSON:response];
        [APP_USER saveLoginUserInfo:userInfo];
        successBlock();
        ShowSucceedAlertHUD(@"修改成功", nil);
        [context.view.loadingView stopAnimation];
    } andFailedCallback:^(NSURLResponse *urlResponse, NSError *error) {
        ShowFailedAlertHUD(@"修改失败", nil);
        [context.view.loadingView stopAnimation];
    }];
}

- (void)requestUserInfoSuccess:(void (^)(void))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSString *token = JudgeContainerCountIsNull(APP_USER.userInfo.api_token)?@"":APP_USER.userInfo.api_token;
    NSDictionary *param = @{@"api_token":token};
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Mine_Get_Userinfo andParaDic:param andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJUserInfoData *userInfo  = [GJUserInfoData yy_modelWithJSON:response];
        [APP_USER saveLoginUserInfo:userInfo];
        successBlock();
    } andFailedCallback:failureBlock];
}

- (void)requestScoreUseListSuccess:(void (^)(GJScoreModel *))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    [[GJHttpNetworkingManager sharedInstance] requestAllDataPostWithPathUrl:Mine_Score_UseHistory andParaDic:@{@"api_token":APP_USER.userInfo.api_token} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJScoreModel *data = [GJScoreModel yy_modelWithJSON:response];
        successBlock(data);
    } andFailedCallback:failureBlock];
}

- (void)uploadPortraitFile:(UIImage *)image success:(void (^)(NSString *))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    if (!image) return ;
    NSData *scaleImgData = [UIImage imageObjectToData:image];
    NSDictionary *param = @{@"api_token":APP_USER.userInfo.api_token,
                            @"type":[NSNumber numberWithInt:1]
                            };
    [[GJHttpNetworkingManager sharedInstance] reqeustLoadImageData:scaleImgData url:Mine_Upload_Portrait params:param andProgress:NULL andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        NSString *imgURL = response[@"message"];
        successBlock(imgURL);
    } andFailedCallback:failureBlock];
    
//                            ,@"file":scaleImgData
//    [[GJHttpNetworkingManager sharedInstance] requestAllDataPostWithPathUrl:Mine_Upload_Portrait andParaDic:param andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
//        NSString *imgURL = response[@"message"];
//        successBlock(imgURL);
//    } andFailedCallback:failureBlock];
}

@end
