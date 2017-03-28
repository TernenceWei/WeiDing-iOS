//
//  WLBookingCarResultObject.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLBookingCarResultObject : NSObject

@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *driverCount;
@property (nonatomic, strong) NSString *nowTime;
@property (nonatomic, strong) NSString *orderPice;
@property (nonatomic, assign) BOOL fromList;

@property (nonatomic, strong) NSString *companyID;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
