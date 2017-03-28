//
//  WL_Application_Driver_OrderDetail_ViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/12/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetail_ViewController.h"
#import "WL_Application_Driver_OrderSectionStatusView.h"
#import "WL_Application_Driver_OrderDetailSectionHeadView.h"
#import "WL_Application_Driver_OrderDetailCell0.h"
#import "WL_Application_Driver_OrderDetailCell1.h"
#import "WL_Application_Driver_OrderDetailCell2.h"
#import "WL_Application_Driver_OrderDetailCell3.h"
#import "WL_Application_Driver_OrderDetailCell4.h"
#import "WL_Application_Driver_OrderDetailCell5.h"
#import "WLDriverReceiptController.h"
#import "WL_Application_Driver_OrderTipView.h"
#import "WL_Application_Driver_RefuseOrderView.h"
@interface WL_Application_Driver_OrderDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource>

/**< 订单详情内容View */
@property (nonatomic, weak) UITableView *contentTableView;
/**< 订单详情底部的View */
@property (nonatomic, weak) WL_Application_Driver_OrderDetailBottomView *orderDetailBottomView;
/**< 拒绝订单的弹框View */
@property (nonatomic, strong) WL_Application_Driver_RefuseOrderView *refuseReasonView;
@end

@implementation WL_Application_Driver_OrderDetail_ViewController
#define FooterHeight 70
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
//     [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupUI];
}
- (void)setupUI
{
    [self.contentTableView removeFromSuperview];
    self.contentTableView  = nil;
    
    if (self.orderDetailStatus == WLOrderDetailCancel ||self.orderDetailStatus == WLOrderDetailRefuse||self.orderDetailStatus == WLOrderDetailOverTime) {
        [self.contentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
    }else
    {
        [self.contentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-ScaleH(FooterHeight));
        }];
        
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view layoutIfNeeded];
    self.orderDetailBottomView.expiry_at = self.orderDetailData.expiry_at;
    self.orderDetailBottomView.orderDetailStatus = self.orderDetailStatus;
    self.orderDetailBottomView.orderDetailData = self.orderDetailData;
    
    [self.contentTableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.orderDetailSectionArray.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WL_Application_Driver_OrderDetailCell0 *cell0 = [WL_Application_Driver_OrderDetailCell0 cellForTableView:tableView];
        NSArray *dataArray = @[
                               self.orderDetailData.trip_name,
                               self.orderDetailData.order_price,
                               self.orderDetailData.car_seat_amount
                               ];
        cell0.dataArray = dataArray;
        return cell0;
    }else if(indexPath.section == 1)
    {
        WL_Application_Driver_OrderDetailCell1 *cell1 = [WL_Application_Driver_OrderDetailCell1 cellForTableView:tableView];
        NSArray *dataArray = @[
                               self.orderDetailData.start_at,
                               self.orderDetailData.start_address,
                               self.orderDetailData.end_at,
                               self.orderDetailData.end_address
                               ];
        cell1.dataArray = dataArray;
        return cell1;
    }else if(indexPath.section == 2)
    {
        if (self.orderDetailStatus == WLOrderDetailFinished || self.orderDetailStatus  == WLOrderDetailSettlement) {
            WL_Application_Driver_OrderDetailCell2 *cell2 = [WL_Application_Driver_OrderDetailCell2 cellForTableView:tableView];
            cell2.isFinished = self.orderDetailStatus == WLOrderDetailFinished ?YES:NO;
            cell2.paidTipImageViewTapHandBlack = ^(){
                [self.contentTableView reloadData];
            };
            
            /**< 实际订单金额 */
            NSString *realPrice = [NSString stringWithFormat:@"%.2lf",[self.orderDetailData.order_price doubleValue] + [self.orderDetailData.customer_adjust_price doubleValue] + [self.orderDetailData.self_adjust_price doubleValue]];
            /**< 已支付 */
            NSString *paidAmount =  [NSString stringWithFormat:@"%.2lf",[self.orderDetailData.selt_pay_amount doubleValue] + [self.orderDetailData.customer_pay_amount doubleValue]];
            
            /**< 未支付金额 */
            NSString *unPaidAmount = [NSString stringWithFormat:@"%.2lf",[realPrice doubleValue] - [paidAmount doubleValue]];
            NSArray *dataArray = @[
                                   self.orderDetailData.order_price,
                                   realPrice,
                                   paidAmount,
                                   self.orderDetailData.pay_list,
                                   unPaidAmount,
                                   ];
            cell2.dataArray = dataArray;
            return cell2;
        }
        WL_Application_Driver_OrderDetailCell3 *cell3 = [WL_Application_Driver_OrderDetailCell3 cellForTableView:tableView];
        
        NSArray *dataArray = @[
                               (self.orderDetailData.companyName == nil)?@"无车调中心":self.orderDetailData.companyName,
                               (self.orderDetailData.number == nil)?@"":self.orderDetailData.number,
                               (self.orderDetailData.use_car_contacts == nil)?@"":self.orderDetailData.use_car_contacts,
                               (self.orderDetailData.dj_group_number == nil)?@"无成团单号":self.orderDetailData.dj_group_number
                               ];
        cell3.dataArray = dataArray;
        return cell3;
    }else if (indexPath.section == 3)
    {
        if(self.orderDetailStatus == WLOrderDetailSettlement || self.orderDetailStatus == WLOrderDetailFinished)
        {
            WL_Application_Driver_OrderDetailCell3 *cell3 = [WL_Application_Driver_OrderDetailCell3 cellForTableView:tableView];
            NSArray *dataArray = @[
                                   (self.orderDetailData.companyName == nil)?@"无车调中心":self.orderDetailData.companyName,
                                   (self.orderDetailData.number == nil)?@"":self.orderDetailData.number,
                                   (self.orderDetailData.use_car_contacts == nil)?@"":self.orderDetailData.use_car_contacts,
                                   (self.orderDetailData.dj_group_number == nil)?@"无成团单号":self.orderDetailData.dj_group_number
                                   ];
            cell3.dataArray = dataArray;
            return cell3;
        }
        WL_Application_Driver_OrderDetailCell4 *cell4 = [WL_Application_Driver_OrderDetailCell4 cellForTableView:tableView];
        cell4.commentLabel.text = [NSString GetStringNSUTF8StringEncodingANDEmoji:self.orderDetailData.memo];
        return cell4;
    }else if(indexPath.section == 4)
    {
        if(self.orderDetailStatus == WLOrderDetailSettlement || self.orderDetailStatus == WLOrderDetailFinished)
        {
            WL_Application_Driver_OrderDetailCell4 *cell4 = [WL_Application_Driver_OrderDetailCell4 cellForTableView:tableView];
            cell4.commentLabel.text = [NSString GetStringNSUTF8StringEncodingANDEmoji:self.orderDetailData.memo];
            return cell4;
        }
    }
    WL_Application_Driver_OrderDetailCell5 *cell5 = [WL_Application_Driver_OrderDetailCell5 cellForTableView:tableView];
    cell5.cellData = self.orderDetailData;
    cell5.orderDetailStatus = self.orderDetailStatus;
    
    return cell5;
}

