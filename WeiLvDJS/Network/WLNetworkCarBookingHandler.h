//
//  WLNetworkCarBookingHandler.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/18.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLNetworkTool.h"
#import "WLBookingCarObject.h"
#import "WLBookingCarResultObject.h"
#import "WLCarBookingOrderListObject.h"
#import "WLCarBookingOrderDetailObject.h"
#import "WLNetworkAccountHandler.h"

@interface WLNetworkCarBookingHandler : NSObject


+ (void)bookingCarWithCarObject:(WLBookingCarObject *)object
                     imageArray:(NSArray *)imageArray
                      dataBlock:(CompletionDataBlock)dataBlock;

+ (void)addCostWithOrderID:(NSString *)orderID
                     price:(NSString *)price
                 companyID:(NSString *)companyID
            operationBlock:(OperationBlock)operationBlock;


+ (void)cancelOrderWithOrderID:(NSString *)orderID
                     dataBlock:(CompletionDataBlock)dataBlock;

+ (void)requestPaymentOrderWithPaymentMode:(WLPaymentMode)mode
                                   orderID:(NSString *)orderID
                                  driverID:(NSString *)driverID
                                 dataBlock:(CompletionDataBlock)dataBlock;

+ (void)requestOrderDetailWithOrderID:(NSString *)orderID
                            dataBlock:(CompletionDataBlock)dataBlock;


+ (void)CarbookingOrderListWithType:(NSString *)type
                          companyID:(NSString *)companyID
                            nextUrl:(NSString *)nextUrl
                          dataBlock:(void(^)(WLResponseType responseType, id data, NSString *nextUrl, NSString *message))dataBlock;

+ (void)someDriversHadBidPriceWithOrderID:(NSString *)orderID
                              resultBlock:(void(^)(BOOL success, BOOL result, NSString *message))resultBlock;

+ (void)requestCarSeatNumbersWithResultBlock:(CompletionDataBlock)dataBlock;

+ (void)doChooseDriverWithOrderID:(NSString *)orderID driverID:(NSString *)driverID Block:(StatusBlock)dataBlock;

@end
