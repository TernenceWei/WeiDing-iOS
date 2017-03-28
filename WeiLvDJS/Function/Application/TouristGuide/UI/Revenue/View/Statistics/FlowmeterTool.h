//
//  FlowmeterTool.h
//  PrivacyGuard
//
//  Created by Ternence on 15/7/31.
//  Copyright (c) 2015年 LEO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowmeterTool : NSObject
- (int)getCurrentMonth;
- (int)getTotalDaysOfMonth;
- (NSString *)getCurrentDate:(NSString *)type;
- (NSNumber *)getMaxFlowCount:(NSArray *)dataArray;
- (NSNumber *)getMinFlowCount:(NSArray *)dataArray;
@end
