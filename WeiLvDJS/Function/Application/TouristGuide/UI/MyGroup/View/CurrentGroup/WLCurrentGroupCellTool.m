//
//  WLCurrentGroupCellTool.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCurrentGroupCellTool.h"
#import "WLCurrentGroupInfo.h"

@implementation WLCurrentGroupCellTool
- (BOOL)hasCarObject
{
    return self.groupInfo.carList.count;
}

- (BOOL)hasHotelObject
{
    return self.groupInfo.hotelList.count;
}

- (BOOL)hasMealObject
{
    return self.groupInfo.mealList.count;
}

- (BOOL)hasTicketObject
{
    return self.groupInfo.ticketList.count;
}

- (BOOL)hasShoppingObject
{
    return self.groupInfo.shopList.count;
}

- (BOOL)hasAdditionalObject
{
    return self.groupInfo.addList.count;
}

- (NSUInteger)getCellSectionCount
{
    NSUInteger count = 0;
    if ([self hasCarObject]) {
        count += 1;
    }
    if ([self hasHotelObject]) {
        count += 1;
    }
    if ([self hasMealObject]) {
        count += 1;
    }
    if ([self hasTicketObject]) {
        count += 1;
    }
    if ([self hasShoppingObject]) {
        count += 1;
    }
    if ([self hasAdditionalObject]) {
        count += 1;
    }
    return count;
}

- (NSArray *)getCellItemTypeArray
{
    NSMutableArray *typeArray = [NSMutableArray array];
    if ([self hasCarObject]) {
        [typeArray addObject:[NSString stringWithFormat:@"%ld",TouristItemTypeCar]];
    }
    if ([self hasHotelObject]) {
        [typeArray addObject:[NSString stringWithFormat:@"%ld",TouristItemTypeHotel]];
    }
    if ([self hasMealObject]) {
        [typeArray addObject:[NSString stringWithFormat:@"%ld",TouristItemTypeMeal]];
    }
    if ([self hasTicketObject]) {
        [typeArray addObject:[NSString stringWithFormat:@"%ld",TouristItemTypeTicket]];
    }
    if ([self hasShoppingObject]) {
        [typeArray addObject:[NSString stringWithFormat:@"%ld",TouristItemTypeShopping]];
    }
    if ([self hasAdditionalObject]) {
        [typeArray addObject:[NSString stringWithFormat:@"%ld",TouristItemTypeAdditional]];
    }
    return [typeArray copy];
}

- (TouristItemType)getCellItemTypeWithSection:(NSUInteger)section
{
    NSArray *tempArray = [self getCellItemTypeArray];
    return (TouristItemType)((NSString *)tempArray[section]).integerValue;
}

- (NSUInteger)getRowCountWithSection:(NSUInteger)section
{
    if (section == 0) {
        if ([self hasCarObject]) {
            return [self getRowCountForCar];
        }
        if ([self hasHotelObject]) {
            return [self getRowCountForHotel];
        }
        if ([self hasMealObject]) {
            return [self getRowCountForMeal];
        }
        if ([self hasTicketObject]) {
            return [self getRowCountForTicket];
        }
        if ([self hasShoppingObject]) {
            return [self getRowCountForShop];
        }
        if ([self hasAdditionalObject]) {
            return [self getRowCountForAdditional];
        }
        
    }else if (section == 1) {
        if ([self hasHotelObject]) {
            return [self getRowCountForHotel];
        }
        if ([self hasMealObject]) {
            return [self getRowCountForMeal];
        }
        if ([self hasTicketObject]) {
            return [self getRowCountForTicket];
        }
        if ([self hasShoppingObject]) {
            return [self getRowCountForShop];
        }
        if ([self hasAdditionalObject]) {
            return [self getRowCountForAdditional];
        }
    }else if (section == 2) {
        if ([self hasMealObject]) {
            return [self getRowCountForMeal];
        }
        if ([self hasTicketObject]) {
            return [self getRowCountForTicket];
        }
        if ([self hasShoppingObject]) {
            return [self getRowCountForShop];
        }
        if ([self hasAdditionalObject]) {
            return [self getRowCountForAdditional];
        }
    }else if (section == 3) {
        if ([self hasTicketObject]) {
            return [self getRowCountForTicket];
        }
        if ([self hasShoppingObject]) {
            return [self getRowCountForShop];
        }
        if ([self hasAdditionalObject]) {
            return [self getRowCountForAdditional];
        }
    }else if (section == 4) {
        if ([self hasShoppingObject]) {
            return [self getRowCountForShop];
        }
        if ([self hasAdditionalObject]) {
            return [self getRowCountForAdditional];
        }
    }else if (section == 5) {
        if ([self hasAdditionalObject]) {
            return [self getRowCountForAdditional];
        }
    }
    return 0;
}

