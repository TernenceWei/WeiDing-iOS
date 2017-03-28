//
//  WL_Driver_CertificationStatus_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Driver_CertificationStatus_Model : WL_BaseModel
/** 司机认证状态 */
@property(nonatomic, copy) NSString *driverStatus;
/** 车辆认证状态 */
@property(nonatomic, copy) NSString *carStatus;
/** 待接单数量 */
@property(nonatomic, copy) NSString *countOrder;
@end
