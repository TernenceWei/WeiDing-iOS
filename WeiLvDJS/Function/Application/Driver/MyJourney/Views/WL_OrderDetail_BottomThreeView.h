//
//  WL_OrderDetail_BottomThreeView.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//



#import "WL_BaseView.h"

typedef NS_ENUM(NSInteger, ClickType)
{
    //以下是枚举成员
    ClickTourOperator = 0,//计调
    ClickTourGuide,//导游
    ClickReminderButton,//出发，结束等
   
};

@interface WL_OrderDetail_BottomThreeView : WL_BaseView

@property(nonatomic,strong)UIButton *statusButton;

@property(nonatomic,strong)UIButton *tourGuideButton;

@property(nonatomic,strong)UIButton *tourOperatorButton;

@property(nonatomic,copy)void(^buttonClick)(ClickType type);

@end
