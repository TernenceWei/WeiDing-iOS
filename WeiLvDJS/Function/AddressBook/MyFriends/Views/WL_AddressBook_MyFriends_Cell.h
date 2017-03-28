//
//  WL_AddressBook_MyFriends_Cell.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WL_AddressBook_MyFriend_Model;
@class WL_AddressBook_SearchResult_Contact_Model;

@interface WL_AddressBook_MyFriends_Cell : UITableViewCell


/** 姓名 */
@property(nonatomic, weak) UILabel *nameLable;
/** 分隔线 */
@property(nonatomic, weak) UIView *lineView;

@property(nonatomic, strong) WL_AddressBook_MyFriend_Model *myFriendModel;

@property(nonatomic, strong) WL_AddressBook_SearchResult_Contact_Model *searchMyFriendModel;

@end
