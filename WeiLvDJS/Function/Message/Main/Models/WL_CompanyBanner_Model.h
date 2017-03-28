//
//  WL_CompanyBanner_Model.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_CompanyBanner_Model : WL_BaseModel

@property (nonatomic,copy) NSString *create_date;
@property (nonatomic,copy) NSString *digest;
@property (nonatomic,copy) NSString *send_date;
@property (nonatomic,copy) NSString *cover_url;
@property (nonatomic,copy) NSString *company_id;
@property (nonatomic,copy) NSString *update_date;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *creator_id;
@property (nonatomic,copy) NSString *notice_type;
@property (nonatomic,copy) NSString *notice_id;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *content;

@end
