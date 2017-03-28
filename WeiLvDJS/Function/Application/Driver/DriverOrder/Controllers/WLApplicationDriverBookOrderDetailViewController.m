//
//  WLApplicationDriverBookOrderDetailViewController.m
//  WeiLvDJS
//
//  Created by whw on 17/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderDetailViewController.h"
#import "WL_Application_Driver_Bill_Top_View.h"
#import "WLApplicationDriverBookOrderDetailBottomView.h"
#import "WLApplicationDriverBookOrderDetailCell0.h"
#import "WLApplicationDriverBookOrderDetailCell1.h"
#import "WLApplicationDriverBookOrderDetailCell2.h"
#import "WLApplicationDriverBookOrderDetailCell3.h"
#import "WL_Application_Driver_OrderDetailCell4.h"
#import "WLApplicationDriverBookOrderDetailCell5.h"
#import "WLApplicationDriverBookOrderSectionStatusView.h"
#import "WL_Application_Driver_OrderDetailSectionHeadView.h"
#import "WL_Application_Driver_OrderTipView.h"
#import "WLApplicationDriverBookOrderSectionTipView.h"
#import "WLQuotePriceView.h"
#import "WLJumpToOrderDetailViewControllerTool.h"
#import "WLApplicationDriverBookOrderDetailCell6.h"
#import "WLApplicationImageBrowserViewController.h"
@interface WLApplicationDriverBookOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
/**< 头部提示 */
@property (nonatomic, strong) WL_Application_Driver_Bill_Top_View *promptViewToFailureOrder;
/**< 失效页面头部的提示View */
@property (nonatomic, strong) UIView *failureOrderTopView;

@property (nonatomic, assign) BOOL isFailureOrderCloseBtnClick;
@property (nonatomic, weak) UITableView *contentTableView;
@property (nonatomic, weak) WLApplicationDriverBookOrderDetailBottomView *bookOrderDetailBottomView;
/**< 订单模型 */
@property (nonatomic, strong) WLDriverOrderObject *orderModel;

@property (nonatomic, strong) NSArray *sectionTitleArray;
/**< 订单状态 */
@property (nonatomic, assign) WLBookOrderStatus bookStatus;
@end

@implementation WLApplicationDriverBookOrderDetailViewController
#define bottomViewH 70
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = Color4;
    self.isFailureOrderCloseBtnClick = NO;
    [self setupUI];
}

