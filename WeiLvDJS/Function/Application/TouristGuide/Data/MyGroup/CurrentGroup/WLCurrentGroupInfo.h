//
//  WLCurrentGroupInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTouristGroupHeader.h"

@interface WLCurrentGroupCarObject : NSObject
@property (nonatomic, copy)   NSString *contactName;
@property (nonatomic, copy)   NSString *contactMobile;
@property (nonatomic, copy)   NSString *contactRole;
@property (nonatomic, copy)   NSString *driverID;
@property (nonatomic, copy)   NSString *orderID;
@property (nonatomic, copy)   NSString *carNO;
@property (nonatomic, copy)   NSString *carAmount;
@property (nonatomic, copy)   NSString *companyName;
@property (nonatomic, copy)   NSString *price;

@property (nonatomic, copy)   NSString *buttonName;
@property (nonatomic, assign) GroupStatus groupStatus;
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *orderNO;
- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLCurrentGroupListObject : NSObject
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *resourceID;
@property (nonatomic, copy)   NSString *itemType;
@property (nonatomic, copy)   NSString *priceListName;//类型名称
@property (nonatomic, copy)   NSString *checkCount;//数量
@property (nonatomic, copy)   NSString *checkPrice;//价格
@property (nonatomic, copy)   NSString *unit;//单位
@property (nonatomic, copy)   NSString *whichDay;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLCurrentGroupHotelObject : NSObject//酒店，餐厅，门票
@property (nonatomic, copy)   NSString *contactName;
@property (nonatomic, copy)   NSString *contactMobile;
@property (nonatomic, copy)   NSString *contactRole;
@property (nonatomic, copy)   NSString *groupID;
@property (nonatomic, copy)   NSString *resourceID;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, copy)   NSString *itemType;//酒店，用餐
@property (nonatomic, copy)   NSString *companyName;
@property (nonatomic, copy)   NSString *settlementMode;
@property (nonatomic, copy)   NSString *whichDay;
@property (nonatomic, copy)   NSString *spend;

@property (nonatomic, copy)   NSString *buttonName;
@property (nonatomic, assign) GroupStatus groupStatus;
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *guideID;
@property (nonatomic, copy)   NSString *pricelistID;

@property (nonatomic, strong) NSArray *itemList;
- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLCurrentGroupShopObject : NSObject//购物店，加点
@property (nonatomic, copy)   NSString *contactName;
@property (nonatomic, copy)   NSString *contactMobile;
@property (nonatomic, copy)   NSString *contactRole;
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *resourceID;
@property (nonatomic, copy)   NSString *supplierID;
@property (nonatomic, copy)   NSString *guideID;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, copy)   NSString *itemType;
@property (nonatomic, copy)   NSString *companyName;
@property (nonatomic, copy)   NSString *whichDay;
@property (nonatomic, copy)   NSString *spend;//加点项目是结余
@property (nonatomic, copy)   NSString *rate;
@property (nonatomic, copy)   NSString *cashBack;

@property (nonatomic, copy)   NSString *buttonName;
@property (nonatomic, assign) GroupStatus groupStatus;

- (instancetype)initWithDict:(NSDictionary *)dict isShopping:(BOOL)isShopping;
@end

@interface WLCurrentGroupInfo : NSObject
@property (nonatomic, strong)   NSString *message;
@property (nonatomic, strong)   NSArray *carList;
@property (nonatomic, strong)   NSArray *hotelList;
@property (nonatomic, strong)   NSArray *mealList;
@property (nonatomic, strong)   NSArray *ticketList;
@property (nonatomic, strong)   NSArray *shopList;
@property (nonatomic, strong)   NSArray *addList;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
