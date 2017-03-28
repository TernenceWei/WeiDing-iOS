//
//  WL_AddressBook_Organization_Title_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_AddressBook_Organization_Department_Model;
@interface WL_AddressBook_Organization_Title_Model : WL_BaseModel

/** 上级组织数组 */
@property(nonatomic, strong) NSArray<WL_AddressBook_Organization_Department_Model *> *departmentList;

@end
