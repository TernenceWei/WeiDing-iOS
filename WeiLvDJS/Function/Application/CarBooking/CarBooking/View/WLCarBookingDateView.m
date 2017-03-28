//
//  WLCarBookingDateView.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingDateView.h"

@interface WLCarBookingDateView ()

@property (nonatomic, copy) void(^onActionBlock)(BOOL isCancel, NSDate *date);
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation WLCarBookingDateView

- (instancetype)initWithFrame:(CGRect)frame
                     justDate:(BOOL)justDate
                  actionBlock:(void (^)(BOOL, NSDate *))actionBlock
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        self.onActionBlock = actionBlock;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        line.backgroundColor = bordColor;
        [self addSubview:line];
        
        //取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelBtn.frame = CGRectMake(5, 0, 50, 35);
        [cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.tag = 501;
        [cancelBtn setTintColor:[WLTools stringToColor:@"#4977e7"]];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:Color1 forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont WLFontOfSize:15];
        [self addSubview:cancelBtn];
        
        //确定按钮
        UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        confrimBtn.frame = CGRectMake(ScreenWidth-55, 0, 50, 35);
        [confrimBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        confrimBtn.tag = 502;
        [confrimBtn setTintColor:[WLTools stringToColor:@"#4977e7"]];
        [confrimBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confrimBtn setTitleColor:Color1 forState:UIControlStateNormal];
        confrimBtn.titleLabel.font = [UIFont WLFontOfSize:15];
        [self addSubview:confrimBtn];
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 35, ScreenWidth, 200)];
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        if (justDate) {
            datePicker.datePickerMode = UIDatePickerModeDate;
        }
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CHS_CN"];
        datePicker.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        [self addSubview:datePicker];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setMonth:3];
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [datePicker setMaximumDate:maxDate];
        [datePicker setMinimumDate:[NSDate date]];
        self.datePicker = datePicker;
    }
    return self;
}

- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 501) {
        self.onActionBlock(YES, nil);
    }else{
        self.onActionBlock(NO, self.datePicker.date);
    }
    
}
@end
