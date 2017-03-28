//
//  WL_OrderStatus_View.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_OrderStatus_View.h"

@implementation WL_OrderStatus_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //添加子控件
        [self setupContentToOrderDetailBottomView];
    }
    return self;
}

#pragma mark - 添加子控件
- (void)setupContentToOrderDetailBottomView
{
    //中间订单状态文字Lable
    UILabel *orderStatusLable = [[UILabel alloc] init];
    [self addSubview:orderStatusLable];
    //设置属性
    orderStatusLable.text = @"订单状态";
    
    orderStatusLable.font =WLFontSize(15);

    orderStatusLable.textAlignment =NSTextAlignmentCenter;
    
    orderStatusLable.textColor = [WLTools stringToColor:@"#868686"];
    
    [orderStatusLable setFrame:CGRectMake((ScreenWidth-80)/2, 30, 80, 16)];

    //左侧分隔线
    UIView *leftLineView = [[UIView alloc] init];
    
    [self addSubview:leftLineView];
    
    leftLineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    
    [leftLineView setFrame:CGRectMake(30, ViewY(orderStatusLable)+7.5,ViewX(orderStatusLable)-30-14, 0.5)];
   
    
    //右侧分隔线
    UIView *rightLineView = [[UIView alloc] init];
    
    [self addSubview:rightLineView];
    
    rightLineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    
    [rightLineView setFrame:CGRectMake(ViewRight(orderStatusLable)+14, ViewY(leftLineView), ViewWidth(leftLineView), 0.5)];
    
    //接单状态Lable
    UILabel *acceptStatusLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:acceptStatusLable];
    //设置属性
    acceptStatusLable.textColor = [WLTools stringToColor:@"#868686"];
    
    acceptStatusLable.text = @"接单状态";
    
    acceptStatusLable.font =WLFontSize(15);
    
    acceptStatusLable.textAlignment =NSTextAlignmentLeft;
    
    [acceptStatusLable setFrame:CGRectMake(18, ViewBelow(orderStatusLable)+25, ScreenWidth-18-10, 16)];
   
    self.acceptStatusLable = acceptStatusLable;
    
    
    self.tripCondition = [UILabel new];
    
    self.tripCondition.textColor = [WLTools stringToColor:@"#868686"];
    
    self.tripCondition.text = @"行程状态";
    
    self.tripCondition.font =WLFontSize(15);
    
    self.tripCondition.textAlignment =NSTextAlignmentLeft;

    [self.tripCondition setFrame:CGRectMake(ViewX(acceptStatusLable), ViewBelow(acceptStatusLable)+10, ViewWidth(acceptStatusLable),ViewHeight(acceptStatusLable))];
   
    
    [self addSubview:self.tripCondition];
    
    self.payStatus =[UILabel new];

    self.payStatus.textColor = [WLTools stringToColor:@"#868686"];
    
    self.payStatus.text = @"支付状态";
    
    self.payStatus.font =WLFontSize(15);
    
    self.payStatus.textAlignment =NSTextAlignmentLeft;
    
    [self.payStatus setFrame:CGRectMake(ViewX(acceptStatusLable), ViewBelow(self.tripCondition)+10, ViewWidth(acceptStatusLable),ViewHeight(acceptStatusLable))];
    
    [self addSubview:self.payStatus];

    self.sendOrderTime =[UILabel new];
    
    self.sendOrderTime.textColor = [WLTools stringToColor:@"#868686"];
    
    self.sendOrderTime.text = @"派单时间";
    
    self.sendOrderTime.font =WLFontSize(15);
    
    self.sendOrderTime.textAlignment =NSTextAlignmentLeft;
    
    [self.sendOrderTime setFrame:CGRectMake(ViewX(acceptStatusLable), ViewBelow(self.payStatus)+10, ViewWidth(acceptStatusLable),ViewHeight(acceptStatusLable))];

    [self addSubview:self.sendOrderTime];
    
    //派单时间Lable
    UILabel *timeLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:timeLable];
    //设置属性
    timeLable.textColor = acceptStatusLable.textColor;
    
    timeLable.text = @"接单时间";
    
    timeLable.font =WLFontSize(15);
    
    timeLable.textAlignment =NSTextAlignmentLeft;
    
    [timeLable setFrame:CGRectMake(ViewX(acceptStatusLable), ViewBelow(self.sendOrderTime)+10, ViewWidth(acceptStatusLable), ViewHeight(acceptStatusLable))];
    
    
    self.receiveOrderTime = timeLable;
    
    
}


@end
