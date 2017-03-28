//
//  WLPriceListObject.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLPriceListObject : NSObject<NSCoding>
@property (nonatomic, copy)   NSString *priceID;
@property (nonatomic, copy)   NSString *priceName;
@property (nonatomic, copy)   NSString *price;
@property (nonatomic, copy)   NSString *unit;
- (instancetype)initWithDict:(NSDictionary*)dict;
- (NSDictionary *)getDict;
@end
