//
//  WLCarBookingInfoCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCarBookingInfoCell : UITableViewCell

+ (WLCarBookingInfoCell *)cellWithTableView:(UITableView*)tableView
                                clickAction:(void(^)(NSUInteger index))clickAction
                              placeHoldText:(NSString *)placeHoldText
                                 placeImage:(UIImage *)image;

- (void)setText:(NSString *)text;
- (void)setImage:(UIImage *)image;
- (void)setImageUrl:(NSString *)imageUrl;
@end
