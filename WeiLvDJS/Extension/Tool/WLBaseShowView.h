//
//  WLBaseShowView.h
//  Show
//
//  Created by whw on 16/11/30.
//  Copyright © 2016年 huhanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KWLBaseShowView [WLBaseShowView sharedBaseShowView]

@interface WLBaseShowView : UIView
/** 单例对象 */
+ (instancetype)sharedBaseShowView;

/** 默认展示View的方式 */ //点击阴影消失 没有回调
- (void)showContentView:(UIView *)contentView;
/**
 展示自定义的view
 @param contentView 自定义的view
 @param canTouchDismiss 是否点击阴影让弹框消失
 @param callblack 当view消失时回调方法
 */

- (void)showWithContentView:(UIView *)contentView andTouch:(BOOL)canTouchDismiss andCallBlack:(void(^)())callblack;

/** 手动取消弹框 */
- (void)dismiss;

@end
