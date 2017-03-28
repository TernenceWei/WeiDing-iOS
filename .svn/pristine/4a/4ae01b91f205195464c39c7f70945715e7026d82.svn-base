//
//  WLChargeUpCarObject.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpCarObject.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLChargeUpFileObject

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.fileID         = [dict objectForKey:@"file_id" defaultValue:@"0"];
    self.fileUrl        = [dict objectForKey:@"file_url" defaultValue:@"0"];
    self.smallFileUrl   = [dict objectForKey:@"file_small_url" defaultValue:@"0"];
    
    return self;
}
@end


@implementation WLChargeUpCarObject
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.startAddress      = [dict objectForKey:@"start_address" defaultValue:@"0"];
    self.startProvince     = [dict objectForKey:@"start_province" defaultValue:@"0"];
    self.startCity         = [dict objectForKey:@"start_city" defaultValue:@"0"];
    self.startTime         = [dict objectForKey:@"start_time" defaultValue:@"0"];
    self.endAddress        = [dict objectForKey:@"end_address" defaultValue:@"0"];
    self.endProvince       = [dict objectForKey:@"end_province" defaultValue:@"0"];
    self.endCity           = [dict objectForKey:@"end_city" defaultValue:@"0"];
    self.endTime           = [dict objectForKey:@"end_time" defaultValue:@"0"];
    self.type              = [dict objectForKey:@"type" defaultValue:@"0"];
    self.orderID           = [dict objectForKey:@"id" defaultValue:@"0"];
    self.payDate           = [dict objectForKey:@"pay_date" defaultValue:@"0"];
    self.registerName      = [dict objectForKey:@"register_name" defaultValue:@"0"];
    self.registerTime      = [dict objectForKey:@"register_time" defaultValue:@"0"];
    self.remark            = [dict objectForKey:@"remark" defaultValue:@"0"];
    self.actualPrice       = [dict objectForKey:@"actual_amount" defaultValue:@"0"];
    self.price             = [dict objectForKey:@"amount" defaultValue:@"0"];
    
    NSArray *tirpArray = [dict objectForKey:@"pic_list" defaultValue:[NSArray array]];
    if ([tirpArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *objectArray1 = [NSMutableArray array];
        for (NSDictionary *dict in tirpArray) {
            WLChargeUpFileObject *object = [[WLChargeUpFileObject alloc] initWithDict:dict];
            [objectArray1 addObject:object];
        }
        self.picList = [objectArray1 copy];
    }
    
    
    return self;
}
@end
