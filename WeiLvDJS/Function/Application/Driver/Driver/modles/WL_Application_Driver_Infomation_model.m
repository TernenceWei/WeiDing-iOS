//
//  WL_Application_Driver_Infomation_model.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/23.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Infomation_model.h"

@implementation WL_Application_Driver_Infomation_model
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
