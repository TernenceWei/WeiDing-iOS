//
//  WL_Mine_HeaderView.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/6.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  个人中心首页 - 个人中心头视图

#import "WL_BaseView.h"

@interface WL_Mine_HeaderView : WL_BaseView

// 显示名字的父视图
@property(nonatomic,strong)UIButton *codeButton;

// 头像点击按钮
@property(nonatomic,strong)UIButton *imageClickButton;

// 头像
@property(nonatomic,strong)UIImageView *photoImage;

// 内容
@property (nonatomic, strong) UILabel * contentLabel;

// 二维码按钮
@property (nonatomic, strong) UIButton * codeImgBtn;

// 名字
@property (nonatomic, strong) UILabel * nameLabel;

@end
