//
//  WLBindCardObject.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/17.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLBindCardObject.h"

@implementation WLBindCardObject
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    
    NSDictionary *realDict = [dict objectForKey:@"real_info"];
    NSDictionary *bankDict = [dict objectForKey:@"bank"];
    self.id_card           = [realDict objectForKey:@"id_card"];
    self.real_name         = [realDict objectForKey:@"real_name"];
    self.bank_name         = [bankDict objectForKey:@"bank_name"];
    self.bank_number       = [bankDict objectForKey:@"bank_number"];
    self.branch_name       = [bankDict objectForKey:@"branch_name"];
    self.city_name         = [bankDict objectForKey:@"city_name"];


    return self;
    
    
}
@end
