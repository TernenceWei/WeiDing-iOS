//
//  WLBillItemCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLBillDetailInfo.h"

typedef NS_ENUM(NSUInteger, BillItemCellType) {
    BillItemCellTypeTitle    = 1,//标题
    BillItemCellTypeHotel    = 2,//酒店，用餐，游玩
    BillItemCellTypeCar      = 3,//用车
    BillItemCellTypeShop     = 4,//购物店，加点项目
    
};

@interface WLBillItemCell : UITableViewCell
+ (WLBillItemCell *)cellWithTableView:(UITableView*)tableView;
@property (nonatomic, assign) BillItemCellType type;
@property (nonatomic, strong) NSArray *textArray;
@end
