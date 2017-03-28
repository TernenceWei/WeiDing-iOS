//
//  WL_Application_Driver_Bill_Bottom_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_Bottom_View.h"

@implementation WL_Application_Driver_Bill_Bottom_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToDriverBillBottomView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToDriverBillBottomView
{
    //1.添加按照时间排序按钮
    //初始化
    UIButton *timeButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:timeButton];
    //设置属性
    [timeButton setTitle:@"按时间" forState:UIControlStateNormal];
    [timeButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateDisabled];
    [timeButton setTitleColor:[WLTools stringToColor:@"#b5b5b5"] forState:UIControlStateNormal];
    [timeButton setImage:[UIImage imageNamed:@"Driver_Bill_AccordingToTime"] forState:UIControlStateNormal];
    [timeButton setImage:[UIImage imageNamed:@"Driver_Bill_AccordingToTime_Selected"] forState:UIControlStateDisabled];
    [timeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 18, 0)];
    [timeButton setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 30)];
    timeButton.titleLabel.font = WLFontSize(12);
    //添加约束
    [timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@(ScreenWidth / 2));
    }];
    self.timeButton = timeButton;
    
    //2.按车队排序
    //初始化
    UIButton *motorcadeButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:motorcadeButton];
    //设置属性
    [motorcadeButton setTitle:@"按车队" forState:UIControlStateNormal];
    [motorcadeButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateDisabled];
    [motorcadeButton setTitleColor:[WLTools stringToColor:@"#b5b5b5"] forState:UIControlStateNormal];
    [motorcadeButton setImage:[UIImage imageNamed:@"Driver_Bill_AccordingToCompany"] forState:UIControlStateNormal];
    [motorcadeButton setImage:[UIImage imageNamed:@"Driver_Bill_AccordingToCompany_Selected"] forState:UIControlStateDisabled];
    motorcadeButton.titleLabel.font = WLFontSize(12);
    [motorcadeButton setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 30)];
    [motorcadeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 18, 0)];
    //添加约束
    [motorcadeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeButton.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@(ScreenWidth / 2));
    }];
    
    self.motorcadeButton = motorcadeButton;
    

    
}

@end
