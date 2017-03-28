//
//  WL_Depratment_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Depratment_Model : WL_BaseModel

/** 所在部门名称 */
@property(nonatomic, copy) NSString *department_name;

/** 所在部门id */
@property(nonatomic, copy) NSString *parent_id;

@end
