//
//  WL_Application_Driver_OrderList_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/29.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  司机接单主控制器

#import "WL_Application_Driver_OrderList_ViewController1.h"
//导入头部标题View的头文件
#import "WL_Application_Driver_Order_NavTitle_View.h"
//导入内容提示信息View的头文件
#import "WL_Application_Driver_Bill_Top_View.h"
//待接单列表cell
#import "WL_Application_Driver_Order_WaitOrder_Cell.h"
//已接单列表的cell
#import "WL_Application_Driver_Order_AcceptOrder_Cell.h"
//已失效列表的cell
#import "WL_Application_Driver_Order_FailureOrder_Cell.h"
//拒绝原因cell
#import "WL_Application_Driver_Order_RefuseOrder_Cell.h"
//待接单详情界面的控制器
#import "WL_Application_Driver_Order_WaitOrderDetail_ViewController.h"
//已接单详情界面的控制器
#import "WL_Application_Driver_Order_AcceptOrderDetail_ViewController.h"
//失效订单详情界面的控制器
#import "WL_Application_Driver_Order_FailureOrderDetail_ViewController.h"
//订单列表模型
#import "WL_Application_Driver_OrderList_Model.h"
//订单模型
#import "WL_Application_Driver_Order_Model.h"
//拒绝订单的弹框
#import "WL_Application_Driver_RefuseOrder_AlertView.h"
//抢单的弹框
#import "WL_Application_Driver_Order_Rush_AlertView.h"
//催款的弹框
#import "WL_Application_Driver_Order_AcceptOrder_AlertView.h"
#import "WL_Application_Driver_Trip_ViewController.h"

@interface WL_Application_Driver_OrderList_ViewController1 ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
/** 全局的NavTitleView<Nav的头部View> */
@property(nonatomic, weak) WL_Application_Driver_Order_NavTitle_View *navTitleView;

/** 待接单界面的头部提示信息 */
@property(nonatomic, weak) WL_Application_Driver_Bill_Top_View *promptViewToWaitOrder;
/** 待接单列表TableView */
@property(nonatomic, weak) UITableView *waitOrderListTableView;

/** 已接单界面的头部提示信息 */
@property(nonatomic, weak) WL_Application_Driver_Bill_Top_View *promptViewToAcceptOrder;
/** 已接单列表TableView */
@property(nonatomic, weak) UITableView *acceptOrderListTableView;

/** 失效订单界面的头部提示信息 */
@property(nonatomic, weak) WL_Application_Driver_Bill_Top_View *promptViewToFailureOrder;
/** 失效订单列表TableView */
@property(nonatomic, weak) UITableView *failureOrderListTableView;
/** 拒绝原因列表TableView */
@property(nonatomic, weak) UITableView *refuseReasonTableView;
/** 拒绝原因列表中其他原因输入框 */
@property(nonatomic, weak) UITextView *reasonTextView;
/** 拒绝原因列表中其他原因输入框中的占位暗文 */
@property (nonatomic,weak) UILabel *placeholderLabel;
/** 网络请求时需要用到的弹框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;
/** 拒绝订单的弹框 */
@property(nonatomic, weak) WL_Application_Driver_RefuseOrder_AlertView *refuseOrderAlert;
/** 抢单的弹框 */
@property(nonatomic, weak) WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView;
/** 催款的弹框 */
@property(nonatomic, weak) WL_Application_Driver_Order_AcceptOrder_AlertView *reminderAlertView;
/** 无网络的View */
@property(nonatomic, strong)WL_NoData_View *noDataView;
/** 请求到的待接单数组 */
@property(nonatomic, strong) NSMutableArray *waitOrders;
/** 请求到的待接单总数组 */
@property(nonatomic, strong) NSMutableArray *totalWaitOrders;
/** 请求到的已接单数组 */
@property(nonatomic, strong) NSMutableArray *acceptOrders;
/** 请求道的已接单总数组 */
@property(nonatomic, strong) NSMutableArray *totalAcceptOrders;
/** 请求到的失效订单数组 */
@property(nonatomic, strong) NSMutableArray *failureOrders;
/** 请求道的失效订单总数组 */
@property(nonatomic, strong) NSMutableArray *totalFailureOrders;
/** 拒绝订单原因数组 */
@property(nonatomic, strong) NSArray *refuseReasons;
/** 拒绝原因参数数组 */
@property(nonatomic, strong) NSMutableArray *refuseReasonArr;
/** 取消订单原因数组 */
@property(nonatomic, strong) NSArray *cancleReasons;
/** 取消订单参数数组 */
@property(nonatomic, strong) NSMutableArray *cancleReasonArr;
/** 待接单列表页码 */
@property(nonatomic, assign) NSInteger waitOrderPage;
/** 待接单列表总页码 */
@property(nonatomic, assign) NSInteger totalPageNumToWaitOrder;
/** 已接单列表页码 */
@property(nonatomic, assign) NSInteger acceptOrderPage;
/** 已接单列表总页码 */
@property(nonatomic, assign) NSInteger totalPageNumToAcceptOrder;
/** 失效订单列表页码 */
@property(nonatomic, assign) NSInteger failureOrderPage;
/** 失效订单列表总页码 */
@property(nonatomic, assign) NSInteger totalPageNumToFailureOrder;
/**< 头部切换订单类型的view */
@property (nonatomic, weak) UIView *topView;
/**< 头部切换订单类型的Segmented*/
@property (nonatomic, weak) UISegmentedControl *orderSegmented;
@end

@implementation WL_Application_Driver_OrderList_ViewController1
/**< 头部切换订单状态View的高度 */
#define topSelectedViewHeight 60
//待接单cell的标识符
static NSString *const waitOrderCellId = @"waitOrderCell";
//已接单cell的标识符
static NSString *const acceptOrderCellId = @"acceptOrderCell";
//已失效cell的标识符
static NSString *const failureOrderCellId = @"failureOrderCell";
//拒绝原因cell的标识符
static NSString *const refuseOrderCellId = @"refuseOrderCell";

#pragma mark - Lazy

- (NSMutableArray *)waitOrders
{
    if (!_waitOrders)
    {
        _waitOrders = [NSMutableArray array];
    }
    return _waitOrders;
}
- (NSMutableArray *)totalWaitOrders
{
    if (!_totalWaitOrders)
    {
        _totalWaitOrders = [NSMutableArray array];
    }
    return _totalWaitOrders;
}
- (NSMutableArray *)cancleReasonArr
{
    if (!_cancleReasonArr) {
        _cancleReasonArr = [NSMutableArray array];
    }
    return _cancleReasonArr;
}
- (NSMutableArray *)acceptOrders
{
    if (!_acceptOrders)
    {
        _acceptOrders = [NSMutableArray array];
    }
    return _acceptOrders;
}
- (NSMutableArray *)totalAcceptOrders
{
    if (!_totalAcceptOrders)
    {
        _totalAcceptOrders = [NSMutableArray array];
    }
    return _totalAcceptOrders;
}

