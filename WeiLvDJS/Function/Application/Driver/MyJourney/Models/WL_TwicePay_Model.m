//
//  WL_TwicePay_Model.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_TwicePay_Model.h"

#import "WL_Pay_RecordModel.h"
@implementation WL_TwicePay_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"pay_record"]) {
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * dic in value) {
            WL_Pay_RecordModel * model = [WL_Pay_RecordModel alloc];
            [model setValuesForKeysWithDictionary:dic];
            [arr addObject:model];
        }
        self.pay_record= arr;
    }
    
}



@end
