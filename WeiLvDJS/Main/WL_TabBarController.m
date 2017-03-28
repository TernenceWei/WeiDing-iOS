//
//  WL_TabBarController.m
//  WeiLvDJS
//
//  Created by jyc on 16/8/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_TabBarController.h"
#import "WL_MessageViewController.h"
#import "WL_ApplicationViewController.h"
#import "WL_AddressBookViewController.h"
#import "WL_MineViewController.h"
#import "AppDelegate.h"
#import "WL_BaseNavigationViewController.h"
@interface WL_TabBarController ()

@end

@implementation WL_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.
    WL_MessageViewController *oneVC=[[WL_MessageViewController alloc] init];
    oneVC.title= @"消息";
    UINavigationController *oneNav=[[UINavigationController alloc] initWithRootViewController:oneVC];
    
    //2.
    WL_ApplicationViewController *twoVC=[[WL_ApplicationViewController alloc] init];
    twoVC.title= @"应用";
    UINavigationController *twoNav=[[UINavigationController alloc] initWithRootViewController:twoVC];
    
    //3.
    WL_AddressBookViewController *threeVC=[[WL_AddressBookViewController alloc] init];
    threeVC.title= @"联系人";
//    UINavigationController *threeNav=[[UINavigationController alloc] initWithRootViewController:threeVC];
    
    //4.
    WL_MineViewController *fourVC=[[WL_MineViewController alloc] init];
    fourVC.title= @"我的";
    UINavigationController *fourNav=[[UINavigationController alloc] initWithRootViewController:fourVC];
    
#ifdef ONADDRESSBOOK
    
    self.viewControllers = [NSArray arrayWithObjects:twoNav,oneNav,threeNav,fourNav,nil];
    
#else
    self.viewControllers = [NSArray arrayWithObjects:twoNav,oneNav,fourNav,nil];
    
#endif
    
    
    [self customTabbar];
    [self customItem];
}

-(void)customTabbar
{

    self.tabBar.translucent=NO;
    //设置样式
    self.tabBar.barStyle = UIBarStyleDefault;
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    self.tabBar.tintColor = Color1;
    
    self.selectedIndex = 0;
}
-(void)customItem
{

    WL_MessageViewController *v1=[self.viewControllers objectAtIndex:1];
    WL_ApplicationViewController *v2=[self.viewControllers objectAtIndex:0];
    
    
    v1.tabBarItem = [[UITabBarItem alloc]init];
    v1.tabBarItem.image =[[UIImage imageNamed:@"xiaoxiNor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v1.tabBarItem.selectedImage = [[UIImage imageNamed:@"xiaoxiSel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v1.tabBarItem.title =@"消息";
    v1.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    v2.tabBarItem = [[UITabBarItem alloc]init];
    v2.tabBarItem.image =[[UIImage imageNamed:@"yingyongNor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v2.tabBarItem.selectedImage = [[UIImage imageNamed:@"yingyongSel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v2.tabBarItem.title =@"应用";
    v2.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    
    
#ifdef ONADDRESSBOOK
    WL_AddressBookViewController *v3=[self.viewControllers objectAtIndex:2];
    WL_MineViewController *v4 = [self.viewControllers objectAtIndex:3];
    
    v3.tabBarItem = [[UITabBarItem alloc]init];
    v3.tabBarItem.image =[[UIImage imageNamed:@"tongxunluNor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tongxunluSel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v3.tabBarItem.title =@"联系人";
    v3.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
#else
    
    WL_MineViewController *v4 = [self.viewControllers objectAtIndex:2];
    
#endif

    
    v4.tabBarItem = [[UITabBarItem alloc]init];
    v4.tabBarItem.image =[[UIImage imageNamed:@"wodeNor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v4.tabBarItem.selectedImage = [[UIImage imageNamed:@"wodeSel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    v4.tabBarItem.title =@"我的";
    v4.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    

    //设置右上角的脚标，badgeValue
    //v1.tabBarItem.badgeValue = @"99+";
}


@end
