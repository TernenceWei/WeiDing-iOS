//
//  WLDriverReceiptController.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  收款记录

#import "WLDriverReceiptController.h"
#import "WLDriverReceiptTopView.h"
#import "WLDriverReceiptBottomView.h"
#import "WLBusinessCardView.h"
#import "WL_Application_Driver_OrderDetailBottomView.h"
#import "WL_Application_Driver_OrderDetail_ViewController.h"
@interface WLDriverReceiptController ()

@property (nonatomic, strong) WLDriverReceiptBottomView *bottomView;


@end

@implementation WLDriverReceiptController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)setupUI
{
    self.view.backgroundColor = HEXCOLOR(0xf2f2f2);
    self.title = @"收款记录";
    
    WLDriverReceiptTopView *topView = [[WLDriverReceiptTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(121))];
    topView.orderPrice = self.orderPrice;
    [self.view addSubview:topView];

    WS(weakSelf);
    WLDriverReceiptBottomView *bottomView = [[WLDriverReceiptBottomView alloc] initWithFrame:CGRectMake(0, ScaleH(121), ScreenWidth, ScaleH((346 + 64))) confirmAction:^(NSString *moneyString,BOOL result) {

        [weakSelf.view endEditing:YES];
         [self showHud];
        [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:weakSelf.orderID tripOperation:@"2" money:moneyString dataBlock:^(WLResponseType responseType, id data, NSString *message) {
            if (responseType == WLResponseTypeSuccess && data) {
                
                if (result) {
                
                    [self hidHud];
                    if (weakSelf.fromControllerType == WLFromAcceptController) {
                      [self.navigationController popViewControllerAnimated:YES];
                        
                    }else if (self.fromControllerType == WLFromDetailController)
                    {
                       
                        [[WLNetworkDriverHandler sharedInstance] requestOrderDetailWithOrderID:weakSelf.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                            if (responseType == WLResponseTypeSuccess && data) {
                                
                                [self hidHud];
                                [self jumpToOrderDetailViewControllerWithStatus:WLOrderDetailSettlement andOrderDetailData:data];
                            }else
                            {
                                [self hidHud];
                                [[WL_TipAlert_View sharedAlert] createTip:@"请求订单详情失败,请重试"];
                            }
                        }];
                        
                    }
                    
                    
                } else {
                    if (self.fromControllerType == WLFromDetailController)
                    {
                        [self showHud];
                        [[WLNetworkDriverHandler sharedInstance] requestOrderDetailWithOrderID:weakSelf.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                            if (responseType == WLResponseTypeSuccess && data) {
                                
                                [self hidHud];
                                [self jumpToOrderDetailViewControllerWithStatus:WLOrderDetailSettlement andOrderDetailData:data];
                            }else
                            {
                                [self hidHud];
                                [[WL_TipAlert_View sharedAlert] createTip:@"请求订单详情失败,请重试"];
                            }
                        }];
                        
                    }else
                    {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                }
            }else if (responseType == WLResponseTypeNoNetwork)
            {
                [[WL_TipAlert_View sharedAlert] createTip:@"请求失败,请重试"];
                return ;
            }
            
        }];
   
        
    }];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    
 
}

#pragma mark - 抽取跳转到订单详情页面的方法
- (void)jumpToOrderDetailViewControllerWithStatus:(WLOrderDetailStatus)status andOrderDetailData:(WLDriverOrderObject *)orderDetailData
{
    for (WL_Application_Driver_OrderDetail_ViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[WL_Application_Driver_OrderDetail_ViewController class]]) {
    
            VC.orderDetailStatus = status;
            VC.orderDetailData = orderDetailData;
            VC.orderDetailSectionArray = @[
                                                                  @{@"iconImage":@"chuxing",@"listLabel":@"出行信息"},
                                                                  @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"支付信息"},
                                                                  @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"订单来源"},
                                                                  @{@"iconImage":@"beihzu",@"listLabel":@"备注信息"},
                                                                  ];
            
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
    
}

- (void) keyboardWillShow:(NSNotification *)notification {

    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = - ScaleH(35);
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
    
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {

    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
