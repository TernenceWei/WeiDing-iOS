//
//  WL_Application_Driver_Pricelist_Model.h
//  WeiLvDJS
//
//  Created by liuxin on 16/10/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Driver_Pricelist_Model : WL_BaseModel
@property (nonatomic,copy) NSString *pricelist_name;
@property (nonatomic,copy) NSString *unit;
@property (nonatomic,copy) NSString *prime_price;
@property (nonatomic,copy) NSString *unit_type;
@end
