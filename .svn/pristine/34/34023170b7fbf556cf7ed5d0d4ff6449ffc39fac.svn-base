//
//  WL_Application_Driver_Bill_Statistics_TopView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_Statistics_TopView.h"

@implementation WL_Application_Driver_Bill_Statistics_TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToBillStatisticsTopView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToBillStatisticsTopView
{
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(10));
    lineLabel.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    [self addSubview:lineLabel];
    
    UILabel * RightTitle = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(20), ScaleW(150), ScaleH(20))];
    RightTitle.text = @"整体收入情况";
    RightTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:RightTitle];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.frame = CGRectMake(0, ScaleH(50), ScreenWidth, ScaleH(0.5));
    lineLabel2.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [self addSubview:lineLabel2];
    
    //标题Lable
    UILabel *titleLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:titleLable];
    //添加约束
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(lineLabel2.mas_bottom).offset(18 * AUTO_IPHONE6_HEIGHT_667);
    }];
    //设置属性
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    titleLable.textColor = [WLTools stringToColor:@"#929292"];
    titleLable.text = @"总收入 (元)";
    
    
    //金额Lable
    UILabel *totalIncomeLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:totalIncomeLable];
    //添加约束
    [totalIncomeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleLable.mas_centerX);
        make.top.equalTo(titleLable.mas_bottom).offset(18 * AUTO_IPHONE6_HEIGHT_667);
    }];
    //设置属性
    totalIncomeLable.textAlignment = NSTextAlignmentCenter;
    totalIncomeLable.textColor = titleLable.textColor;
    self.totalIncomeLable = totalIncomeLable;
    titleLable.font = WLFontSize(18);
    totalIncomeLable.font = WLFontSize(35);
}

@end
