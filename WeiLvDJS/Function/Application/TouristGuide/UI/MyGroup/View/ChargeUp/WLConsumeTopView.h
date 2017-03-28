//
//  WLConsumeTopView.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"
#import "WLChargeUpHotelObject.h"
#import "WLChargeUpCarObject.h"
#import "WLChargeUpShopObject.h"
#import "WLChargeUpMiddleObject.h"

@interface WLConsumeTopView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)itemType
                       object:(id)object
                      canEdit:(BOOL)canEdit
                 middleObject:(WLChargeUpMiddleObject *)middleObject;;
- (NSArray *)getTopViewTextArray;

- (void)setEndEditingBlock:(void(^)())endEditingBlock;
@end
