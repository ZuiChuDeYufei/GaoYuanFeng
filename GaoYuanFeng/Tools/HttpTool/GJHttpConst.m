//
//  GJHttpConst.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJHttpConst.h"

@implementation GJHttpConst

// Order
NSString *const Order_Payment_Scan = @"api/payForNewOrder";
NSString *const Order_Payment_QueryStatus = @"api/payForStatus";

// Mine
NSString *const Mine_Score_List = @"api/getGoodslist";  // 积分商品列表
NSString *const Mine_Score_UseHistory = @"api/user_credits_log";    //积分记录
NSString *const Mine_Upload_Portrait = @"api/editUserImg";
NSString *const Mine_Get_Userinfo = @"api/getUserInfo";
NSString *const Mine_Edit_Userinfo = @"api/editUserInfo";
NSString *const Mine_User_PayRecord = @"api/user_paymd";
NSString *const Mine_APP_Info = @"api/system_info";
NSString *const Mine_Invite_Friends = @"api/user_yqlist";
NSString *const Mine_Address_List = @"api/userAddressList";
NSString *const Mine_Address_Add = @"api/add_addr";
NSString *const Mine_Address_Delete = @"api/userAddressDel";
NSString *const Mine_Address_Update = @"api/userAddressUpdate";
NSString *const Mine_Address_SetDefault = @"api/userAddressSetDefault";

// Login
NSString *const Login_Get_SMSCode = @"api/getSMSCode";
NSString *const Login_By_TelePhone = @"api/getLogin";

// Home
NSString *const SupplierList_Latalongi = @"api/getSupplierList";
NSString *const SupplierDetail_ID = @"api/getSupplier";
NSString *const Home_Region_List = @"api/getRegionList";
NSString *const Home_Search_StoreList = @"api/shopsearch";
NSString *const Home_Filter_ZoneList = @"api/getZoneList";

@end
