//
//  GJHttpConst.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJHttpConst : NSObject

// Order
FOUNDATION_EXPORT NSString *const Order_Payment_Scan;
FOUNDATION_EXPORT NSString *const Order_Payment_QueryStatus;

// Mine
FOUNDATION_EXPORT NSString *const Mine_Score_List;
FOUNDATION_EXPORT NSString *const Mine_Score_UseHistory;
FOUNDATION_EXPORT NSString *const Mine_Upload_Portrait;
FOUNDATION_EXPORT NSString *const Mine_Get_Userinfo;
FOUNDATION_EXPORT NSString *const Mine_Edit_Userinfo;
FOUNDATION_EXPORT NSString *const Mine_User_PayRecord;
FOUNDATION_EXPORT NSString *const Mine_APP_Info;
FOUNDATION_EXPORT NSString *const Mine_Invite_Friends;
FOUNDATION_EXPORT NSString *const Mine_Address_List;
FOUNDATION_EXPORT NSString *const Mine_Address_Add;
FOUNDATION_EXPORT NSString *const Mine_Address_Delete;
FOUNDATION_EXPORT NSString *const Mine_Address_Update;
FOUNDATION_EXPORT NSString *const Mine_Address_SetDefault;

// Login
FOUNDATION_EXPORT NSString *const Login_Get_SMSCode;
FOUNDATION_EXPORT NSString *const Login_By_TelePhone;

// Home
FOUNDATION_EXPORT NSString *const SupplierList_Latalongi;
FOUNDATION_EXPORT NSString *const SupplierDetail_ID;
FOUNDATION_EXPORT NSString *const Home_Region_List;
FOUNDATION_EXPORT NSString *const Home_Search_StoreList;
FOUNDATION_EXPORT NSString *const Home_Filter_ZoneList;

@end
