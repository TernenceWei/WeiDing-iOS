//
//  WL_Application_Driver_OrderDetail_Guide_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Driver_OrderDetail_Guide_Model : WL_BaseModel

/** 导游电话 */
@property(nonatomic, copy) NSString *mobile;
/** 导游名称 */
@property(nonatomic, copy) NSString *staff_name;
@end
