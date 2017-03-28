//
//  WL_AddressBook_Organiztion_Search_Prompt_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Organiztion_Search_Prompt_View.h"
#import "WL_AddressBook_Search_Prompt_Button.h"

@implementation WL_AddressBook_Organiztion_Search_Prompt_View

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withIconImageName:(NSString *)imageName
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupChildViewToMainSearchPromptViewWithTitle:title WithIconImageName:imageName];
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    }
    return self;
}

- (void)setupChildViewToMainSearchPromptViewWithTitle:title WithIconImageName:imageName
{
    //1.添加标题Lable
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(48);
        make.centerX.equalTo(self.mas_centerX);
    }];
    titleLable.font = WLFontSize(16);
    titleLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
    titleLable.text = @"在这里可以搜到";
    
    //2.分隔线
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(13);
        make.centerX.equalTo(titleLable.mas_centerX);
        make.width.equalTo(@(221.5 * AUTO_IPHONE6_WIDTH_375));
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    //3.搜索提示logo
        WL_AddressBook_Search_Prompt_Button *searchPromptButton = [[WL_AddressBook_Search_Prompt_Button alloc] initWithFrame:CGRectZero withImage:[UIImage imageNamed:imageName] withTitle:title];
    //@"WL_AddressBook_SearchLinkMan"  @"联系人"
        [self addSubview:searchPromptButton];
    
        [searchPromptButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@100);
            make.height.equalTo(@100);
            make.top.equalTo(lineView.mas_bottom).offset(18);
        }];

    
    
}

@end
