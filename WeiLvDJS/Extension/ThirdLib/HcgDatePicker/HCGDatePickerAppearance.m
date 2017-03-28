//
//  HCGDatePickerAppearance.m
//  HcgDatePicker-master
//
//  Created by 黄成钢 on 14/12/2016.
//  Copyright © 2016 chedaoshanqian. All rights reserved.
//

#import "HCGDatePickerAppearance.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define DATE_PICKER_HEIGHT 216.0f
#define TOOLVIEW_HEIGHT 40.0f
#define BACK_HEIGHT TOOLVIEW_HEIGHT + DATE_PICKER_HEIGHT

typedef void(^dateBlock)(BOOL isCancel, NSDate *);

@interface HCGDatePickerAppearance ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) DatePickerMode dataPickerMode;
@property (nonatomic, copy) dateBlock dateBlock;
@property (nonatomic, strong) HCGDatePicker *datePicker;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *selectDate;

@property (nonatomic, strong) NSDate *baseDate;

@end

@implementation HCGDatePickerAppearance

- (instancetype)initWithDatePickerMode:(DatePickerMode)dataPickerMode baseDate:(NSDate *)baseDate completeBlock:(void (^)(BOOL, NSDate *))completeBlock{
    self = [super init];
    if (self) {
        _dataPickerMode = dataPickerMode;
        _baseDate = baseDate;
        [self setupUI];
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _dateBlock = completeBlock;
    }
    return self;
}

- (instancetype)initWithDatePickerMode:(DatePickerMode)dataPickerMode
                               minDate:(NSDate *)minDate
                               maxDate:(NSDate *)maxDate
                            selectDate:(NSDate *)selectDate
                         completeBlock:(void (^)(BOOL, NSDate *))completeBlock
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _dataPickerMode = dataPickerMode;
        _minDate = minDate;
        _maxDate = maxDate;
        _selectDate = selectDate;
        _dateBlock = completeBlock;
        [self setupUI];
        
        
    }
    return self;
}

- (void)setupUI {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, BACK_HEIGHT)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    _datePicker = [[HCGDatePicker alloc] initWithDatePickerMode:_dataPickerMode MinDate:_minDate MaxDate:_maxDate selectedDate:_selectDate];
    _datePicker.frame = CGRectMake(0, TOOLVIEW_HEIGHT, kScreenWidth, DATE_PICKER_HEIGHT);
    [self.backView addSubview:_datePicker];
    
    UIButton *btn0 = [[UIButton alloc]initWithFrame:CGRectMake(0, 8, 80, 40)];
    [btn0 setTitle:@"取消" forState:UIControlStateNormal];
    [btn0 setTitleColor:Color1 forState:UIControlStateNormal];
    btn0.tag = 0;
    [btn0 addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:btn0];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 8, 80, 40)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:Color1 forState:UIControlStateNormal];
    btn.tag = 1;
    [btn addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:btn];
    
}

- (void)done:(UIButton *)button {
    if (_dateBlock) {
        if (button.tag == 0) {
           _dateBlock(YES,  nil);
        }else{
            _dateBlock(NO, _datePicker.date);
        }
        
    }
}

- (void)selectDate:(NSDate *)date
{
    [_datePicker selectDate:date];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:0.25 animations:^{
        _backView.frame = CGRectMake(0, kScreenHeight - (BACK_HEIGHT), kScreenWidth, BACK_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
}

-(void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        _backView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, BACK_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

@end
