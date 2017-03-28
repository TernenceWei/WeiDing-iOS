//
//  WL_AddressBook_Organization_Staff_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_AddressBook_Organization_Staff_Model : WL_BaseModel
//"department_name" = "\U6d4b\U8bd5\U90e8";
//"is_manager" = 0;
//"is_select" = 0;
//photo = "http://dev.nawanr.com/uploads/app/userAdver/20160922151041.png";
//"real_name" = "\U5218\U79c0";
//"user_id" = 66;
//"user_mobile" = 15014600017;

/** 部门名称 */
@property(nonatomic, copy) NSString *department_name;
/** 是否为管理员 */
@property(nonatomic, copy) NSString *is_manager;
/** 是否选中 */
@property(nonatomic, copy) NSString *is_select;
/** 员工头像 */
@property(nonatomic, copy) NSString *photo;
/** 员工姓名 */
@property(nonatomic, copy) NSString *real_name;
/** 员工id */
@property(nonatomic, copy) NSString *user_id;
/** 员工电话 */
@property(nonatomic, copy) NSString *user_mobile;
/** 职位名称 */
@property(nonatomic, copy) NSString *position_name;

@end
