//
//  WL_AddressBook_OrganizationStructure_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_AddressBook_Organization_Staff_Model;
@class WL_AddressBook_Organization_Department_Model;

@interface WL_AddressBook_OrganizationStructure_Model : WL_BaseModel

/** 部门列表 */
@property(nonatomic, strong) NSArray<WL_AddressBook_Organization_Department_Model *> *department_list;

/** 员工列表 */
@property(nonatomic, strong) NSArray<WL_AddressBook_Organization_Staff_Model *> *staff_list;

@end
