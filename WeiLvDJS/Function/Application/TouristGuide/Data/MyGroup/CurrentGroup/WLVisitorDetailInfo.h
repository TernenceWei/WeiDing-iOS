//
//  WLVisitorDetailInfo.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLVisitorDetailInfo : NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *phoneNO;
@property (nonatomic, copy)   NSString *IDNO;//身份证号
@property (nonatomic, copy)   NSString *orderID;
@property (nonatomic, copy)   NSString *lineName;
@property (nonatomic, copy)   NSString *adults;

@property (nonatomic, copy)   NSString *comeDate;//接站时间
@property (nonatomic, copy)   NSString *comePlace;//接站地点
@property (nonatomic, copy)   NSString *backDate;//送站时间
@property (nonatomic, copy)   NSString *backPlace;//送站地点
@property (nonatomic, copy)   NSString *remark;
@property (nonatomic, copy)   NSString *customerName;//组团社
@property (nonatomic, copy)   NSString *contactName;//联系人
@property (nonatomic, copy)   NSString *contactPhoneNO;//电话

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
