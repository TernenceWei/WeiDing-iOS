//
//  WLCurrentGroupCellTool.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLCurrentGroupInfo.h"
#import "WLTouristGroupHeader.h"

@interface WLCurrentGroupCellTool : NSObject
@property (nonatomic, strong) WLCurrentGroupInfo *groupInfo;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *isFoldArray;
@property (nonatomic, assign) NSUInteger selectedIndex;

- (BOOL)hasCarObject;
- (BOOL)hasHotelObject;
- (BOOL)hasMealObject;
- (BOOL)hasTicketObject;
- (BOOL)hasShoppingObject;
- (BOOL)hasAdditionalObject;


- (NSUInteger)getCellSectionCount;
- (TouristItemType)getCellItemTypeWithSection:(NSUInteger)section;
- (NSArray *)getCellDataArrayWithSection:(NSUInteger )section;




- (NSUInteger)getCell2RowCountWithSection:(NSUInteger)section type:(TouristItemType)type;
- (GroupItemCellType)getCell2TypeWithIndexPath:(NSIndexPath *)indexPath type:(TouristItemType)type;
- (NSArray *)getCell2DataArrayWithIndexPath:(NSIndexPath *)indexPath type:(TouristItemType)type;


- (CGFloat)getCellRowHeight;
- (CGFloat)getCell2RowHeightWithIndexPath:(NSIndexPath *)indexPath;

@end
