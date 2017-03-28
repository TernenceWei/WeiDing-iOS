//
//  WL_Mine_Setting_ValidationOldPassword_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_ValidationOldPassword_View.h"

@implementation WL_Mine_Setting_ValidationOldPassword_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToValidationOldPasswordView];
        //设置背景颜色
        self.backgroundColor = BgViewColor;
    }
    return self;
}

#pragma mark - 设置验证原密码View的子控件
- (void)setupChildViewToValidationOldPasswordView
{
    //1.密码输入框的背景View
    UIView *bgView = [[UIView alloc] init];
    //将背景View添加到父视图
    [self addSubview:bgView];
    //设置背景View的属性
    bgView.backgroundColor = WLColor(255, 255, 255, 1);
    //添加约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(15);
        make.height.equalTo(@50);
    }];
    
    //2.原密码输入框
    UITextField *oldPasswordField = [[UITextField alloc] init];
    //添加到父视图
    [bgView addSubview:oldPasswordField];
    //设置原密码输入框的属性
    oldPasswordField.font = WLFontSize(15);
    oldPasswordField.placeholder = @"请输入原密码";
    [oldPasswordField setValue:WLColor(156, 160, 176, 1) forKeyPath:@"_placeholderLabel.textColor"];
    oldPasswordField.secureTextEntry = YES;
    oldPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //添加约束
    [oldPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(20);
        make.right.equalTo(bgView.mas_right).offset(-20);
        make.top.equalTo(bgView.mas_top);
        make.bottom.equalTo(bgView.mas_bottom);
    }];
    self.oldPasswordField = oldPasswordField;
    
    
    
    //3.下一步按钮
    UIButton *nextButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:nextButton];
    // 设置属性
    //设置按钮字体内容
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    //设置按钮字体颜色
    [nextButton setTitleColor:WLColor(255, 255, 255, 1) forState:UIControlStateNormal];
    //设置按钮字体大小
    nextButton.titleLabel.font = WLFontSize(16);
    //设置按钮背景颜色
    [nextButton setBackgroundColor:[WLTools stringToColor:@"#879efb"]];
    //设置按钮的圆角
    nextButton.layer.cornerRadius = 5.0f;
    nextButton.layer.masksToBounds = YES;
    nextButton.userInteractionEnabled = NO;
    nextButton.alpha = 0.5;
    //添加约束
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.top.equalTo(bgView.mas_bottom).offset(60);
        make.height.equalTo(@50);
    }];
    self.nextButton = nextButton;
}

@end
