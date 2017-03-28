//
//  WL_AddressBook_OrganizationDetail_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_AddressBook_OrganizationDetail_Business_Model;

@interface WL_AddressBook_OrganizationDetail_Model : WL_BaseModel
/** 公司地址 */
@property(nonatomic, copy) NSString *address;

/** <#type#> */
@property(nonatomic, copy) NSString *admin_id;

/** <#type#> */
@property(nonatomic, copy) NSString *admin_mobile;

/** <#type#> */
@property(nonatomic, copy) NSString *admin_realname;

/** <#type#> */
@property(nonatomic, copy) NSString *audit_date;

/** <#type#> */
@property(nonatomic, copy) NSString *audit_remark;

/** 认证状态 0, 1, 2, 3 */
@property(nonatomic, copy) NSString *audit_status;

/** <#type#> */
@property(nonatomic, copy) NSString *auditor_id;

/** <#type#> */
@property(nonatomic, copy) NSString *b_business_license;

/** <#type#> */
@property(nonatomic, copy) NSString *b_company_address;

/** <#type#> */
@property(nonatomic, copy) NSString *b_company_status;

/** <#type#> */
@property(nonatomic, copy) NSString *b_legal_person;

/** 企业经营范围 */
@property(nonatomic, copy) NSString *business;

/** <#type#> */
@property(nonatomic, copy) NSString *c_qualified_status;

/** <#type#> */
@property(nonatomic, copy) NSString *city_id;

/** 企业开通的应用 */
@property(nonatomic, strong) NSArray<WL_AddressBook_OrganizationDetail_Business_Model *> *companyApp;

/** <#type#> */
@property(nonatomic, copy) NSString *company_account_id;

/** 公司id */
@property(nonatomic, copy) NSString *company_id;

/** 公司logo */
@property(nonatomic, copy) NSString *company_logo;

/** 公司名称 */
@property(nonatomic, copy) NSString *company_name;

/** <#type#> */
@property(nonatomic, copy) NSString *company_name_py;

/** <#type#> */
@property(nonatomic, copy) NSString *create_date;

/** 联系方式 */
@property(nonatomic, copy) NSString *customer_phone;

/** 企业介绍 */
@property(nonatomic, copy) NSString *description_content;

/** 是否关注 */
@property(nonatomic, copy) NSString *isFollow;

/** <#type#> */
@property(nonatomic, copy) NSString *is_delete;

/** <#type#> */
@property(nonatomic, copy) NSString *issuing_authority;

/** <#type#> */
@property(nonatomic, copy) NSString *province_id;

/** <#type#> */
@property(nonatomic, copy) NSString *relation_user_id;

/** <#type#> */
@property(nonatomic, copy) NSString *update_date;

/** <#type#> */
@property(nonatomic, copy) NSString *website;

@property(nonatomic, assign) CGFloat cellHeight;

@end
