//
//  WL_AddressBook_LinkMan_Company_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_AddressBook_LinkMan_Department_Model;

@interface WL_AddressBook_LinkMan_Company_Model : WL_BaseModel
/**
 "company_id" = 1;
 "company_name" = tianles008;
 department =                 (
 {
 "company_id" = 1;
 "company_logo" = "";
 "department_id" = 1;
 "department_name" = "\U7f51\U7edc\U90e8";
 }
    );
 "department_id" = 1;
 "position_name" = "\U8fd0\U7ef4";
 
 */
/** 公司id */
@property(nonatomic, copy) NSString *company_id;
/** 公司名称 */
@property(nonatomic, copy) NSString *company_name;
/** 部门id */
@property(nonatomic, copy) NSString *department_id;
/** 职位名称 */
@property(nonatomic, copy) NSString *position_name;
/** 部门数组 */
@property(nonatomic, strong) NSArray<WL_AddressBook_LinkMan_Department_Model *> *department;
@end
