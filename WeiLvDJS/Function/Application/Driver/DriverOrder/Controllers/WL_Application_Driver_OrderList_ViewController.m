//
//  WL_Application_Driver_OrderList_ViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderList_ViewController.h"
#import "WL_Application_Driver_OrderCell.h"
#import "WL_Application_Driver_Bill_Top_View.h"
#import "WL_Application_Driver_RefuseOrderView.h"
#import "WL_Application_Driver_OrderTipView.h"
#import "WL_Application_Driver_OrderDetail_ViewController.h"
#import "WLDriverOrderListObject.h"
#import "WLDriverOrderObject.h"
#import "WLDriverReceiptController.h"
#import "WLApplicationDriverBookOrderCell.h"
#import "WLApplicationDriverBookOrderDetailViewController.h"
#import "WLQuotePriceView.h"
#import "WLApplicationDriverAcceptOrderSettingController.h"
@interface WL_Application_Driver_OrderList_ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
/**< 头部切换订单类型的view */
@property (nonatomic, weak) UIView *topView;
/**< 头部切换订单类型的Segmented*/
@property (nonatomic, weak) UISegmentedControl *orderSegmented;
/**< 订单内容View */
@property (nonatomic, weak) UITableView *contentTableView;
/**< 记录失效订单头部的按钮是否点击 */
@property (nonatomic, assign) BOOL isFailureOrderCloseBtnClick;
/**< 失效页面头部的提示View */
@property (nonatomic, strong) UIView *failureOrderTopView;
/**< 拒绝订单的弹框View */
@property (nonatomic, strong) WL_Application_Driver_RefuseOrderView *refuseReasonView;
/** 订单列表上拉加载更多 */ //下拉传nil
@property (nonatomic, copy) NSString *next;
/**< 订单列表数据源 */
@property (nonatomic, strong) NSMutableArray *orderListData;
/**< 无数据的占位图 */
@property (nonatomic, weak) UILabel *noOrderLabel;
/**< 选中cell的订单号 */
@property (nonatomic, copy) NSString *selectedOrderID;
/**< 记录数据的当前页 */
@property (nonatomic, copy) NSString *currentPage;
@end

/**< 头部切换订单状态View的高度 */
#define topSelectedViewHeight ScaleH(60)

@implementation WL_Application_Driver_OrderList_ViewController

static NSString *const DriverOrderCellId = @"driverOrderCellId";
static NSString *const DriverBookOrderCellId = @"driverBookOrderCellId";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /**< 每次进来刷新页面 */
    self.next = nil;
    self.orderListData = nil;
    self.currentPage = nil;
    [self sendRequestToOrderListWithOrderStatus:self.orderStatus page:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //0.初始化参数
    [self initParam];
     //2.绘制订单控制器的UI界面
    [self setupUI];
    //3.发送订单列表的网络请求
//    [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:nil];
    //4.注册上下拉刷新
    [self setupRefresh];
}
#pragma mark - 配置UI
- (void)setupUI
{
    self.title = @"接单";
    self.view.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
//    [self setNavigationRightTitle:@"接单设置" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, topSelectedViewHeight)];
    topView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [self.view addSubview:topView];
    self.topView = topView;
    //设置中间选择器
    NSArray *items = @[ @"待接单",@"已接单",@"已失效" ];
    UISegmentedControl *orderSegmented = [[UISegmentedControl alloc]initWithItems:items];
    [orderSegmented setSelectedSegmentIndex:0];
    [orderSegmented setTintColor:[WLTools stringToColor:@"#333333"]];
    
    [self.topView addSubview:orderSegmented];
    [orderSegmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(ScaleW(12));
        make.right.equalTo(self.topView).offset(-ScaleW(12));
        make.centerY.equalTo(self.topView);
    }];
    
    [orderSegmented addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    
    //订单内容view
    UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //添加到父控件
    [self.view addSubview:contentTableView];
    //添加约束
    [contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UILabel *noOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 150, 30)];
    noOrderLabel.textColor = [WLTools stringToColor:@"#929292"];
    noOrderLabel.textAlignment = NSTextAlignmentCenter;
    noOrderLabel.text = @"暂无订单";
    noOrderLabel.font = [UIFont WLFontOfSize:14];
    noOrderLabel.centerX = self.view.centerX;
    [contentTableView addSubview:noOrderLabel];
    self.noOrderLabel = noOrderLabel;
    //设置代理与数据源为控制器
    contentTableView.delegate = self;
    contentTableView.dataSource = self;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.showsVerticalScrollIndicator = NO;
    contentTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];
    //注册cell
    [contentTableView registerClass:[WL_Application_Driver_OrderCell class] forCellReuseIdentifier:DriverOrderCellId];
    [contentTableView registerClass:[WLApplicationDriverBookOrderCell class] forCellReuseIdentifier:DriverBookOrderCellId];
    self.contentTableView = contentTableView;
    
    //添加失效订单界面的头部View
    UIView *failureOrderTopView = [[UIView alloc]init];
    failureOrderTopView.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];
    WL_Application_Driver_Bill_Top_View *promptViewToFailureOrder = [[WL_Application_Driver_Bill_Top_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(31))];
    promptViewToFailureOrder.promptLable.text = @"提示:  拒单率太高,会导致派单变少哦!";
    //关闭按钮点击方法
    [failureOrderTopView addSubview:promptViewToFailureOrder];
    [promptViewToFailureOrder.closeButton addTarget:self action:@selector(closePromptViewToFailureOrder) forControlEvents:UIControlEventTouchUpInside];
    self.failureOrderTopView = failureOrderTopView;
    
