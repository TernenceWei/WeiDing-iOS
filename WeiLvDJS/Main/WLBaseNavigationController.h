//
//  WLBaseNavigationController.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/23.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  自定义导航栏


/**
 *  关于导航栏
 1.如需自定义导航栏，控制器继承自WLBaseNavigationController，该控制器继承自WL_BaseViewController,主要处理导航栏事宜,如不需要请继承自WL_BaseViewController。

 2.如果想要添加导航栏右边的按钮，添加代码self.titleItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Information-Icon"] style:UIBarButtonItemStyleBordered target:self                                                                     action:@selector(vidgetGuideBtnDidClicked)];相应的点击事件自行处理
 
 3.如果想要在返回按钮的点击事件中处理一些事物，重载backButtonAction方法，最后调用super方法

 4.Controller内部的view frame从65开始，因为导航栏属于控制器。
 
 5.如需更改title文字，请添加代码 self.titleItem.title = @"device monitor"或self.navigationItem.titleView;
 
 */


#import <UIKit/UIKit.h>
#import "WL_BaseViewController.h"

@interface WLBaseNavigationController : WL_BaseViewController

@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) UINavigationItem *titleItem;

- (void)setupNavigationBar;
- (void)backButtonAction;
@end