//返回每一组的组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return nil;
    }else if(section == self.orderDetailSectionArray.count + 1)
    {
        WL_Application_Driver_OrderSectionStatusView *orderSectionStatusView = [[WL_Application_Driver_OrderSectionStatusView alloc ]initWithStatus:self.orderDetailStatus andFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(90))];
        return orderSectionStatusView;
    }
    NSInteger index = section - 1;
    if (index >= self.orderDetailSectionArray.count ) {
        return nil;
    }
        WL_Application_Driver_OrderDetailSectionHeadView *orderDetailSectionHeadView = [[WL_Application_Driver_OrderDetailSectionHeadView alloc]init];
        NSDictionary *dataDict = self.orderDetailSectionArray[section -1];
        orderDetailSectionHeadView.iconImage.image = [UIImage imageNamed:dataDict[@"iconImage"]];
        orderDetailSectionHeadView.listLabel.text = dataDict[@"listLabel"];
        return orderDetailSectionHeadView;
    
}

//返回每一组组尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == self.orderDetailSectionArray.count + 1)
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
        return 0.01;
        
    }else if(section == self.orderDetailSectionArray.count + 1)
    {
        return 85;
    }else
    {
        return 44;
    }
}
//预估行高
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       return ScaleH(115);
    }else if(indexPath.section == 1)
    {
        return ScaleH(190);
        
    }else if(indexPath.section == 2)
    {
        if (self.orderDetailStatus  == WLOrderDetailSettlement) {
            return ScaleH(176);
        }else if (self.orderDetailStatus == WLOrderDetailFinished)
        {
            return ScaleH(132);
        }
        
        return ScaleH(128);
    }else if (indexPath.section == 3)
    {
        if(self.orderDetailStatus == WLOrderDetailSettlement || self.orderDetailStatus == WLOrderDetailFinished)
        {
          return ScaleH(128);
        }
        return ScaleH(44);
    }else if(indexPath.section == 4)
    {
        if(self.orderDetailStatus == WLOrderDetailSettlement || self.orderDetailStatus == WLOrderDetailFinished)
        {
             return ScaleH(44);
        }
         return ScaleH(128);
    }
     return ScaleH(44);
}
#pragma mark - 底部接单按钮的点击事件
- (void)didClickAcceptButton:(UIButton *)sender
{
    WL_Application_Driver_OrderTipView  *acceptOrderTipView;
    
    if ([self.orderDetailData.reception_status isEqualToString:@"0"]) {
        acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(145)) andTipType:WLOrderTipAccept];
        
        acceptOrderTipView.startInfo = [NSString stringWithFormat:@"%@-%@",[self getDateStringWithTime: self.orderDetailData.start_at],self.orderDetailData.start_address];
        [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
        
        WS(weakSelf);
        acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
        {
            if (isAccept)
            {
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:weakSelf.orderDetailData.orderID orderOperation:@"1" refuseReason:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                       
                        [weakSelf refreshOrderDetailViewControllerWithStatus:WLOrderDetailStart andOrderDetailData:data];
                    }else//请求失败
                    {
                        [[WL_TipAlert_View sharedAlert] createTip:@"请求失败,请重试"];
                    }
                    
                }];
            }
             [KWLBaseShowView dismiss];
            
        };
        
    }
 
    if([sender.currentTitle isEqualToString:@"出发"])
    {
        acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(125)) andTipType:WLOrderTipStart];
         [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
        WS(weakSelf);
        acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
        {
            if (isAccept)
            {
                NSTimeInterval resurtTime = [WLTools setupDifferentTime:self.orderDetailData.start_at];
                if(resurtTime > 0)
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"不可以提前出发"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:weakSelf.orderDetailData.orderID tripOperation:@"1" money:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                        [self refreshOrderDetailViewControllerWithStatus:WLOrderDetailTravel andOrderDetailData:data];
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
        acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(145)) andTipType:WLOrderTipEnd];
        [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
        WS(weakSelf);
        acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
        {
            if (isAccept) {
                NSTimeInterval resurtTime = [WLTools setupDifferentTime:weakSelf.orderDetailData.end_at];
                if(resurtTime > 0)
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"不可以提前结束"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:self.orderDetailData.orderID tripOperation:@"1" money:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                        WLDriverReceiptController *receiptController = [[WLDriverReceiptController alloc]init];
                        receiptController.orderPrice = weakSelf.orderDetailData.order_price;
                        receiptController.fromControllerType = WLFromDetailController;
                        receiptController.orderID = weakSelf.orderDetailData.orderID;
                        [weakSelf.navigationController pushViewController:receiptController animated:YES];
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

#pragma mark - 底部拒单按钮的点击事件
- (void)didClickRefusedButton:(UIButton *)sender
{
    if([sender.currentTitle isEqualToString:@"拒绝"])
    {
        
        self.refuseReasonView.hidden = NO;
        [KWLBaseShowView showWithContentView:self.refuseReasonView andTouch:NO andCallBlack:nil];
        __weak typeof(self) weakSelf = self;
        self.refuseReasonView.ButtonCallBlack = ^(NSArray *titleArray)
        {
            if (titleArray == nil ||titleArray.count == 0) {//说明点击的是取消按钮
                [KWLBaseShowView dismiss];
                weakSelf.refuseReasonView = nil;
                return ;
            }
            NSData *data= [NSJSONSerialization dataWithJSONObject:titleArray options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSString *reasons = [titleArray componentsJoinedByString:@"||"];
            
            [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:weakSelf.orderDetailData.orderID orderOperation:@"2" refuseReason:jsonStr dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                
                if (responseType == WLResponseTypeSuccess) {//请求成功
                    [KWLBaseShowView dismiss];
                    weakSelf.refuseReasonView = nil;
                    [weakSelf refreshOrderDetailViewControllerWithStatus:WLOrderDetailRefuse andOrderDetailData:data];
                }else//请求失败
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"请求失败,请重试"];
                }
            }];
        };
        
        self.refuseReasonView.otherReasonCallBlack = ^(BOOL isSelected)
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                if (isSelected)
                {
                    weakSelf.refuseReasonView.reasonTextView.hidden = NO;
                    weakSelf.refuseReasonView.height = ScaleH(425);
                }else
                {
                    weakSelf.refuseReasonView.reasonTextView.hidden = YES;
                    weakSelf.refuseReasonView.height = ScaleH(305);
                }
                [weakSelf.refuseReasonView layoutIfNeeded];
            }];
        };
    }
}

