//
//  TLDatePickerAppearance.h
//  TLDatePicker
//
//  Created by ternence on 2017/2/17.
//  Copyright © 2017年 ternence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TLDatePicker.h"

@interface TLDatePickerAppearance : UIView

- (instancetype)initWithDatePickerMode:(DatePickerMode)dataPickerMode completeBlock:(void (^)(NSDate *date))completeBlock;
- (instancetype)initWithDatePicker:(TLDatePicker *)datePicker DatePickerMode:(DatePickerMode)dataPickerMode completeBlock:(void (^)(NSDate *date))completeBlock;
- (void)show;
@end