- (NSMutableArray *)failureOrders
{
    if (!_failureOrders)
    {
        _failureOrders = [NSMutableArray array];
    }
    return _failureOrders;
}
- (NSMutableArray *)totalFailureOrders
{
    if (!_totalFailureOrders)
    {
        _totalFailureOrders = [NSMutableArray array];
    }
    return _totalFailureOrders;
}
- (NSMutableArray *)refuseReasonArr
{
    if (!_refuseReasonArr) {
        _refuseReasonArr = [NSMutableArray array];
    }
    return _refuseReasonArr;
}
- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        CGRect noDataViewFrame = CGRectMake(self.view.x, self.view.y + ScaleH(topSelectedViewHeight), self.view.width, self.view.height - ScaleH(topSelectedViewHeight));
        _noDataView = [[WL_NoData_View alloc] initWithFrame:noDataViewFrame andRefreshBlock:^{
            if (self.navTitleView.waitButton.enabled == NO) {
                [weakSelf sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:1];
            }
            else if (self.navTitleView.orderButton.enabled == NO)
            {
                [weakSelf sendRequestToOrderListWithOrderStatus:WL_AcceptOrderStatus page:1];
            }
            else if (self.navTitleView.failureButton.enabled == NO)
            {
               [weakSelf sendRequestToOrderListWithOrderStatus:WL_FailureOrderStatus page:1];
            }
            else
            {
               [weakSelf sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:1];
            }
            
        }];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}

#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.waitOrderListTableView.hidden == NO)
    {
        //初始化页码
        self.waitOrderPage = 1;
        //初始化当前页
        self.totalPageNumToWaitOrder = 1;
        //发送网络请求
        [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:1];
    }
    else if (self.acceptOrderListTableView.hidden == NO)
    {
        //初始化页码
        self.acceptOrderPage = 1;
        //初始化当前页
        self.totalPageNumToAcceptOrder = 1;
        
        [self sendRequestToOrderListWithOrderStatus:WL_AcceptOrderStatus page:1];
    }
    else if (self.failureOrderListTableView.hidden == NO)
    {
        //初始化页码
        self.failureOrderPage = 1;
        //初始化当前页
        self.totalPageNumToFailureOrder = 1;
        
        //发送网络请求
        [self sendRequestToOrderListWithOrderStatus:WL_FailureOrderStatus page:1];
    }
    else
    {
        //初始化页码
        self.waitOrderPage = 1;
        //初始化当前页
        self.totalPageNumToWaitOrder = 1;
        //发送网络请求
        [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:1];
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //0.初始化参数
    [self initParam];

    //1.设置Nav的内容
    [self setupContentViewToNav];
    
    //2.绘制订单控制器的UI界面
    [self setupContentViewToOrderList];
    //3.发送订单列表的网络请求
    [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:1];
    //4.注册网络请求时的弹框
    //注册弹框
    [self creatTipAlertView];
    //无网络View
    [self.view addSubview:self.noDataView];
    //注册下拉刷新
    WS(weakSelf);
    //待接单列表-下拉刷新
    // 下拉刷新
    
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //初始化页码
        weakSelf.waitOrderPage = 1;
        //初始化当前页
        weakSelf.totalPageNumToWaitOrder = 1;
        
        
        //发送网络请求
        [weakSelf sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:weakSelf.waitOrderPage];
    }];
    self.waitOrderListTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    
    //已接单列表-下拉刷新
    
    MJRefreshNormalHeader *headerToAccept = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //初始化页码
        weakSelf.acceptOrderPage = 1;
        //初始化当前页
        weakSelf.totalPageNumToAcceptOrder = 1;
        
        [weakSelf sendRequestToOrderListWithOrderStatus:WL_AcceptOrderStatus page:weakSelf.acceptOrderPage];

    }];
    self.acceptOrderListTableView.mj_header = headerToAccept;
    headerToAccept.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [headerToAccept setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [headerToAccept setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [headerToAccept setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    //失效订单列表-下拉刷新
    
     MJRefreshNormalHeader *headerToFailure = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //初始化页码
        weakSelf.failureOrderPage = 1;
        //初始化当前页
        weakSelf.totalPageNumToFailureOrder = 1;
        
        //发送网络请求
        [weakSelf sendRequestToOrderListWithOrderStatus:WL_FailureOrderStatus page:weakSelf.failureOrderPage];
    }];
    self.failureOrderListTableView.mj_header = headerToFailure;
    headerToFailure.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [headerToFailure setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [headerToFailure setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [headerToFailure setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    //待接单列表-上拉刷新
    self.waitOrderListTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (weakSelf.waitOrderPage != weakSelf.totalPageNumToWaitOrder)
        {
            [weakSelf loadMoreDataToWaitOrderList];
        }
        weakSelf.waitOrderPage = weakSelf.waitOrderPage + 1;
    }];
    //已接单列表-上拉刷新
    self.acceptOrderListTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (weakSelf.acceptOrderPage != weakSelf.totalPageNumToAcceptOrder)
        {
            [weakSelf loadMoreDataToAcceptOrderList];
        }
        weakSelf.acceptOrderPage = weakSelf.acceptOrderPage + 1;
    }];
    //失效订单列表-上拉刷新
    self.failureOrderListTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (weakSelf.failureOrderPage != weakSelf.totalPageNumToFailureOrder)
        {
            [weakSelf loadMoreDataToFailureOrderList];
        }
        weakSelf.failureOrderPage = weakSelf.failureOrderPage + 1;
    }];

}

#pragma mark - 待接单列表管理-上拉刷新->加载更多
- (void)loadMoreDataToWaitOrderList
{
        [self showHud];
        [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:self.waitOrderPage];
        [self hidHud];

}
#pragma mark - 已接单列表管理-上拉刷新->加载更多
- (void)loadMoreDataToAcceptOrderList
{
        [self showHud];
        [self sendRequestToOrderListWithOrderStatus:WL_AcceptOrderStatus page:self.acceptOrderPage];
        [self hidHud];

}
#pragma mark - 失效订单列表管理-上拉刷新->加载更多
- (void)loadMoreDataToFailureOrderList
{
        [self showHud];
        [self sendRequestToOrderListWithOrderStatus:WL_FailureOrderStatus page:self.failureOrderPage];
        [self hidHud];

}


