//
//  WL_CompanyList_Model.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface department :  WL_BaseModel

@property(nonatomic,copy)NSString *department_name;

@property(nonatomic,copy)NSString *parent_id;

@end

@interface rganization :  WL_BaseModel

@property(nonatomic,copy)NSString *parent_id;

@property(nonatomic,copy)NSString *rganization_name;

@end

@interface roleModel :  WL_BaseModel

@property(nonatomic,copy)NSString *company_id;

@property(nonatomic,copy)NSString *group_id;

@property(nonatomic,copy)NSString *group_name;

@property(nonatomic,copy)NSString *group_type;

@property(nonatomic,copy)NSString *is_system;

@property(nonatomic,copy)NSString *user_id;

@end


@interface WL_CompanyList_Model : WL_BaseModel

@property(nonatomic,copy)NSString *audit_status;

@property(nonatomic,copy)NSString *company_id;

@property(nonatomic,copy)NSString *company_logo;

@property(nonatomic,copy)NSString *company_name;

@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,copy)NSString *count;

@property(nonatomic,strong)department *departmentModel;

@property(nonatomic,strong)rganization *rganizationModel;

@property(nonatomic,strong)NSArray *role;

@end