- (void)setupUI
{

    
    [self showHud];
    [[WLNetworkDriverHandler sharedInstance] requestOrderDetailWithOrderID:self.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        if (responseType == WLResponseTypeSuccess && data) {
            [self hidHud];
            self.orderModel = data;
            self.sectionTitleArray =  @[
                                        @"",
                                        @{@"iconImage":@"chuxing",@"listLabel":@"出行信息"},
                                        @{@"iconImage":@"xiangqingNor",@"listLabel":@"订单金额"},
                                        @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"订单来源"},
                                        @{@"iconImage":@"beizhu",@"listLabel":@"备注信息"},
                                        @"",
                                        ];
            self.bookStatus = [KJumpTool getBookOrderStatusWithModel:self.orderModel];
            self.bookOrderDetailBottomView.orderModel = self.orderModel;
            self.bookOrderDetailBottomView.bookStatus = self.bookStatus;
            
            [self.contentTableView removeFromSuperview];
            self.contentTableView  = nil;
            
            if(self.bookStatus==WLWaitOrderStatus||self.bookStatus==WLOrderStatusStart||self.bookStatus==WLOrderStatusTravel){
                [self.contentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.equalTo(self.view);
                    make.bottom.equalTo(self.view).offset(-ScaleH(bottomViewH));
                }];
                
            }else
            {
                [self.contentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.view);
                }];
            }
            self.automaticallyAdjustsScrollViewInsets = NO;
            [self.view layoutIfNeeded];
            [self.contentTableView reloadData];

        }else
        {
            [self hidHud];
            [[WL_TipAlert_View sharedAlert] createTip:@"请求订单详情失败,请重试"];
        }
    }];
}
//
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
    {
        if ([[self.orderModel.bid objectForKey:@"bid_price"] doubleValue]*100 <= 0) {
            return 0;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WLApplicationDriverBookOrderDetailCell0 *cell0 = [WLApplicationDriverBookOrderDetailCell0 cellForTableView:tableView];
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:6];
        if ([[self.orderModel.bid objectForKey:@"bid_price"] doubleValue]*100<= 0){
            dataArray = @[
                          self.orderModel.start_city,
                          self.orderModel.via_address,
                          self.orderModel.end_city,
                          @"未报价",
                          self.orderModel.car_model,
                          self.orderModel.car_seat_amount,
                          self.orderModel.trip_img == nil?@[]:self.orderModel.trip_img
                          ].mutableCopy;
        }else  if ([[self.orderModel.bid objectForKey:@"bid_price"] doubleValue]*100> 0){
            dataArray = @[
                          self.orderModel.start_city,
                          self.orderModel.via_address,
                          self.orderModel.end_city,
                          [NSString stringWithFormat:@"¥%@",[self.orderModel.bid objectForKey:@"bid_price"] ],
                          self.orderModel.car_model,
                          self.orderModel.car_seat_amount,
                          self.orderModel.trip_img == nil?@[]:self.orderModel.trip_img
                          ].mutableCopy;
        }
        cell0.dataArray = dataArray.copy;
        WS(weakSelf);
        cell0.tripButtonCallBack = ^(NSArray *urlArray){
            WLApplicationImageBrowserViewController *imageBrowserVC = [[WLApplicationImageBrowserViewController alloc]init];
            imageBrowserVC.imagesArray = urlArray;
            
            [weakSelf.navigationController pushViewController:imageBrowserVC animated:YES];
        };
        return cell0;
    }else if(indexPath.section == 1)
    {
        WLApplicationDriverBookOrderDetailCell1 *cell1 = [WLApplicationDriverBookOrderDetailCell1 cellForTableView:tableView];
        NSArray *dataArray = @[
                               self.orderModel.start_at,
                               self.orderModel.start_address,
                               self.orderModel.start_memo_address==nil?@" ":self.orderModel.start_memo_address,
                               self.orderModel.end_at,
                               self.orderModel.end_address,
                               self.orderModel.end_memo_address==nil?@" ":self.orderModel.end_memo_address,
                               ];
        cell1.dataArray = dataArray;
        return cell1;
    }else if(indexPath.section == 2)
    {
        WLApplicationDriverBookOrderDetailCell2 *cell2 = [WLApplicationDriverBookOrderDetailCell2 cellForTableView:tableView];
        NSString * settingStr = [self.orderModel.bid objectForKey:@"cost_memo"];
        
       NSArray *arr = [settingStr componentsSeparatedByString:@","];
        cell2.dataArray = arr.count?arr:@[];
        return cell2;
    }
    else if(indexPath.section == 3)
    {
        WLApplicationDriverBookOrderDetailCell3 *cell3 = [WLApplicationDriverBookOrderDetailCell3 cellForTableView:tableView];
        cell3.dataArray = @[ self.orderModel.number==nil?@"":self.orderModel.number,
                             self.orderModel.use_car_contacts==nil?@"":self.orderModel.use_car_contacts,
                             self.orderModel.use_car_mobile==nil?@"":self.orderModel.use_car_mobile,
                             self.orderModel.start_at==nil?@"":self.orderModel.start_at
                             ];
        cell3.bookStatus = self.bookStatus;

        return cell3;
    }else if (indexPath.section == 4)
    {
        
        WL_Application_Driver_OrderDetailCell4 *cell4 = [WL_Application_Driver_OrderDetailCell4 cellForTableView:tableView];
        cell4.commentLabel.text = [NSString GetStringNSUTF8StringEncodingANDEmoji:self.orderModel.memo];
        
        return cell4;
    }else if(indexPath.section == 5)
    {
        if(self.bookStatus == WLFailureOrderStatusQuoted||self.bookStatus == WLFailureOrderStatusOverTime||self.bookStatus == WLFailureOrderStatusUnquoted||self.bookStatus == WLFailureOrderStatusQuotedCanceled||self.bookStatus == WLFailureOrderStatusUnquotedCanceled)
        {
            WLApplicationDriverBookOrderDetailCell5 *cell5 = [WLApplicationDriverBookOrderDetailCell5 cellForTableView:tableView];
            cell5.orderModel = self.orderModel;
            cell5.bookStatus = self.bookStatus;
            
            return cell5;
        }else
        {
          WLApplicationDriverBookOrderDetailCell6 *cell6 = [WLApplicationDriverBookOrderDetailCell6 cellForTableView:tableView];
            cell6.orderModel = self.orderModel;
            cell6.bookStatus = self.bookStatus;
            return cell6;
        }
        
    }
    return [UITableViewCell new];
}

