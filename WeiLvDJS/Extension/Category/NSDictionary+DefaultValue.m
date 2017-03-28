//
//  NSDictionary+DefaultValue.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "NSDictionary+DefaultValue.h"

@implementation NSDictionary (DefaultValue)
- (id)objectForKey:(NSString*)key defaultValue:(id)defaultValue{
    
    if ([[self allKeys] containsObject:key]) {
        if ([self[key] isKindOfClass:[NSNull class]]) {
            return defaultValue;
        }
        return self[key];
    }
    return defaultValue;
}
@end
