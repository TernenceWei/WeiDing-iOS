//
//  WL_Copmany_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_Depratment_Model;
@class WL_Rganization_Model;
@class WL_Application_Role_Model;
@interface WL_Copmany_Model : NSObject
/** 公司认证状态 */
//@property(nonatomic, copy) NSString *audit_status;
///** 公司Logo */
//@property(nonatomic, copy) NSString *company_logo;
//
///** 公司员工数 */
//@property(nonatomic, copy) NSString *count;
///** 所在部门 */
//@property(nonatomic, strong) WL_Depratment_Model *department;
///** 组织架构 */
//@property(nonatomic, strong) WL_Rganization_Model *rganization;
///** 导游公司id */
//@property(nonatomic, copy) NSString *user_company_id;

///**************新版分隔线************
/** 公司id */
@property(nonatomic, copy) NSString *company_id;
/** 公司名称 */
@property(nonatomic, copy) NSString *company_name;
/**< 公司logo地址 */
@property (nonatomic, copy) NSString *logo_url;
/** 角色数组 */
@property(nonatomic, strong) NSArray *role;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
