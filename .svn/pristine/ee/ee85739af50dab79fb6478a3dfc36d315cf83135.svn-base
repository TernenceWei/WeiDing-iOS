//
//  WL_Application_Driver_Bill_StatustucsBottom_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_StatisticsBottom_View.h"


@implementation WL_Application_Driver_Bill_StatisticsBottom_View




- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToBillStatucsBottomView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToBillStatucsBottomView
{
    //顶部间隔View
    UIView *intervalView = [[UIView alloc] init];
    //添加到父控件
    [self addSubview:intervalView];
    //添加约束
    [intervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@12);
    }];
    //设置属性
    intervalView.backgroundColor = [WLTools stringToColor:@"#f0f3f5"];
    
    UILabel *lineLabel3 = [[UILabel alloc] init];
    lineLabel3.frame = CGRectMake(ScaleW(10), ScaleH(20), ScreenWidth, ScaleH(15));
    lineLabel3.text = @"收益趋势";
    //lineLabel3.textColor = [UIColor redColor];
    lineLabel3.textAlignment = NSTextAlignmentLeft;
    [self addSubview:lineLabel3];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.frame = CGRectMake(0, ScaleH(45), ScreenWidth, ScaleH(0.5));
    lineLabel2.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [self addSubview:lineLabel2];
}

@end
