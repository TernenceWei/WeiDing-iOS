//
//  WL_Application_Driver_Bill_Statistics_Bill_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Driver_Bill_Statistics_Bill_Model : WL_BaseModel
/** 月份 */
@property(nonatomic ,copy) NSString *mon;
/** 金额 */
@property(nonatomic ,copy) NSString *amount;
/** 当月账单总和 */
@property(nonatomic ,copy) NSString *year;

@end
