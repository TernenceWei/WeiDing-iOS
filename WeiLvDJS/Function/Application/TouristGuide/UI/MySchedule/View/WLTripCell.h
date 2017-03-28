//
//  WLTripCell.h
//  WeiLvDJS
//
//  Created by xiaobai2268 on 2016/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLOrderListInfo.h"

@interface WLTripCell : UITableViewCell

@property(nonatomic,strong)UIImageView *dateImage;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UIButton *startButton;

@property (nonatomic, strong) UILabel * mainRedLabel;  // 主

@property (nonatomic, strong) UILabel * howCustomerLabel;   //散客

@property (nonatomic, strong) UILabel * howCourierLabel;   //3导

@property (nonatomic, strong) UILabel * howCourierFeeLabel;   //导服费

@property(nonatomic,strong)UILabel *orderNumber;

//@property(nonatomic,strong)UILabel *startCity;

//@property(nonatomic,strong)UILabel *endCity;

@property(nonatomic,strong)UIImageView *arrowImage;

@property(nonatomic,strong)UILabel *personNumber;

@property(nonatomic,strong)UILabel *startTimee;

@property(nonatomic,strong)UILabel *endTime;

@property(nonatomic,strong)UILabel *company;

@property(nonatomic,strong) WLOrderListInfo *orderModel;

@property(nonatomic,strong) WLOrderListInfo *orderMod;

@end
