//
//  WL_PromptToStatistics_AlertView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/3.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_PromptToStatistics_AlertView.h"

@implementation WL_PromptToStatistics_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildViewToPromptTpStatistics];
    }
    return self;
}

- (void)setupChildViewToPromptTpStatistics
{
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(328);
        make.left.equalTo(self.mas_left).offset(48 * AUTO_IPHONE6_WIDTH_375);
        make.right.equalTo(self.mas_right).offset(-48 * AUTO_IPHONE6_WIDTH_375);
        make.height.mas_equalTo(162 * AUTO_IPHONE6_HEIGHT_667);
    }];
    contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    UILabel *titleLable = [[UILabel alloc] init];
    [contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(30 * AUTO_IPHONE6_HEIGHT_667);
        make.centerX.equalTo(contentView.mas_centerX);
        make.left.equalTo(contentView.mas_left).offset(20 * AUTO_IPHONE6_WIDTH_375);
        make.right.equalTo(contentView.mas_right).offset(-20 * AUTO_IPHONE6_WIDTH_375);
    }];
    
    //分隔线
    UIView *lineView = [[UIView alloc] init];
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(14 * AUTO_IPHONE6_WIDTH_375);
        make.right.equalTo(contentView.mas_right).offset(-14 * AUTO_IPHONE6_WIDTH_375);
        make.height.equalTo(@0.5);
        make.top.equalTo(titleLable.mas_bottom).offset(18 * AUTO_IPHONE6_HEIGHT_667);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#b7b7b7"];
    
    //确定按钮
    UIButton *defineButton = [[UIButton alloc] init];
    [contentView addSubview:defineButton];
    [defineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView.mas_centerX);
        make.height.mas_equalTo(52 * AUTO_IPHONE6_HEIGHT_667);
        make.top.equalTo(lineView.mas_bottom);
    }];
//    self.defineButton = defineButton;
    
    
    
    
    
}

@end
