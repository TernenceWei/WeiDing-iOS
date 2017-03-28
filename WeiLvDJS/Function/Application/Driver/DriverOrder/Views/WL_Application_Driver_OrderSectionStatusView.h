//
//  WL_Application_Driver_OrderSectionStatusView.h
//  WeiLvDJS
//
//  Created by whw on 16/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WL_Application_Driver_OrderDetailBottomView.h"
@interface WL_Application_Driver_OrderSectionStatusView : UIView

- (instancetype)initWithStatus:(WLOrderDetailStatus)status andFrame:(CGRect)frame;
@end
