//
//  WL_Application_Driver_Bill_TableHeaderView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_TableHeaderView.h"

@implementation WL_Application_Driver_Bill_TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupContentViewToBillTableHeaderView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupContentViewToBillTableHeaderView
{
    //添加Lable
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    //设置属性
    titleLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.font = WLFontSize(13);
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12.5);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.titleLable = titleLable;
    
    //指示器Button
    UIButton *indicatorButton = [[UIButton alloc] init];
    [self addSubview:indicatorButton];
    //设置属性
    [indicatorButton setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
    [indicatorButton setImage:[UIImage imageNamed:@"xiangshang"] forState:UIControlStateSelected];
    
    //添加约束
    [indicatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-12.5);
        make.centerY.equalTo(titleLable.mas_centerY);
        make.left.equalTo(self.mas_left);
    }];
    [indicatorButton setImageEdgeInsets:UIEdgeInsetsMake(0, 345 * AUTO_IPHONE6_WIDTH_375, 0, 0)];
    self.indicatorButton = indicatorButton;
    
    
    //剩余金额Lable
    UILabel *balanceLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:balanceLable];
    //设置属性
    balanceLable.font = titleLable.font;
    balanceLable.textColor = [WLTools stringToColor:@"#ff5b3d"];
    balanceLable.textAlignment = NSTextAlignmentLeft;
    //添加约束
    [balanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-37);
        make.centerY.equalTo(titleLable.mas_centerY);
    }];
    self.balanceLable = balanceLable;
    
    //添加剩余金额TitleLable
    UILabel *balanceTitleLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:balanceTitleLable];
    //设置属性
    balanceTitleLable.textAlignment = NSTextAlignmentLeft;
    balanceTitleLable.textColor = titleLable.textColor;
    balanceTitleLable.font = titleLable.font;
    balanceTitleLable.text = @"剩余应收：";
    self.balanceTitleLable = balanceTitleLable;
    //添加约束
    [balanceTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(balanceLable.mas_left);
        make.centerY.equalTo(titleLable.mas_centerY);
    }];
    
    //分隔线
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
   //设置属性
    lineView.backgroundColor = [WLTools stringToColor:@"#dce0e8"];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    self.lineView = lineView;
    
}

@end
