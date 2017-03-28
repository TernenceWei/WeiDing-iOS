//
//  WLDataCarBookingHandler.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDataCarBookingHandler : NSObject

+ (instancetype)sharedInstance;


/**
 出发地点缓存
 */
- (NSArray *)getStartPointHistory;
- (void)addNewStartPointItem:(NSDictionary *)dict;
- (void)removeStartPointItem:(NSDictionary *)dict;

/**
 结束地点缓存
 */
- (NSArray *)getEndPointHistory;
- (void)addNewEndPointItem:(NSDictionary *)dict;
- (void)removeEndPointItem:(NSDictionary *)dict;

/**
 行程详情缓存
 */
- (void)saveCarBookingImageArray:(NSArray *)array;
- (void)removeCarBookingImageArray;
- (NSArray *)getImageDataArray;

/**
 备注缓存
 */
- (void)saveCarBookingRemark:(NSString *)remark;
- (void)removeCarBookingRemark;
- (NSString *)getCarBookingRemark;
@end
