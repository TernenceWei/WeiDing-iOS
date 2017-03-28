//
//  WL_Trip_Cell.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  应用 －－ 我的日程－－行程的cell

#import <UIKit/UIKit.h>

#import "WL_Trip_OrderModel.h"

#import "WL_Trip_ScheduleModel.h"

#import "WL_Application_Driver_OrderDetail_Guide_Model.h"

#import "WL_Application_Driver_OrderDetail_Dispatcher_Model.h"

@interface WL_Trip_Cell : UITableViewCell

@property(nonatomic,strong)UIImageView *dateImage;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UIButton *startButton;

@property(nonatomic,strong)UILabel *orderNumber;

@property(nonatomic,strong)UILabel *startCity;

@property(nonatomic,strong)UILabel *endCity;

@property(nonatomic,strong)UIImageView *arrowImage;

@property(nonatomic,strong)UILabel *personNumber;

@property(nonatomic,strong)UILabel *startTime;

@property(nonatomic,strong)UILabel *endTime;

@property(nonatomic,strong)UILabel *company;

@property(nonatomic,strong)UIButton *concactService;

@property(nonatomic,strong)UIButton *concactTour;

@property(nonatomic,strong)WL_Trip_OrderModel *orderModel;

@property(nonatomic,strong)WL_Trip_ScheduleModel *scheduleModel;

@property(nonatomic,strong)WL_Trip_OrderModel *orderMod;

@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Dispatcher_Model *dispatcher_Model;

@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Guide_Model *guide_Model;

@end
