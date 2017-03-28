


//
//  WLUserTools.h
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WL_UserInfo_Model;
@interface WLUserTools : NSObject

/** 获取存入本地的用户密码 */
+(NSString *)getUserPassword;

//获取加密后的用户密码
+(NSString *)getRSAUserPassword;

/** 获取存入本地的用户id */
+(NSString *)getUserId;

/** 获取存入本地的用户姓名 */
+(NSString *)getUserName;


//获取本地的身份证号码
+(NSString *)getIdCard;

/** 获取存入本地的用户真实姓名 */
+(NSString *)getRealName;

/** 获取存入本地的用户电话号码 */
+(NSString *)getUserMobile;

/** 获取存入本地的用户性别 */
+(NSString *)getUserSex;

/** 获取存入本地的用户头像 */
+(NSString *)getUserPhoto;

/** 获取存入本地的融云Token */
+(NSString *)getUserToken;

/** 获取存入本地的融云Token有效期 */
+(NSString *)getUserTokenExpires;

/** 获取存入本地的用户类型 */
+(NSString *)getUserType;

/** 获取存入本地的用户职位名称 */
+(NSString *)getUserPosition;

/** 存储用户密码 */
+ (void)saveUserPassword:(NSString *)userPassword;
/** 存储用户手机号码/登录账号 */
+ (void)saveUserMobile:(NSString *)userMobile;

/** 保存服务器返回的登录信息 */
+ (void)saveUserWithUserInfo:(WL_UserInfo_Model *)userInfo;

+(NSString *)readUsertoken;

/** 存储token */
+ (void)saveAccessToken:(NSString *)token;

/** 读取token */
+ (NSString *)getAccessToken;

/** 存储实名 */
+ (void)saveRealName:(NSString *)realName;

/** 存储身份证 */
+ (void)saveIDCard:(NSString *)IDCard;

+ (void)saveJPushUserID:(NSString *)userID;

+ (NSString *)getJPushUserID;

+ (void)removeJPushUserID;
@end
