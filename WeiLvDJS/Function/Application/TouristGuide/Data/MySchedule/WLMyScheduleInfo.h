//
//  WLMyScheduleInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTouristGroupHeader.h"

@interface WLMySchedule : NSObject
@property (nonatomic, copy)   NSString *startTime;
@property (nonatomic, copy)   NSString *endTime;
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, assign) JourneyStatus journeyStatus;//出团状态
@property (nonatomic, copy)   NSString *remark;
@property (nonatomic, assign) BOOL receiveVisitors;//是否接单

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLMyScheduleInfo : NSObject


@property (nonatomic, strong) NSArray *allSchedule;
@property (nonatomic, strong) NSArray *groupList;
@property (nonatomic, copy)   NSString *remark;
@property (nonatomic, copy)   NSString *nowDate;
@property (nonatomic, copy)   NSString *status;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
