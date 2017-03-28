//
//  WL_Mine_Setting_ValidationSucceed_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_ValidationSucceed_View.h"

@implementation WL_Mine_Setting_ValidationSucceed_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       //设置子控件
        [self setupChildViewToValidationView];
        //设置背景颜色
        self.backgroundColor = WLColor(255, 255, 255, 1);
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToValidationView
{
    //设置成功图片
    UIImageView *succeedImage = [[UIImageView alloc] init];
    //添加到父控件
    [self addSubview:succeedImage];
    //设置属性
    succeedImage.image = [UIImage imageNamed:@"WLSetSucessImage"];
    //添加约束
    [succeedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(45);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@70);
        make.width.equalTo(@70);
    }];
    
    //2.设置提示信息Lable
    UILabel *titleLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:titleLable];
    //设置属性
    titleLable.text = @"恭喜你,修改成功!";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = WLFontSize(20);
    titleLable.textColor = WLColor(80, 80, 80, 1);
    
    //添加约束
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(succeedImage.mas_bottom).offset(20);
    }];
    [titleLable sizeToFit];
    
    //3.确定按钮
    UIButton *sureButton = [[UIButton alloc] init];
    //添加到父控件
    [self addSubview:sureButton];
    //设置属性
    
    sureButton.layer.cornerRadius = 5.0f;
    sureButton.layer.masksToBounds = YES;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setBackgroundColor:[WLTools stringToColor:@"#879efb"]];
    [sureButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    [sureButton.titleLabel setFont:WLFontSize(18)];
    //添加约束
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(titleLable.mas_bottom).offset(50);
        make.height.equalTo(@45);
        make.width.equalTo(@290);
    }];
    
    self.sureButton = sureButton;
}

@end
