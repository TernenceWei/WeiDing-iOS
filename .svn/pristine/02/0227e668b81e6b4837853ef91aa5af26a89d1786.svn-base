//
//  WLNetworkLoginHandler.m
//  WeiLvDJS
//
//  Created by hsliang on 2016/12/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkLoginHandler.h"
#import "JPUSHService.h"

static WLNetworkLoginHandler * sharedInstance;

@implementation WLNetworkLoginHandler

+ (instancetype)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[WLNetworkLoginHandler alloc] init];
    }
    return sharedInstance;
}

// 登录
- (void)requestLoginWithPhoneNO:(NSString *)phoneNOStr password:(NSString *)psStr result:(void (^)(BOOL, BOOL, NSString *, WL_UserInfo_Model *))resultBlock
{
    //登录URL
    NSString *urlStr = LoginUrl;
    //登录参数
    NSDictionary *params = @{
                             @"user_mobile" : phoneNOStr,
                             @"user_password" : psStr,
                             };
    
    [WLNetworkTool requestWithMethod:@"POST" url:urlStr params:params success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([baseModel.result isEqualToString:@"1"])
        {
            WL_UserInfo_Model *userInfo = [WL_UserInfo_Model mj_objectWithKeyValues:baseModel.data];
            return resultBlock(YES,YES,nil,userInfo);
        }
        else
        {
            return resultBlock(YES,NO,@"账户名或密码错误",nil);
        }
    } failure:^(NSError *error) {
        
        return resultBlock(NO,NO,nil,nil);
    }];
}

// 发送验证码
- (void)sendRequestToCaptchaWithPhoneNO:(NSString *)phoneNOStr codeType:(NSString *)type result:(void (^)(BOOL, BOOL, NSString *, NSInteger))resultBlock
{
    NSString *urlStr = [[NSString alloc] init];
    
    if ([type isEqual:@"0"]) {
        //注册=验证码发送
        urlStr = [[WLNetworkTool getBaseUrl] stringByAppendingString:@"v1/user/get-register-sms"];
    }
    else
    {
        //=验证码发送
        urlStr = [[WLNetworkTool getBaseUrl] stringByAppendingString:@"v1/user/get-sms"];
    }
    
    //登录参数
    NSDictionary *params = @{
                             @"mobile" : phoneNOStr
                             };
    
    [WLNetworkTool requestWithMethod:@"POST" url:urlStr params:params success:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSUInteger status = ((NSString *)[dict objectForKey:@"status"]).integerValue;
        
        if (status == 200) {
            return resultBlock(YES,YES,[NSString stringWithFormat:@"%@", dict[@"msg"]],[dict[@"data"][@"resendTimeSpan"] intValue]);
        }
        else
        {
            return resultBlock(YES,NO,[NSString stringWithFormat:@"%@", dict[@"msg"]],[dict[@"data"][@"resendTimeSpan"] intValue]);
        }
        
    } failure:^(NSError *error) {
        
        NSString *message = [WLNetworkTool getFailureMessageWithError:error];
//        if ([error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 400) {
//            return resultBlock(NO,NO,@"400",0);
//        }
        return resultBlock(NO,NO,message,0);
    }];
}

// 登录获取token
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password isSMSLogin:(BOOL)isSMSLogin result:(void (^)(BOOL, BOOL, NSString *, NSString *))resultBlock
{
    NSString *urlString = [[WLNetworkTool getBaseUrl] stringByAppendingString:@"v2/user/login"];

    NSString *loginType = isSMSLogin?@"sms_login":@"password_login";
    
    NSDictionary *params = [[NSDictionary alloc] init];
    
    if (isSMSLogin) {
        params = @{@"mobile": userName,
                   @"sms_verify_code": password,
                   @"login_type":loginType,
                   @"device_name": [NSString stringWithFormat:@"%@的%@",[UIDevice currentDevice].name,[UIDevice currentDevice].model]};
    }
    else
    {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"public_cert" ofType:@"der"];
        NSString *encryptStr =[[MyRSA encryptString:password publicKeyWithContentsOfFile:file] uppercaseString];
        
        params = @{@"username": userName,
                   @"password": encryptStr,
                   @"login_type":loginType,
                   @"device_name": [NSString stringWithFormat:@"%@的%@",[UIDevice currentDevice].name,[UIDevice currentDevice].model]};
    }
    
    
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSLog(@"%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          
                                          
                                          NSString *token = [data objectForKey:@"token"];
                                          NSString *decryptToken = [WLNetworkTool decryptString:token];
                                          NSString *userID = [data objectForKey:@"id"];
                                          [WLUserTools saveJPushUserID:userID];
                                          [[AppManager sharedInstance] registerJPushTagsAndAlias];
                                          return resultBlock(YES, YES, decryptToken, message);
                                          
                                      }
                                      return resultBlock(YES,NO, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return resultBlock(NO,NO, nil, message);
                                  }];

}

