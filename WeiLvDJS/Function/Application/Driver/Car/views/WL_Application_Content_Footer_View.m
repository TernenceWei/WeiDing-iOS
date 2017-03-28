//
//  WL_Application_Content_Footer_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Content_Footer_View.h"

@implementation WL_Application_Content_Footer_View
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
        //设置子控件
        [self setupChildViewToContentFooterView];
    }
    return self;
}

- (void)setupChildViewToContentFooterView
{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = Color4;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.offset(0.75);
    }];
    //提示标题Lable
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(12.5));
        make.top.equalTo(self.mas_top).offset(ScaleH(5));
    }];
    titleLable.text = @"重要提示: ";
    titleLable.font = [UIFont WLFontOfBoldSize:12];
    titleLable.textColor = Color3;
    titleLable.textAlignment = NSTextAlignmentLeft;
    [titleLable layoutIfNeeded];
    self.titleLable = titleLable;
    //提示内容Lable
    UILabel *promptLable = [[UILabel alloc] init];
    promptLable.font = [UIFont WLFontOfSize:11];
    promptLable.textColor = Color3;
    promptLable.textAlignment = NSTextAlignmentLeft;
    promptLable.numberOfLines = 0;
    promptLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:promptLable];
    
    [promptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(12.5));
        make.top.equalTo(titleLable.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-12.5);

    }];    
    
    self.promptLable = promptLable;
    
}


@end
