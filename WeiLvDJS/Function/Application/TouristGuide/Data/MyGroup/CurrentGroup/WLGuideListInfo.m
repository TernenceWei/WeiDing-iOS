//
//  WLGuideListInfo.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideListInfo.h"
#import "NSDictionary+DefaultValue.h"

@implementation WLGuideListInfo
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.userID           = [dict objectForKey:@"guide_id" defaultValue:@"0"];
    self.guideName        = [dict objectForKey:@"guide_name" defaultValue:@"0"];
    self.checklistID      = [dict objectForKey:@"checklist_id" defaultValue:@"0"];
    self.guideID          = [dict objectForKey:@"resource_id" defaultValue:@"0"];
    self.checkPrice       = [dict objectForKey:@"check_price" defaultValue:@"0"];
    self.isMainGuide      = [dict objectForKey:@"is_main_guide" defaultValue:@"0"];
    self.headImage        = [dict objectForKey:@"photo" defaultValue:@"0"];

    return self;
}

@end
