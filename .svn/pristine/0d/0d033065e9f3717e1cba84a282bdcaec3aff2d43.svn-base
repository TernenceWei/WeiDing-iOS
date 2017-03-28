//
//  WLWriteOffDetailObject.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/4.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLWriteOffDetailObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLWriteOffDetailObject
- (instancetype)initWithDict:(NSDictionary *)dic
{
    self = [super init];
    
    self.objectID                 = [dic objectForKey:@"id" defaultValue:@"0"];
    self.consuming_at             = [dic objectForKey:@"consuming_at" defaultValue:@"0"];
    self.electronic_code          = [dic objectForKey:@"electronic_code" defaultValue:@"0"];
    self.contacts_mobile          = [dic objectForKey:@"contacts_mobile" defaultValue:@"0"];
    self.order_type               = [dic objectForKey:@"order_type" defaultValue:@"0"];
    return self;
}
@end
