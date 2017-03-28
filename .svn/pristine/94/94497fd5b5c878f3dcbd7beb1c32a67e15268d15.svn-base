//
//  WL_Application_Driver_Bill_Statistics_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_Application_Driver_Bill_Statistics_Price_Model;
@class WL_Application_Driver_Bill_Statistics_Company_Model;
@class WL_Application_Driver_Bill_Statistics_Bill_Model;

@interface WL_Application_Driver_Bill_Statistics_Model : WL_BaseModel
/** 统计已结算订单金额*/
@property(nonatomic, copy) NSString *price;
/** 公司数组 */
@property(nonatomic, strong) NSArray<WL_Application_Driver_Bill_Statistics_Company_Model *> *all_percent;
/**月份数组 */
@property(nonatomic, strong) NSArray<WL_Application_Driver_Bill_Statistics_Bill_Model *> *all_mon;
/** 年份 */
@property(nonatomic, copy) NSString *year;
@end
