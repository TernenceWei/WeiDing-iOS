//
//  HCGDatePickerAppearance.h
//  HcgDatePicker-master
//
//  Created by 黄成钢 on 14/12/2016.
//  Copyright © 2016 chedaoshanqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCGDatePicker.h"


@interface HCGDatePickerAppearance : UIView

- (instancetype)initWithDatePickerMode:(DatePickerMode)dataPickerMode
                              baseDate:(NSDate *)baseDate
                         completeBlock:(void (^)(BOOL isCancel, NSDate *date))completeBlock;

- (instancetype)initWithDatePickerMode:(DatePickerMode)dataPickerMode
                               minDate:(NSDate *)minDate
                               maxDate:(NSDate *)maxDate
                            selectDate:(NSDate *)selectDate
                         completeBlock:(void (^)(BOOL isCancel, NSDate *date))completeBlock;

- (void)show;

- (void)hide;

@end
