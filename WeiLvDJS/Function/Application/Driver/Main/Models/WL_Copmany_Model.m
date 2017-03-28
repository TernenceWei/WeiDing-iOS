//
//  WL_Copmany_Model.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Copmany_Model.h"
#import "WL_Application_Role_Model.h"
@implementation WL_Copmany_Model
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
   
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    
    if ([key isEqualToString:@"role"]) {
        NSMutableArray *objectArray = [NSMutableArray array];
        for (NSDictionary *itemDict in value) {
            WL_Application_Role_Model *object = [WL_Application_Role_Model mj_objectWithKeyValues:itemDict];
            [objectArray addObject:object];
        }
        self.role = objectArray.copy;
    }else
    {
        [super setValue:value forKey:key];
    }
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
