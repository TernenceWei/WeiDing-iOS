//
//  WLBaseNavigationController.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/23.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBaseNavigationController.h"

@interface WLBaseNavigationController ()

@end

@implementation WLBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupNavigationBar
{
    self.view.backgroundColor = BgViewColor;
    
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[WLTools stringToColor:@"#f7f7f7"]]forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: Color2, NSFontAttributeName: T3};
    [self.view addSubview:self.navigationBar];
    
    self.titleItem = [[UINavigationItem alloc] initWithTitle:@"我的资料"];
    self.titleItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"getbackImg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(backButtonAction)];
    self.navigationBar.items = @[self.titleItem];
    
}

- (void)setupNavigationBarWithOutBackBtn
{
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[WLTools stringToColor:@"#f7f7f7"]]forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: Color2, NSFontAttributeName: T3};
    [self.view addSubview:self.navigationBar];

    
    self.titleItem = [[UINavigationItem alloc] initWithTitle:@"我的资料"];
    self.navigationBar.items = @[self.titleItem];
    
}

- (void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
