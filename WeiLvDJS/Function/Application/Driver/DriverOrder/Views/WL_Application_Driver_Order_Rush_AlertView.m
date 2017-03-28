//
//  WL_Application_Driver_Order_Rush_AlertView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/23.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Order_Rush_AlertView.h"

@interface WL_Application_Driver_Order_Rush_AlertView ()


@end

@implementation WL_Application_Driver_Order_Rush_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupContentViewToRushOrderAlertView];
    }
    return self;
}

#pragma mark - 添加子控件
- (void)setupContentViewToRushOrderAlertView
{
    //添加弹框内容的底部View
    UIView *bottomView = [[UIView alloc] init];
    //添加到父控件
    [self addSubview:bottomView];
    //设置属性
    bottomView.layer.cornerRadius = 5.0f;
    bottomView.layer.masksToBounds = YES;
    bottomView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    //添加约束
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(280 * AUTO_IPHONE6_HEIGHT_667);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(280 * AUTO_IPHONE6_WIDTH_375));
        make.height.equalTo(@(175 * AUTO_IPHONE6_HEIGHT_667));
    }];
    self.bottomView = bottomView;
    //设置内容View的子控件
    [self setupChildViewToBottom];
    
}

#pragma mark - 设置内容View的子控件
- (void)setupChildViewToBottom
{
    //提示Lable
    UILabel *promptLable = [[UILabel alloc] init];
    //添加到父控件
    [self.bottomView addSubview:promptLable];
    //设置属性
    promptLable.textColor = [WLTools stringToColor:@"#4877e7"];
    promptLable.text = @"提示";
    promptLable.font = WLFontSize(16);
    //添加约束
    [promptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(17 * AUTO_IPHONE6_HEIGHT_667);
        make.centerX.equalTo(self.bottomView.mas_centerX);
    }];
    self.promptLable = promptLable;
    
    //提示信息Lable
    UILabel *promptMessageLable = [[UILabel alloc] init];
    //添加到父控件
    [self.bottomView addSubview:promptMessageLable];
    //设置属性
    promptMessageLable.textAlignment = NSTextAlignmentLeft;
    promptMessageLable.numberOfLines = 0;
    promptMessageLable.font = WLFontSize(15);
    promptMessageLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    
    //添加约束
    [promptMessageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLable.mas_bottom).offset(28 * AUTO_IPHONE6_HEIGHT_667);
        make.left.equalTo(self.bottomView.mas_left).offset(17 * AUTO_IPHONE6_WIDTH_375);
        make.right.equalTo(self.bottomView.mas_right).offset(-17 * AUTO_IPHONE6_WIDTH_375);
    }];
    self.promptMessageLable = promptMessageLable;
    
    //添加分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.bottomView addSubview:lineView];
    //设置属性
    lineView.backgroundColor = [WLTools stringToColor:@"#b7b7b7"];
    //添加约束
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(15 * AUTO_IPHONE6_WIDTH_375);
        make.right.equalTo(self.bottomView.mas_right).offset(-15 * AUTO_IPHONE6_WIDTH_375);
        make.top.equalTo(self.bottomView.mas_top).offset(125 * AUTO_IPHONE6_HEIGHT_667);
        make.height.equalTo(@0.5);
    }];
    self.lineView = lineView;
    
    //添加取消按钮
    UIButton *cancleButton = [[UIButton alloc] init];
    [self.bottomView addSubview:cancleButton];
    //设置属性
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[WLTools stringToColor:@"#b5b5b5"] forState:UIControlStateNormal];
    cancleButton.titleLabel.font = promptLable.font;
    //添加约束
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.equalTo(self.bottomView.mas_left);
        make.bottom.equalTo(self.bottomView.mas_bottom);
        make.width.equalTo(@(140 * AUTO_IPHONE6_WIDTH_375));
    }];
    self.cancleButton = cancleButton;
    
    //接单按钮
    UIButton *rushButton = [[UIButton alloc] init];
    [self.bottomView addSubview:rushButton];
    //设置属性
    [rushButton setTitle:@"接单" forState:UIControlStateNormal];
    [rushButton setTitleColor:[WLTools stringToColor:@"#4499ff"] forState:UIControlStateNormal];
     [rushButton setTitleColor:[WLTools stringToColor:@"#b5b5b5"] forState:UIControlStateDisabled];
    rushButton.titleLabel.font = promptLable.font;
    //添加约束
    [rushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancleButton.mas_top);
        make.left.equalTo(cancleButton.mas_right);
        make.right.equalTo(self.bottomView.mas_right);
        make.bottom.equalTo(cancleButton.mas_bottom);
    }];
    self.rushButton = rushButton;
}

@end
