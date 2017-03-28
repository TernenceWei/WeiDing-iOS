//
//  WLIncomeStatisticsCenterView.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLIncomeStatisticsItemView : UIView
- (instancetype)initWithFrame:(CGRect)frame flagColor:(UIColor *)color text:(NSString *)text value:(NSUInteger)value;
@end

@interface WLIncomeStatisticsCenterView : UIView
- (instancetype)initWithFrame:(CGRect)frame objectArray:(NSArray *)objectArray;
@end
