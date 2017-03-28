//
//  WL_Application_Driver_BillList_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"
@class WL_Application_Driver_Bill_Model;
@class WL_Application_Driver_Bill_Month_Model;
@class WL_Application_Driver_Bill_Company_Model;

@interface WL_Application_Driver_BillList_Model : WL_BaseModel
/** 订单信息数组 */
@property(nonatomic, strong) NSMutableArray<WL_Application_Driver_Bill_Model *> *data;
/** 月份数组 */
@property(nonatomic, strong) NSMutableArray<WL_Application_Driver_Bill_Month_Model *> *months;
/** 公司数组 */
@property(nonatomic, strong) NSMutableArray<WL_Application_Driver_Bill_Company_Model *> *companys;

@end
