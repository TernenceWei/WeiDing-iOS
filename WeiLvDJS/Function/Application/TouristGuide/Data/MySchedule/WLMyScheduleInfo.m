//
//  WLMyScheduleInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLMyScheduleInfo.h"
#import "NSDictionary+DefaultValue.h"
#import "WLOrderListInfo.h"

@implementation WLMySchedule

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.startTime         = [dict objectForKey:@"start_time" defaultValue:@"0"];
    self.endTime           = [dict objectForKey:@"end_time" defaultValue:@"0"];
    self.receiveVisitors   = [[dict objectForKey:@"status" defaultValue:@"0"] integerValue];
    self.checklistID       = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.journeyStatus     = [[dict objectForKey:@"journey_status" defaultValue:@"0"] integerValue];
    self.remark            = [dict objectForKey:@"remark" defaultValue:@"0"];
    
    return self;
}

@end

@implementation WLMyScheduleInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.remark = [dict objectForKey:@"remark" defaultValue:@"0"];
    self.nowDate = [dict objectForKey:@"now_date" defaultValue:@"0"];
    self.status = [dict objectForKey:@"status" defaultValue:@"0"];
    NSArray *array1 = [dict objectForKey:@"my_all_date"];
    NSMutableArray *scheduleArray = [NSMutableArray array];
    for (NSDictionary *dict in array1) {
        WLMySchedule *schedule = [[WLMySchedule alloc] initWithDict:dict];
        [scheduleArray addObject:schedule];
    }
    self.allSchedule = [scheduleArray copy];
    
    NSArray *array2 = [dict objectForKey:@"group_list"];
    if ([array2 isKindOfClass:[NSArray class]]) {
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dict in array2) {
            WLOrderListInfo *schedule = [[WLOrderListInfo alloc] initWithDict:dict];
            [groupArray addObject:schedule];
        }
        self.groupList = [groupArray copy];
    }
    
    return self;
}
@end
