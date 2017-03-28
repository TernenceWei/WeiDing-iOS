//
//  WLConsumeItemCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/11/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLChargeUpHotelObject.h"

typedef NS_ENUM(NSUInteger, ItemCellType) {
    ItemCellTypeTitle = 0,
    ItemCellTypeHotelItem = 1,
    ItemCellTypeAddItem = 2,
    ItemCellTypeAddBtn = 3,
    ItemCellTypeItemList = 4,
    ItemCellTypeAddFooter = 5,
    
};

@interface WLConsumeItemCell : UITableViewCell

+ (WLConsumeItemCell *)cellWithTableView:(UITableView*)tableView
                                    type:(ItemCellType)cellType
                          scheduleObject:(WLChargeUpScheduleObject *)scheduleObject
                               textArray:(NSArray *)textArray
                                 canEdit:(BOOL)canEdit
                                showList:(BOOL)showList
                            middleObject:(WLChargeUpScheduleObject *)middleObject;

- (void)setAddNewItemClickBlock:(void(^)(BOOL showList))block
               chooseAItemBlock:(void(^)(NSUInteger index))chooseBlock
                endEditingBlock:(void(^)())endEditingBlock;

- (NSArray *)getScheduleObjectFieldArray;

- (void)setTotalJieyu:(NSString *)price;
@end
