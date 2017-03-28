//
//  WL_OrderDetail_ViewController.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  日程详情

#import "WL_BaseViewController.h"

#import "WL_Trip_OrderModel.h"
@interface WL_OrderDetail_ViewController : WL_BaseViewController


@property(nonatomic,strong)WL_Trip_OrderModel *model;

@property(nonatomic,assign)NSTimeInterval timeInterval;


@property(nonatomic,copy)void (^popReloadBlock)();


@end
