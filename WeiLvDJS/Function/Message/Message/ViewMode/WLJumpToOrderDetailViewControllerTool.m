//
//  WLJumpToOrderDetailViewControllerTool.m
//  WeiLvDJS
//
//  Created by whw on 17/2/8.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLJumpToOrderDetailViewControllerTool.h"

@interface WLJumpToOrderDetailViewControllerTool ()
@property (nonatomic, strong) UINavigationController *navigationController;

@end

static WLJumpToOrderDetailViewControllerTool* instance;
@implementation WLJumpToOrderDetailViewControllerTool
+ (instancetype)sharedJumpToolInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WLJumpToOrderDetailViewControllerTool alloc]init];
    });
    return instance;
}

- (void)jumpToDriveOrderDetailViewControllerWithOrderID:(NSString *)orderID andNaVC:(UINavigationController *)navigationController
{
    self.navigationController = navigationController;
    [[WLNetworkDriverHandler sharedInstance] requestOrderDetailWithOrderID:orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        if (responseType == WLResponseTypeSuccess&&data) {
            WLDriverOrderObject *orderModel = data;
            
            if([orderModel.order_type isEqualToString:@"1"]){//接单
                [self jumpToOrderDetailViewControllerWithStatus:[self getSendOrderStatusWithModel:orderModel] andOrderDetailData:data];
            }else if ([orderModel.order_type isEqualToString:@"2"])//抢单
            {
                
//                //跳转到抢单详情页面
//                [self jumpToBookOrderDetailViewControllerWithStatus:[self getBookOrderStatusWithModel:orderModel] OrderID:orderID];
            }
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:@"请求订单列表失败,请稍后再试."];
        }
        
        
    }];
}
#pragma mark - 跳转到竞价详情控制器
- (void)jumpToDriveBookOrderDetailViewControllerWithOrderID:(NSString *)orderID andNaVC:(UINavigationController *)navigationController
{
    WLApplicationDriverBookOrderDetailViewController *bookVC = [[WLApplicationDriverBookOrderDetailViewController alloc]init];
    bookVC.orderID = orderID;
    bookVC.company_id = [WLKeychainTool readKeychainValue:@"CompanyID"];
    bookVC.hidesBottomBarWhenPushed = YES;
    [navigationController pushViewController:bookVC animated:YES];
}
#pragma mark - 获取派单状态的订单类型 
- (WLOrderDetailStatus)getSendOrderStatusWithModel:(WLDriverOrderObject*)orderModel
{
    WLOrderDetailStatus orderStatus;
    switch ([orderModel.reception_status intValue]) {
        case 0:
        {
            orderStatus = [WLTools setupDifferentTime:orderModel.expiry_at] < 0?WLOrderDetailOverTime:WLOrderDetailWait;
            
        }
            break;
        case 1:
        {
            switch ([orderModel.trip_status intValue])
            {
                case 0:
                    orderStatus = WLOrderDetailStart;
                    break;
                case 1:
                    orderStatus = WLOrderDetailTravel;
                    break;
                case 2:
                    orderStatus = WLOrderDetailFinished;
                    break;
                default:
                    break;
            }
            break;
        }
        case 2:
            orderStatus = WLOrderDetailRefuse;
            break;
        case 3:
        case 4:
            orderStatus = WLOrderDetailCancel;
            break;
        default:
            orderStatus = WLOrderDetailOverTime;
            break;
    }
    return orderStatus;
}
#pragma mark - 获取竞价状态的订单类型
- (WLBookOrderStatus)getBookOrderStatusWithModel:(WLDriverOrderObject*)orderModel
{
    WLBookOrderStatus bookStatus;
    
    switch ([orderModel.reception_status intValue]) {
        case 0://待竞价
        {
            if([[orderModel.bid objectForKey:@"bid_status"] intValue] == 0){
                bookStatus = WLWaitOrderStatus;//待报价
            }else if([[orderModel.bid objectForKey:@"bid_status"] intValue] == 1){
                if([orderModel.pay_status intValue] == 0){
                    bookStatus = WLUnpaidStatus;//待客户确认
                }
            }
            break;
        }
        case 1://已抢单
        {
            
            if([[orderModel.bid objectForKey:@"bid_status"] intValue] == 3){
                bookStatus = [[orderModel.bid objectForKey:@"bid_price"] doubleValue]*100>0?WLFailureOrderStatusQuoted:WLFailureOrderStatusUnquoted;
            }else
            {
                switch ([orderModel.trip_status intValue])
                {
                    case 0:
                    {
                        bookStatus = WLOrderStatusStart;//待出发
                        break;
                    }
                    case 1:
                        bookStatus = WLOrderStatusTravel;
                        break;
                    case 2:
                        //                    if([orderModel.pay_status integerValue] == 2)
                        //                    {
                        //                        bookStatus = WLOrderStatusFinish;//已结清
                        //                    }else
                        //                    {
                        //                        bookStatus = WLOrderStatusSettlement;//待结算
                        //                    }
                        bookStatus = WLOrderStatusFinish;
                        break;
                    default:
                        break;
                }
            }
            break;
        }
        case 4://取消订单
        {
            if([[orderModel.bid objectForKey:@"bid_price"] doubleValue]*100>0 )
            {
                bookStatus = WLFailureOrderStatusQuotedCanceled;//已竞价取消
                
            }else {
                bookStatus = WLFailureOrderStatusUnquotedCanceled;//未竞价取消
            }
            break;
        }
        case 6:
            bookStatus = WLFailureOrderStatusOverTime; //超时
            break;
        case 7:
            bookStatus = WLFailureOrderStatusQuotedCanceled;//被动取消
            break;
        default:
            bookStatus = WLFailureOrderStatusOverTime;
            break;
    }
    
    
    return bookStatus;
}
#pragma mark - 抽取跳转到订单详情页面的方法
- (void)jumpToOrderDetailViewControllerWithStatus:(WLOrderDetailStatus)status andOrderDetailData:(WLDriverOrderObject *)orderDetailData
{
    WL_Application_Driver_OrderDetail_ViewController *orderDetailViewController = [[ WL_Application_Driver_OrderDetail_ViewController alloc]init];
    orderDetailViewController.orderDetailStatus = status;
    orderDetailViewController.orderDetailData = orderDetailData;
    if (status == WLOrderDetailSettlement ||status == WLOrderDetailFinished) {
        orderDetailViewController.orderDetailSectionArray = @[
                                                              @{@"iconImage":@"chuxing",@"listLabel":@"出行信息"},
                                                              @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"支付信息"},
                                                              @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"订单来源"},
                                                              @{@"iconImage":@"beihzu",@"listLabel":@"备注信息"},
                                                              ];
    }else
    {
        orderDetailViewController.orderDetailSectionArray = @[
                                                              @{@"iconImage":@"chuxing",@"listLabel":@"出行信息"},
                                                              @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"订单来源"},
                                                              @{@"iconImage":@"beizhu",@"listLabel":@"备注信息"},
                                                              ];
    }
     orderDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderDetailViewController animated:YES];
}
                
@end
