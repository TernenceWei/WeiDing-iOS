//
//  WLCarBookingDateView.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCarBookingDateView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                     justDate:(BOOL)justDate
                  actionBlock:(void(^)(BOOL isCancel, NSDate *date))actionBlock;

@end
