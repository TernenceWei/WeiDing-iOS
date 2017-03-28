//
//  WL_Settlement_ViewController.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  结算中心

#import "WL_BaseViewController.h"

@interface WL_Settlement_ViewController : WL_BaseViewController

@property(nonatomic,copy)NSString *sj_order_id;

@property(nonatomic,copy)void (^popBlock)(NSString *sj_order_id);

@end
