//
//  WL_Application_Driver_Order_OrderDetail_NavTitleView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Order_OrderDetail_NavTitleView.h"

@implementation WL_Application_Driver_Order_OrderDetail_NavTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置子控件
        [self setupContentViewToOrderDetailNavTitleView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupContentViewToOrderDetailNavTitleView
{
    //标题Lable
    UILabel *titleLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:titleLable];
    //设置属性
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = WLFontSize(14);
    titleLable.text = @"距离订单失效还剩";
    titleLable.textColor = [WLTools stringToColor:@"#b7cbfd"];
    //添加约束
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
    }];
    //倒计时Lable
    UILabel *timerLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:timerLable];
    //设置属性
    timerLable.font = WLFontSize(18);
    timerLable.textAlignment = NSTextAlignmentCenter;
    timerLable.textColor = [WLTools stringToColor:@"#ffffff"];
    //添加约束
    [timerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(10);
        make.centerX.equalTo(titleLable.mas_centerX);
    }];
    self.timerLable = timerLable;

}






@end
