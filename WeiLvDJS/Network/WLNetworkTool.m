//
//  WLNetworkTool.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkTool.h"
#import "WL_Login_ViewController.h"
#import "JPUSHService.h"
#import "WL_BaseNavigationViewController.h"
#import "WLDataCarBookingHandler.h"

@interface WLNetworkTool ()

@end

@implementation WLNetworkTool
+ (void)requestWithMethod:(NSString *)method
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([method isEqualToString:@"GET"]){
            
            [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){

                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (success){
                         
                         success(responseObject);
                         
                         
                     }
                 });
                 
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (failure){
                         if (error.code == -1009) {
                             [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
                         }
                         else
                         {
//                             [[WL_TipAlert_View sharedAlert]createTip:@"服务器出去旅行了"];
                         }
                         
                         if ([error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 498) {
                             [WLNetworkTool LoginOutAlert:[WLNetworkTool getFailureMessageWithError:error]];
                         }
                         else
                         {
                             failure(error);
                         }
                         
                     }
                 });
                 
             }];
        }else if ([method isEqualToString:@"POST"]){
            [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
             {
                 
             } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (success){
                         
                         success(responseObject);
                     }
                 });
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (failure){
                         if (error.code == -1009) {
                             [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
                         }
                         else
                         {
                             //                             [[WL_TipAlert_View sharedAlert]createTip:@"服务器出去旅行了"];
                         }
                         
                         if ([error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 498) {
                             [WLNetworkTool LoginOutAlert:[WLNetworkTool getFailureMessageWithError:error]];
                         }
                         else
                         {
                             failure(error);
                         }
                     }
                 });
                 
             }];
        }else if ([method isEqualToString:@"PATCH"]){
            [manager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success){
                        
                        success(responseObject);
                    }
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failure){
                        if (error.code == -1009) {
                            [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
                        }
                        else
                        {
                            //                             [[WL_TipAlert_View sharedAlert]createTip:@"服务器出去旅行了"];
                        }
                        
                        if ([error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 498) {
                            [WLNetworkTool LoginOutAlert:[WLNetworkTool getFailureMessageWithError:error]];
                        }
                        else
                        {
                            failure(error);
                        }
                    }
                });
            }];
            
        }else if ([method isEqualToString:@"PUT"]){
            [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success){
                        
                        success(responseObject);
                    }
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failure){
                        if (error.code == -1009) {
                            [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
                        }
                        else
                        {
                            //                             [[WL_TipAlert_View sharedAlert]createTip:@"服务器出去旅行了"];
                        }
                        
                        if ([error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 498) {
                            [WLNetworkTool LoginOutAlert:[WLNetworkTool getFailureMessageWithError:error]];
                        }
                        else
                        {
                            failure(error);
                        }
                    }
                });
            }];
        }else if ([method isEqualToString:@"DELETE"]){
            
            [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success){
                        
                        success(responseObject);
                    }
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failure){
                        if (error.code == -1009) {
                            [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
                        }
                        else
                        {
                            //                             [[WL_TipAlert_View sharedAlert]createTip:@"服务器出去旅行了"];
                        }
                        
                        if ([error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 498) {
                            [WLNetworkTool LoginOutAlert:[WLNetworkTool getFailureMessageWithError:error]];
                        }
                        else
                        {
                            failure(error);
                        }
                    }
                });
            }];
        }
        
    });
    
}

+ (void)LoginOutAlert:(NSString *)message
{
    [[AppManager sharedInstance] stopJPushService];
    if ([WLKeychainTool readKeychainValue:@"user_mobile"].length != 0 && [WLKeychainTool readKeychainValue:@"user_mobile"] != nil) {
        UIAlertView * LoginOutAlertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",message] message:nil delegate:nil  cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [LoginOutAlertView show];
    }

    [WLNetworkTool clearUserInfo];
}

+ (void)clearUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CarBookingSavedUserInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[WLDataCarBookingHandler sharedInstance] removeCarBookingImageArray];
    [WLKeychainTool deleteKeychainValue:@"user_mobile"];
    [WLKeychainTool deleteKeychainValue:@"access_token"];
    
    [WLKeychainTool deleteKeychainValue:@"CompanyID"];
    
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * fileName = [arr.firstObject stringByAppendingPathComponent:@"archiverModel"];
    //删除归档文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:fileName]) {
        [defaultManager removeItemAtPath:fileName error:nil];
    }
    
    WL_Login_ViewController *loginVC = [[WL_Login_ViewController alloc] init];
    
    WL_BaseNavigationViewController *_navi = [[WL_BaseNavigationViewController alloc] initWithRootViewController:loginVC];
    
    [ShareApplicationDelegate window].rootViewController = _navi;
}

