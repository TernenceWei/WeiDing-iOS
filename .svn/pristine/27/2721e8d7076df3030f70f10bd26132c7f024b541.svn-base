//
//  WL_Application_Content_OtherTitle_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Content_OtherTitle_View.h"

@implementation WL_Application_Content_OtherTitle_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToContentTitleView];
    }
    return self;
}


#pragma mark - 设置子控件
- (void)setupChildViewToContentTitleView
{
    
    //    //添加应用标题左侧红色指示器
    //    UIView *indicatorView = [[UIView alloc] init];
    //    //添加到父控件
    //    [self addSubview:indicatorView];
    //    //设置属性
    //    indicatorView.layer.cornerRadius = 2.5f;
    //    indicatorView.layer.masksToBounds = YES;
    //    indicatorView.backgroundColor = WLColor(255, 0, 0, 1);
    //    //添加约束
    //    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.mas_left).offset(13);
    //        make.top.equalTo(self.mas_top).offset(25);
    //        make.height.equalTo(@15);
    //        make.width.equalTo(@5);
    //    }];
    
    //添加应用标题
    UILabel *titleLable = [[UILabel alloc] init];
    //添加到父控件
    [self addSubview:titleLable];
    //设置属性
    //设置字体大小为15
    titleLable.font = WLFontSize(15);
    //靠左对齐
    titleLable.textAlignment = NSTextAlignmentLeft;
    //添加约束
    titleLable.frame = CGRectMake(9, 0, ScreenWidth, 45);

    titleLable.textColor = Color3;
    self.titleLable = titleLable;
}


@end
