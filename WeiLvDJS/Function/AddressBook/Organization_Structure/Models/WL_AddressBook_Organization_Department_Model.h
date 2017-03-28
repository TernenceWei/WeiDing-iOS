//
//  WL_AddressBook_Organization_Department_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_AddressBook_Organization_Department_Model : WL_BaseModel
//"company_id" = 1;
//"company_logo" = "";
//"department_id" = 1;
//"department_name" = "\U7f51\U7edc\U90e8";
//"total_son_department" = 3;
//"total_staff" = 9;

/** 公司id */
@property(nonatomic, copy) NSString *company_id;

/** 公司logo */
@property(nonatomic, copy) NSString *company_logo;

/** 部门id */
@property(nonatomic, copy) NSString *department_id;
/** 部门名称 */
@property(nonatomic, copy) NSString *department_name;

/** 下边还有几个子部门 */
@property(nonatomic, copy) NSString *total_son_department;
/** 部门下有多少员工 */
@property(nonatomic, copy) NSString *total_staff;
@end
