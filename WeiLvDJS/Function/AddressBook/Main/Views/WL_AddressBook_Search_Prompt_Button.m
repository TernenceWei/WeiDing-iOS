//
//  WL_AddressBook_Search_Prompt_Button.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Search_Prompt_Button.h"

@implementation WL_AddressBook_Search_Prompt_Button

- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage *)image withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        [self creatChildViewToSearchPromptButtonWithImage:image withTitle:title];
    }
    return self;
}

- (void)creatChildViewToSearchPromptButtonWithImage:(UIImage *)image withTitle:(NSString *)title
{
    //1.添加一个imageView
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
    }];
    
    //2.添加标题Lable
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(iconImageView.mas_bottom).offset(9);
    }];
    titleLable.font = WLFontSize(13);
    titleLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = title;

}

@end