// 忘记密码
- (void)changePassWord:(NSString *)phoneNOStr password:(NSString *)password isSMSLogin:(NSString *)isSMSStr isForget:(BOOL)isForget result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    
    NSString *urlString = [[NSString alloc] init];
    if (isForget) {
        urlString = [[WLNetworkTool getBaseUrl] stringByAppendingString:@"v1/set-pass/forget-pass"];
    }
    else
    {
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/set-pass/set-login-pass"];
    }
    
    NSDictionary *params = [[NSDictionary alloc] init];
    
    params = @{@"mobile": phoneNOStr,
               @"code": isSMSStr,
               @"login_pass":password};

    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSLog(@"%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                    
                                      if (status == 200) {
                                          return resultBlock(YES, YES, message);
                                          
                                      }
                                      return resultBlock(YES,NO, message);
                                  }
                                  failure:^(NSError *error) {
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return resultBlock(NO,NO, message);
                                  }];
}

// 注册
- (void)RegisterRegisterWithPhone:(NSString *)phoneNOStr password:(NSString *)password isSMSLogin:(NSString *)isSMSStr result:(void (^)(BOOL, BOOL, NSString *, NSString *))resultBlock
{
    NSString *urlString = [[WLNetworkTool getBaseUrl] stringByAppendingString:@"v1/user/register"];
    
    NSDictionary *params = [[NSDictionary alloc] init];
    
    params = @{@"mobile": phoneNOStr,
               @"password": password,
               @"sms_verify_code":isSMSStr};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSLog(@"%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      
                                      if (status == 200) {
                                          NSString *token = [data objectForKey:@"access_token"];
                                          NSString *decryptToken = [WLNetworkTool decryptString:token];
                                          NSString *userID = [data objectForKey:@"id"];
                                          [WLUserTools saveJPushUserID:userID];
                                          [[AppManager sharedInstance] registerJPushTagsAndAlias];
                                          return resultBlock(YES, YES,decryptToken, message);
                                          
                                      }
                                      return resultBlock(YES,NO,nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      NSUInteger status = [WLNetworkTool getFailureStatusWithError:error];
                                      
                                      if (status == 400) {
                                          return resultBlock(NO,NO,@"400",message);
                                      }
                                      return resultBlock(NO,NO,nil, message);
                                  }];
}

// 修改原手机号
- (void)ChangePhoneWithUserName:(NSString *)userName password:(NSString *)password isNew:(BOOL)isnew result:(void (^)(BOOL, BOOL, NSString *))resultBlock
{
    NSString * urlString = [[NSString alloc] init];
    if (isnew) {
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/set-pass/set-mobile"];
    }
    else
    {
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/set-pass/check-old-mobile"];
    }
    
    NSDictionary *params = [[NSDictionary alloc] init];
    
    params = @{@"mobile": userName,
               @"code": password};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      if (status == 200) {
                                          return resultBlock(YES, YES, message);
                                          
                                      }
                                      return resultBlock(YES,NO, message);
                                  }
                                  failure:^(NSError *error) {
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return resultBlock(NO,NO, message);
                                  }];
}

- (void)UserLicenseWithUserName:(void (^)(BOOL, id, NSString *))resultBlock
{
    NSString *urlString = [[WLNetworkTool getBaseUrl] stringByAppendingString:@"v1/user/end-user-license"];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      //NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          return resultBlock(YES, [dict objectForKey:@"data"], message);
                                      }
                                      
                                      return resultBlock(YES, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return resultBlock(NO, nil, message);
                                  }];
}

@end
