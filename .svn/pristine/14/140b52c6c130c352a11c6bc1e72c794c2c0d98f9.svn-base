//
//  WLHotelBillListInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLHotelBillListItemInfo : NSObject
@property (nonatomic, copy)   NSString *groupNO;//团号
@property (nonatomic, copy)   NSString *djCompanyID;//
@property (nonatomic, copy)   NSString *checkerID;//计调id
@property (nonatomic, copy)   NSString *grouplistID;//团id
@property (nonatomic, copy)   NSString *price;//价格
@property (nonatomic, copy)   NSString *cDate;//入住时间
- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLHotelBillListInfo : NSObject
@property (nonatomic, copy)   NSString *ymDate;//年月
@property (nonatomic, copy)   NSString *totalPrice;//总金额
@property (nonatomic, strong) NSArray *listArray;
- (instancetype)initWithDict:(NSDictionary*)dict;
@end
