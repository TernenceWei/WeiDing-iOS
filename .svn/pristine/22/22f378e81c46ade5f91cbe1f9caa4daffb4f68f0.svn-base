//
//  WLCarBookingAddressCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AddressActionType) {
    AddressActionTypeInputStartingPoint    = 1,
    AddressActionTypeInputTerminalPoint    = 2,
    AddressActionTypeAddPoint              = 3,
    AddressActionTypeDeletePoint           = 4,
    AddressActionTypeInputVisaPoint        = 5,
    
};

@interface WLCarBookingAddressCell : UITableViewCell

+ (WLCarBookingAddressCell *)cellWithTableView:(UITableView*)tableView
                                    titleArray:(NSArray *)titleArray
                                 addressAction:(void(^)(AddressActionType actionType, NSInteger deleteIndex))addressAction
                                   detailArray:(NSArray *)detailArray;



@end