#pragma mark - 初始化参数
- (void)initParam
{
    //初始化待接单列表页码与总页码
    self.waitOrderPage = 1;
    self.totalPageNumToWaitOrder = 1;
    //初始化已接单列表页码与总页码
    self.acceptOrderPage = 1;
    self.totalPageNumToAcceptOrder = 1;
    //初始化失效订单列表页码与总页码
    self.failureOrderPage = 1;
    self.totalPageNumToFailureOrder = 1;
    
    self.refuseReasons = @[@"价格太低", @"订单信息不全", @"车辆暂时无法正常行驶", @"其他"];
    self.cancleReasons = @[@"接单时看错信息", @"订单信息不全", @"车辆暂时无法正常行驶", @"个人身体不适,需要休息", @"其他原因"];
}

#pragma mark - 设置Nav的内容
- (void)setupContentViewToNav
{
    self.title = @"接单";
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, topSelectedViewHeight)];
    topView.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];
    //设置中间选择器
    UISegmentedControl *orderSegmented = [[UISegmentedControl alloc]initWithItems:@[ @"待接单",@"已接单",@"已失效"]];
    [topView addSubview:orderSegmented];
    
    
//    WL_Application_Driver_Order_NavTitle_View *navTitleView = [[WL_Application_Driver_Order_NavTitle_View alloc] initWithFrame:CGRectMake(0, 0, 220, 45)];
//    self.navigationItem.titleView = navTitleView;
//    self.navTitleView = navTitleView;
//    [navTitleView.waitButton addTarget:self action:@selector(waitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [navTitleView.orderButton addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [navTitleView.failureButton addTarget:self action:@selector(failureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.navTitleView.hidden = YES;
}
#pragma mark - Nav的头部View中按钮的点击方法
/** 等待接单按钮点击方法 */
- (void)waitButtonClick:(UIButton *)button
{
    [self buttonClick:button];
    //发送请求
    self.waitOrderPage = 1;
    [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:self.waitOrderPage];
    [self setNavigationRightImg:@"Driver_Order_My Travel"];
}
/** 已接单的按钮点击方法 */
- (void)orderButtonClick:(UIButton *)button
{
    [self buttonClick:button];
    //发送请求
    self.acceptOrderPage = 1;
    [self sendRequestToOrderListWithOrderStatus:WL_AcceptOrderStatus page:self.acceptOrderPage];
    [self setNavigationRightImg:@"Driver_Order_My Travel"];

}
/** 已失效的按钮的点击方法 */
- (void)failureButtonClick:(UIButton *)button
{
    [self buttonClick:button];
    self.failureOrderPage = 1;
    //发送请求
    [self sendRequestToOrderListWithOrderStatus:WL_FailureOrderStatus page:self.failureOrderPage];
    [self setNavigationRightImg:@"Cliear_FailureOrder"];
}
/** 按钮点击动画 */
- (void)buttonClick:(UIButton *)button
{
    // 修改按钮状态
    self.navTitleView.selectedButton.enabled = YES;
    button.enabled = NO;
    self.navTitleView.selectedButton = button;
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.navTitleView.indicatorView.width = button.titleLabel.width;
        self.navTitleView.indicatorView.centerX = button.centerX;
    }];
}

#pragma mark - 设置页面内容
- (void)setupContentViewToOrderList
{
    //1.设置背景颜色
    self.view.backgroundColor = BgViewColor;
    //设置Nav图片
    [self setNavigationRightImg:@"Driver_Order_My Travel"];
    
    //2.创建待接单页面内容
    [self setupContentViewToWaitOrderList];
    //3.创建已接单页面内容
    [self setupContentViewToAcceptOrderList];
    //4.创建失效订单页面内容
    [self setupContentViewToFailureOrderList];
}
//创建待接单界面
- (void)setupContentViewToWaitOrderList
{

    //创建待接单页面内容
    //1.创建页面头部提示信息View
    //添加待接单界面的头部View
    WL_Application_Driver_Bill_Top_View *promptViewToWaitOrder = [[WL_Application_Driver_Bill_Top_View alloc] init];
    //添加到父控件
    [self.view addSubview:promptViewToWaitOrder];
    //添加约束
    [promptViewToWaitOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
    }];
    //赋值给全局控件
    self.promptViewToWaitOrder = promptViewToWaitOrder;
    //关闭按钮点击方法
    [promptViewToWaitOrder.closeButton addTarget:self action:@selector(closePromptViewToWaitOrder) forControlEvents:UIControlEventTouchUpInside];
    promptViewToWaitOrder.hidden = YES;
    
    //2.创建待接单TableView
    UITableView *waitOrderListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //添加到父控件
    [self.view addSubview:waitOrderListTableView];
    //添加约束
    [waitOrderListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //设置代理与数据源为控制器
    waitOrderListTableView.delegate = self;
    waitOrderListTableView.dataSource = self;
    waitOrderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    waitOrderListTableView.showsVerticalScrollIndicator = NO;
    waitOrderListTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    //注册cell
    [waitOrderListTableView registerClass:[WL_Application_Driver_Order_WaitOrder_Cell class] forCellReuseIdentifier:waitOrderCellId];
    waitOrderListTableView.hidden = YES;
    self.waitOrderListTableView = waitOrderListTableView;
}
//关闭待接单界面的弹框方法
- (void)closePromptViewToWaitOrder
{
    self.promptViewToWaitOrder.hidden = YES;
    [self.waitOrderListTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
    }];
}

// 创建已接单界面
- (void)setupContentViewToAcceptOrderList
{
    //创建已接单界面内容
    //添加已接单界面的头部View
    WL_Application_Driver_Bill_Top_View *promptViewToAcceptOrder = [[WL_Application_Driver_Bill_Top_View alloc] init];
    //添加到父控件
    [self.view addSubview:promptViewToAcceptOrder];
    //添加约束
    [promptViewToAcceptOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
    }];
    //赋值给全局控件
    self.promptViewToAcceptOrder = promptViewToAcceptOrder;
    //关闭按钮点击方法
    [promptViewToAcceptOrder.closeButton addTarget:self action:@selector(closePromptViewToAcceptOrder) forControlEvents:UIControlEventTouchUpInside];
    promptViewToAcceptOrder.hidden = YES;
    
    
    //2.创建已接单TableView
    UITableView *acceptOrderListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //添加到父控件
    [self.view addSubview:acceptOrderListTableView];
    //添加约束
    [acceptOrderListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //设置代理与数据源为控制器
    acceptOrderListTableView.delegate = self;
    acceptOrderListTableView.dataSource = self;
    acceptOrderListTableView.showsVerticalScrollIndicator = NO;
    acceptOrderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    acceptOrderListTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    //注册cell
    [acceptOrderListTableView registerClass:[WL_Application_Driver_Order_AcceptOrder_Cell class] forCellReuseIdentifier:acceptOrderCellId];
    acceptOrderListTableView.hidden = YES;
    //赋值给全局变量
    self.acceptOrderListTableView = acceptOrderListTableView;
}
//关闭已接单界面的弹框方法
- (void)closePromptViewToAcceptOrder
{
    self.promptViewToAcceptOrder.hidden = YES;
    [self.acceptOrderListTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
    }];

}


