//
//  WLTradeRecordListObject.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/4.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTradeRecordListObject : NSObject

@property (nonatomic, strong) NSString *current_date;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *expenditure;
@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
