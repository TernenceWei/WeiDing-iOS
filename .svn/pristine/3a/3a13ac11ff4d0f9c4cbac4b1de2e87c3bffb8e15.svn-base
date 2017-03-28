//
//  WL_Application_Driver_Bill_NavTitle_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_NavTitle_View.h"

@implementation WL_Application_Driver_Bill_NavTitle_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToDriverOrderInNavTitle];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToDriverOrderInNavTitle
{
    //1.底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    //设置背景颜色
    indicatorView.backgroundColor = [UIColor orangeColor];
    //设置高度
    indicatorView.height = 2;
    //设置指示器的y值
    indicatorView.y = self.height - indicatorView.height;
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    NSArray *titles = @[@"结算中", @"已结清"];
    CGFloat width = self.width / titles.count;
    CGFloat height = self.height;
    //待接单按钮
    UIButton *settlementButton = [[UIButton alloc] init];
    settlementButton.height = height;
    settlementButton.width = width;
    settlementButton.x = 0;
    [settlementButton setTitle:titles[0] forState:UIControlStateNormal];
    [settlementButton setTitleColor:WLColor(255, 255, 255, 0.5) forState:UIControlStateNormal];
    [settlementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    settlementButton.titleLabel.font = WLFontSize(17);
    [self addSubview:settlementButton];
    self.settlementButton = settlementButton;
    
    
    //默认点击了待接单按钮
    settlementButton.enabled = NO;
    self.selectedButton = settlementButton;
    // 让按钮内部的label根据文字内容来计算尺寸
    [settlementButton.titleLabel sizeToFit];
    self.indicatorView.width = settlementButton.titleLabel.width;
    self.indicatorView.centerX = settlementButton.centerX;
    
    // 已接单按钮
    UIButton *unSettlementButton = [[UIButton alloc] init];
    unSettlementButton.height = height;
    unSettlementButton.width = width;
    unSettlementButton.x = width;
    [unSettlementButton setTitle:titles[1] forState:UIControlStateNormal];
    [unSettlementButton setTitleColor:WLColor(255, 255, 255, 0.5) forState:UIControlStateNormal];
    [unSettlementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    unSettlementButton.titleLabel.font = WLFontSize(17);
    [self addSubview:unSettlementButton];
    self.unSettlementButton = unSettlementButton;
    
    
}

@end
