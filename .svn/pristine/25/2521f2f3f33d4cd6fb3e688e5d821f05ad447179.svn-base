//
//  WLUserInfo.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLUserInfo.h"

@implementation WLUserInfo

+(WLUserInfo *)shareUserInfo
{
    static WLUserInfo *share=nil;
    
    static dispatch_once_t once;
    
    dispatch_once(&once,^{
        
        share = [[self alloc]init];
        
    });
    
    return share;
}

-(void)saveUserWithBaseInfo:(WL_Mine_UserInfoModel *)userInfo

{
    if (![userInfo.frozen_amount isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.frozen_amount forKey:@"frozen_amount"];
    }

    if (![userInfo.is_protect isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.is_protect forKey:@"is_protect"];
    }
    
    if (![userInfo.leave_amount isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.leave_amount forKey:@"leave_amount"];
    }
    if (![userInfo.photo isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.photo forKey:@"photo"];
    }
    
    if (![userInfo.qrcode isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.qrcode forKey:@"qrcode"];
    }
    if (![userInfo.real_name isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.real_name forKey:@"real_name"];
    }
    
    
    if (![userInfo.user_account_id isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.user_account_id forKey:@"user_account_id"];
    }
    if (![userInfo.user_id isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.user_id forKey:@"user_id"];
    }
    if (![userInfo.user_name isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.user_name  forKey:@"user_name"];
    }
    if (![userInfo.moneyCount isEqual:[NSNull null]]) {
        
        [DEFAULTS setObject:userInfo.moneyCount  forKey:@"moneyCount"];
    }


    //立即保存
    [DEFAULTS synchronize];


}
//获取本地的用户头像
-(NSString *)getUserPhoto
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"photo"];
}
//获取本地的冻结金额
-(NSString *)getFrozen_Amount
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"frozen_amount"];
}
//获取本地的是否 受保护
-(NSString *)getIs_Protect
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"is_protect"];
}
//获取本地的
-(NSString *)getLeave_Amount
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"leave_amount"];
}
//获取本地的二维码
-(NSString *)getQrcode
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"qrcode"];
}
//获取本地的真实姓名
-(NSString *)getReal_Name
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"real_name"];
}
//获取本地的用户账户id
-(NSString *)getUser_account_id
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user_account_id"];
}
//获取本地的用户id
-(NSString *)getUser_id
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
}
//获取本地的用户名称
-(NSString *)getUser_Name
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"];
}


@end
