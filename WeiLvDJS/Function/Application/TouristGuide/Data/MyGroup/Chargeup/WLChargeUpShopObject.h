//
//  WLChargeUpShopObject.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLChargeUpRoleObject : NSObject
@property (nonatomic, copy)   NSString *groupID;
@property (nonatomic, copy)   NSString *checklistID;
@property (nonatomic, copy)   NSString *actualPersons;
@property (nonatomic, copy)   NSString *actualPrice;
@property (nonatomic, copy)   NSString *companyName;
@property (nonatomic, copy)   NSString *isMainGuide;
@property (nonatomic, strong) NSArray *picList;
@property (nonatomic, copy)   NSString *rate;
@property (nonatomic, copy)   NSString *remark;
@property (nonatomic, copy)   NSString *userID;
@property (nonatomic, copy)   NSString *userName;
@property (nonatomic, copy)   NSString *whichDate;
@property (nonatomic, copy)   NSString *headImage;

//加点项目的
@property (nonatomic, copy)   NSString *resourceID;
@property (nonatomic, assign) NSUInteger settlementMode;
@property (nonatomic, strong) NSMutableArray *scheduleList;
@property (nonatomic, strong) NSArray *pricelist;

- (instancetype)initWithDict:(NSDictionary*)dict additional:(BOOL)additional;
@end

@interface WLChargeUpShopObject : NSObject
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, strong) NSArray *roleArray;

- (instancetype)initWithDict:(NSDictionary*)dict additional:(BOOL)additional;;
@end
