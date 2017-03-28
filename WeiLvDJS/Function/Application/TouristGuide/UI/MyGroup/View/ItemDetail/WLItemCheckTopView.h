//
//  WLItemCheckTopView.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLItemDetailHotelObject.h"
#import "WLTouristGroupHeader.h"

@interface WLItemCheckTopView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)itemType
                       object:(WLItemDetailHotelObject *)object;
@end
