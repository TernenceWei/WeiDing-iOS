//
//  WL_AddressBook_Organization_DepartmentTitle_Button.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Organization_DepartmentTitle_Button.h"

@implementation WL_AddressBook_Organization_DepartmentTitle_Button

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupContentViewToDepartmentTitleButton];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupContentViewToDepartmentTitleButton
{
    //1.按钮中的标题名称
    UILabel *nameLable = [[UILabel alloc] init];
    [self addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [nameLable sizeToFit];
    self.nameLable = nameLable;
    
    //2.按钮后边的箭头
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLable.mas_right).offset(4);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.iconImageView = iconImageView;
    
    
}

@end
