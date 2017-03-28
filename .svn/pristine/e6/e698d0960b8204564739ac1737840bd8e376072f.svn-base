//
//  WL_Alert_View.h
//  WeiLv
//
//  Created by nicz on 16/6/20.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AlertType){
    
    AlertTypeNormal,                    //普通样式（取消按钮文本为灰色）
    
    AlertTypeCall,                      //拨打电话样式
    
    AlertTypeHighlight,                 //高亮样式（取消按钮文本为蓝色）
    
    AlertTypePurchase                   //采购样式
};

@interface WL_Alert_View : UIView

@property(copy, nonatomic) void (^otherButtonClicked)(void);

@property(copy, nonatomic) void (^cancelButtonClicked)(void);

@property(weak, nonatomic) UIView *alertView;

@property(weak, nonatomic) UILabel *titleLabel;

@property(weak, nonatomic) UILabel *messageLabel;

@property(weak, nonatomic) UILabel *cancelBtn;

@property(weak, nonatomic) UILabel *otherBtn;

/**
 * 初始化警告框(注意：请将警告框加载至UIWindow中，并在dealloc方法中将警告框从父类中删除，同时请保证controller中不要出现循环引用)
 */
- (instancetype)init;

/**
 * 设置警告框布局样式
 *
 * @param  type          警告框样式
 * @param  title         警告框标题
 * @param  message       警告框提示消息内容
 * @param  cancelTiTle   取消按钮文本
 * @param  otherTitle    其他按钮问题
 */
- (void)setAlertType:(AlertType)type title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle andOtherButtonTitle:(NSString *)otherTitle;

/**
 * 设置隐藏/显示
 */
- (void)hide:(BOOL)hidden;

@end
