//
//  WL_Network_Model.h
//  WeiLv
//
//  Created by James on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WL_BaseModel.h"

@interface WL_Network_Model<ObjectType> : WL_BaseModel

@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,assign)NSInteger total;
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,strong)ObjectType data;
@property(nonatomic,strong)NSString *result;
/** 总页面数 */
@property(nonatomic, copy)NSString *count_page;
/** 当前页码数 */
@property(nonatomic, copy)NSString *page;
/** 统计好友请求个数 */
@property(nonatomic, copy)NSString *num;

@end
