//
//  WLVisitorListInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLVisitorListHeaderInfo : NSObject
@property (nonatomic, copy)   NSString *orderID;//
@property (nonatomic, copy)   NSString *lineName;//线路名称
@property (nonatomic, copy)   NSString *comeDate;//
@property (nonatomic, copy)   NSString *lineID;//

- (instancetype)initWithDict:(NSDictionary*)dict;
@end

@interface WLVisitorListCellInfo : NSObject

@property (nonatomic, copy)   NSString *orderID;//orderID
@property (nonatomic, copy)   NSString *visitorID;
@property (nonatomic, copy)   NSString *phoneNO;//手机号
@property (nonatomic, copy)   NSString *name;//姓名
@property (nonatomic, copy)   NSString *peopleCount;//人数

- (instancetype)initWithDict:(NSDictionary*)dict;
@end



@interface WLVisitorListInfo : NSObject

@property (nonatomic, strong) NSArray *list;/*WLVisitorListCellInfo*/
@property (nonatomic, strong) WLVisitorListHeaderInfo *headerInfo;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
