//
//  WL_BaseViewController.m
//  WeiLv
//
//  Created by James on 16/5/19.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//  【微旅管家】->控制器 基类

#import "WL_BaseViewController.h"
#import "UIImage+Extension.h"
#import "AppManager.h"
@interface WL_BaseViewController ()

@property (nonatomic, strong) id originalDelegate;
/**< 导航栏下面的线条 */
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation WL_BaseViewController

@synthesize pushType=_pushType;

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor = BgViewColor;
    
    [self setNavBarBackgroundColor];


    if (_pushType == isModel || _pushType == isPush)
    {
        [self setNavigationLeftImg:@"getbackImg"];//NavigationBack
    }

    if (SystemVersion <= 7.0) {
         self.navigationController.navigationBar.translucent = NO;
    }
    self.originalDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
   
    WlLog(@"当前控制器 %@",[[AppManager sharedInstance] getCurrentViewController]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar addSubview:self.lineLabel];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    WlLog(@"delegate = %@",self.navigationController.interactivePopGestureRecognizer.delegate);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.lineLabel removeFromSuperview]; //解决下划线重复添加的问题
    self.navigationController.interactivePopGestureRecognizer.delegate = self.originalDelegate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  设置导航栏
 */
-(void)setNavBarImage
{
    UIImage *image=[UIImage imageNamed:IsiPhone4?@"":@""];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    NSDictionary *attribute=@{
                              NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName:[UIFont systemFontOfSize:18]
                             };
    [self.navigationController.navigationBar setTitleTextAttributes:attribute];
}


/**
 *  设置导航栏背景颜色
 */
-(void)setNavBarBackgroundColor

{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[WLTools stringToColor:@"#f7f7f7"]]forBarMetrics:UIBarMetricsDefault];
    
    //self.navigationController.navigationBar.barTintColor = [WLTools stringToColor:@"#f7f7f7"];

    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    //self.navigationController.navigationBar.translucent = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSDictionary *attribute = @{NSForegroundColorAttributeName:[WLTools stringToColor:@"#333333"],
                                NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    [self.navigationController.navigationBar setTitleTextAttributes:attribute];

}

/**
 *  设置左侧导航栏图片
 *
 *  @param imageName 左侧导航图片名称
 */
-(void)setNavigationLeftImg:(NSString *)imageName
{
    UIImage *image=[UIImage imageNamed:imageName];
    image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(NavigationLeftEvent)];
    self.navigationItem.leftBarButtonItem=item;
}

/**
 *  设置右侧导航栏图片
 *
 *  @param imageName 右侧导航图片名称
 */
-(void)setNavigationRightImg:(NSString *)imageName
{
    UIImage *image=[UIImage imageNamed:imageName];
    image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(NavigationRightEvent)];
    self.navigationItem.rightBarButtonItem=item;
}


/**
 *  设置左侧导航栏标题
 *
 *  @param titleName  左侧导航标题名称
 *  @param fontSize   标题字号
 *  @param titleColor 标题颜色
 *  @param isEnable   是否可用
 */
-(void)setNavigationLeftTitle:(NSString *)titleName fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor isEnable:(BOOL)isEnable
{
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithTitle:titleName style:UIBarButtonItemStyleDone target:self action:isEnable?@selector(NavigationLeftEvent):nil];
    self.navigationItem.leftBarButtonItem=item;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] =WLFontSize(fontSize);
    attrs[NSForegroundColorAttributeName] =titleColor;
    [item setTitleTextAttributes:attrs forState:isEnable?UIControlStateNormal:UIControlStateDisabled];
}

/**
 *  设置右侧导航栏标题
 *
 *  @param titleName  右侧导航标题名称
 *  @param fontSize   标题字号
 *  @param titleColor 标题颜色
 *  @param isEnable   是否可用
 */
-(void)setNavigationRightTitle:(NSString *)titleName fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor isEnable:(BOOL)isEnable
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:titleName style:UIBarButtonItemStyleDone target:self action:isEnable?@selector(NavigationRightEvent):nil];
    self.navigationItem.rightBarButtonItem = item;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = WLFontSize(fontSize);
    attrs[NSForegroundColorAttributeName] = titleColor;
    [item setTitleTextAttributes:attrs forState:isEnable?UIControlStateNormal:UIControlStateDisabled];
    
    [item setTarget:self];
    [item setAction:@selector(NavigationRightEvent)];
}


/**
 * 左侧导航 点击事件
 */
-(void)NavigationLeftEvent
{
    if (_pushType==isPush)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else if(_pushType == isModel)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

/**
 * 右侧导航 点击事件
 */
-(void)NavigationRightEvent
{
    
}


- (MBProgressHUD *)progressHud
{
    
    if (!_progressHud) {
        
        _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        
        _progressHud.frame = self.view.bounds;
        
        _progressHud.minSize = CGSizeMake(100, 100);
        
        _progressHud.mode = MBProgressHUDModeIndeterminate;
        
        _progressHud.labelText = @"加载中...";
        
        [self.view addSubview:_progressHud];
    }
    return _progressHud;
}

/**
 * 显示菊花
 */

- (void)showHud
{
    [self.progressHud show:YES];
    
    [self.view bringSubviewToFront:self.progressHud];
}

/**
 * 隐藏菊花
 */

- (void)hidHud
{
   
    [self.progressHud hide:YES];
    
}

/**
 * 定制菊花下方显示字体
 */

- (void)showHudWithString:(NSString *)loadingText
{
    
    self.progressHud.labelText = loadingText;
    self.progressHud.minShowTime = 1;
    [self.progressHud show:YES];
    [self.view bringSubviewToFront:self.progressHud];
}

- (UILabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height - ScaleH(0.5), self.navigationController.navigationBar.frame.size.width, ScaleH(0.5))];
        _lineLabel.backgroundColor = [WLTools stringToColor:@"#b2b2b2"];
    }
    return _lineLabel;
}



@end
