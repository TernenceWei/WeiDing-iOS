//
//  WL_AddressBook_HeaderView.h
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"
@class WL_AddressBook_AccessView;
@interface WL_AddressBook_HeaderView : WL_BaseView

/** 搜索框View */
@property(nonatomic, weak) UIButton *searchButton;
/** 手机通讯录入口button */
@property(nonatomic, weak) WL_AddressBook_AccessView *mobileAddressView;
/** 微叮好友列表入口button */
@property(nonatomic, weak) WL_AddressBook_AccessView *enterFriendsView;
/** 商家号入口button */
@property(nonatomic, weak) WL_AddressBook_AccessView *enterMerchantView;

@end
