//
//  LeoActionPicker.m
//  ActionSheetPicker-iOS-5-7
//
//  Created by guohao on 1/8/15.
//
//

#import "LeoActionPicker.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetCustomPicker.h"
#import "ActionSheetPickerCustomPickerDelegate.h"

// 👇此文件用于自定义段数的picker
#import "ActionSheetCustomGroupPickerDelegate.h"
@implementation LeoActionPicker

+ (void)showPickerWithSender:(id)sender
                       Title:(NSString*)title
                       Array:(NSArray*)array
                   InitIndex:(NSInteger)initIndex
                       Block:(onSelectBlock)block{
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if (block) {
            block(selectedIndex);
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
       
    };
    [ActionSheetStringPicker showPickerWithTitle:title rows:array initialSelection:initIndex doneBlock:done cancelBlock:cancel origin:sender];
}

+ (void)showDatePickerWithSender:(id)sender
                           Title:title
                           Block:(onDateSelectBlock)block{
   
    
    ActionSheetDatePicker* actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:title
                                                                             datePickerMode:UIDatePickerModeDate
                                                                               selectedDate:[NSDate date]
                                                                                  doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                                                                      if (block) {
                                                                                          block(selectedDate);
                                                                                      }
                                                                                  } cancelBlock:^(ActionSheetDatePicker *picker) {
                                                                                      
                                                                                  } origin:sender];
    
    [actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    actionSheetPicker.hideCancel = YES;
    [actionSheetPicker showActionSheetPicker];
}

+ (void)showTwoGroupPickerWithSender:(id)senderView
                           ArrayLeft:(NSArray*)arrayleft
                       initLeftIndex:(NSInteger)initLeft
                          ArrayRight:(NSArray*)arrayright
                      initRightIndex:(NSInteger)initRight
                               Title:(NSString*)title
                               Block:(onTwoGroupBlock)block{
    ActionSheetPickerCustomPickerDelegate *delg = [[ActionSheetPickerCustomPickerDelegate alloc] initWithArrayLeft:arrayleft
                                                                                                          initLeft:initLeft
                                                                                                        ArrayRight:arrayright
                                                                                                         initRight:initRight];
    [delg setSelectBlock:^(NSInteger leftIndex, NSInteger rightIndex) {
        if (block) {
            block(leftIndex,rightIndex);
        }
    }];
    NSNumber *yass1 = @(initLeft);
    NSNumber *yass2 = @(initRight);
    
    NSArray *initialSelections = @[yass1, yass2];
    
    [ActionSheetCustomPicker showPickerWithTitle:title delegate:delg showCancelButton:NO origin:senderView
                               initialSelections:initialSelections];
}

+ (void)showCustomGroupPickerWithSender:(id)senderView
                                  Title:(NSString*)title
                                  Group:(NSArray*)group
                                  Block:(void (^)(NSArray* selectArray))block{
    
    ActionSheetCustomGroupPickerDelegate* delegate = [[ActionSheetCustomGroupPickerDelegate alloc] initWithGroupArray:group Title:title Block:block];
    
    
    NSMutableArray* defaultArray = [NSMutableArray new];
    for (int i = 0; i < group.count; i++) {
        [defaultArray addObject:@(0)];
    }
    
    ActionSheetCustomPicker* picker;
    picker = [ActionSheetCustomPicker showPickerWithTitle:title
                                                 delegate:delegate
                                         showCancelButton:NO
                                                   origin:senderView
                                        initialSelections:defaultArray];
    
    CGFloat width = 62.5/375 * SCREEN_WIDTH;
    CGFloat x = 110/375.f * SCREEN_WIDTH;
    CGFloat delta = 100.f/375 * SCREEN_WIDTH;
    
    UILabel* adv = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, width, 35)];
    adv.text = NSLocalizedString(@"In Advance", nil);
    adv.textAlignment = NSTextAlignmentCenter;
    adv.adjustsFontSizeToFitWidth = YES;
    adv.font = [UIFont systemFontOfSize:14];
    [picker.pickerView addSubview:adv];
    
    UILabel* day = [[UILabel alloc] initWithFrame:CGRectMake(x, 90, width, 35)];
    day.text = NSLocalizedString(@"Day(s)", nil);
    day.textAlignment = NSTextAlignmentCenter;
    day.font = [UIFont systemFontOfSize:14];
    [picker.pickerView addSubview:day];
    
    UILabel* hour = [[UILabel alloc] initWithFrame:CGRectMake(x + delta, 90, width, 35)];
    hour.text = @":";
    hour.textAlignment = NSTextAlignmentCenter;
    [picker.pickerView addSubview:hour];
    
}

@end
