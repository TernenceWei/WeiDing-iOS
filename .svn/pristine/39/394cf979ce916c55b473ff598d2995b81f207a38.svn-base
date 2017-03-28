//
//  WL_BaseViewController.h
//  WeiLv
//
//  Created by James on 16/5/19.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
// 【微旅管家】->控制器 基类

#import <UIKit/UIKit.h>

//定义导航枚举类型
typedef enum{
  isPush,
  isModel
}WLPushType;


@interface WL_BaseViewController : UIViewController
{
    WLPushType _pushType;
}

/**
 *  设置加载菊花
 */

@property (nonatomic,strong)MBProgressHUD *progressHud;


@property(nonatomic,assign)WLPushType pushType;

/**
 *  设置导航栏
 */
-(void)setNavBarImage;

/**
 *  设置导航栏背景颜色
 */
-(void)setNavBarBackgroundColor;


/**
 *  设置左侧导航栏图片
 *
 *  @param imageName 左侧导航图片名称
 */
-(void)setNavigationLeftImg:(NSString *)imageName;


/**
 *  设置右侧导航栏图片
 *
 *  @param imageName 右侧导航图片名称
 */
-(void)setNavigationRightImg:(NSString *)imageName;


/**
 *  设置左侧导航栏标题
 *
 *  @param titleName  左侧导航标题名称
 *  @param fontSize   标题字号
 *  @param titleColor 标题颜色
 *  @param isEnable   是否可用
 */
-(void)setNavigationLeftTitle:(NSString *)titleName fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor isEnable:(BOOL)isEnable;

/**
 *  设置右侧导航栏标题
 *
 *  @param titleName  右侧导航标题名称
 *  @param fontSize   标题字号
 *  @param titleColor 标题颜色
 *  @param isEnable   是否可用
 */
-(void)setNavigationRightTitle:(NSString *)titleName fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor isEnable:(BOOL)isEnabl;

/**
 * 左侧导航 点击事件
 */
-(void)NavigationLeftEvent;

/**
 * 右侧导航 点击事件
 */
-(void)NavigationRightEvent;


/**
 * 显示菊花
 */

- (void)showHud;

/**
 * 隐藏菊花
 */

- (void)hidHud;

/**
 * 定制菊花下方显示字体
 */

- (void)showHudWithString:(NSString *)loadingText;



@end
