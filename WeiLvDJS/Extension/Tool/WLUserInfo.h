//
//  WLUserInfo.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  点击个人中心之后

#import <Foundation/Foundation.h>
#import "WL_Mine_UserInfoModel.h"
@interface WLUserInfo : NSObject

+(WLUserInfo *)shareUserInfo;

//获取本地的用户头像
-(NSString *)getUserPhoto;

//获取本地的冻结金额
-(NSString *)getFrozen_Amount;


//获取本地的是否 受保护
-(NSString *)getIs_Protect;

//获取本地的
-(NSString *)getLeave_Amount;

//获取本地的二维码
-(NSString *)getQrcode;

//获取本地的真实姓名
-(NSString *)getReal_Name;

//获取本地的用户账户id
-(NSString *)getUser_account_id;

//获取本地的用户id
-(NSString *)getUser_id;

//获取本地的用户名称
-(NSString *)getUser_Name;

-(void)saveUserWithBaseInfo:(WL_Mine_UserInfoModel *)userInfo;
@end
