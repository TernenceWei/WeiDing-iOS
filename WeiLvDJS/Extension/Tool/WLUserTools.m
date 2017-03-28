//
//  WLUserTools.m
//  WeiLvDJS
//
//  Created by zhaoxiao on 16/9/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLUserTools.h"
#import "WL_UserInfo_Model.h"
#import "WLNetworkTool.h"

@implementation WLUserTools

//获取本地的用户密码
+(NSString *)getUserPassword
{
#ifdef ONADDRESSBOOK
    
    return @"123456";
    
#else
    return [WLKeychainTool readKeychainValue:@"userPassword"];;
    
#endif
    
}

//获取加密后的用户密码
+(NSString *)getRSAUserPassword
{
    NSString *passWord = [self getUserPassword];
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    return encryptStr;
}

//获取本地的用户id
+(NSString *)getUserId
{
#ifdef ONADDRESSBOOK
    
  return @"8";
    
#else
   return [WLKeychainTool readKeychainValue:@"user_id"];

#endif
    
}

//获取本地的用户姓名
+(NSString *)getUserName
{
    return [WLKeychainTool readKeychainValue:@"user_name"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"];
}

//获取本地的身份证号码
+(NSString *)getIdCard
{
    return [WLKeychainTool readKeychainValue:@"id_card"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"id_card"];
}

//获取本地的用户电话号码
+(NSString *)getUserMobile
{
    return [WLKeychainTool readKeychainValue:@"user_mobile"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"user_mobile"];
}

//获取本地的用户性别
+(NSString *)getUserSex
{
    return [WLKeychainTool readKeychainValue:@"sex"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
}

//获取本地的用户头像
+(NSString *)getUserPhoto
{
    return [WLKeychainTool readKeychainValue:@"photo"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"photo"];
}

//获取本地的融云Token
+(NSString *)getUserToken
{
    return [WLKeychainTool readKeychainValue:@"ry_token"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"];
}

//获取本地的融云Token有效期
+(NSString *)getUserTokenExpires
{
    return [WLKeychainTool readKeychainValue:@"ry_token_expires"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token_expires"];
}

//获取本地的用户类型
+(NSString *)getUserType
{
    return [WLKeychainTool readKeychainValue:@"user_type"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"];
}

//获取本地的用户职位名称
+(NSString *)getUserPosition
{
    return [WLKeychainTool readKeychainValue:@"position_name"];
}

//获取本地的用户职位名称
+(NSString *)getRealName
{
    return [WLKeychainTool readKeychainValue:@"realName"];
}

//存储本地的用户密码
+ (void)saveUserPassword:(NSString *)userPassword
{
    //用户密码
    if (![userPassword isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userPassword key:@"userPassword"];
    }
}

//存储本地手机号码
+ (void)saveUserMobile:(NSString *)userMobile
{
    //用户密码
    if (![userMobile isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userMobile key:@"user_mobile"];
    }
}

//保存服务器返回的登录信息
+ (void)saveUserWithUserInfo:(WL_UserInfo_Model *)userInfo
{
    //用户id
    if (![userInfo.user_id isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.user_id key:@"user_id"];
    }
    //用户名
    if (![userInfo.user_name isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.user_name key:@"user_name"];
    }
    //真实姓名
    if (![userInfo.real_name isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.real_name key:@"realName"];
    }
    
     //身份证号
    if (![userInfo.id_card isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.id_card key:@"id_card"];
        ////[DEFAULTS setObject:userInfo.id_card forKey:@"id_card"];
    }
     //用户电话
    if (![userInfo.user_mobile isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.user_mobile key:@"user_mobile"];
        ////[DEFAULTS setObject:userInfo.user_mobile forKey:@"user_mobile"];
    }
     //用户性别
    if (![userInfo.sex isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.sex key:@"sex"];
        ////[DEFAULTS setObject:userInfo.sex forKey:@"sex"];
    }
     //用户头像
    if (![userInfo.photo isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.photo key:@"photo"];
        //[DEFAULTS setObject:userInfo.photo forKey:@"photo"];
    }
     //融云Token
    if (![userInfo.ry_token isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.ry_token key:@"ry_token"];
        ////[DEFAULTS setObject:userInfo.ry_token forKey:@"ry_token"];
    }
     //融云Token有效期
    if (![userInfo.ry_token_expires isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.ry_token_expires key:@"ry_token_expires"];
        ////[DEFAULTS setObject:userInfo.ry_token_expires forKey:@"ry_token_expires"];
    }
     //用户类型
    if (![userInfo.user_type isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.user_type key:@"user_type"];
        ////[DEFAULTS setObject:userInfo.user_type forKey:@"user_type"];
    }
     //职位名称
    if (![userInfo.position_name isEqual:[NSNull null]])
    {
        [WLKeychainTool saveKeychainValue:userInfo.position_name key:@"position_name"];
        ////[DEFAULTS setObject:userInfo.position_name forKey:@"position_name"];
    }
    //立即保存
    ////[DEFAULTS synchronize];

}

//获取本地的用户登录token
+(NSString *)readUsertoken
{
    return [WLKeychainTool readKeychainValue:@"access_token"];////[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
}

+ (void)saveAccessToken:(NSString *)token
{
    if (![token isEqual:[NSNull null]]){
        [WLKeychainTool saveKeychainValue:token key:@"access_token"];

    }
}

+ (NSString *)getAccessToken
{
    NSString *token = [WLKeychainTool readKeychainValue:@"access_token"];
    
    return [WLNetworkTool encryptString:token];
}

+ (void)saveRealName:(NSString *)realName
{
    [WLKeychainTool saveKeychainValue:realName key:@"realName"];
}

+ (void)saveIDCard:(NSString *)IDCard
{
    [WLKeychainTool saveKeychainValue:IDCard key:@"id_card"];
}

+ (void)saveJPushUserID:(NSString *)userID
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",userID] forKey:@"JPushUserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getJPushUserID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"JPushUserID"];
}

+ (void)removeJPushUserID
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"JPushUserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
@end
