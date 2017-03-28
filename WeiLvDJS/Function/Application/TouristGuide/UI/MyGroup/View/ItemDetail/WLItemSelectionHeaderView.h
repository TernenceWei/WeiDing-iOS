//
//  WLItemSelectionHeaderView.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTouristGroupHeader.h"

@interface WLItemSelectionHeaderView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                     itemType:(TouristItemType)type
                      section:(NSUInteger)section;
@end
