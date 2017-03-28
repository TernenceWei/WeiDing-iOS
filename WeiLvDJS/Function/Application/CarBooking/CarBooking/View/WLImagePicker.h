//
//  WLImagePicker.h
//  WeiLvDJS
//
//  Created by ternence on 2017/2/22.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLImagePicker : UIView


typedef NS_ENUM(NSUInteger, ImagePickerType) {
    ImagePickerTypeCarBooking    = 1,
    
};
- (instancetype)initWithFrame:(CGRect)frame
                   pickerType:(ImagePickerType)type
           attachedController:(UIViewController *)attachedController
                 selectAction:(void(^)(NSArray * array))selectAction;

- (NSArray *)getSelectedImageArray;

- (void)updateFrameWithImageDataArray:(NSArray *)dataArray;

@end
