//
//  WLDataTouristHandler.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDataTouristHandler.h"
#import "WLNetworkManager.h"

static WLDataTouristHandler* sharedInstance;
@implementation WLDataTouristHandler
+ (instancetype)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[WLDataTouristHandler alloc] init];
    }
    return sharedInstance;
}

@end
