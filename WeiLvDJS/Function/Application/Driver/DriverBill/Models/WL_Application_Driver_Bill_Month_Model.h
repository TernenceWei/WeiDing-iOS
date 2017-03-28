//
//  WL_Application_Driver_Bill_Month_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_Application_Driver_Bill_Model;

@interface WL_Application_Driver_Bill_Month_Model : WL_BaseModel
/** 月份 */
@property(nonatomic, copy) NSString *month;
/** 每个月的未收款项余额 */
@property(nonatomic, copy) NSString *ys;
/** 每个月的已收款项总和 */
@property(nonatomic, copy) NSString *jl;
/** 本月账单模型数组 */
@property(nonatomic, strong)NSMutableArray <WL_Application_Driver_Bill_Model *> *data;
@end