//创建失效订单界面内容
- (void)setupContentViewToFailureOrderList
{
    //创建失效订单界面内容
    //添加失效订单界面的头部View
    WL_Application_Driver_Bill_Top_View *promptViewToFailureOrder = [[WL_Application_Driver_Bill_Top_View alloc] init];
    //添加到父控件
    [self.view addSubview:promptViewToFailureOrder];
    //添加约束
    [promptViewToFailureOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
    }];
    //赋值给全局控件
    self.promptViewToFailureOrder = promptViewToFailureOrder;
    //关闭按钮点击方法
    [promptViewToFailureOrder.closeButton addTarget:self action:@selector(closePromptViewToFailureOrder) forControlEvents:UIControlEventTouchUpInside];
    promptViewToFailureOrder.hidden = YES;
    
    //2.创建已失效接单TableView
    UITableView *failureOrderListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //添加到父控件
    [self.view addSubview:failureOrderListTableView];
    //添加约束
    [failureOrderListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //设置代理与数据源为控制器
    failureOrderListTableView.delegate = self;
    failureOrderListTableView.dataSource = self;
    failureOrderListTableView.showsVerticalScrollIndicator = NO;
    failureOrderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    failureOrderListTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    
    //注册cell
    [failureOrderListTableView registerClass:[WL_Application_Driver_Order_FailureOrder_Cell class] forCellReuseIdentifier:failureOrderCellId];
    failureOrderListTableView.hidden = YES;
    //赋值给全局变量
    self.failureOrderListTableView = failureOrderListTableView;
}
// 关闭已失效订单界面的弹框方法
- (void)closePromptViewToFailureOrder
{
    self.promptViewToFailureOrder.hidden = YES;
    [self.failureOrderListTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
    }];
    
}


#pragma mark - UITableViewDataSource
//返回cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.waitOrderListTableView)
    {
        return self.totalWaitOrders.count;
    }
    else if (tableView == self.acceptOrderListTableView)
    {
        return self.totalAcceptOrders.count;
    }
    else if (tableView == self.failureOrderListTableView)
    {
        return self.totalFailureOrders.count;
    }
    else if (tableView == self.refuseReasonTableView)
    {
        return 4;
    }
    return 0;

}

//cell的创建方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.waitOrderListTableView)
    {
        WL_Application_Driver_Order_WaitOrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:waitOrderCellId];
        cell.driverOrderModel = self.totalWaitOrders[indexPath.row];
        cell.sj_order_id = cell.driverOrderModel.sj_order_id;
        //点击cell的拒单按钮
        [cell.refuseButton addTarget:self action:@selector(refuseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //点击cell的抢单按钮
        [cell.rushOrderButton addTarget:self action:@selector(rushOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (tableView == self.acceptOrderListTableView)
    {
        WL_Application_Driver_Order_AcceptOrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:acceptOrderCellId];
        cell.driverOrderModel = self.totalAcceptOrders[indexPath.row];
        cell.sj_order_id = cell.driverOrderModel.sj_order_id;
            //取消订单方法
            [cell.cancleOrderButton addTarget:self action:@selector(cancleOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];



        return cell;
    }
    else if (tableView == self.failureOrderListTableView)
    {
        WL_Application_Driver_Order_FailureOrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:failureOrderCellId];
        cell.driverOrderModel = self.totalFailureOrders[indexPath.row];
        
        return cell;
    }
    else
    {
        WL_Application_Driver_Order_RefuseOrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:refuseOrderCellId];
        if (indexPath.row == 3)
        {
            cell.reasonTextView.hidden = NO;
            cell.reasonTextView.delegate = self;
            self.placeholderLabel = cell.placeholderLabel;
        }

        if (self.waitOrderListTableView.hidden == NO)
        {
            cell.reasonLable.text = self.refuseReasons[indexPath.row];
        }
        else
        {
             cell.reasonLable.text = self.cancleReasons[indexPath.row];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
}
#pragma mark - 待接单列表cell上的按钮点击方法
//拒单按钮点击方法
- (void)refuseButtonClick:(UIButton *)button
{
    //拒绝原因数组
    [self.refuseReasonArr removeAllObjects];
    //取出button所在的cell
    WL_Application_Driver_Order_WaitOrder_Cell *cell;
    if (SystemVersion < 8.0)
    {
        cell = (WL_Application_Driver_Order_WaitOrder_Cell *)button.superview.superview.superview;
    }
    else
    {
        cell = (WL_Application_Driver_Order_WaitOrder_Cell *)button.superview.superview;
    }
    
    //弹出拒绝订单的弹框
    WL_Application_Driver_RefuseOrder_AlertView *refuseOrderAlert = [[WL_Application_Driver_RefuseOrder_AlertView alloc] init];
    self.refuseOrderAlert = refuseOrderAlert;
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    [myWindow addSubview:refuseOrderAlert];
    //添加背景颜色
    refuseOrderAlert.backgroundColor = WLColor(0, 0, 0, 0.5);
    //添加约束
    [refuseOrderAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWindow.mas_left);
        make.right.equalTo(myWindow.mas_right);
        make.top.equalTo(myWindow.mas_top);
        make.bottom.equalTo(myWindow.mas_bottom);
    }];
    
    refuseOrderAlert.refuseReasonTableView.delegate = self;
    refuseOrderAlert.refuseReasonTableView.dataSource = self;
    //注册cell
    [refuseOrderAlert.refuseReasonTableView registerClass:[WL_Application_Driver_Order_RefuseOrder_Cell class] forCellReuseIdentifier:refuseOrderCellId];
    self.refuseReasonTableView = refuseOrderAlert.refuseReasonTableView;
    refuseOrderAlert.refuseButton.tag = [cell.sj_order_id integerValue];
    //点击弹框的取消按钮
    [refuseOrderAlert.cancleButton addTarget:self action:@selector(refuseOrderAlertHidden) forControlEvents:UIControlEventTouchUpInside];
    //点击确认拒绝按钮的方法
    [refuseOrderAlert.refuseButton addTarget:self action:@selector(confirmRefuseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    

}

//隐藏拒单弹框的点击方法
- (void)refuseOrderAlertHidden
{
    [self.refuseOrderAlert removeFromSuperview];
}
//确认拒绝按钮的点击方法
- (void)confirmRefuseButtonClick:(UIButton *)button
{
    NSMutableArray *refuseReasonsArr = [self.refuseReasonArr mutableCopy];
    for (NSString *reasons in refuseReasonsArr)
    {
        if ([reasons isEqualToString:@"其他"])
        {
            [self.refuseReasonArr removeObject:reasons];
            NSString *otherReason = [NSString stringWithFormat:@"%@:%@",reasons, self.reasonTextView.text];
            [self.refuseReasonArr addObject:otherReason];
        }
    }
    
    if (self.refuseReasonArr.count == 0)
    {
        [self.alert createTip:@"请选择拒绝理由"];
        return;
    }
    //发送拒绝请求
    //1.发送更新订单状态的网络请求请求数据
    NSString *urlStr = DriverOrderUpdateOrderUrl;
    //请求参数
    //司机id
    NSString *driver_id = [WLUserTools getUserId];
    //用户密码
    
    NSString *user_password = [WLUserTools getUserPassword];;
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];
    //订单状态
    NSString *status = @"2";
    //订单类型
    NSString *order_status_type = @"1";
    NSData *remark = [self.refuseReasonArr mj_JSONData];
    
    //参数集合
    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"order_status_type" : order_status_type,
                             @"status" : status,
                             @"sj_order_id" : [NSString stringWithFormat:@"%zd", button.tag],
                             @"remark" : remark
                             };
    //显示菊花
    [self showHud];
    //发送请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        //1.将返回的json转换为基础模型
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.status isEqualToString:@"1"])
        {
            //隐藏弹框
            [self refuseOrderAlertHidden];
            //弹框提示信息
            [self.alert createTip:baseModel.msg];
            //隐藏菊花
            [self hidHud];
            return;
        }
        //隐藏菊花
        [self hidHud];
        //弹框提示
        [self.alert createTip:@"拒绝成功"];
        [self refuseOrderAlertHidden];
        
        //初始化页码
        self.waitOrderPage = 1;
        //初始化当前页
        self.totalPageNumToWaitOrder = 1;
        //发送网络请求
        [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:self.waitOrderPage];

    } Failure:^(NSError *error) {
        //弹框提示错误信息
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
        //隐藏菊花
        [self hidHud];
    }];

}

