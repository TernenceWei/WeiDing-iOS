//
//  WL_Application_Driver_Bill_Statistics_Price_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_Application_Driver_Bill_Statistics_Price_Model : WL_BaseModel
/** 已收款 */
@property(nonatomic ,copy) NSString *cash;
/** 未收款 */
@property(nonatomic ,copy) NSString *nocash;
/** 总收入 */
@property(nonatomic ,copy) NSString *all;
/** 回款率 */
@property(nonatomic ,copy) NSString *percent;
@end
