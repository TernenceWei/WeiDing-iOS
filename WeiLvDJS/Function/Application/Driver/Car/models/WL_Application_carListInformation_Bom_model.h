//
//  WL_Application_carListInformation_Bom_model.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_carListInformation_Bom_model : WL_BaseModel
@property (nonatomic,copy) NSString *company_id;
@property (nonatomic,copy) NSString *company_name;
@property (nonatomic,copy) NSString *reason;
@property (nonatomic,copy) NSString *status;
@property(nonatomic,assign)BOOL addId;
@end