//抢单按钮点击方法
- (void)rushOrderButtonClick:(UIButton *)button
{
    //取出button所在的cell
     WL_Application_Driver_Order_WaitOrder_Cell *cell;
    if (SystemVersion < 8.0)
    {
        cell = (WL_Application_Driver_Order_WaitOrder_Cell *)button.superview.superview.superview;
    }
    else
    {
        cell = (WL_Application_Driver_Order_WaitOrder_Cell *)button.superview.superview;
    }
    //抢单按钮点击
    WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView = [[WL_Application_Driver_Order_Rush_AlertView alloc] init];
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    [myWindow addSubview:rushOrderAlertView];
    rushOrderAlertView.backgroundColor = WLColor(0, 0, 0, 0.5);
    [rushOrderAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWindow.mas_left);
        make.right.equalTo(myWindow.mas_right);
        make.top.equalTo(myWindow.mas_top);
        make.bottom.equalTo(myWindow.mas_bottom);
    }];
    NSString *departureTimeToMon = [cell.driverOrderModel.start_time substringWithRange:NSMakeRange(5, 2)];
    NSString *departureTimeToDay = [cell.driverOrderModel.start_time substringWithRange:NSMakeRange(8, 2)];
    //出发时间字符串
    NSString *timeStr = [NSString stringWithFormat:@"%@月%@日", departureTimeToMon, departureTimeToDay];
    
    rushOrderAlertView.promptMessageLable.text = [NSString stringWithFormat:@"该订单需要在“%@－%@” 出发，是否确认接单", timeStr, cell.driverOrderModel.start_city];
    
    [rushOrderAlertView.cancleButton addTarget:self action:@selector(cancleRushOrderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rushOrderAlertView.rushButton addTarget:self action:@selector(confirmRushOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rushOrderAlertView = rushOrderAlertView;
    rushOrderAlertView.rushButton.tag = [cell.sj_order_id integerValue];
}
//取消抢单的按钮点击方法
- (void)cancleRushOrderButtonClick
{
    [self.rushOrderAlertView removeFromSuperview];
}
//确定抢单的按钮点击方法
- (void)confirmRushOrderButtonClick:(UIButton *)button
{
    //发送接单请求
    //发送更新订单状态的网络请求 请求数据
    NSString *urlStr = DriverOrderUpdateOrderUrl;
    //请求参数
    //司机id
    NSString *driver_id = [WLUserTools getUserId];
    //用户密码
    NSString *user_password =[WLUserTools getUserPassword];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];
    //订单id
    NSString *sj_order_id = [NSString stringWithFormat:@"%zd", button.tag];
    //订单状态
    NSString *status = @"5";
    //参数集合
    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"order_status_type" : @"1",
                             @"status" : status,
                             @"sj_order_id" : sj_order_id
                             };
    
    //显示菊花
    [self showHud];
    //发送网络请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![model.status isEqualToString:@"1"])
        {
            //弹框返回信息
            [self.alert createTip:model.msg];
            //隐藏接单弹框
            [self cancleRushOrderButtonClick];
            //初始化页码
            self.waitOrderPage = 1;
            //初始化当前页
            self.totalPageNumToWaitOrder = 1;
            //发送网络请求
            [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:self.waitOrderPage];
            //隐藏菊花
            [self hidHud];
            return;
        }

        //隐藏菊花
        [self hidHud];
        //隐藏接单弹框
        [self cancleRushOrderButtonClick];
        //抢单成功提示
        [self.alert createTip:@"抢单成功"];
        //初始化页码
        self.waitOrderPage = 1;
        //初始化当前页
        self.totalPageNumToWaitOrder = 1;
        //发送网络请求
        [self sendRequestToOrderListWithOrderStatus:WL_WaitOrderStatus page:self.waitOrderPage];
        
    } Failure:^(NSError *error) {
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
        //隐藏菊花
        [self hidHud];
    }];

}

#pragma mark - 已接单列表cell上的按钮点击方法