#pragma mark - 刷新订单详情的方法
- (void)refreshOrderDetailViewControllerWithStatus:(WLOrderDetailStatus)status andOrderDetailData:(WLDriverOrderObject *)orderDetailData
{
    
    self.orderDetailStatus = status;
    self.orderDetailData = orderDetailData;
    if (status == WLOrderDetailSettlement ||status == WLOrderDetailFinished) {
        self.orderDetailSectionArray = @[
                                         @{@"iconImage":@"chuxing",@"listLabel":@"出行信息"},
                                         @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"支付信息"},
                                         @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"订单来源"},
                                         @{@"iconImage":@"beihzu",@"listLabel":@"备注信息"},
                                         ];
    }else
    {
        self.orderDetailSectionArray = @[
                                         @{@"iconImage":@"chuxing",@"listLabel":@"出行信息"},
                                         @{@"iconImage":@"dingdanlaiyuan",@"listLabel":@"订单来源"},
                                         @{@"iconImage":@"beizhu",@"listLabel":@"备注信息"},
                                         ];
    }
    [self setupUI];
}
#pragma mark - 将时间戳转换成指定格式的字符串
- (NSString *)getDateStringWithTime:(NSString *)time
{
    
    NSTimeInterval newTime = [time doubleValue];
    
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:newTime];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"MM月dd日"];
    
    return  [dateFormatter stringFromDate:detaildate];
    
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
- (WL_Application_Driver_OrderDetailBottomView *)orderDetailBottomView
{
    if (_orderDetailBottomView == nil) {
        WL_Application_Driver_OrderDetailBottomView *orderDetailBottomView = [[WL_Application_Driver_OrderDetailBottomView alloc]init];
        [orderDetailBottomView.acceptButton addTarget:self action:@selector(didClickAcceptButton:) forControlEvents:UIControlEventTouchUpInside];
        [orderDetailBottomView.refuseButton addTarget:self action:@selector(didClickRefusedButton:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:orderDetailBottomView];
        
        [orderDetailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.height.offset(ScaleH(FooterHeight));
        }];
        _orderDetailBottomView = orderDetailBottomView;
    }
    return _orderDetailBottomView;
}
- (WL_Application_Driver_RefuseOrderView *)refuseReasonView
{
    if (!_refuseReasonView)
    {
        _refuseReasonView = [[WL_Application_Driver_RefuseOrderView alloc]initWithFrame:CGRectMake(0, 0,ScaleW(291), ScaleH(305))];
        _refuseReasonView.hidden = YES;
    }
    return _refuseReasonView;
}
@end
