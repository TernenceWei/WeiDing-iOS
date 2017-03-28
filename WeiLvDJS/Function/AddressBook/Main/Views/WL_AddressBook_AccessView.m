//
//  WL_AddressBook_ AccessView.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_AccessView.h"

@implementation WL_AddressBook_AccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupContentViewToAccessView];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupContentViewToAccessView
{
    //1.添加底部的标题文字
    UILabel *iconTitleLable = [[UILabel alloc] init];
    [self addSubview:iconTitleLable];
    [iconTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-16);
    }];
    iconTitleLable.textAlignment = NSTextAlignmentCenter;
    iconTitleLable.textColor = [WLTools stringToColor:@"@2f2f2f"];
    iconTitleLable.font = WLFontSize(14);
    self.iconTitleLable = iconTitleLable;
    //2.添加中间的图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(iconTitleLable.mas_top).offset(-40);
    }];
    self.iconImageView = iconImageView;
    
}

@end
