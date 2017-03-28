//
//  WL_AddressBook_FollowCompany_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_AddressBook_FollowCompanys_Model : WL_BaseModel
/** 公司id */
@property(nonatomic, copy) NSString *company_id;
/** 公司logo */
@property(nonatomic, copy) NSString *company_logo;
/** 是否已关注 */
@property(nonatomic, copy) NSString *isFollow;
/** 企业名称 */
@property(nonatomic, copy) NSString *company_name;

@end
