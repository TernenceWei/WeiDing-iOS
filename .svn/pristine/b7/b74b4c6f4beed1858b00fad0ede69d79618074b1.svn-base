//
//  WLPriceListObject.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLPriceListObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLPriceListObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.priceID           = [dict objectForKey:@"pricelist_id" defaultValue:@"0"];
    self.priceName         = [dict objectForKey:@"pricelist_name" defaultValue:@"0"];
    self.price             = [dict objectForKey:@"prime_price" defaultValue:@"0"];
    self.unit              = [dict objectForKey:@"unit" defaultValue:@"0"];
    
    
    return self;
}

- (NSDictionary *)getDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.priceID != nil) {
        [dict setObject:self.priceID forKey:@"pricelist_id"];
    }
    [dict setObject:self.priceName forKey:@"pricelist_name"];
    [dict setObject:self.price forKey:@"prime_price"];
    [dict setObject:self.unit forKey:@"unit"];
    return [dict copy];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        self.priceID = [aDecoder decodeObjectForKey:@"priceID"];
        self.priceName = [aDecoder decodeObjectForKey:@"priceName"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.unit = [aDecoder decodeObjectForKey:@"unit"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.priceID forKey:@"priceID"];
    [aCoder encodeObject:self.priceName forKey:@"priceName"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.unit forKey:@"unit"];
}

- (WLPriceListObject *)description
{
    return self;
}

@end
