//
//  WLNetworkLoginHandler.h
//  WeiLvDJS
//
//  Created by hsliang on 2016/12/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WL_UserInfo_Model.h"

@interface WLNetworkLoginHandler : NSObject
+ (instancetype)sharedInstance;

- (void)requestLoginWithPhoneNO:(NSString *)phoneNOStr
                       password:(NSString *)psStr
                         result:(void(^)(BOOL success,BOOL result,NSString * message,WL_UserInfo_Model * datamodel))resultBlock;

- (void)sendRequestToCaptchaWithPhoneNO:(NSString *)phoneNOStr codeType:(NSString *)type result:(void(^)(BOOL success,BOOL result,NSString * message,NSInteger minTimespan))resultBlock;

- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
               isSMSLogin:(BOOL)isSMSLogin
                   result:(void(^)(BOOL success,BOOL result,NSString *token, NSString * message))resultBlock;

- (void)changePassWord:(NSString *)phoneNOStr
              password:(NSString *)password
            isSMSLogin:(NSString *)isSMSStr
              isForget:(BOOL)isForget
                result:(void(^)(BOOL success,BOOL result, NSString * message))resultBlock;

- (void)RegisterRegisterWithPhone:(NSString *)phoneNOStr
                         password:(NSString *)password
                       isSMSLogin:(NSString *)isSMSStr
                           result:(void(^)(BOOL success,BOOL result,NSString *token, NSString * message))resultBlock;
// 修改原手机号
- (void)ChangePhoneWithUserName:(NSString *)userName
                       password:(NSString *)password
                       isNew:(BOOL)isnew
                         result:(void(^)(BOOL success,BOOL result, NSString * message))resultBlock;

// 个人用户注册服务条款获取
- (void)UserLicenseWithUserName:(void(^)(BOOL success,id data, NSString * message))resultBlock;

@end
