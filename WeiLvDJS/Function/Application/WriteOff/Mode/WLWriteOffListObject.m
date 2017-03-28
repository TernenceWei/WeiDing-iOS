//
//  WLWriteOffListObject.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/4.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLWriteOffListObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLWriteOffListItemObject

- (instancetype)initWithDict:(NSDictionary *)dic
{
    self = [super init];
    
    self.date            = [dic objectForKey:@"date" defaultValue:@"0"];
    self.num             = [dic objectForKey:@"num" defaultValue:@"0"];

    return self;
}

@end

@implementation WLWriteOffListObject
- (instancetype)initWithDict:(NSDictionary *)dic
{
    self = [super init];
    
    self.date            = [dic objectForKey:@"date" defaultValue:@"0"];
    self.year            = [dic objectForKey:@"year" defaultValue:@"0"];
    self.month           = [dic objectForKey:@"month" defaultValue:@"0"];
    self.num             = [dic objectForKey:@"num" defaultValue:@"0"];
    
    NSArray *dictArray = [dic objectForKey:@"items" defaultValue:[NSArray array]];
    NSMutableArray *objectTrendArray = [NSMutableArray array];
    if ([dictArray isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary *dict in dictArray) {
            WLWriteOffListItemObject *object = [WLWriteOffListItemObject mj_objectWithKeyValues:dict];
            [objectTrendArray addObject:object];
        }
        self.items = [objectTrendArray copy];
    }
    
    return self;
}
@end
