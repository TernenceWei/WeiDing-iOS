//
//  AppManager.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "AppManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WLNetworkAccountHandler.h"
#import "WL_TabBarController.h"
#import "WLJumpToOrderDetailViewControllerTool.h"
#import "WL_MessageViewController.h"
#import "JPUSHService.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLCarBookingChooseDriverController.h"
#import "WLCarBookingAddCostController.h"
#import "WLCarBookingOrderDetailController.h"
#import "WLCarBookingOrderListViewController.h"
#import "WLAffirmDriverViewController.h"
#import <Bugly/Bugly.h>

@interface AppManager ()

@property(nonatomic, strong) NSArray *cityList;

@end
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
}while (0)
@implementation AppManager
+ (instancetype)sharedInstance
{
    static AppManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSArray *)cityList
{
    if (!_cityList) {
        _cityList = [NSArray array];
    }
    return _cityList;
}

#pragma mark - 获取屏幕当前最外层的控制器
- (UIViewController *)getCurrentViewController
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *currentViewController;
    currentViewController = [self judgeTopViewController:window.rootViewController];
    while (currentViewController.presentedViewController) {//考虑到moda出来的控制器不在栈里面
        currentViewController = [self judgeTopViewController:currentViewController.presentedViewController];
    }
    return currentViewController;;
}

- (UIViewController *)judgeTopViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        return [self judgeTopViewController:[(UINavigationController *)viewController topViewController]];
        
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        
        return [self judgeTopViewController:[(UITabBarController *)viewController selectedViewController]];
        
    } else {
        
        return viewController;
    }
    return nil;
}

#pragma mark payment
- (void)handelAliPayResultWithUrl:(NSURL *)url
{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
        NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
        WLPaymentCode code = WLPaymentCodeSuccess;
        if ([errorCode intValue] == 9000){
            
            code = WLPaymentCodeSuccess;
        }else if ([errorCode intValue] == 8000){
                
            code = WLPaymentCodeProcessed;
        }else if ([errorCode intValue] == 6001){
            
            code = WLPaymentCodeCancel;
        }else{
            code = WLPaymentCodeFailure;
        }
        [self paymentFinishWithCode:code];

    }];
}

- (void)handelWeixinPaymentResultWithResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        WLPaymentCode code = WLPaymentCodeSuccess;
        switch (response.errCode)
        {
                //微信支付成功
            case WXSuccess:
            {
                code = WLPaymentCodeSuccess;
                break;
            }
                //用户取消微信支付
            case WXErrCodeUserCancel:
            {
                code = WLPaymentCodeCancel;
                break;
            }
            default:
            {
                code = WLPaymentCodeFailure;
                break;
            }
        }
        [self paymentFinishWithCode:code];
    }

}

//支付完成之后的消息通知
- (void)paymentFinishWithCode:(WLPaymentCode)code
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PaymentNotification object:nil userInfo:@{@"code":[NSString stringWithFormat:@"%zd",code]}];
}