+ (void)requestWithRequestType:(WLRequestType)type
                           url:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(id))success
                       failure:(void (^)(NSError *))failure
{
    NSString *method = @"GET";
    if (type == WLRequestTypePost) {
        method = @"POST";
    }else if (type == WLRequestTypePatch) {
        method = @"PATCH";
    }else if (type == WLRequestTypePut) {
        method = @"PUT";
    }else if (type == WLRequestTypeDelete){
        method = @"DELETE";
    }
    [self requestWithMethod:method url:url params:params success:success failure:failure];
}

+ (void)requestWithUrl:(NSString *)url
                params:(NSDictionary *)params
             fileArray:(NSArray *)fileArray
              fileName:(NSString *)fileName
               success:(void (^)(id))success
               failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 40;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            
            for (int i = 0; i < fileArray.count; i ++) {
//                UIImage *image = fileArray[i];
                NSData *data = fileArray[i];//UIImageJPEGRepresentation(image, 0.8);
                NSString *formatFileName = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@%d",fileName,i] fileName:formatFileName mimeType:@"image/jpeg"];
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success){
                    
                    success(responseObject);
                }
            });
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            if ([error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 498) {
                [WLNetworkTool LoginOutAlert:[WLNetworkTool getFailureMessageWithError:error]];
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failure){
                        
                        failure(error);
                    }
                });
            }
        }];
        
    });
    
}

+ (NSString *)getTag
{
    NSUInteger code = [[NSUserDefaults standardUserDefaults] integerForKey:@"ConfigurationCode"];
    if (code == 0) {//开发
        return @"dev";
    }else if (code == 1){//测试
        return @"test";
    }else if (code == 2){//预发
        return @"test";
    }
    return @"prod";
}

+ (NSString *)getBaseUrl
{
    NSUInteger code = [[NSUserDefaults standardUserDefaults] integerForKey:@"ConfigurationCode"];
    if (code == 0) {//开发
        return @"http://api.app.vding.wang/";
    }else if (code == 1){//测试
        return @"http://api.t.vding.wang/";
    }
    else if (code == 2)
    {
        
        return @"http://api.beta.vding.wang/";
    }
    //正式
    return  @"http://api.vding.wang/";
}

+ (BOOL)JpushIsOnDistributionEnvironment
{
    NSString *url = [self getBaseUrl];
    if ([url isEqualToString:@"http://api.vding.wang/"]) {
        return YES;
    }
    return NO;
}


+ (NSString *)getAuthenticationUrlStringWithActionString:(NSString *)actionString
{
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"v1%@",actionString];
    NSString *accessToken = [WLUserTools getAccessToken];
    url = [url stringByAppendingFormat:@"?access-token=%@",accessToken];
    return url;
}

+ (NSString *)encryptString:(NSString *)str
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"public_cert" ofType:@"der"];
    NSString *encryptStr =[[MyRSA encryptString:str publicKeyWithContentsOfFile:file] uppercaseString];
    return encryptStr;
}

+ (NSString *)decryptString:(NSString *)str
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"public_cert" ofType:@"der"];
    NSString *decryptStr = [MyRSA decryptString:str publicKeyWithContentsOfFile:file];
    return decryptStr;
}

+ (NSString *)getFailureMessageWithError:(NSError *)error
{
    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
    if (errorData == nil) {
        return @"服务器错误";
    }
    NSDictionary *errorDict = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
    NSString *message = [errorDict objectForKey:@"message"];
    return message;
}

+ (NSUInteger)getFailureStatusWithError:(NSError *)error
{
    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
    if (errorData == nil) {
        return 404;
    }
    NSDictionary *errorDict = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
    NSUInteger status = [[errorDict objectForKey:@"status"] integerValue];
    return status;
}

+ (NSString *)getCurrentTime
{
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyyMMddHHmmss";
    NSString *str1 = [formatter1 stringFromDate:[NSDate date]];
    return str1;
}
@end