//    发送订单列表的网络请求
    [self didClicksegmentedControlAction:orderSegmented];
    
}
#pragma mark - 发送订单列表的网络请求

- (void)sendRequestToOrderListWithOrderStatus:(NSInteger)orderStatus page:(NSString *)nextPage
{
    NSString *type = [NSString stringWithFormat:@"%ld",(long)orderStatus];
    [self showHud];
    [[WLNetworkDriverHandler sharedInstance] requestOrderListWithType:type nextUrl:nextPage
                                                            dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                                if (responseType == WLResponseTypeSuccess) {
                                                                    
                                                                    if ([self.currentPage integerValue] == [[(WLDriverOrderListObject *)data pageCount] integerValue]) {/*说明是最后一页*/
                                                                         [self hidHud];
//                                                                        [[WL_TipAlert_View sharedAlert] createTip:@"没有更多数据了"];
                                                                        [self.contentTableView.mj_header endRefreshing];
                                                                        [self.contentTableView.mj_footer endRefreshing];
                                                                        
                                                                        [self.contentTableView reloadData];
                                                                        return;
                                                                    }
                                                                    //表示是下拉刷新
                                                                    if (nextPage == nil)
                                                                    {
                                                                        self.orderListData = [(WLDriverOrderListObject *)data items].mutableCopy ;
                                                                        self.currentPage = nil;
                                                                    }else//表示是上拉加载更多
                                                                    {
                                                                       
                                                                        [self.orderListData addObjectsFromArray:[(WLDriverOrderListObject *)data items]] ;
                                                                    }
                                                                    self.currentPage = [(WLDriverOrderListObject *)data currentPage];
                                                                    if ([[(WLDriverOrderListObject *)data currentPage] integerValue] == [[(WLDriverOrderListObject *)data pageCount] integerValue]) {
                                                                        
                                                                    }else
                                                                    {
                                                                       self.next = [(WLDriverOrderListObject *)data nextUrlString];
                                                                    }
                                                                    [self hidHud];
                                                                    self.noOrderLabel.hidden = YES;
                                                                    [self.contentTableView reloadData];
                                                                    
                                                                }else
                                                                {
                                                                   
                                                                    self.noOrderLabel.hidden = NO;
                                                                }
                                                                
                                                                [self.contentTableView.mj_header endRefreshing];
                                                                [self.contentTableView.mj_footer endRefreshing];
                                                                [self hidHud];
                                                            }];
    
}
#pragma mark - 初始化参数
- (void)initParam
{
    self.orderStatus = WL_WaitOrderStatus;
    self.isFailureOrderCloseBtnClick = NO;
    self.selectedOrderID = @"";

    self.next = nil;
    self.currentPage = nil;
}
#pragma mark - 注册上下拉刷新
- (void)setupRefresh
{
    WS(weakSelf);
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.next = nil;
        weakSelf.orderListData = nil;
        weakSelf.currentPage = nil;
        //发送网络请求
        [weakSelf sendRequestToOrderListWithOrderStatus:weakSelf.orderStatus page:weakSelf.next];
    }];
    self.contentTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    //待接单列表-上拉刷新
    self.contentTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf loadMoreDataToOrderList];

    }];

}
#pragma mark - 切换订单状态的点击事件
- (void)didClicksegmentedControlAction:(UISegmentedControl *)orderSegmented
{
    NSInteger selectIndex = orderSegmented.selectedSegmentIndex;
    //清空数据源
    self.next = nil;
    self.orderListData = nil;
    self.currentPage = nil;
    if(selectIndex == 0){
        if (self.driverStatus == -1 || self.carStaus == -1) {
            [self setNavigationRightTitle:nil fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
        }else
        {
        [self setNavigationRightTitle:@"接单设置" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
        }
    }else if(selectIndex == 2){
      [self setNavigationRightTitle:@"清空" fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
    }else if(selectIndex == 1){
       [self setNavigationRightTitle:nil fontSize:15 titleColor:[WLTools stringToColor:@"#00cc99"] isEnable:YES];
    }
//   [self setNavigationRightTitle:selectIndex == 2?@"清空":nil fontSize:17 titleColor:[WLTools stringToColor:@"#00cc99"]isEnable:YES];

    switch (selectIndex) {
        case 0:
            self.orderStatus = WL_WaitOrderStatus;
            break;
        case 1:
            self.orderStatus = WL_AcceptOrderStatus;
            break;
        case 2:
            self.orderStatus = WL_FailureOrderStatus;
            break;
        default:
            break;
    }
//    self.contentTableView.scrollsToTop = YES;
    [self sendRequestToOrderListWithOrderStatus:self.orderStatus page:self.next];
    [self.contentTableView setContentOffset:CGPointMake(0, 0) animated:NO];
}
#pragma mark - 待接单列表管理-上拉刷新->加载更多
- (void)loadMoreDataToOrderList
{
    [self sendRequestToOrderListWithOrderStatus:self.orderStatus page:self.next];
}
#pragma mark - 右边item的点击事件
- (void)NavigationRightEvent
{
   
    if(self.orderStatus == WL_WaitOrderStatus){
        //跳转到接单设置控制器
        WLApplicationDriverAcceptOrderSettingController *VC = [[WLApplicationDriverAcceptOrderSettingController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if(self.orderStatus == WL_FailureOrderStatus){
        if (self.orderListData != nil)
        {
            WL_Application_Driver_OrderTipView *acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(125)) andTipType:WLOrderTipDelete];
            
            [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
            
            WS(weakSelf);
            acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
            {
                if (isAccept)
                {
                    [[WLNetworkDriverHandler sharedInstance] deleteOutOfDateOrderListWithOperationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                        if (result)
                        {
                            [[WL_TipAlert_View sharedAlert] createTip:@"删除成功"];
                            self.orderListData = nil;
                            [self.contentTableView reloadData];
                            weakSelf.noOrderLabel.hidden = NO;
                            
                        }else {
                            [[WL_TipAlert_View sharedAlert] createTip:@"删除失败"];
                        }
                    }];
                }
                [KWLBaseShowView dismiss];
            };
            
            
        }
    }
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.orderListData.count > 0)
    {
        self.noOrderLabel.hidden = YES;
    }else
    {
        self.noOrderLabel.hidden = NO;
    }
    return self.orderListData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLDriverOrderObject *orderModel = self.orderListData[indexPath.section];
    if ([orderModel.order_type isEqualToString:@"1"]) {//派单
        WL_Application_Driver_OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverOrderCellId];
        cell.orderModel = self.orderListData[indexPath.section];
        [cell.refuseButton addTarget:self action:@selector(didClickRefuseButton:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.refuseButton.tag = indexPath.section;
        [cell.acceptButton addTarget:self action:@selector(didClickAcceptButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.acceptButton.tag  = indexPath.section + 100;
        return cell;
    }else if([orderModel.order_type isEqualToString:@"2"])//抢单
    {
        WLApplicationDriverBookOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverBookOrderCellId];
        cell.orderModel = self.orderListData[indexPath.section];
         cell.bookButton.tag  = indexPath.section + 200;
        [cell.bookButton addTarget:self action:@selector(didClickBookButton:) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        if (self.orderStatus == WL_WaitOrderStatus) {
            cell.timeEndCallBack = ^(){/*倒计时结束 刷新列表*/
//              [KWLBaseShowView dismiss]; /*将弹框去掉*/
             [weakSelf sendRequestToOrderListWithOrderStatus:self.orderStatus page:nil];
            };
        }
        return cell;
    }
    return [UITableViewCell new];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLDriverOrderObject *orderModel = self.orderListData[indexPath.section];
    if([orderModel.order_type isEqualToString:@"1"])
    {
        return ScaleH(228);
    }
    return ScaleH(240);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.orderStatus == WL_FailureOrderStatus && section == 0 && self.isFailureOrderCloseBtnClick == NO)
    {
        return ScaleH(45);
    }
    return ScaleH(14);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.orderStatus == WL_FailureOrderStatus && section == 0 && self.isFailureOrderCloseBtnClick == NO)
    {
        return self.failureOrderTopView;
    }
    return nil;
}

#pragma mark - 跳转到订单详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLDriverOrderObject *orderModel = self.orderListData[indexPath.section];
    if([orderModel.order_type isEqualToString:@"1"])
    {
        
        WL_Application_Driver_OrderCell *cell = [self.contentTableView cellForRowAtIndexPath:indexPath];
        WLOrderDetailStatus detailStatus;
        switch (cell.orderStatus) {
            case WL_WaitOrderStatus:
                detailStatus = WLOrderDetailWait;
                break;
            case WL_AcceptOrderStatusStart:
                detailStatus = WLOrderDetailStart;
                break;
            case WL_AcceptOrderStatusTravel:
                detailStatus = WLOrderDetailTravel;
                break;
            case WL_FailureOrderStatusCanceled:
                detailStatus = WLOrderDetailCancel;
                break;
            case WL_FailureOrderStatusRefused:
                detailStatus = WLOrderDetailRefuse;
                break;
            case WL_FailureOrderStatusOverTime:
                detailStatus = WLOrderDetailOverTime;
                break;
            default:
                break;
        }
        if ([cell.orderModel.trip_status isEqualToString:@"2"] ) {
            if ([cell.orderModel.pay_status isEqualToString:@"0"]) {
                detailStatus = WLOrderDetailSettlement;//待结算
            }else if([cell.orderModel.pay_status isEqualToString:@"1"])
            {
                detailStatus = WLOrderDetailFinished;//已结算
            }
        }
        
        [self showHud];
        
        [[WLNetworkDriverHandler sharedInstance] requestOrderDetailWithOrderID:cell.orderModel.orderID dataBlock:^(WLResponseType responseType, id data, NSString *message) {
            if (responseType == WLResponseTypeSuccess && data) {
                [self hidHud];
                [self jumpToOrderDetailViewControllerWithStatus:detailStatus andOrderDetailData:data];
            }else
            {
                [self hidHud];
                [[WL_TipAlert_View sharedAlert] createTip:@"请求订单详情失败,请重试"];
            }
        }];
    }else if([orderModel.order_type isEqualToString:@"2"])//
    {
        WLApplicationDriverBookOrderCell *cell = [self.contentTableView cellForRowAtIndexPath:indexPath];
        WLApplicationDriverBookOrderDetailViewController *bookVC = [[WLApplicationDriverBookOrderDetailViewController alloc]init];
//        bookVC.bookStatus = cell.bookStatus;
        bookVC.orderID = cell.orderModel.orderID;
        bookVC.company_id = self.company_id;
        [self.navigationController pushViewController:bookVC animated:YES];
    }
    
    
}

#pragma mark -点击了抢单按钮
- (void)didClickBookButton:(UIButton *)sender
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:sender.tag - 200];
    WLApplicationDriverBookOrderCell *cell = [self.contentTableView cellForRowAtIndexPath:path];
    
    WL_Application_Driver_OrderTipView  *acceptOrderTipView;
    if (cell.bookStatus == WLWaitOrderStatus)//竞价
    {
        NSString *order_id = cell.orderModel.orderID;
        
        WLQuotePriceView *quotePriceView = [[WLQuotePriceView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(340), ScaleH(320))];
        
        [KWLBaseShowView showWithContentView:quotePriceView andTouch:NO andCallBlack:nil];
        quotePriceView.buttonCallBack = ^(NSInteger index,NSString *price,NSString *paras)
        {
            [KWLBaseShowView dismiss];
            if(index == 20)
            {//取消
//                [KWLBaseShowView dismiss];
            }else if(index == 21)
            {//竞价
//                [KWLBaseShowView dismiss];
                NSString *newOrder_id = cell.orderModel.orderID;
                if ([order_id integerValue] == [newOrder_id integerValue]) {
                    [[WLNetworkDriverHandler sharedInstance] bidOrderWithOrderID:cell.orderModel.orderID companyID:self.company_id andBid_price:price Cost_memo:paras statusBlock:^(WLResponseType responseType, NSInteger status, NSString *message)
                     {
                         if(responseType == WLResponseTypeSuccess){
                             if(status == 200)
                             {
                                 
                                 [[WL_TipAlert_View sharedAlert] createTip:@"报价成功"];
                                 
                                 WLApplicationDriverBookOrderDetailViewController *bookVC = [[WLApplicationDriverBookOrderDetailViewController alloc]init];
                                 //                                         bookVC.bookStatus = WLUnpaidStatus;
                                 bookVC.orderID = cell.orderModel.orderID;
                                 bookVC.company_id = self.company_id;
                                 [self.navigationController pushViewController:bookVC animated:YES];
                             }else if(status == 400)
                             {
                                 [[WL_TipAlert_View sharedAlert] createTip:message];
//                                 [KWLBaseShowView dismiss];
                                 [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:nil];
                             }
                         }else
                         {
//                             [KWLBaseShowView dismiss];
                             [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请稍后再试."];
                         }
                     }];
                }else
                {
//                    [KWLBaseShowView dismiss];
                    [[WL_TipAlert_View sharedAlert] createTip:@"该订单已失效"];
                }
                
            }
        };
    }else if ([sender.currentTitle isEqualToString:@"出发"])
    {
        acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(145)) andTipType:WLBookOrderTipStart];
        [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
        WS(weakSelf);
        acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
        {
            if (isAccept)
            {
                if(![NSString isTodayOfTimeString:cell.orderModel.start_at])
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"不可以提前出发!"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:cell.orderModel.orderID  tripOperation:@"1" money:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                        //跳到订单详情页
                        WLApplicationDriverBookOrderDetailViewController *bookVC = [[WLApplicationDriverBookOrderDetailViewController alloc]init];
//                        bookVC.bookStatus = WLOrderStatusTravel;
                        bookVC.orderID = cell.orderModel.orderID;
                        bookVC.company_id = weakSelf.company_id;
                        [self.navigationController pushViewController:bookVC animated:YES];
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

                if(![NSString isTodayOfTimeString:cell.orderModel.end_at])
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"不可以提前结束!"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:cell.orderModel.orderID  tripOperation:@"2" money:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                        //跳到订单详情页
                        WLApplicationDriverBookOrderDetailViewController *bookVC = [[WLApplicationDriverBookOrderDetailViewController alloc]init];
//                        bookVC.bookStatus = WLOrderStatusSettlement;
                        bookVC.orderID = cell.orderModel.orderID;
                        bookVC.company_id = weakSelf.company_id;
                        [weakSelf.navigationController pushViewController:bookVC animated:YES];
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
    NSIndexSet *section = [NSIndexSet indexSetWithIndex:0];
    [self.contentTableView reloadSections: section withRowAnimation: UITableViewRowAnimationFade];
}
#pragma mark -点击了拒单按钮
- (void)didClickRefuseButton:(UIButton *)sender
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
            
            WLDriverOrderObject *model = weakSelf.orderListData[sender.tag];
            [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:model.orderID orderOperation:@"2" refuseReason:jsonStr dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                
                if (responseType == WLResponseTypeSuccess) {//请求成功
                    
                    weakSelf.refuseReasonView = nil;
                    [weakSelf jumpToOrderDetailViewControllerWithStatus:WLOrderDetailRefuse andOrderDetailData:data];
                    
                }else//请求失败
                {
                   [[WL_TipAlert_View sharedAlert] createTip:@"请求失败,请重试"];
                }
                [KWLBaseShowView dismiss];
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
#pragma mark -点击了接单按钮
- (void)didClickAcceptButton:(UIButton *)sender
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:sender.tag - 100];
    WL_Application_Driver_OrderCell *cell = [self.contentTableView cellForRowAtIndexPath:path];
//    self.selectedOrderID = cell.orderModel.orderID;
    WL_Application_Driver_OrderTipView  *acceptOrderTipView;
    switch (self.orderStatus) {
        case WL_WaitOrderStatus://待接单
        {
            acceptOrderTipView = [[ WL_Application_Driver_OrderTipView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(ScreenWidth - 95), ScaleH(145)) andTipType:WLOrderTipAccept];
            
            acceptOrderTipView.startInfo = [NSString stringWithFormat:@"%@-%@",cell.departureTimeLabel.text,cell.fromCityLabel.text];
            [KWLBaseShowView showWithContentView:acceptOrderTipView andTouch:NO andCallBlack:nil];
            
            WS(weakSelf);
            acceptOrderTipView.seletedCallBack = ^(BOOL isAccept)
            {
                if (isAccept)
                {
                    [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:cell.orderModel.orderID orderOperation:@"1" refuseReason:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                        
                        if (responseType == WLResponseTypeSuccess) {//请求成功
                            
                            [weakSelf jumpToOrderDetailViewControllerWithStatus:WLOrderDetailStart andOrderDetailData:data];
                        }else//请求失败
                        {
                            [[WL_TipAlert_View sharedAlert] createTip:@"请求失败,请重试"];
                        }
                    }];
                }
                [KWLBaseShowView dismiss];
            };
            
        }
            
        default:
            break;
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
                NSTimeInterval resurtTime = [WLTools setupDifferentTime:cell.orderModel.start_at];
                if(resurtTime > 0)
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"不可以提前出发"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:cell.orderModel.orderID  tripOperation:@"1" money:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                        [weakSelf jumpToOrderDetailViewControllerWithStatus:WLOrderDetailTravel andOrderDetailData:data];
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
                
                
                NSTimeInterval resurtTime = [WLTools setupDifferentTime:cell.orderModel.end_at];
                if(resurtTime > 0)
                {
                    [[WL_TipAlert_View sharedAlert] createTip:@"不可以提前结束"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] modifyOrderStatusWithOrderID:cell.orderModel.orderID  tripOperation:@"2" money:nil dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                    if (responseType == WLResponseTypeSuccess) {//请求成功
                        WLDriverReceiptController *receiptController = [[WLDriverReceiptController alloc]init];
                        receiptController.orderPrice = cell.orderModel.order_price;
                        receiptController.fromControllerType = WLFromAcceptController;
                        receiptController.orderID = cell.orderModel.orderID;
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
    [self.navigationController pushViewController:orderDetailViewController animated:YES];
}
#pragma mark - 懒加载
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







