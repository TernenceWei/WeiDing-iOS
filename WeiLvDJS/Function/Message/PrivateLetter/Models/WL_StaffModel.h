//
//  WL_StaffModel.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_StaffModel : WL_BaseModel

@property(nonatomic,copy)NSString *department_name;

@property(nonatomic,copy)NSString *is_manager;

@property(nonatomic,copy)NSString *is_select;

@property(nonatomic,copy)NSString *photo;

@property(nonatomic,copy)NSString *real_name;

@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,copy)NSString *user_mobile;

@end
