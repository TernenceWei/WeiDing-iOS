//
//  WL_Application_carListInformation_Bom_model.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_carListInformation_Bom_model.h"

@implementation WL_Application_carListInformation_Bom_model
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
