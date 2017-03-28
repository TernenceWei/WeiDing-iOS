//
//  WL_AddressBook_Main_Search_Prompt_View.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Main_Search_Prompt_View.h"
#import "WL_AddressBook_Search_Prompt_Button.h"

@implementation WL_AddressBook_Main_Search_Prompt_View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
            //设置子控件
        [self setupChildViewToMainSearchPromptView];
        self.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    }
    return self;
}

- (void)setupChildViewToMainSearchPromptView
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
    //标题文字数组
    NSArray *titleArr = @[@"手机通讯录", @"联系人", @"好友", @"企业"];
    //标题图片数组
    NSArray *iconImageArrs = @[@"WL_AddressBook_SearchMyAddressBook", @"WL_AddressBook_SearchLinkMan", @"WL_AddressBook_SearchMyFriends", @"WL_AddressBook_SearchCompany"];
    for (int i = 0; i < 4; i++) {
        WL_AddressBook_Search_Prompt_Button *searchPromptButton = [[WL_AddressBook_Search_Prompt_Button alloc] initWithFrame:CGRectMake(43 + i * (62 + 14), 94, 62, 50) withImage:[UIImage imageNamed:iconImageArrs[i]] withTitle:titleArr[i]];
        [self addSubview:searchPromptButton];
    }
    
    
}

@end