//取消订单方法
- (void)cancleOrderButtonClick:(UIButton *)button
{
    //创建弹框
    //拒绝原因数组
    [self.cancleReasonArr removeAllObjects];
    //取出button所在的cell
    WL_Application_Driver_Order_AcceptOrder_Cell *cell;
    if (SystemVersion < 8.0)
    {
        cell = (WL_Application_Driver_Order_AcceptOrder_Cell *)button.superview.superview.superview;
    }
    else
    {
        cell = (WL_Application_Driver_Order_AcceptOrder_Cell *)button.superview.superview;
    }
    NSInteger buttonTag = [cell.sj_order_id integerValue];
    
    //弹出拒绝订单的弹框
    WL_Application_Driver_RefuseOrder_AlertView *refuseOrderAlert = [[WL_Application_Driver_RefuseOrder_AlertView alloc] init];
    self.refuseOrderAlert = refuseOrderAlert;
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    [myWindow addSubview:refuseOrderAlert];
    //添加背景颜色
    refuseOrderAlert.backgroundColor = WLColor(0, 0, 0, 0.5);
    
    //添加约束
    [refuseOrderAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWindow.mas_left);
        make.right.equalTo(myWindow.mas_right);
        make.top.equalTo(myWindow.mas_top);
        make.bottom.equalTo(myWindow.mas_bottom);
    }];
    
    refuseOrderAlert.refuseButton.tag = buttonTag;
    
    refuseOrderAlert.refuseReasonTableView.delegate = self;
    refuseOrderAlert.refuseReasonTableView.dataSource = self;
    //注册cell
    [refuseOrderAlert.refuseReasonTableView registerClass:[WL_Application_Driver_Order_RefuseOrder_Cell class] forCellReuseIdentifier:refuseOrderCellId];
    self.refuseReasonTableView = refuseOrderAlert.refuseReasonTableView;
   
    //点击弹框的取消按钮
    [refuseOrderAlert.cancleButton addTarget:self action:@selector(refuseOrderAlertHidden) forControlEvents:UIControlEventTouchUpInside];
    //点击确认拒绝按钮的方法
    [refuseOrderAlert.refuseButton setTitle:@"确认取消" forState:UIControlStateNormal];
    [refuseOrderAlert.refuseButton addTarget:self action:@selector(confirmCancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

//确认拒绝按钮的点击方法
- (void)confirmCancleButtonClick:(UIButton *)button
{
    NSMutableArray *cancleReasonsArr = self.cancleReasonArr;
    for (NSString *reasons in cancleReasonsArr)
    {
        if ([reasons isEqualToString:@"其他"])
        {
            [self.cancleReasonArr removeObject:reasons];
            NSString *otherReason = [NSString stringWithFormat:@"%@:%@",reasons, self.reasonTextView.text];
            [self.cancleReasonArr addObject:otherReason];
        }
    }
    
    if (self.cancleReasonArr.count == 0)
    {
        [self.alert createTip:@"请选择拒绝理由"];
        return;
    }
    //发送拒绝请求
    //1.发送更新订单状态的网络请求请求数据
    NSString *urlStr = DriverOrderUpdateOrderUrl;
    //请求参数
    //司机id
    NSString *driver_id = [WLUserTools getUserId];
    //用户密码
    NSString *user_password = [WLUserTools getUserPassword];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];
    //订单状态
    NSString *status = @"2";
    //订单类型
    NSString *order_status_type = @"1";
    NSData *remark = [self.cancleReasonArr mj_JSONData];
    //参数集合
    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"order_status_type" : order_status_type,
                             @"status" : status,
                             @"sj_order_id" : [NSString stringWithFormat:@"%zd", button.tag],
                             @"remark" : remark
                             };
    //显示菊花
    [self showHud];
    //发送请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        //1.将返回的json转换为基础模型
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.status isEqualToString:@"1"])
        {
            //隐藏弹框
            [self refuseOrderAlertHidden];
            //弹框提示信息
            [self.alert createTip:baseModel.msg];
            //初始化页码
            self.acceptOrderPage = 1;
            //初始化当前页
            self.totalPageNumToAcceptOrder = 1;
            //发送网络请求
            [self sendRequestToOrderListWithOrderStatus:WL_AcceptOrderStatus page:self.acceptOrderPage];
            //隐藏菊花
            [self hidHud];
            return;
        }
        //隐藏菊花
        [self hidHud];
        //弹框提示
        [self.alert createTip:@"拒单成功"];
        [self refuseOrderAlertHidden];
        //初始化页码
        self.acceptOrderPage = 1;
        //初始化当前页
        self.totalPageNumToAcceptOrder = 1;
        //发送网络请求
        [self sendRequestToOrderListWithOrderStatus:WL_AcceptOrderStatus page:self.acceptOrderPage];
//        [self.acceptOrderListTableView.mj_header beginRefreshing];
        
    } Failure:^(NSError *error) {
        [self refuseOrderAlertHidden];
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
        //隐藏菊花
        [self hidHud];
        
    }];
    
}


//打电话联系方法
- (void)telPhoneToCompany:(UIButton *)button
{
    [self hiddenTourOperatorAlertView];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%zd",button.tag]];
    
    [[UIApplication sharedApplication]openURL:phoneURL];
}
#pragma mark - 隐藏弹框方法
- (void)hiddenTourOperatorAlertView
{
    [self.reminderAlertView removeFromSuperview];
}

#pragma mark - UITableViewDelegate
//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.waitOrderListTableView)
    {
        return 235.0f;
    }
    else if (tableView == self.acceptOrderListTableView)
    {

        WL_Application_Driver_Order_Model *driverOrderModel =  self.totalAcceptOrders[indexPath.row];
        return driverOrderModel.cellHeight;
    }
    else if (tableView == self.failureOrderListTableView)
    {
        return 195.0f;
    }
    else if (tableView == self.refuseReasonTableView)
    {
        if (indexPath.row == 3)
        {
            return 100;
        }
        else
        {
            return 43;
        }
    }
    return 0;
}

//为防止重复调用返回cell高度方法,需要先预估下cell的高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}

//因为创建的为分组模式的TableView,所以需要将TableView的头试图和尾视图高度设置为0
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

