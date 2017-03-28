//
//  ActionSheetPickerCustomPickerDelegate.h
//  ActionSheetPicker
//
//  Created by  on 13/03/2012.
//  Copyright (c) 2012 Club 15CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionSheetPicker.h"
typedef void (^onTwoGroupSelectBlock)(NSInteger leftIndex,NSInteger rightIndex);
@interface ActionSheetPickerCustomPickerDelegate : NSObject <ActionSheetCustomPickerDelegate>
{
    NSArray *notesToDisplayForKey;
    NSArray *scaleNames;
    onTwoGroupSelectBlock selectBlock;
}
- (id)initWithArrayLeft:(NSArray*)arrayLeft
               initLeft:(NSInteger)ileft
             ArrayRight:(NSArray*)arrayRight
              initRight:(NSInteger)iright;
- (void)setSelectBlock:(onTwoGroupSelectBlock)block;
@property (nonatomic, strong) NSString *selectedKey;
@property (nonatomic) NSInteger selectLeft;
@property (nonatomic) NSInteger selectRight;
@property (nonatomic, strong) NSString *selectedScale;

@end
