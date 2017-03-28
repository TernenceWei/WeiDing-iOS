//
//  NSDictionary+DefaultValue.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DefaultValue)
- (id)objectForKey:(NSString*)key defaultValue:(id)defaultValue;
@end