- (NSUInteger)getRowCountForCar
{
    NSUInteger count = 0;
    count = 5 * self.groupInfo.carList.count + self.groupInfo.carList.count - 1;
    return count;
}

- (NSUInteger)getRowCountForHotel
{
    NSUInteger count = 0;
    for (WLCurrentGroupHotelObject *object in self.groupInfo.hotelList) {
        count += ((3 + object.itemList.count) * self.groupInfo.hotelList.count );
    }
    count += (self.groupInfo.hotelList.count - 1);
    return count;
}

- (NSUInteger)getRowCountForMeal
{
    NSUInteger count = 0;
    for (WLCurrentGroupHotelObject *object in self.groupInfo.mealList) {
        count += ((3 + object.itemList.count) * self.groupInfo.mealList.count );
    }
    count += (self.groupInfo.mealList.count - 1);
    return count;
}

- (NSUInteger)getRowCountForTicket
{
    NSUInteger count = 0;
    for (WLCurrentGroupHotelObject *object in self.groupInfo.ticketList) {
        count += ((3 + object.itemList.count) * self.groupInfo.ticketList.count );
    }
    count += (self.groupInfo.ticketList.count - 1);
    return count;
}

- (NSUInteger)getRowCountForShop
{
    NSUInteger count = 0;
    count = self.groupInfo.shopList.count * 2 + self.groupInfo.shopList.count - 1;
    return count;
}
- (NSUInteger)getRowCountForAdditional
{
    NSUInteger count = 0;
    count = self.groupInfo.addList.count * 2 + self.groupInfo.addList.count - 1;
    return count;
}


- (GroupItemCellType)getCell2TypeWithIndexPath:(NSIndexPath *)indexPath type:(TouristItemType)type
{
    if (type == TouristItemTypeCar) {
        if (indexPath.row == 0) {
            return GroupItemCellTypeCarTitle;
        }
        if (indexPath.row == 3) {
            return GroupItemCellTypeContact;
        }
        if (indexPath.row == 4) {
            return GroupItemCellTypeAction;
        }
        return GroupItemCellTypeCarItem;
        
    }else if (type == TouristItemTypeHotel || type == TouristItemTypeMeal || type == TouristItemTypeTicket) {
        
        NSUInteger count = [self getCell2RowCountWithSection:indexPath.section type:type];
        if (indexPath.row == 0) {
            return GroupItemCellTypeTitle;
        }
        if (indexPath.row == count - 1) {
            return GroupItemCellTypeAction;
        }
        if (indexPath.row == count - 2) {
            return GroupItemCellTypeContact;
        }
        return GroupItemCellTypeItem;
        
    }else if (type == TouristItemTypeShopping || type == TouristItemTypeAdditional) {
        if (indexPath.row == 0) {
            return GroupItemCellTypeContact;
        }
        if (indexPath.row == 1) {
            return GroupItemCellTypeAction;
        }
    }
    return GroupItemCellTypeItem;
}

- (NSArray *)getCellDataArrayWithSection:(NSUInteger )section
{
    
    NSArray *itemArray = [self getCellItemTypeArray];
    NSArray *tempArray;

    TouristItemType type = (TouristItemType)((NSString *)itemArray[section]).integerValue;
    switch (type) {
        case TouristItemTypeCar:{
            tempArray = self.groupInfo.carList;
            break;
        }
        case TouristItemTypeHotel:{
            tempArray = self.groupInfo.hotelList;
            break;
        }
        case TouristItemTypeMeal:{
            tempArray = self.groupInfo.mealList;
            break;
        }
        case TouristItemTypeTicket:{
            tempArray = self.groupInfo.ticketList;
            break;
        }
        case TouristItemTypeShopping:{
            tempArray = self.groupInfo.shopList;
            break;
        }
        case TouristItemTypeAdditional:{
            tempArray = self.groupInfo.addList;
            break;
        }
            
        default:
            break;
    }
    
    return tempArray;
}

