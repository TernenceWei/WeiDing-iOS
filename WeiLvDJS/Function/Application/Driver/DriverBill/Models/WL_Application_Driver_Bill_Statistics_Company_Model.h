//
//  WL_Application_Driver_Bill_Statistics_Company_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Driver_Bill_Statistics_Company_Model : WL_BaseModel

/** 公司id */
@property(nonatomic ,copy) NSString *company_id;
/** 公司名称 */
@property(nonatomic ,copy) NSString *company_name;
/** 百分比 */
@property(nonatomic ,copy) NSString *percent;
/** 该车队的订单金额 */
@property(nonatomic ,copy) NSString *aam;
@end
