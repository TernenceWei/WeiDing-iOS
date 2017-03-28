//
//  WLWriteOffObject.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/4.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLWriteOffObject : NSObject

@property(nonatomic,copy)NSString *time;//时间戳
@property(nonatomic,copy)NSString *prduct_name;//产品名称
@property(nonatomic,copy)NSString *pricelist_name;//价目名称
@property(nonatomic,copy)NSString *order_type;//订单类型
@property(nonatomic,copy)NSString *quantity;//数量

@property(nonatomic,copy)NSString *is_passed_card;//是否一卡通//0 否，1 是
@property(nonatomic,copy)NSString *used_day;//预定使用日期// 可使用的开始日期
@property(nonatomic,copy)NSString *used_end_day;//可用截止日期// 可使用的截止日期
@property(nonatomic,copy)NSString *imgimg;//log图片地址

@end
