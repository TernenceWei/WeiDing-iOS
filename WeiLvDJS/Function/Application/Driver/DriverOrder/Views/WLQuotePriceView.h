//
//  WLQuotePriceView.h
//  WeiLvDJS
//
//  Created by whw on 17/2/9.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//  竞价弹框

#import <UIKit/UIKit.h>

@interface WLQuotePriceView : UIView
@property (nonatomic, copy) void(^buttonCallBack)(NSInteger index,NSString *price,NSString *paras);
@end
