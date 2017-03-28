//
//  LeoActionPicker.h
//  ActionSheetPicker-iOS-5-7
//
//  Created by guohao on 1/8/15.
//
//

#import <Foundation/Foundation.h>
typedef void (^onSelectBlock)(NSInteger selectedIndex);
typedef void (^onDateSelectBlock)(NSDate* selectedDate);
typedef void (^onTwoGroupBlock)(NSInteger leftIndex, NSInteger rightIndex);

@interface LeoActionPicker : NSObject{
    onSelectBlock selectBlock;
}

+ (void)showPickerWithSender:(id)sender
                       Title:(NSString*)title
                      Array:(NSArray*)array
                  InitIndex:(NSInteger)initIndex
                      Block:(onSelectBlock)block;

+ (void)showDatePickerWithSender:(id)senderView
                           Title:title
                           Block:(onDateSelectBlock)block;


/*!
 * @abstract 自定义段数picker,group为数组的数组
 */
+ (void)showCustomGroupPickerWithSender:(id)senderView
                                  Title:(NSString*)title
                                  Group:(NSArray*)group
                                  Block:(void (^)(NSArray* selectArray))block;

+ (void)showTwoGroupPickerWithSender:(id)senderView
                           ArrayLeft:(NSArray*)arrayleft
                       initLeftIndex:(NSInteger)initLeft
                          ArrayRight:(NSArray*)arrayright
                      initRightIndex:(NSInteger)initRight
                               Title:(NSString*)title
                               Block:(onTwoGroupBlock)block;
@end
