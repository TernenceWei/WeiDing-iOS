//
//  WLNetworkTool.h
//  WeiLvDJS
//
//  Created by ternence on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLNetworkTool : NSObject

typedef NS_ENUM (NSUInteger, WLRequestType){
    WLRequestTypeGet,                     //GET请求
    WLRequestTypePost,                    //POST请求
    WLRequestTypePostUpload,              //POST数据请求
    WLRequestTypeGetDownload,             //下载文件请求
    WLRequestTypePatch,                   //patch请求
    WLRequestTypePut,                     //put请求
    WLRequestTypeDelete                   //delete请求
};

typedef NS_ENUM (NSUInteger, WLResponseType){
    WLResponseTypeSuccess       = 0,//请求成功
    WLResponseTypeNoNetwork     = 1,//无网络
    WLResponseTypeServerError   = 2,//服务器错误
    WLResponseTypeNoData        = 3,//无数据
    WLResponseTypeNoMoreData    = 4,//无更多数据
    
    WLResponseType1       = 422,//已核销
    WLResponseType2       = 404,//无法识别
};

typedef void (^OperationBlock)(WLResponseType responseType, BOOL result, NSString *message);
typedef void (^CompletionDataBlock)(WLResponseType responseType, id data, NSString *message);
typedef void (^DataCountBlock)(WLResponseType responseType, id data, NSUInteger count, NSString *message);
typedef void (^StatusBlock)(WLResponseType responseType, NSInteger status, NSString *message);

+ (void)requestWithMethod:(NSString *)method
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

+ (void)requestWithRequestType:(WLRequestType)type
                           url:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;


+ (void)requestWithUrl:(NSString *)url
                params:(NSDictionary *)params
             fileArray:(NSArray *)fileArray
              fileName:(NSString *)fileName
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

+ (NSString *)getBaseUrl;

+ (NSString *)getTag;

/**
 追加token后的url

 @param actionString actionUrl
 @return
 */
+ (NSString *)getAuthenticationUrlStringWithActionString:(NSString *)actionString;


/**
 公钥加密

 @param str 要加密的字符串，如token
 @return 公钥加密过后的字符串
 */
+ (NSString *)encryptString:(NSString *)str;


/**
 公钥解密

 @param str 私钥加密过的字符串
 @return 解密后的字符串
 */
+ (NSString *)decryptString:(NSString *)str;


/**
 获取错误消息

 @param error
 @return
 */
+ (NSString *)getFailureMessageWithError:(NSError *)error;


/**
 获取错误码（400，404等）

 @param error
 @return
 */
+ (NSUInteger)getFailureStatusWithError:(NSError *)error;


/**
 获取当前时间
 */
+ (NSString *)getCurrentTime;


/**
 推送环境

 @return
 */
+ (BOOL)JpushIsOnDistributionEnvironment;


+ (void)LoginOutAlert:(NSString *)message;
/**
 清楚登录数据
 */
+ (void)clearUserInfo;
@end
