//
//  WL_Friendlist_Model.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Friendlist_Model : WL_BaseModel

@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *photo;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *isCompany;

@end
