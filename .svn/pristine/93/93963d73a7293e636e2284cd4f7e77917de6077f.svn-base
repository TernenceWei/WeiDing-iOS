//
//  TLDatePickerAppearance.m
//  TLDatePicker
//
//  Created by ternence on 2017/2/17.
//  Copyright © 2017年 ternence. All rights reserved.
//

#import "TLDatePickerAppearance.h"

#define DATE_PICKER_HEIGHT 216.0f
#define TOOLVIEW_HEIGHT 40.0f
#define BACK_HEIGHT TOOLVIEW_HEIGHT + DATE_PICKER_HEIGHT

typedef void(^dateBlock)(NSDate *);

@interface TLDatePickerAppearance ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, assign) DatePickerMode dataPickerMode;

@property (nonatomic, copy) dateBlock dateBlock;
@property (nonatomic, strong) TLDatePicker *datePicker;

@end

@implementation TLDatePickerAppearance

- (instancetype)initWithDatePickerMode:(DatePickerMode)dataPickerMode completeBlock:(void (^)(NSDate *date))completeBlock {
    self = [super init];
    if (self) {
        _dataPickerMode = dataPickerMode;
        [self setupUI];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _dateBlock = completeBlock;
    }
    return self;
}
- (instancetype)initWithDatePicker:(TLDatePicker *)datePicker DatePickerMode:(DatePickerMode)dataPickerMode completeBlock:(void (^)(NSDate *date))completeBlock
{
    self = [super init];
    if (self) {
        _dataPickerMode = dataPickerMode;
        _datePicker = datePicker;
        [self setupUI];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _dateBlock = completeBlock;
    }
    return self;

}
- (void)setupUI {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, BACK_HEIGHT)];
    _backView.backgroundColor = [UIColor whiteColor];
    
    if (!_datePicker) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDate *minDate = [NSDate dateWithTimeIntervalSince1970:0];
        NSDateComponents *maxComps = [[NSDateComponents alloc] init];
        [maxComps setYear:0];
        NSDate *maxDate = [calendar dateByAddingComponents:maxComps toDate:currentDate options:0];
        _datePicker = [[TLDatePicker alloc]initWithDatePickerMode:_dataPickerMode MinDate:minDate MaxDate:maxDate];
        _datePicker.frame = CGRectMake(0, TOOLVIEW_HEIGHT, ScreenWidth, DATE_PICKER_HEIGHT);
    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 80, 8, 80, 40)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:15/255.0f green:136/255.0f blue:235/255.0f alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_datePicker];
    [self.backView addSubview:btn];
    [self addSubview:self.backView];
}

- (void)done {
    if (_dateBlock) {
        _dateBlock(_datePicker.date);
    }
    [self hide];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:0.25 animations:^{
        _backView.frame = CGRectMake(0, ScreenHeight - (BACK_HEIGHT), ScreenWidth, BACK_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
}

-(void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        _backView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, BACK_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
