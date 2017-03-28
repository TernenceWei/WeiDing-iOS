//
//  TLDatePicker.h
//  TLDatePicker
//
//  Created by ternence on 2017/2/17.
//  Copyright © 2017年 ternence. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TLDatePicker;

@protocol TLDatePickerDelegate <NSObject>

@optional
- (void)datePicker:(TLDatePicker *)datePicker didSelectedDate:(NSDate *)date;

@end

typedef enum {
    DatePickerYearMonthMode = 2,
    DatePickerDateMode,
    DatePickerHourMode
}DatePickerMode;

@interface TLDatePicker : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id<TLDatePickerDelegate> dvDelegate;

@property (nonatomic, strong) UIColor *monthSelectedTextColor;
@property (nonatomic, strong) UIColor *monthTextColor;

@property (nonatomic, strong) UIColor *yearSelectedTextColor;
@property (nonatomic, strong) UIColor *yearTextColor;

@property (nonatomic, strong) UIFont *monthSelectedFont;
@property (nonatomic, strong) UIFont *monthFont;

@property (nonatomic, strong) UIFont *yearSelectedFont;
@property (nonatomic, strong) UIFont *yearFont;

@property (nonatomic, assign) NSInteger rowHeight;
/**< 默认显示的日期 */
@property (nonatomic, strong) NSDate *defaultDate;

/**
 *  查看datePicker当前选择的日期
 */
@property (nonatomic, strong, readonly) NSDate *date;


/**
 *  datePicker显示date
 */
- (void)selectDate:(NSDate *)date;

/**
 *  datePicker设置最小年份和最大年份
 */
- (void)setMinDate:(NSDate *)minDate;

-(instancetype)initWithDatePickerMode:(DatePickerMode)datePickerMode MinDate:(NSDate *)minDate MaxDate:(NSDate *)maxDate;

@end
