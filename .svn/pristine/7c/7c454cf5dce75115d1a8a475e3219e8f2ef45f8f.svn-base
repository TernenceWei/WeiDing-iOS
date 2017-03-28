//
//  WL_Application_Driver_Bill_StatisticsDetail_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_StatisticsDetail_View.h"

@implementation WL_Application_Driver_Bill_StatisticsDetail_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToStatisticsDetail];
    }
    return self;
}

- (void)setupChildViewToStatisticsDetail
{
    //已收款按钮
    UIButton *moneyReceiptButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:moneyReceiptButton];
    //添加约束
    [moneyReceiptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(27 * AUTO_IPHONE6_WIDTH_375);
        make.top.equalTo(self.mas_top).offset(15 * AUTO_IPHONE6_HEIGHT_667);
        make.height.equalTo(@(60 * AUTO_IPHONE6_HEIGHT_667));
        make.width.equalTo(@(150 * AUTO_IPHONE6_WIDTH_375));
    }];
    //设置属性
    [moneyReceiptButton setBackgroundColor:[WLTools stringToColor:@"#ff4567"]];
    moneyReceiptButton.layer.cornerRadius = 6.0f;
    moneyReceiptButton.layer.masksToBounds = YES;
    
    //已收款标题Lable
    UILabel *moneyReceiptTitleLable = [[UILabel alloc] init];
    //添加到父控件
    [moneyReceiptButton addSubview:moneyReceiptTitleLable];
    //添加约束
    [moneyReceiptTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(moneyReceiptButton.mas_centerX);
        make.top.equalTo(moneyReceiptButton.mas_top).offset(9 * AUTO_IPHONE6_HEIGHT_667);
    }];
    //设置属性
    moneyReceiptTitleLable.textColor = [WLTools stringToColor:@"#ffffff"];
    moneyReceiptTitleLable.font = WLFontSize(12);
    moneyReceiptTitleLable.textAlignment = NSTextAlignmentCenter;
    moneyReceiptTitleLable.text = @"已收款 (元)";
    
    //已收款金额Lable
    UILabel *moneyReceiptLable = [[UILabel alloc] init];
    //添加到父控件
    [moneyReceiptButton addSubview:moneyReceiptLable];
    //添加约束
    [moneyReceiptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(moneyReceiptTitleLable.mas_centerX);
        make.bottom.equalTo(moneyReceiptButton.mas_bottom).offset(-9 * AUTO_IPHONE6_HEIGHT_667);
    }];
    //设置属性
    moneyReceiptLable.textAlignment = NSTextAlignmentCenter;
    moneyReceiptLable.textColor = moneyReceiptTitleLable.textColor;
    if (IsiPhone4)
    {
        moneyReceiptLable.font = WLFontSize(18);
    }
    else
    {
        moneyReceiptLable.font = WLFontSize(15);
    }
    
    self.moneyReceiptLable = moneyReceiptLable;

    
    
    //未收款按钮
    UIButton *uncollectedButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:uncollectedButton];
    //添加约束
    [uncollectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-27 * AUTO_IPHONE6_WIDTH_375);
        make.top.equalTo(moneyReceiptButton.mas_top);
        make.height.equalTo(moneyReceiptButton.mas_height);
        make.width.equalTo(moneyReceiptButton.mas_width);
    }];
    //设置属性
    [uncollectedButton setBackgroundColor:[WLTools stringToColor:@"#9f52ff"]];
    uncollectedButton.layer.cornerRadius = 6.0f;
    uncollectedButton.layer.masksToBounds = YES;
    
    //已收款标题Lable
    UILabel *uncollectedTitleLable = [[UILabel alloc] init];
    //添加到父控件
    [uncollectedButton addSubview:uncollectedTitleLable];
    //添加约束
    [uncollectedTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(uncollectedButton.mas_centerX);
        make.top.equalTo(uncollectedButton.mas_top).offset(9 * AUTO_IPHONE6_HEIGHT_667);
    }];
    //设置属性
    uncollectedTitleLable.textColor = [WLTools stringToColor:@"#ffffff"];
    uncollectedTitleLable.font = WLFontSize(12);
    uncollectedTitleLable.textAlignment = NSTextAlignmentCenter;
    uncollectedTitleLable.text = @"剩余款额 (元)";
    
    //已收款金额Lable
    UILabel *uncollectedLable = [[UILabel alloc] init];
    //添加到父控件
    [uncollectedButton addSubview:uncollectedLable];
    //添加约束
    [uncollectedLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(uncollectedTitleLable.mas_centerX);
        make.bottom.equalTo(uncollectedButton.mas_bottom).offset(-9 * AUTO_IPHONE6_HEIGHT_667);
    }];
    //设置属性
    uncollectedLable.textAlignment = NSTextAlignmentCenter;
    uncollectedLable.textColor = moneyReceiptTitleLable.textColor;
    if (IsiPhone4)
    {
        uncollectedLable.font = WLFontSize(18);
    }
    else
    {
        uncollectedLable.font = WLFontSize(15);
    }
    
    self.uncollectedLable = uncollectedLable;
    
    
    //分隔线
    UIView *lineView = [[UIView alloc] init];
    //添加到父控件
    [self addSubview:lineView];
    //添加约束
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@0.5);
        make.top.equalTo(uncollectedButton.mas_bottom).offset(15 * AUTO_IPHONE6_HEIGHT_667);
    }];
    //设置属性
    lineView.backgroundColor = [WLTools stringToColor:@"#d4d4d4"];
    
    //回款率Lable
    UILabel *receivableRatioLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:receivableRatioLable];
    //添加约束
    [receivableRatioLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(@(45 * AUTO_IPHONE6_HEIGHT_667));
    }];
    //设置属性
    receivableRatioLable.text = @"回款率   18%";
    receivableRatioLable.textAlignment = NSTextAlignmentCenter;
    receivableRatioLable.font = WLFontSize(14);
    receivableRatioLable.textColor = WLColor(47, 47, 47, 1);
    self.receivableRatioLable = receivableRatioLable;
    
}

@end