//tableView的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.waitOrderListTableView)
    {
        WL_Application_Driver_Order_WaitOrder_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //跳转待接单控制器界面
        WL_Application_Driver_Order_WaitOrderDetail_ViewController *waitOrderDetailVc = [[WL_Application_Driver_Order_WaitOrderDetail_ViewController alloc] init];
        waitOrderDetailVc.sj_order_id = cell.driverOrderModel.sj_order_id;
        [self.navigationController pushViewController:waitOrderDetailVc animated:YES];
    }
    else if (tableView == self.acceptOrderListTableView)
    {
        WL_Application_Driver_Order_AcceptOrder_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //跳转已接单控制器
        WL_Application_Driver_Order_AcceptOrderDetail_ViewController *acceptOrderDetailVc = [[WL_Application_Driver_Order_AcceptOrderDetail_ViewController alloc] init];
        acceptOrderDetailVc.sj_order_id = cell.driverOrderModel.sj_order_id;
        [self.navigationController pushViewController:acceptOrderDetailVc animated:YES];
    }
    else if (tableView == self.failureOrderListTableView)
    {
        WL_Application_Driver_Order_FailureOrder_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //跳转失效订单控制器
        WL_Application_Driver_Order_FailureOrderDetail_ViewController *failureOrderDetailVc = [[WL_Application_Driver_Order_FailureOrderDetail_ViewController alloc] init];
        failureOrderDetailVc.sj_order_id = cell.driverOrderModel.sj_order_id;
        [self.navigationController pushViewController:failureOrderDetailVc animated:YES];
    }
    else if (tableView == self.refuseReasonTableView)
    {
        WL_Application_Driver_Order_RefuseOrder_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectedButton.userInteractionEnabled = NO;
        cell.selectedButton.selected = !cell.selectedButton.selected;
        self.reasonTextView = cell.reasonTextView;
        if (self.acceptOrderListTableView.hidden == NO)
        {
            if (cell.selectedButton.selected)
            {
                [self.cancleReasonArr addObject:cell.reasonLable.text];
            }
            else
            {
               [self.cancleReasonArr removeObject:cell.reasonLable.text];
            }
        }
        else
        {
            if (cell.selectedButton.selected)
            {
                [self.refuseReasonArr addObject:cell.reasonLable.text];
            }
            else
            {
                 [self.refuseReasonArr removeObject:cell.reasonLable.text];
            }

        }

    }
}

#pragma mark - 发送订单列表的网络请求
- (void)sendRequestToOrderListWithOrderStatus:(WLOrderStatus)orderStatus page:(NSInteger)page
{
    //1.请求参数
    //用户密码
    NSString *user_password = [WLUserTools getUserPassword];
    NSString *driver_id = [WLUserTools getUserId];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];

    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"order_status" : @(orderStatus),
                             @"page" : @(page)
                             };
    //2.显示菊花
    [self showHud];
    //3.发送请求
    [[WLHttpManager shareManager] requestWithURL:DriverOrderListUrl RequestType:RequestTypePost Parameters:params Success:^(id responseObject)
    {
        self.waitOrderListTableView.hidden = YES;
        self.promptViewToWaitOrder.hidden = YES;
        self.acceptOrderListTableView.hidden = YES;
        self.promptViewToAcceptOrder.hidden = YES;
        self.failureOrderListTableView.hidden = YES;
        self.promptViewToFailureOrder.hidden = YES;
        
        if (self.waitOrderPage == 1)
        {
            [self.totalWaitOrders removeAllObjects];
        }
        if (self.acceptOrderPage == 1) {
            [self.totalAcceptOrders removeAllObjects];
        }
        if (self.failureOrderPage == 1)
        {
            [self.totalFailureOrders removeAllObjects];
        }
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        //返回失败信息
        if (![baseModel.status isEqualToString:@"1"])
        {
            [self.alert createTip:baseModel.msg];
            [self hidHud];
            return;
        }
        //请求成功
        //显示Nav的TitleView
        self.navTitleView.hidden = NO;
        //1.将订单列表数据转换为订单列表模型数据
        WL_Application_Driver_OrderList_Model *orderListModel = [WL_Application_Driver_OrderList_Model mj_objectWithKeyValues:baseModel.data];
        //如果返回的数据为空
        if (orderListModel.data.count == 0)
        {
            [self.alert createTip:@"暂无订单"];
            [self hideNoData:NO andType:WLNetworkTypeNOData];
            [self hidHud];
            return;
        }
        
        self.noDataView.hidden = YES;
        //返回的有列表数据
        //如果是待接订单状态
        if (orderStatus == WL_WaitOrderStatus)
        {
            self.totalPageNumToWaitOrder = [orderListModel.count_page integerValue];
            self.waitOrders = [WL_Application_Driver_Order_Model mj_objectArrayWithKeyValuesArray:orderListModel.data];
            for (WL_Application_Driver_Order_Model *model in self.waitOrders)
            {
                [self.totalWaitOrders addObject:model];
            }
            if (self.waitOrderPage == self.totalPageNumToWaitOrder || self.totalPageNumToWaitOrder == 0)
            {
                [self.waitOrderListTableView.mj_footer setHidden:YES];
            }
            else
            {
                [self.waitOrderListTableView.mj_footer setHidden:NO];
            }
            [self.waitOrderListTableView.mj_header endRefreshing];
            [self.waitOrderListTableView.mj_footer endRefreshing];
            
            
            //显示待接单列表
            self.waitOrderListTableView.hidden = NO;
            self.promptViewToWaitOrder.hidden = NO;
//            if ([orderListModel.tips isEqualToString:@""] || orderListModel.tips == nil)
//            {
//                self.promptViewToWaitOrder.promptLable.text = @"请先启用车辆后方可接单!";
//            }
//            else
//            {
//                self.promptViewToWaitOrder.promptLable.text = orderListModel.tips;
//                
//            }
//            [self heightToView:self.promptViewToWaitOrder withTableView:self.waitOrderListTableView];
        }
        //已接单状态
        else if (orderStatus == WL_AcceptOrderStatus)
        {
            self.totalPageNumToAcceptOrder = [orderListModel.count_page integerValue];
            self.acceptOrders = [WL_Application_Driver_Order_Model mj_objectArrayWithKeyValuesArray:orderListModel.data];
            for (WL_Application_Driver_Order_Model *model in self.acceptOrders)
            {
                [self.totalAcceptOrders addObject:model];
            }
            if (self.acceptOrderPage == self.totalPageNumToAcceptOrder || self.totalPageNumToAcceptOrder == 0)
            {
                [self.acceptOrderListTableView.mj_footer setHidden:YES];
            }
            else
            {
                [self.acceptOrderListTableView.mj_footer setHidden:NO];
            }
            [self.acceptOrderListTableView.mj_header endRefreshing];
            [self.acceptOrderListTableView.mj_footer endRefreshing];
            
            self.acceptOrderListTableView.hidden = NO;
            self.promptViewToAcceptOrder.hidden = NO;

            
//            self.promptViewToAcceptOrder.promptLable.text = orderListModel.tips;
//            [self heightToView:self.promptViewToAcceptOrder withTableView:self.acceptOrderListTableView];
        }
        //失效订单状态
        else if (orderStatus == WL_FailureOrderStatus)
        {
            self.totalPageNumToFailureOrder = [orderListModel.count_page integerValue];
            self.failureOrders = [WL_Application_Driver_Order_Model mj_objectArrayWithKeyValuesArray:orderListModel.data];
            for (WL_Application_Driver_Order_Model *model in self.failureOrders)
            {
                [self.totalFailureOrders addObject:model];
            }
            if (self.failureOrderPage == self.totalPageNumToFailureOrder || self.totalPageNumToFailureOrder == 1)
            {
                [self.failureOrderListTableView.mj_footer setHidden:YES];
            }
            else
            {
                [self.failureOrderListTableView.mj_footer setHidden:NO];
            }
            [self.failureOrderListTableView.mj_header endRefreshing];
            [self.failureOrderListTableView.mj_footer endRefreshing];
            
            self.failureOrderListTableView.hidden = NO;
            self.promptViewToFailureOrder.hidden = NO;
//            self.promptViewToFailureOrder.promptLable.text = @"提示: 订单失效率太高, 会导致拍单变少哦!";
            
//            [self heightToView:self.promptViewToFailureOrder withTableView:self.failureOrderListTableView];
        }
        [self hidHud];
    }
    Failure:^(NSError *error)
    {
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
        //隐藏菊花
        [self hidHud];
        
    }];
}

