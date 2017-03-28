//
//  WLApplicationDriverBookOrderSectionStatusView.h
//  WeiLvDJS
//
//  Created by whw on 17/1/21.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLApplicationDriverBookOrderCell.h"

@interface WLApplicationDriverBookOrderSectionStatusView : UIView
- (instancetype)initWithStatus:(WLBookOrderStatus)status andFrame:(CGRect)frame;
@end
