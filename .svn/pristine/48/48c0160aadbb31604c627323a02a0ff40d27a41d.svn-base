//
//  WLChargeUpHotelObject.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLChargeUpScheduleObject : NSObject
@property (nonatomic, copy)   NSString *pricelistID;
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *priceName;
@property (nonatomic, copy)   NSString *actualCount;
@property (nonatomic, copy)   NSString *actualPrice;
@property (nonatomic, copy)   NSString *checkCount;
@property (nonatomic, copy)   NSString *actualDanJia;//加点的实际单价
@property (nonatomic, copy)   NSString *primePrice;//加点的调配单价
@property (nonatomic, assign) BOOL canDelete;//是否可以删除
- (instancetype)initWithDict:(NSDictionary*)dict additional:(BOOL)additional isSchedule:(BOOL)isSchedule;
@end


@interface WLChargeUpHotelObject : NSObject
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *groupID;
@property (nonatomic, copy)   NSString *resourceID;
@property (nonatomic, copy)   NSString *companyName;
@property (nonatomic, copy)   NSString *registerName;
@property (nonatomic, copy)   NSString *registerTime;
@property (nonatomic, copy)   NSString *remark;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, assign) NSUInteger settlementMode;
@property (nonatomic, copy)   NSString *whichDay;
@property (nonatomic, copy)   NSString *actualPerson;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSArray *picList;
@property (nonatomic, strong) NSMutableArray *scheduleList;
@property (nonatomic, strong) NSArray *priceList;
- (instancetype)initWithDict:(NSDictionary*)dict;
@end