#pragma mark - 计算顶部标题的高度与相应的tableView的frame
//- (void)heightToView:(WL_Application_Driver_Bill_Top_View *)topView withTableView:(UITableView *)tableView
//{
//    CGFloat promptViewHeight = 0;
//    if (topView.promptLable.text == nil || [topView.promptLable.text isEqualToString:@""]) {
//        topView.promptLable.text = @"";
//    }
//        NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc]initWithString:topView.promptLable.text];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//        [paragraphStyle setLineSpacing:9.0];
//        [attrs addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [topView.promptLable.text length])];
//        topView.promptLable.attributedText = attrs;
//        [topView.promptLable sizeToFit];
//    
//        if (topView.promptLable.text == nil || [topView.promptLable.text isEqualToString:@""])
//        {
//            
//        }
//        else
//        {
//            promptViewHeight = topView.promptLable.height + 27;
//        }
//        
//        [topView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(promptViewHeight));
//        }];
//        [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(topView.mas_bottom);
//        }];
//    
//    [tableView reloadData];
//}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (IsiPhone4) {
        [self.refuseReasonTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.refuseOrderAlert.mas_top).offset(-80);
        }];
    }
    else
    {
        [self.refuseReasonTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.refuseOrderAlert.mas_top).offset(-50);
        }];
    }
    
    
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""] || textView.text == nil)
    {
        self.placeholderLabel.hidden = NO;
    }
    else
    {
        self.placeholderLabel.hidden = YES;
    }
}

#pragma mark - 注册网络请求状态下的弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
}

//控制器销毁时,移除弹框
- (void)dealloc
{
    [self.alert removeFromSuperview];
}

#pragma mark - 计算当前时间到失效时间之间的间隔
- (double)setupDifferentTime:(NSString *)failureTime
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    //将服务器返回的字符串转换为NSDate类型
    NSDate *failureDate = [formatter dateFromString:failureTime];
    
    //取出现在的时间
    NSDate *nowDate = [NSDate date];
    double nowTime = [nowDate timeIntervalSince1970];
    NSString *nowSec = [NSString stringWithFormat:@"%.0f", nowTime];
    double failureSec = [failureDate timeIntervalSince1970];
    //将过期时间戳减去现有的时间戳
    double differentSec = failureSec - [nowSec doubleValue];
    return differentSec;
}

#pragma mark - 跳转我的行程界面
- (void)NavigationRightEvent
{
    if (self.navTitleView.failureButton.enabled == YES) {
        //跳转我的行程页面
        WL_Application_Driver_Trip_ViewController *driverTripVc = [[WL_Application_Driver_Trip_ViewController alloc] init];
        [self.navigationController pushViewController:driverTripVc animated:YES];
    } else {
        //清空失效订单
        WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView = [[WL_Application_Driver_Order_Rush_AlertView alloc] init];
        UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
        [myWindow addSubview:rushOrderAlertView];
        rushOrderAlertView.backgroundColor = WLColor(0, 0, 0, 0.5);
        [rushOrderAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myWindow.mas_left);
            make.right.equalTo(myWindow.mas_right);
            make.top.equalTo(myWindow.mas_top);
            make.bottom.equalTo(myWindow.mas_bottom);
        }];
        
        [rushOrderAlertView.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
             make.height.equalTo(@(120 * AUTO_IPHONE6_HEIGHT_667));
        }];
        
        rushOrderAlertView.promptLable.hidden = YES;
        rushOrderAlertView.promptMessageLable.text = @"是否删除所有已失效订单列表";
        [rushOrderAlertView.promptMessageLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rushOrderAlertView.bottomView.mas_top).offset(28 * AUTO_IPHONE6_HEIGHT_667);
        }];
        
        [rushOrderAlertView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rushOrderAlertView.bottomView.mas_top).offset(70 * AUTO_IPHONE6_HEIGHT_667);
        }];
        
        rushOrderAlertView.promptMessageLable.textAlignment = NSTextAlignmentCenter;
        [rushOrderAlertView.cancleButton setTitle:@"否" forState:UIControlStateNormal];
        [rushOrderAlertView.cancleButton addTarget:self action:@selector(cancleRushOrderButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [rushOrderAlertView.rushButton setTitle:@"全部删除" forState:UIControlStateNormal];
        [rushOrderAlertView.rushButton addTarget:self action:@selector(sendRequestToClearFailureList) forControlEvents:UIControlEventTouchUpInside];
        self.rushOrderAlertView = rushOrderAlertView;
        
        if (self.totalFailureOrders.count == 0 || self.totalFailureOrders == nil)
        {
            rushOrderAlertView.rushButton.enabled = NO;
        } else {
            rushOrderAlertView.rushButton.enabled = YES;
        }

    }
    
    
}

#pragma mark - 发送请求清空已失效订单列表
- (void)sendRequestToClearFailureList
{
    //清空失效订单列表url
    NSString *urlStr = DriverOrderClearFailureListUrl;
    //请求参数
    NSString *driver_id = [WLUserTools getUserId];
    //密码
    NSString *password = [WLUserTools getUserPassword];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:password publicKey:RSAKey];
    //获取公司id
    NSDictionary *params = @{
                           @"driver_id" : @(driver_id.intValue),
                           @"user_password" : encriptString
                           };
    
    //发送清空列表请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.status isEqualToString:@"1"]) {
            [self.alert createTip:[NSString stringWithFormat:@"%@", baseModel.msg]];
            return;
        }
        self.failureOrderPage = 1;
        [self sendRequestToOrderListWithOrderStatus:self.orderStatus page:self.failureOrderPage];
    } Failure:^(NSError *error) {
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
        //隐藏菊花
        [self hidHud];
    }];
    [self cancleRushOrderButtonClick];
    
    
}



@end
