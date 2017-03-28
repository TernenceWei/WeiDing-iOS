//
//  WLChargeUpSummaryInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTouristGroupHeader.h"

@interface WLChargeUpTripObject :NSObject
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, copy)   NSString *day;
@property (nonatomic, copy)   NSString *dayText;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLChargeUpNameCardObject :NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *mobile;
@property (nonatomic, copy)   NSString *roleName;
@property (nonatomic, copy)   NSString *roleID;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLChargeUpSummaryInfo : NSObject

@property (nonatomic, copy)   NSString *type;//0散客，成团
@property (nonatomic, copy)   NSString *lineName;
@property (nonatomic, copy)   NSString *groupNO;
@property (nonatomic, copy)   NSString *receiveDate;//开始时间
@property (nonatomic, copy)   NSString *sendDate;//结束时间
@property (nonatomic, copy)   NSString *peopleCount;
@property (nonatomic, copy)   NSString *guideNums;
@property (nonatomic, copy)   NSString *isMainGuide;
@property (nonatomic, copy)   NSString *days;//从0开始，2表示3天
@property (nonatomic, strong) NSArray *tripList;
@property (nonatomic, strong) NSArray *nameCardList;

@property (nonatomic, assign)  JourneyStatus status;
@property (nonatomic, strong) NSString *statusString;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
