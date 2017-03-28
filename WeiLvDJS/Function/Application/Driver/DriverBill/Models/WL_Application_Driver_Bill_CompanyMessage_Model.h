//
//  WL_Application_Driver_Bill_CompanyMessage_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Driver_Bill_CompanyMessage_Model : WL_BaseModel

/**
 "admin_mobile" = 18129802552;
 "company_id" = 2;
 "company_name" = "\U4e00\U53ea\U732a\U79d1\U6280\U6709\U9650\U516c\U53f8";
 
 */
/** 车队联系电话 */
@property(nonatomic, copy) NSString *admin_mobile;
/** 车队id */
@property(nonatomic, copy) NSString *company_id;
/** 车队名称 */
@property(nonatomic, copy) NSString *company_name;
@end
