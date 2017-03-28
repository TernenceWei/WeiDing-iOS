//
//  WL_PrivateDetail_Model.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_PrivateDetail_Model.h"

@implementation WL_userInfo_Model


@end

@implementation WL_authorInfo_Model



@end

@implementation WL_PrivateDetail_Model

-(void)setValue:(id)value forUndefinedKey:(NSString *)key

{
    if ([key isEqualToString:@"reply"]) {
        
        for (NSDictionary *dic in value) {
            
            WL_authorInfo_Model *model = [[WL_authorInfo_Model alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
           
            [self.reply addObject:model];
            
        }
    }
}
-(NSMutableArray *)reply
{
    if (_reply==nil) {
        
        _reply =[[NSMutableArray alloc]init];
    }
    return _reply;
}
@end
