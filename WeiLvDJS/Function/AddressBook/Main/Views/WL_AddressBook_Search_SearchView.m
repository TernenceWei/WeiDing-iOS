//
//  WL_AddressBook_Search_SearchView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Search_SearchView.h"

@implementation WL_AddressBook_Search_SearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupContentViewToSearchView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupContentViewToSearchView
{
    //1.左侧搜索图标
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AddressBook_search"]];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //2.右侧搜索框
    UITextField *searchField = [[UITextField alloc] init];
    [self addSubview:searchField];
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(30);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.mas_right);
    }];
    searchField.placeholder = @"搜索";
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.textColor = [WLTools stringToColor:@"#868686"];
    searchField.font = WLFontSize(15);
    [searchField setTintColor:[WLTools stringToColor:@"#4877e7"]];
    [searchField setValue:[WLTools stringToColor:@"#c6cbd2"] forKeyPath:@"_placeholderLabel.textColor"];
    self.searchField = searchField;
    
}




@end
