//
//  WL_ShareArray.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_ShareArray.h"

@implementation WL_ShareArray

+(WL_ShareArray *)shareArray
{
    static WL_ShareArray *share=nil;
    
    static dispatch_once_t once;
    
    dispatch_once(&once,^{
        
        share = [[self alloc]init];
        
        //_saveArray =[[NSMutableArray alloc]init];
        
    });
    
    return share;
}

-(NSMutableDictionary *)saveArray
{
    if (_saveArray==nil) {
        
        _saveArray =[[NSMutableDictionary alloc]init];
    }
    return _saveArray;
}

@end
