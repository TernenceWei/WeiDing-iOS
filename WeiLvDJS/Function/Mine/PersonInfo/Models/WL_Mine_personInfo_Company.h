//
//  WL_Mine_personInfo_Company.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Mine_personInfo_Company : WL_BaseModel
@property (nonatomic,copy)NSString *company_id;//
@property (nonatomic,copy)NSString *company_name;//
@property (nonatomic,strong)NSMutableArray *department;//
@property (nonatomic,copy)NSString *city_id;//
@property (nonatomic,copy)NSString *position_name;

@property (nonatomic,strong)NSMutableArray *showArr;

@end
