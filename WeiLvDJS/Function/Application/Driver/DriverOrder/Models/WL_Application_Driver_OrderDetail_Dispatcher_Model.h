//
//  WL_Application_Driver_OrderDetail_Dispatcher_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Driver_OrderDetail_Dispatcher_Model : WL_BaseModel
/** 计调 id */
@property(nonatomic, copy) NSString *user_id;
/** 计调电话 */
@property(nonatomic, copy) NSString *user_mobile;
/** 计调名称 */
@property(nonatomic, copy) NSString *staff_name;
@end
