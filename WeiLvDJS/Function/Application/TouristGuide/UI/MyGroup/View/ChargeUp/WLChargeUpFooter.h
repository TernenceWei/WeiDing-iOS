//
//  WLChargeUpFooter.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"

@interface WLChargeUpFooter : UIView
- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)itemType;

- (void)setName:(NSString *)name time:(NSString *)time;
@end