- (NSUInteger)getCell2RowCountWithSection:(NSUInteger)section type:(TouristItemType)type
{
    if (type == TouristItemTypeCar) {
        return 5;
    }else if (type == TouristItemTypeHotel) {
        WLCurrentGroupHotelObject *object = self.dataArray[section];
        return 3 + object.itemList.count;
    }else if (type == TouristItemTypeMeal) {
        WLCurrentGroupHotelObject *object = self.dataArray[section];
        return 3 + object.itemList.count;
    }else if (type == TouristItemTypeTicket) {
        WLCurrentGroupHotelObject *object = self.dataArray[section];
        return 3 + object.itemList.count;
    }else if (type == TouristItemTypeShopping) {
        return 2 ;
    }else if (type == TouristItemTypeAdditional) {
        return 2;
    }
    return 3;
}

- (NSArray *)getCell2DataArrayWithIndexPath:(NSIndexPath *)indexPath type:(TouristItemType)type
{
    if (type == TouristItemTypeCar) {
        WLCurrentGroupCarObject *object = self.dataArray[indexPath.section];
        if (indexPath.row == 0) {
            return @[@"车型",@"订单价"];
        }
        if (indexPath.row == 1) {
            return @[CHECKNIL(object.carAmount),CHECKNIL(object.price)];
        }
        if (indexPath.row == 2) {
            return @[CHECKNIL(object.companyName),CHECKNIL(object.carNO)];
        }
        if (indexPath.row == 3) {
            return @[CHECKNIL(object.contactName),CHECKNIL(object.contactMobile)];
        }
        if (indexPath.row == 4) {
            return @[@"联系司机",CHECKNIL(object.buttonName)];
        }
        
    }else if (type == TouristItemTypeHotel) {
        WLCurrentGroupHotelObject *object = self.dataArray[indexPath.section];
        if (indexPath.row == 0) {
            return @[@"类型",@"单价",@"数量"];
        }
        NSUInteger count = [self getCell2RowCountWithSection:indexPath.section type:type];
        if (indexPath.row == count - 1) {
            return @[@"联系酒店",CHECKNIL(object.buttonName)];
        }
        if (indexPath.row == count - 2) {
            return @[object.companyName, object.contactName];
        }
        WLCurrentGroupListObject *listO = object.itemList[indexPath.row - 1];
        return @[listO.priceListName, listO.checkPrice, listO.checkCount];
        
    }else if (type == TouristItemTypeMeal) {
        WLCurrentGroupHotelObject *object = self.dataArray[indexPath.section];
        if (indexPath.row == 0) {
            return @[@"类型",@"单价",@"数量"];
        }
        NSUInteger count = [self getCell2RowCountWithSection:indexPath.section type:type];
        if (indexPath.row == count - 1) {
            return @[@"联系餐厅",CHECKNIL(object.buttonName)];
        }
        if (indexPath.row == count - 2) {
            return @[object.companyName, object.contactName];
        }
        WLCurrentGroupListObject *listO = object.itemList[indexPath.row - 1];
        return @[listO.priceListName, listO.checkPrice, listO.checkCount];
    }else if (type == TouristItemTypeTicket) {
        WLCurrentGroupHotelObject *object = self.dataArray[indexPath.section];
        if (indexPath.row == 0) {
            return @[@"类型",@"单价",@"数量"];
        }
        NSUInteger count = [self getCell2RowCountWithSection:indexPath.section type:type];
        if (indexPath.row == count - 1) {
            return @[@"联系景点",CHECKNIL(object.buttonName)];
        }
        if (indexPath.row == count - 2) {
            return @[object.companyName, object.contactName];
        }
        WLCurrentGroupListObject *listO = object.itemList[indexPath.row - 1];
        return @[listO.priceListName, listO.checkPrice, listO.checkCount];
    }else if (type == TouristItemTypeShopping) {
        WLCurrentGroupShopObject *object = self.dataArray[indexPath.section];
        if (indexPath.row == 1) {
            return @[@"联系商店",CHECKNIL(object.buttonName)];
        }
        if (indexPath.row == 0) {
            return @[object.companyName, object.contactName];
        }
    }else if (type == TouristItemTypeAdditional) {
        WLCurrentGroupShopObject *object = self.dataArray[indexPath.section];
        if (indexPath.row == 1) {
            return @[@"联系商家",CHECKNIL(object.buttonName)];
        }
        if (indexPath.row == 0) {
            return @[object.companyName, object.contactName];
        }
    }
    return [NSArray array];
}

- (BOOL)isFoldWithSection:(NSUInteger)section
{
    NSString *foldString = self.isFoldArray[section];
    return !foldString.boolValue;
}

