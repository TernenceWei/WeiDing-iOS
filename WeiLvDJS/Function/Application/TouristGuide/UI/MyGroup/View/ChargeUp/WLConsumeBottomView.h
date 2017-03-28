//
//  WLConsumeBottomView.h
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

@interface WLConsumeBottomView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)itemType
                       object:(id)object
                     showList:(BOOL)showList
                      canEdit:(BOOL)canEdit
                 newItemArray:(NSArray *)newItemArray
                 middleObject:(WLChargeUpMiddleObject *)middleObject;

- (void)setAddNewItemClickBlock:(void(^)(BOOL showList))block
               chooseAItemBlock:(void(^)(WLChargeUpScheduleObject *object))chooseBlock
                endEditingBlock:(void(^)())endEditingBlock;

- (NSArray *)getScheduleObjectArray;
@end
