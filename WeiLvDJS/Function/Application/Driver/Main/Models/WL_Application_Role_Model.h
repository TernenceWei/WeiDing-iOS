//
//  WL_Application_Role_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Role_Model : NSObject
/////** 公司id */
//@property(nonatomic, copy) NSString *company_id;
///** 角色id */
//@property(nonatomic, copy) NSString *group_id;
///** 角色名称 */
//@property(nonatomic, copy) NSString *group_name;
///** 1:导游 2: 司机 */
//@property(nonatomic, copy) NSString *group_type;
///** 1:内置角色 2:企业自定义添加角色 */
//@property(nonatomic, copy) NSString *is_system;
///** 用户id */
//@property(nonatomic, copy) NSString *user_id;

//*****分隔线****
/** 类别 */
@property(nonatomic,copy)NSString *type;
//角色名称
@property(nonatomic,copy)NSString *role_name;
//店铺地址
@property(nonatomic, copy) NSString *store_url;

@end
