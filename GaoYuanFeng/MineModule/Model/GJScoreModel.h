//
//  GJScoreModel.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/3.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJScoreModelList : GJBaseModel
@property (nonatomic, strong) NSString *beizhu;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *credits;
@property (nonatomic, strong) NSString *log_type;
@property (nonatomic, strong) NSString *order_id;
@end

@interface GJScoreModel : GJBaseModel
@property (nonatomic, strong) NSString *user_credits;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int current_page;
@property (nonatomic, assign) int total_pages;
@property (nonatomic, strong) NSArray <GJScoreModelList *> *data;
@end

