//
//  WL_Application_Driver_RefuseOrderView.h
//  WeiLvDJS
//
//  Created by whw on 16/12/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WL_Application_Driver_RefuseOrderView : UIView
/**< 按钮点击事件的回调 */
@property (nonatomic, copy) void(^ButtonCallBlack)(NSArray *);
/**< 点击其它原因按钮的回调 */
@property (nonatomic, copy) void(^otherReasonCallBlack)(BOOL isSelected);
/**< 其它原因输入框 */
@property (nonatomic, weak) UITextView *reasonTextView;
@end
