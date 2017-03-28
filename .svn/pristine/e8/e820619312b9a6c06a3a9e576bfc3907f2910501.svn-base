//
//  ActionSheetCustomGroupPicker.m
//  PrivacyGuard
//
//  Created by guohao on 21/11/15.
//  Copyright © 2015 LEO. All rights reserved.
//

#import "ActionSheetCustomGroupPickerDelegate.h"

@interface ActionSheetCustomGroupPickerDelegate()
@property (nonatomic,strong) NSArray* dataGroupArray;
@property (nonatomic,strong) NSMutableArray* pickArray;
@property (nonatomic,copy)   void (^onPickerBlock)(NSArray* selectArray);
@end

@implementation ActionSheetCustomGroupPickerDelegate

- (id)initWithGroupArray:(NSArray*)groupArray
                   Title:(NSString*)title
                   Block:(void (^)(NSArray* selectArray))block{
    self = [super init];
    self.dataGroupArray = [NSArray arrayWithArray:groupArray];
    self.onPickerBlock = block;
    return self;
}

- (void)setDataGroupArray:(NSArray *)dataGroupArray{
    _dataGroupArray = dataGroupArray;
    NSInteger n  = dataGroupArray.count;
    self.pickArray = [NSMutableArray new];
    for (int i = 0; i < n; i++) {
        [self.pickArray addObject:@(0)];
    }
    
}


/////////////////////////////////////////////////////////////////////////
#pragma mark - ActionSheetCustomPickerDelegate Optional's
/////////////////////////////////////////////////////////////////////////
- (void)configurePickerView:(UIPickerView *)pickerView
{
    // Override default and hide selection indicator
    pickerView.showsSelectionIndicator = NO;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin{
    
    if (self.onPickerBlock) {
        self.onPickerBlock(self.pickArray);
    }
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource Implementation
/////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.dataGroupArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray* subArray = self.dataGroupArray[component];
    return subArray.count;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark UIPickerViewDelegate Implementation
/////////////////////////////////////////////////////////////////////////

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH/(self.dataGroupArray.count+1);
}
/*- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {
 return
 }
 */
// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataGroupArray[component][row];
}

/////////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    [self.pickArray replaceObjectAtIndex:component withObject:@(row)];
   
}

@end