#pragma mark version update
- (void)checkVersionUpdate
{
    [WLNetworkTool requestWithMethod:@"POST" url:@"http://itunes.apple.com/lookup?id=1193521071" params:nil success:^(id responseObject) {
        NSArray * array = responseObject[@"results"];
        NSDictionary * dict = [array lastObject];
        NSString *appstoreVersion = dict[@"version"];
        
        if ([self shouldUpdateVersionWithAppStoreVersion:appstoreVersion]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发现新版本"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"暂不更新"
                                                  otherButtonTitles:@"前往更新", nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/gb/app/yi-dong-cai-bian/id1193521071?mt=8"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (BOOL)shouldUpdateVersionWithAppStoreVersion:(NSString*)AppStoreVersion{
    
    BOOL shouldUpdate = false;
    
    NSString *currentVersion = AppVersion;
    NSMutableArray *a = [[AppStoreVersion componentsSeparatedByString: @"."] mutableCopy];
    NSMutableArray *b = [[currentVersion componentsSeparatedByString: @"."] mutableCopy];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j < a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            shouldUpdate = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            shouldUpdate = false;
            break;
        }else{
            shouldUpdate = false;
        }
    }
    return shouldUpdate;
}

#pragma mark remote notification

// 前台
- (void)remoteNotificationWillPresent:(NSDictionary *)userInfo
{
    NSUInteger messageType = [[userInfo objectForKey:@"msg_type"] integerValue];
    UIViewController *topController = [self getCurrentViewController];
    
    if ([topController isKindOfClass:[WL_MessageViewController class]]) {
        SEL sel = NSSelectorFromString(@"refreshMessageData");
        if ([topController respondsToSelector:sel]) {
            SuppressPerformSelectorLeakWarning(
               [topController performSelector:sel withObject:nil];
            );
        }
    }
    if (messageType == 14) {//报价提醒
            
        [self jumpToChooseDriverPage];
        
    }
    if (messageType == 15 || messageType == 16) {//行程开始，行程结束
        
        NSString *orderID = [userInfo objectForKey:@"relation_id"];
        [self jumpToOrderDetailPageWithOrderID:orderID];
        
    }
    if (messageType == 17) {//无司机应答
        
        [self jumpToOrderDetailPage];
    }
    if (messageType == 19) {
        
        [self RefreshWLCarBookingChooseDriverController];
    }
}
// 后台
- (void)remoteNotificationDidSelected:(NSDictionary *)userInfo
{
    NSUInteger messageType = [[userInfo objectForKey:@"msg_type"] integerValue];
    // 1 导游，2 司机，3 房销，4 其它 5 车辆,6 叫车
    NSUInteger roleType = [[userInfo objectForKey:@"role_type"] integerValue];
    // 0 未读，1 已读'
//    NSUInteger status = [[userInfo objectForKey:@"status"] integerValue];
    NSString *relationID = [userInfo objectForKey:@"relation_id"];
    
//    NSDictionary *detailDict = [userInfo objectForKey:@"aps"];
//    NSString *message = [detailDict objectForKey:@"alert"];
    
//    UIViewController *topController = [self getCurrentViewController];
    
    if (messageType == 14) {//报价提醒
        
        [self jumpToChooseDriverPage];
        
    }
    if (messageType == 15 || messageType == 16) {//行程开始，行程结束
        
        NSString *orderID = [userInfo objectForKey:@"relation_id"];
        [self jumpToOrderDetailPageWithOrderID:orderID];
        
    }
    if (messageType == 17) {//无司机应答
        [self jumpToOrderDetailPage];
    }
    if (messageType == 19) {
        WL_TabBarController *tabBar = (WL_TabBarController *)[ShareApplicationDelegate window].rootViewController;
        tabBar.selectedIndex = 1;
        UINavigationController *nav = tabBar.viewControllers[1];
        WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
        detailVC.orderID = relationID;
        detailVC.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:detailVC animated:YES];
    }
 
    
    if(roleType == 2)
    {
        WL_TabBarController *tabBar = (WL_TabBarController *)[ShareApplicationDelegate window].rootViewController;
        tabBar.selectedIndex = 1;
        UINavigationController *nav = tabBar.viewControllers[1];
//        UIViewController *VC = nav.viewControllers[0];/**< 消息控制器 */
        
        switch(messageType){
            case 1:
            case 2:
            {
                [KJumpTool jumpToDriveOrderDetailViewControllerWithOrderID:relationID andNaVC:nav];
                break;
            }
            case 8:
            case 9:
            case 10:
            case 11:
            {
                [KJumpTool jumpToDriveBookOrderDetailViewControllerWithOrderID:relationID andNaVC:nav];
                break;
            }
        }
    }
}

- (void)handelAliPayResultAndWeixinPaymentResultWithUrl
{
    UIViewController *topController = [self getCurrentViewController];
    
    if ([topController isKindOfClass:[WLAffirmDriverViewController class]]) {
        SEL sel = NSSelectorFromString(@"loadData");
        if ([topController respondsToSelector:sel]) {
            SuppressPerformSelectorLeakWarning(
            [topController performSelector:sel withObject:nil];
            );
        }
    }
}

