//
//  WLDriverOrderListObject.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDriverOrderListObject.h"
#import "WLDriverOrderObject.h"

@implementation WLDriverOrderListObject

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    NSArray *dictArray = [dict objectForKey:@"items"];
    NSMutableArray *objectArray = [NSMutableArray array];
    for (NSDictionary *itemDict in dictArray) {
        WLDriverOrderObject *object = [WLDriverOrderObject mj_objectWithKeyValues:itemDict];
        object.orderID = [itemDict objectForKey:@"id"];
        object.companyName = [[itemDict  objectForKey:@"company"] objectForKey:@"name"];
        [objectArray addObject:object];
    }
    self.items = [objectArray copy];

    NSDictionary *links = [dict objectForKey:@"_links"];
    self.nextUrlString = [[links objectForKey:@"next"] objectForKey:@"href"];
    NSDictionary *meta = [dict objectForKey:@"_meta"];
    self.pageCount = [meta objectForKey:@"pageCount"];
    self.currentPage = [meta objectForKey:@"currentPage"];
    return self;
}
@end
