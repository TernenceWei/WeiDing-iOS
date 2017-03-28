//
//  WLChargeUpSectionHeader.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"

@interface WLChargeUpSectionHeader : UIView
- (instancetype)initWithType:(TouristItemType)type
                    roleType:(TouristRoleType)roleType
                     section:(NSInteger)section;
@end