- (void)setDistributionMode
{
    //写入配置项，100为正式环境，开发及测试环境下注释掉，上线时打开。
    
    [[NSUserDefaults standardUserDefaults] setObject:@"100" forKey:@"ConfigurationCode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isDistributionMode
{
    NSString *mode = [[NSUserDefaults standardUserDefaults] objectForKey:@"ConfigurationCode"];
    if (mode.integerValue == 100) {
        return YES;
    }
    return NO;
}

- (void)requestCityList
{
    WS(weakSelf);
    [WLNetworkAccountHandler requestCityListWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.cityList = data;
        }
    }];
}

- (void)getCityListWithResultBlock:(void (^)(NSArray *))resultBlock
{
    WS(weakSelf);
    if (self.cityList.count) {
        resultBlock(self.cityList);
    }else{
        [WLNetworkAccountHandler requestCityListWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
            if (responseType == WLResponseTypeSuccess) {
                weakSelf.cityList = data;
                resultBlock(data);
            }
        }];
    }
}

- (void)registerJPushTagsAndAlias
{
    NSString *userID = [WLUserTools getJPushUserID];
    NSString *tag = [WLNetworkTool getTag];
    if (userID && tag) {
        [JPUSHService setTags:[NSSet setWithObject:tag] alias:userID fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            WlLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
        }];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:kJPFNetworkDidLoginNotification
                                                      object:nil];
    }
}

- (void)stopJPushService
{
    [JPUSHService setTags:[NSSet set] alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        WlLog(@"停止推送服务");
        
    }];
    [WLUserTools removeJPushUserID];
}


- (void)jumpToChooseDriverPage
{
    UIViewController *topController = [self getCurrentViewController];
    if ([topController isKindOfClass:[WLCarBookingAddCostController class]]) {
        
        WLCarBookingAddCostController *costVC = (WLCarBookingAddCostController *)topController;
        WLCarBookingChooseDriverController *detailVC = [[WLCarBookingChooseDriverController alloc] init];
        detailVC.orderID = costVC.object.orderID;
        detailVC.hidesBottomBarWhenPushed = YES;
        [costVC.navigationController pushViewController:detailVC animated:YES];

    }
    
    if ([topController isKindOfClass:[WLCarBookingChooseDriverController class]]) {
        SEL sel = NSSelectorFromString(@"loadData");
        if ([topController respondsToSelector:sel]) {
            SuppressPerformSelectorLeakWarning(
            [topController performSelector:sel withObject:nil];
            );
        }
    }
}

- (void)jumpToOrderDetailPage
{
    UIViewController *topController = [self getCurrentViewController];
    if ([topController isKindOfClass:[WLCarBookingAddCostController class]]) {
        
        WLCarBookingAddCostController *costVC = (WLCarBookingAddCostController *)topController;
        WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
        detailVC.orderID = costVC.object.orderID;
        detailVC.iSAddCost = YES;
        detailVC.hidesBottomBarWhenPushed = YES;
        [costVC.navigationController pushViewController:detailVC animated:YES];
    }
    if ([topController isKindOfClass:[WLCarBookingOrderListViewController class]]) {
        
        SEL sel = NSSelectorFromString(@"dataLoad");
        if ([topController respondsToSelector:sel]) {
            SuppressPerformSelectorLeakWarning(
                                               [topController performSelector:sel withObject:nil];
                                               );
        }
    }
}

- (void)RefreshWLCarBookingChooseDriverController
{
    UIViewController *topController = [self getCurrentViewController];
    if ([topController isKindOfClass:[WLCarBookingChooseDriverController class]]) {
        SEL sel = NSSelectorFromString(@"loadData");
        if ([topController respondsToSelector:sel]) {
            SuppressPerformSelectorLeakWarning(
                                               [topController performSelector:sel withObject:nil];
                                               );
        }
    }
}

- (void)jumpToOrderDetailPageWithOrderID:(NSString *)orderID
{
    UIViewController *topController = [self getCurrentViewController];
    if (![topController isKindOfClass:[WLCarBookingOrderDetailController class]]) {
        WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
        detailVC.orderID = orderID;
        detailVC.hidesBottomBarWhenPushed = YES;
        [topController.navigationController pushViewController:detailVC animated:YES];
    }
}
/**
 初始化bugly
 */
- (void)setBugly
{
  [Bugly startWithAppId:@"1068e88042"];
}
@end
