//
//  ActionSheetPickerCustomPickerDelegate.m
//  ActionSheetPicker
//
//  Created by  on 13/03/2012.
//  Copyright (c) 2012 Club 15CC. All rights reserved.
//

#import "ActionSheetPickerCustomPickerDelegate.h"

@implementation ActionSheetPickerCustomPickerDelegate

- (id)initWithArrayLeft:(NSArray*)arrayLeft
               initLeft:(NSInteger)ileft
             ArrayRight:(NSArray*)arrayRight
              initRight:(NSInteger)iright
{
    if (self = [super init]) {
        notesToDisplayForKey = arrayLeft;
        scaleNames = arrayRight;
        self.selectLeft = ileft;
        self.selectRight = iright;
    }
    return self;
}
- (void)setSelectBlock:(onTwoGroupSelectBlock)block{
    selectBlock = block;
}
/////////////////////////////////////////////////////////////////////////
#pragma mark - ActionSheetCustomPickerDelegate Optional's 
/////////////////////////////////////////////////////////////////////////
- (void)configurePickerView:(UIPickerView *)pickerView
{
    // Override default and hide selection indicator
    pickerView.showsSelectionIndicator = NO;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    
    if (selectBlock) {
        selectBlock(self.selectLeft,self.selectRight);
    }
//    NSString *resultMessage = [NSString stringWithFormat:@"%@ %@ selected.",
//                                                         self.selectedKey,
//                                                         self.selectedScale];
    
   // [[[UIAlertView alloc] initWithTitle:@"Success!" message:resultMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource Implementation
/////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView 
{ 
    return 2; 
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{ 
    // Returns
    switch (component) {
        case 0: return [notesToDisplayForKey count];
        case 1: return [scaleNames count];
        default:break;
    }
    return 0;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark UIPickerViewDelegate Implementation
/////////////////////////////////////////////////////////////////////////

// returns width of column and height of row for each component. 
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: return SCREEN_WIDTH/2;
        case 1: return SCREEN_WIDTH/2;
        default:break;
    }
    
    return 0;
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
    switch (component) {
        case 0: return notesToDisplayForKey[(NSUInteger) row];
        case 1: return scaleNames[(NSUInteger) row];
        default:break;
    }
    return nil;
}

/////////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            self.selectedKey = notesToDisplayForKey[(NSUInteger) row];
            self.selectLeft = row;
            return;
            
        case 1:
            self.selectedScale = scaleNames[(NSUInteger) row];
            self.selectRight = row;
            return;
        default:break;
    }
}


@end
