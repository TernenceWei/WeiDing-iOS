//
//  WL_Application_Driver_Pricelist_Model.m
//  WeiLvDJS
//
//  Created by liuxin on 16/10/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Pricelist_Model.h"

@implementation WL_Application_Driver_Pricelist_Model
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
