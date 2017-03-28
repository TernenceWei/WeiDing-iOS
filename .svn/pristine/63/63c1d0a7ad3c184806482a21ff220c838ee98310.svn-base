//
//  AppDelegate.m
//  WeiLvDJS
//
//  Created by jyc on 16/8/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "AppDelegate.h"
#import "WL_TabBarController.h"
#import "WL_BaseNavigationViewController.h"
#import "WL_Login_ViewController.h"
#import "WL_CheckVersion.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppManager.h"
#import "WLNetworkDriverHandler.h"
#import "WLNetworkLoginHandler.h"
#import "ossl_typ.h"
#import "pem.h"
#import "rsa.h"
#import "WLNetworkTool.h"
#import "JPUSHService.h"
#import "WLCarBookingChooseDriverController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define BaiduMap_APPKEY @"xGyiRy3kW9EsD5b9f6AfGUVuTPLVpuEN"


@interface AppDelegate ()<JPUSHRegisterDelegate>{

   BMKMapManager * _mapManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [[AppManager sharedInstance] setBugly];/* 初始化bugly */
     //正式环境开关
//    [[AppManager sharedInstance] setDistributionMode];

    [WXApi registerApp:WeiXinID];
    [self setupJPushServiceWithOptions:launchOptions];
    [self setupBaiduMap];
    [[AppManager sharedInstance] checkVersionUpdate];
    [[AppManager sharedInstance] requestCityList];
    
    [self goToMain];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupBaiduMap{
    // 百度地图
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:BaiduMap_APPKEY generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (void)goToMain
{
    NSString *userID = [WLUserTools readUsertoken];
    // 显示主界面
    if (userID){
        // 设置窗口的根控制器
        WL_TabBarController * _rootController=[[WL_TabBarController alloc] init];
        self.window.rootViewController = _rootController;

    }else{
        
        WL_Login_ViewController *loginVC = [[WL_Login_ViewController alloc] init];
        UINavigationController  *_navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = _navi;
    
    }
}

#pragma mark - 微信回调函数
-(void)onResp:(BaseResp *)resp
{
    [[AppManager sharedInstance] handelWeixinPaymentResultWithResp:resp];
}

// 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{

    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AppManager sharedInstance] handelAliPayResultWithUrl:url];
        
    }else if ([url.host isEqualToString:@"pay"]){
        
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *string =[NSString stringWithFormat:@"%@",url];
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AppManager sharedInstance] handelAliPayResultWithUrl:url];
        
    }else if ([url.host isEqualToString:@"pay"]){
        
        return [WXApi handleOpenURL:url delegate:self];
        
    }else  if( [string hasPrefix:@"BestPayWeiLv"]){

        
    }
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    [application cancelAllLocalNotifications];
    
    [[AppManager sharedInstance] handelAliPayResultAndWeixinPaymentResultWithUrl];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    WlLog(@"applicationDidBecomeActive");
   
}


#pragma mark Push
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    WlLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)setupJPushServiceWithOptions:(NSDictionary *)launchOptions
{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //极光调试模式
//    [JPUSHService setDebugMode];
    
    //监听极光自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];

    //监听极光登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jpushNetworkDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];

    BOOL result = [WLNetworkTool JpushIsOnDistributionEnvironment];
    // init Push
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPushAppKey
                          channel:@"APP Store"
                 apsForProduction:result];
}


/**
 登录成功之后别名才能设置成功
 */
- (void)jpushNetworkDidLogin:(NSNotification *)notification {
  
    [[AppManager sharedInstance] registerJPushTagsAndAlias];
}

// iOS 10 Support,程序在前台收到通知调用该方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;

    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [[AppManager sharedInstance] remoteNotificationWillPresent:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

// iOS 10 Support，程序在后台或未启动时收到通知，点击通知后调用该方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [[AppManager sharedInstance] remoteNotificationDidSelected:userInfo];

    completionHandler();  // 系统要求执行这个方法
 
}


/**
 极光自定义消息，程序在前台时可以收取极光下发的消息，用于补偿推送延迟带来的不良用户体验
 */
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSString *title = [userInfo valueForKey:@"title"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    [[AppManager sharedInstance] remoteNotificationWillPresent:extras];
    
}



@end
