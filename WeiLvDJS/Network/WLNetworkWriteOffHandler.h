//
//  WLNetworkWriteOffHandler.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/4.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLNetworkTool.h"

#import "WLWriteOffObject.h"
#import "WLWriteOffObjectBuyUser.h"

@interface WLNetworkWriteOffHandler : NSObject


/**
 核销

 @param code 验证码
 @param resultBlock
 */
+ (void)writeOffWithCode:(NSString *)code
             resultBlock:(void (^)(WLResponseType responseType, WLWriteOffObject * WLWriteOffObjectmodel,WLWriteOffObjectBuyUser * WLWriteOffObjectBuyUsermodel, NSString * message))resultBlock;


/**
 核销记录

 @param resultBlock
 */
+ (void)requestWriteOffListWithResultBlock:(CompletionDataBlock)resultBlock;


/**
 核销明细

 @param date 时间戳
 @param nextUrl 下页url
 @param resultBlock
 */
+ (void)requestWriteOffDetailWithDate:(NSString *)date
                              nextUrl:(NSString *)nextUrl
                          resultBlock:(void(^)(BOOL success, NSArray *dataArray, NSString *nextUrl, NSString *message))resultBlock;

/**
 核销详情
 
 @param date 时间戳
 @param nextUrl 下页url
 @param resultBlock
 */
+ (void)requestWriteOffDetailgetGoWithDate:(NSString *)Id
                          resultBlock:(void(^)(BOOL success, WLWriteOffObject *dataArray,WLWriteOffObjectBuyUser * modelbusy, NSString *message))resultBlock;
@end
