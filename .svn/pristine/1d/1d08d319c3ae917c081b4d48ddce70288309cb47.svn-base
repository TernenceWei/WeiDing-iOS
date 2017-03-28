//
//  WLRemarkCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLRemarkCell : UITableViewCell
+ (WLRemarkCell *)cellWithTableView:(UITableView*)tableView
                             remark:(NSString *)remark
                                tag:(NSUInteger)tag
                            canEdit:(BOOL)canEdit
                      keyboardBlock:(void(^)(BOOL keyboardShow,CGFloat height, NSUInteger section))keyboardBlock middleRemark:(NSString *)middleRemark;

- (NSString *)getUploadeRemark;
@property (nonatomic, strong) XKPEPlaceholderTextView *textView;
@end