- (CGFloat)getCellRowHeight
{
    CGFloat height = 0;
    NSArray *itemArray = [self getCellItemTypeArray];
    for (int i = 0; i < itemArray.count; i++) {
        TouristItemType type = ((NSString *)itemArray[i]).integerValue;
        switch (type) {
            case TouristItemTypeCar:{
                if (![self isFoldWithSection:i]) {
                    
                    height += ScaleH(45);
                }else{
                    height += ((self.groupInfo.carList.count * 5 + 1) * ScaleH(45) + (self.groupInfo.carList.count - 1) * ScaleH(10));
                }
                break;
            }
            case TouristItemTypeHotel:{
                if (![self isFoldWithSection:i]) {
                    
                    height += ScaleH(45);
                }else{
                    for (WLCurrentGroupHotelObject *object in self.groupInfo.hotelList) {
                        height += ((object.itemList.count + 3) * ScaleH(45));
                    }
                    height += (ScaleH(45) + (self.groupInfo.hotelList.count - 1) * ScaleH(10));
                }
                break;
            }
            case TouristItemTypeMeal:{
                if (![self isFoldWithSection:i]) {
                    height += ScaleH(45);
                    
                }else{
                    for (WLCurrentGroupHotelObject *object in self.groupInfo.mealList) {
                        height += ((object.itemList.count + 3) * ScaleH(45));
                    }
                    height += (ScaleH(45) + (self.groupInfo.mealList.count - 1) * ScaleH(10));
                }
                break;
            }
            case TouristItemTypeTicket:{
                if (![self isFoldWithSection:i]) {
                    height += ScaleH(45);
                }else{
                    
                    for (WLCurrentGroupHotelObject *object in self.groupInfo.ticketList) {
                        height += ((object.itemList.count + 3) * ScaleH(45));
                    }
                    height += (ScaleH(45) + (self.groupInfo.ticketList.count - 1) * ScaleH(10));
                    
                }
                break;
            }
            case TouristItemTypeShopping:{
                if (![self isFoldWithSection:i]) {
                    height += ScaleH(45);
                }else{
                    height += ((self.groupInfo.shopList.count * 2 + 1) * ScaleH(45) + (self.groupInfo.shopList.count - 1) * ScaleH(10));
                }
                break;
            }
            case TouristItemTypeAdditional:{
                if (![self isFoldWithSection:i]) {
                    height += ScaleH(45);
                }else{
                    height += ((self.groupInfo.addList.count * 2 + 1) * ScaleH(45) + (self.groupInfo.addList.count - 1) * ScaleH(10));
                    
                }
                break;
            }
                
            default:
                break;
        }
    }
    if ([self getCellSectionCount] > 1) {
        
        height += (([self getCellSectionCount] - 1) * ScaleH(15));
    }
    return height;
}

- (CGFloat)getCell2RowHeightWithIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    TouristItemType type = [self getCellItemTypeWithSection:indexPath.section];
    if (type == TouristItemTypeCar) {
        height += ((self.groupInfo.carList.count * 5) * ScaleH(45) + (self.groupInfo.carList.count - 1) * ScaleH(10));

    }else if (type == TouristItemTypeHotel){
        for (WLCurrentGroupHotelObject *object in self.groupInfo.hotelList) {
            height += ((object.itemList.count + 3) * ScaleH(45));
        }
        height += ((self.groupInfo.hotelList.count - 1) * ScaleH(10));
    }else if (type == TouristItemTypeMeal){
        for (WLCurrentGroupHotelObject *object in self.groupInfo.mealList) {
            height += ((object.itemList.count + 3) * ScaleH(45));
        }
        height += ((self.groupInfo.mealList.count - 1) * ScaleH(10));
    }else if (type == TouristItemTypeTicket){
        for (WLCurrentGroupHotelObject *object in self.groupInfo.ticketList) {
            height += ((object.itemList.count + 3) * ScaleH(45));
        }
        height += ((self.groupInfo.ticketList.count - 1) * ScaleH(10));
    }else if (type == TouristItemTypeShopping){
        height += ((self.groupInfo.shopList.count * 2) * ScaleH(45) + (self.groupInfo.shopList.count - 1) * ScaleH(10));
    }else if (type == TouristItemTypeAdditional){
        height += ((self.groupInfo.addList.count * 2) * ScaleH(45) + (self.groupInfo.addList.count - 1) * ScaleH(10));
    }
    return height;
    
    
}
@end
