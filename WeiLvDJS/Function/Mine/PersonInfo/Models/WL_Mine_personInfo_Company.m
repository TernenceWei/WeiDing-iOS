//
//  WL_Mine_personInfo_Company.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_personInfo_Company.h"

@implementation WL_Mine_personInfo_Company
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