//返回每一组的组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
//        if(self.bookStatus == WLOrderStatusSettlement){
//            self.promptViewToFailureOrder.promptLable.text = @"提示: 行程结束7天后,订单金额将自动到账!";
//            return self.failureOrderTopView;
//        }else if(self.bookStatus == WLUnpaidStatus){
//            
//           self.promptViewToFailureOrder.promptLable.text = @"提示: 待客户付款后,即可联系乘客上车!";
//            return self.failureOrderTopView;
//        }
        return nil;
    }else if(section == 5)
    {
        if(self.bookStatus == WLFailureOrderStatusOverTime ||self.bookStatus == WLFailureOrderStatusUnquotedCanceled ||self.bookStatus == WLFailureOrderStatusQuotedCanceled||self.bookStatus == WLFailureOrderStatusQuoted||self.bookStatus == WLFailureOrderStatusUnquoted){
            WLApplicationDriverBookOrderSectionTipView *tipView = [[WLApplicationDriverBookOrderSectionTipView alloc]init];
            tipView.bookStatus = self.bookStatus;
            return tipView;
        }else{
//        WLApplicationDriverBookOrderSectionStatusView *orderSectionStatusView = [[WLApplicationDriverBookOrderSectionStatusView alloc ]initWithStatus:self.bookStatus andFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(85))];
//        return orderSectionStatusView;
            return [UIView new];
        }
    }else if(section == 2)
    {
            WL_Application_Driver_OrderDetailSectionHeadView *orderDetailSectionHeadView = [[WL_Application_Driver_OrderDetailSectionHeadView alloc]init];
            orderDetailSectionHeadView.priceLabel.hidden = NO;
        if([[self.orderModel.bid objectForKey:@"bid_price"] doubleValue]*100 <= 0)
        {
          orderDetailSectionHeadView.priceLabel.text = @"未报价";
        }else
        {
            if ([self.orderModel.pay_status integerValue] == 1||[self.orderModel.pay_status integerValue] == 2)/**< 表示已付款 */
            {
                orderDetailSectionHeadView.priceLabel.text = [NSString stringWithFormat:@"¥%@(客户已付款)",[self.orderModel.bid objectForKey:@"bid_price"]];
            }else
            {
               orderDetailSectionHeadView.priceLabel.text = [NSString stringWithFormat:@"¥%@(客户未付款)",[self.orderModel.bid objectForKey:@"bid_price"]];
            }
        }
            NSDictionary *dataDict = self.sectionTitleArray[section];
            orderDetailSectionHeadView.iconImage.image = [UIImage imageNamed:dataDict[@"iconImage"]];
            orderDetailSectionHeadView.listLabel.text = dataDict[@"listLabel"];
            return orderDetailSectionHeadView;
    }else
    {
        WL_Application_Driver_OrderDetailSectionHeadView *orderDetailSectionHeadView = [[WL_Application_Driver_OrderDetailSectionHeadView alloc]init];
        orderDetailSectionHeadView.priceLabel.hidden = YES;
        NSDictionary *dataDict = self.sectionTitleArray[section];
        orderDetailSectionHeadView.iconImage.image = [UIImage imageNamed:dataDict[@"iconImage"]];
        orderDetailSectionHeadView.listLabel.text = dataDict[@"listLabel"];
        return orderDetailSectionHeadView;
    }

}
//返回每一组组尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 5)
    {
        return 0.01;
    }
    return ScaleH(14);
}
//返回每一组组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
//        if(self.bookStatus == WLOrderStatusSettlement||self.bookStatus == WLUnpaidStatus){
//            if (!self.isFailureOrderCloseBtnClick) {
//                return 44;
//            }
//        }
        return 0.01;

    }else if(section == 5)
    {
        if(self.bookStatus == WLFailureOrderStatusOverTime ||self.bookStatus == WLFailureOrderStatusUnquotedCanceled ||self.bookStatus == WLFailureOrderStatusQuotedCanceled||self.bookStatus == WLFailureOrderStatusQuoted||self.bookStatus == WLFailureOrderStatusUnquoted){
            return ScaleH(126);
        }
//        return 90;
        return 0.01;
    }else
    {
        return 44;
    }
}
//预估行高
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ScaleH(95);
    }else if(indexPath.section == 1)
    {
        return ScaleH(190);

    }
    else if(indexPath.section == 3)
    {
        return ScaleH(90);
    }
    return ScaleH(44);
}
#pragma mark -点击了抢单按钮
- (void)didClickBookButton:(UIButton *)sender
{
    WL_Application_Driver_OrderTipView  *acceptOrderTipView;
    if (self.bookStatus == WLWaitOrderStatus)//竞价
    {
        
        WLQuotePriceView *quotePriceView = [[WLQuotePriceView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(340), ScaleH(320))];
        [KWLBaseShowView showWithContentView:quotePriceView andTouch:NO andCallBlack:nil];
        quotePriceView.buttonCallBack = ^(NSInteger index,NSString *price,NSString *paras)
        {
            if(index == 20)
            {//取消
                [KWLBaseShowView dismiss];
            }else if(index == 21)
            {//竞价
                [[WLNetworkDriverHandler sharedInstance] bidOrderWithOrderID:self.orderID companyID:self.company_id andBid_price:price Cost_memo:paras statusBlock:^(WLResponseType responseType, NSInteger status, NSString *message)
                 {
                     if(responseType == WLResponseTypeSuccess){
                         if(status == 200)
                         {
                             [KWLBaseShowView dismiss];
                             [[WL_TipAlert_View sharedAlert] createTip:@"报价成功"];
                             //刷新数据
                             self.bookStatus = WLUnpaidStatus;
                             [self setupUI];
                         }else if(status == 400)
                         {
                             [KWLBaseShowView dismiss];
                             [[WL_TipAlert_View sharedAlert] createTip:message];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                     }else
                     {
                         [KWLBaseShowView dismiss];
                         [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请稍后再试."];
                     }
                 }];
            }
        };
    }
   else if ([sender.currentTitle isEqualToString:@"出发"])
    {
        acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(145)) andTipType:WLBookOrderTipStart];
        [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
        WS(weakSelf);
        acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
        {
            if (isAccept)
            {
                if(![NSString isTodayOfTimeString:self.orderModel.start_at])
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"不可以提前出发!"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:weakSelf.orderID  tripOperation:@"1" money:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                        //刷新数据
                        self.bookStatus = WLOrderStatusTravel;
                        [self setupUI];
                    }else
                    {
                        [[WL_TipAlert_View sharedAlert] createTip:@"请求失败,请重试"];
                    }
                }];
            }
            [KWLBaseShowView dismiss];
            
        };
        
    }else if([sender.currentTitle isEqualToString:@"结束"])
    {
        acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(145)) andTipType:WLBookOrderTipEnd];
        [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
        WS(weakSelf);
        acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
        {
            if (isAccept) {
                
                if(![NSString isTodayOfTimeString:self.orderModel.end_at])
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"不可以提前结束!"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:weakSelf.orderID  tripOperation:@"2" money:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                        //刷新数据
                        self.bookStatus = WLOrderStatusSettlement;
                        [self setupUI];
                    }else
                    {
                        [[WL_TipAlert_View sharedAlert] createTip:@"请求失败,请重试"];
                    }
                }];
            }
            [KWLBaseShowView dismiss];
            
        };
        
    }
    
}
#pragma mark -  关闭已失效订单界面的弹框方法
- (void)closePromptViewToFailureOrder
{
    self.isFailureOrderCloseBtnClick = YES;
    self.failureOrderTopView.hidden = YES;
    [self.contentTableView reloadData];
}
#pragma mark - 懒加载

