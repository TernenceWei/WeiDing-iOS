//
//  WL_AddressBook_NewFriends_Button.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_NewFriends_Button.h"

@implementation WL_AddressBook_NewFriends_Button

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupChildViewToNewFriendsButton];
    }
    return self;
}

#pragma mark - 添加子控件
- (void)setupChildViewToNewFriendsButton
{
    //1.添加一个铜铃图片
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewFriendMessage"]];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //2.添加一个消息条数Lable
    UILabel *countToNewFriendsLable = [[UILabel alloc] init];
    [self addSubview:countToNewFriendsLable];
    [countToNewFriendsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.mas_top).offset(-6.5);
        make.right.equalTo(iconImageView.mas_right).offset(6.5);
        make.width.and.height.equalTo(@17);
    }];
    countToNewFriendsLable.font = WLFontSize(12);
    countToNewFriendsLable.layer.cornerRadius = 8.5f;
    countToNewFriendsLable.layer.masksToBounds = YES;
    countToNewFriendsLable.textColor = [WLTools stringToColor:@"#ffffff"];
    countToNewFriendsLable.textAlignment = NSTextAlignmentCenter;
    countToNewFriendsLable.backgroundColor = [WLTools stringToColor:@"#f7585e"];
    countToNewFriendsLable.text = @"1";
    self.countToNewFriendsLable = countToNewFriendsLable;
    
}

@end
