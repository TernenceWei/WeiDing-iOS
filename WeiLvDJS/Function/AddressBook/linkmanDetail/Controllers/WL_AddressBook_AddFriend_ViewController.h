//
//  WL_AddressBook_AddFriend_ViewController.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@interface WL_AddressBook_AddFriend_ViewController : WL_BaseViewController
//好友的id
@property(nonatomic, copy) NSString *view_id;
//好友电话号码
@property(nonatomic, copy) NSString *friend_mobile;
//自己的真实姓名
@property(nonatomic, copy) NSString *real_name;

//自己的电话号码
@property(nonatomic, copy) NSString *user_mobile;
@end
