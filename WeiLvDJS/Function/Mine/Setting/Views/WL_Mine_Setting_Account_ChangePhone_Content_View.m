//
//  WL_ChangePhone_Content_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_Setting_Account_ChangePhone_Content_View.h"

@implementation WL_Mine_Setting_Account_ChangePhone_Content_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToChangePhoneView];
        //设置背景颜色
        self.backgroundColor = WLColor(255, 255, 255, 1);
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupChildViewToChangePhoneView
{
    //1.创建内容上手机图片ImageView
    UIImageView *phoneImage = [[UIImageView alloc] init];
    [self addSubview:phoneImage];
    //设置imageView的图片
    phoneImage.image = [UIImage imageNamed:@"SetPhone"];
    //添加约束
    [phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(50 * AUTO_IPHONE6_HEIGHT_667);
        make.height.equalTo(@(137 * AUTO_IPHONE6_HEIGHT_667));
        make.width.equalTo(@(68 * AUTO_IPHONE6_WIDTH_375));
    }];
    
    //2. 创建手机图片下方的手机号码Lable
    UILabel *phoneNumLable = [[UILabel alloc] init];
    [self addSubview:phoneNumLable];
    //设置属性
    phoneNumLable.text = [WLUserTools getUserMobile];
    phoneNumLable.textColor = WLColor(47, 47, 47, 1);
    phoneNumLable.font = WLFontSize(24 * AUTO_IPHONE6_WIDTH_375);
    [phoneNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneImage.mas_bottom).offset(50 * AUTO_IPHONE6_HEIGHT_667);
        make.right.equalTo(self.mas_right).offset(-50 * AUTO_IPHONE6_WIDTH_375);
    }];
    self.phoneNumLable = phoneNumLable;
    
    //3.手机号码标题Lable
    UILabel *phoneTitleLable = [[UILabel alloc] init];
    [self addSubview:phoneTitleLable];
    //设置属性
    phoneTitleLable.text = @"你的手机号:";
    phoneTitleLable.textColor = WLColor(111, 115, 120, 1);
    phoneTitleLable.font = WLFontSize(18 * AUTO_IPHONE6_WIDTH_375);
    [phoneTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50 * AUTO_IPHONE6_WIDTH_375);
        make.centerY.equalTo(phoneNumLable.mas_centerY);
    }];
    [phoneTitleLable sizeToFit];
    
    //4.更换手机按钮
    UIButton *changePhoneButton = [[UIButton alloc] init];
    [self addSubview:changePhoneButton];
    //设置属性
    changePhoneButton.layer.cornerRadius = 5.0f;
    changePhoneButton.layer.masksToBounds = YES;
    [changePhoneButton setTitle:@"更换手机号" forState:UIControlStateNormal];
    changePhoneButton.titleLabel.font = WLFontSize(16);
    [changePhoneButton setBackgroundColor:[WLTools stringToColor:@"#879efb"]];
    
    [changePhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.top.equalTo(phoneTitleLable.mas_bottom).offset(45);
        make.height.equalTo(@(50 * AUTO_IPHONE6_HEIGHT_667));
    }];
    self.changePhoneButton = changePhoneButton;
    
    
    //下方提示Lable
    UILabel *tipLable = [[UILabel alloc] init];
    [self addSubview:tipLable];
    //设置属性
    tipLable.numberOfLines = 0;
    tipLable.font = WLFontSize(15);
    tipLable.text = @"更换手机号后, 登录手机号和企业通讯录号码均改变";
    tipLable.textColor = WLColor(111, 115, 120, 1);
    tipLable.textAlignment = NSTextAlignmentCenter;
    [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changePhoneButton.mas_bottom).offset(24);
        make.left.equalTo(changePhoneButton.mas_left);
        make.right.equalTo(changePhoneButton.mas_right);
    }];
       
}

@end
