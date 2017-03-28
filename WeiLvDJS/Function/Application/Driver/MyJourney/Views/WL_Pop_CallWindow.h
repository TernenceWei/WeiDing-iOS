//
//  WL_Pop_CallWindow.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"
#import "WL_Application_Driver_OrderDetail_Guide_Model.h"
#import "WL_Application_Driver_OrderDetail_Dispatcher_Model.h"
@interface WL_Pop_CallWindow : WL_BaseView

@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Guide_Model *guide_Model;


@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Dispatcher_Model *dispatcher_Model;

@property(nonatomic,assign)BOOL isTour;
@end