- (UITableView *)contentTableView
{
    if (_contentTableView == nil) {
        UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        //添加到父控件
        [self.view addSubview:contentTableView];
        //设置代理与数据源为控制器
        contentTableView.delegate = self;
        contentTableView.dataSource = self;
        contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        contentTableView.showsVerticalScrollIndicator = NO;
        contentTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];

        contentTableView.rowHeight = UITableViewAutomaticDimension;
        _contentTableView = contentTableView;
    }
    return _contentTableView;
}
- (WLApplicationDriverBookOrderDetailBottomView *)bookOrderDetailBottomView
{
    
    if (_bookOrderDetailBottomView == nil) {
        WLApplicationDriverBookOrderDetailBottomView *bookOrderDetailBottomView = [[WLApplicationDriverBookOrderDetailBottomView alloc]init];
        WS(weakSelf);
        bookOrderDetailBottomView.timeEndCallBack = ^(){
            [KWLBaseShowView dismiss]; /*将弹框去掉*/
            [weakSelf setupUI];
        };
        [bookOrderDetailBottomView.bookButton addTarget:self action:@selector(didClickBookButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bookOrderDetailBottomView];
        [bookOrderDetailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.height.offset(ScaleH(bottomViewH));
        }];
        _bookOrderDetailBottomView = bookOrderDetailBottomView;
    }
    return _bookOrderDetailBottomView;
}

- (WL_Application_Driver_Bill_Top_View*)promptViewToFailureOrder
{
    if (_promptViewToFailureOrder == nil) {
        UIView *failureOrderTopView = [[UIView alloc]init];
        failureOrderTopView.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];
        _promptViewToFailureOrder = [[WL_Application_Driver_Bill_Top_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(31))];
        [_promptViewToFailureOrder.closeButton addTarget:self action:@selector(closePromptViewToFailureOrder) forControlEvents:UIControlEventTouchUpInside];
        [failureOrderTopView addSubview:_promptViewToFailureOrder];
        self.failureOrderTopView = failureOrderTopView;
    }
    return _promptViewToFailureOrder;
}

@end
