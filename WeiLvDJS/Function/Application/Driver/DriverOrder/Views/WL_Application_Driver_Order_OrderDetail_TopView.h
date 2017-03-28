//
//  WL_Application_Driver_Order_OrderDetail_TopView.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_Application_Driver_Order_OrderDetail_TopView : WL_BaseView
/** 行程数 */
@property(nonatomic, weak) UILabel *mileageLable;
/** 出发城市Lable */
@property(nonatomic, weak) UILabel *fromCityLable;
/** 到达城市Lable */
@property(nonatomic, weak) UILabel *endCityLable;
/** 出发日期Lable */
@property(nonatomic, weak) UILabel *startTimeLable;
/** 结束日期Lable */
@property(nonatomic, weak) UILabel *endTimeLable;
/** 总人数Lable */
@property(nonatomic, weak) UILabel *personCountLable;
/** 出发地点Lable */
@property(nonatomic, weak) UILabel *startAddressLable;
/** 出发时间Lable */
@property(nonatomic, weak) UILabel *beginTimeLable;
/** 结束地点Lable */
@property(nonatomic, weak) UILabel *endAddressLable;
/** 结束时间Lable */
@property(nonatomic, weak) UILabel *arriveTimeLable;
@end
