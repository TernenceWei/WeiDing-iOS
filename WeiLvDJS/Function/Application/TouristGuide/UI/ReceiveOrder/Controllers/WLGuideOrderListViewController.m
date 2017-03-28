//
//  WLGuideOrderListViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/10/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

/** 待接单cell */
#import "WLGuideWaitOrderTableViewCell.h"
#import "WLGuideReceivedOrderTableViewCell.h"
#import "WLGuideInvalidOrderTableViewCell.h"
#import "WLGuideSuccessOrderController.h"
#import "WLGuideFailureOrderController.h"
#import "WLGuideOrdelDetailViewController.h"
#import "WLGuideOrderListViewController.h"
#import "WLRecieveOrderHeader.h"
#import "WLNetworkManager.h"
#import "WLOrderListInfo.h"
#import "WLGuideRefuseOrderAlertView.h"
#import "WLGuideRefuseOrderAlertViewCell.h"
#import "WL_Application_Driver_Order_Rush_AlertView.h"
#import "WLScheduleListViewController.h"

@interface WLGuideOrderListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,WLGuideWaitOrderTableViewCellDelegate>
//记录是否显示提醒条的属性
@property(nonatomic, assign)NSInteger mark;

@property(nonatomic, weak)WLGuideRefuseOrderAlertView *refuseOrderAlert;
/** 内容TableView */
@property(nonatomic, weak)UITableView *refuseReasonTableView;
/** 取消订单原因数组 */
@property(nonatomic, strong) NSArray *cancleReasonsToDetail;
/** 取消订单参数数组 */
@property(nonatomic, strong) NSMutableArray *cancleReasonArrToDetail;
/** 拒绝原因列表中其他原因输入框 */
@property(nonatomic, weak) UITextView *reasonTextView;
/** 占位文字Lable */
@property(nonatomic, weak) UILabel *placeholderLabel;
@property(nonatomic, strong)WL_TipAlert_View *alert;
//info模型
@property(nonatomic, strong)WLOrderListInfo *orderInfo;
@property(nonatomic, weak)WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView;

/** 导航条 */
@property(nonatomic, strong)WLRecieveOrderHeader *headerView;
@property(nonatomic, assign)OrderStatus status;
@property(nonatomic, strong)UITableView *tableView;

//提示条
@property(nonatomic, strong)UIView *warningView;

@property(nonatomic, strong)NSMutableArray *firstArray;
@property(nonatomic, strong)NSMutableArray *secondArray;
@property(nonatomic, strong)NSMutableArray *thirdArray;
@property(nonatomic, strong)NSMutableArray *dataSource;
@property(nonatomic, strong)NSMutableArray *pageArray;

@property (nonatomic, assign) BOOL isShow;
@property(nonatomic, strong) WLGuideRefuseOrderAlertViewCell *selectedCell;
@end

@implementation WLGuideOrderListViewController


#pragma mark --------lazy initialize
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray *)firstArray{
    if (_firstArray == nil) {
        _firstArray = [NSMutableArray array];
    }
    return _firstArray;
}

-(NSMutableArray *)secondArray{
    if (_secondArray == nil) {
        _secondArray = [NSMutableArray array];
    }
    return _secondArray;
}

-(NSMutableArray *)thirdArray{
    if (_thirdArray == nil) {
        _thirdArray = [NSMutableArray array];
    }
    return _thirdArray;
}

- (NSMutableArray *)cancleReasonArrToDetail
{
    if (!_cancleReasonArrToDetail) {
        _cancleReasonArrToDetail = [NSMutableArray array];
    }
    return _cancleReasonArrToDetail;
}


#pragma mark ----- 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    if (_isShow) {
        self.status = OrderStatusWaitReceive;
        [self loadMoreDataDown:self.status];
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpNavBar];
    

    //初始化
    _isShow = NO;
    self.pageArray = [@[@"2",@"2",@"2"] mutableCopy];
    
    [self creatView];
    
    [self initParams];
    
    self.alert = [WL_TipAlert_View sharedAlert];
    
    [self refresh];
    
    self.status = OrderStatusWaitReceive;
    [self loadMoreDataDown:self.status];
}

-(void)initParams{
    self.cancleReasonsToDetail = @[@"导服费太低", @"订单信息不全", @"购物返点未明确", @"行程变化，没有时间", @"不接受纯玩团订单",@"其他原因"];
    self.mark = 1;

}


-(void)setUpNavBar{
    //设置导航栏右侧图片
        [self setNavigationRightImg:@"Driver_Order_My Travel"];
}

-(void)refresh{
    //注册下拉刷新
    WS(weakSelf);
    //待接单列表-下拉刷新
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [weakSelf loadMoreDataDown:self.status];
    }];
    self.tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    //待接单列表-上拉刷新
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

       [weakSelf loadMoreDataUp];

    }];
    self.tableView.mj_footer = footer;
    [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];

}

- (void)loadMoreDataDown:(OrderStatus)sstatus
{
    [self showHud];
    [WLNetworkManager requestOrderListOrGroupListWithType:GroupOrderTypeOrder miniType:sstatus page:1 result:^(BOOL success, NSArray *listArray) {
        [self.tableView.mj_header endRefreshing];
        [self.dataSource removeAllObjects];
        [self hidHud];
        if (success) {
            
            switch(sstatus){
                case OrderStatusWaitReceive:
                    [self.firstArray addObjectsFromArray:listArray];
                    self.dataSource = self.firstArray;
                    break;
                    
                case OrderStatusAlreadyReceive:
                    [self.secondArray addObjectsFromArray:listArray];
                    self.dataSource = self.secondArray;
                    break;
                    
                case OrderStatusOutOfDate:
                    [self.thirdArray addObjectsFromArray:listArray];
                    self.dataSource = self.thirdArray;
                    break;
                    
                default:
                    break;
            }
            
        }
        [self.tableView reloadData];
        
    }];
    
    
}

//上拉
-(void)loadMoreDataUp
{
    [self showHud];

    [WLNetworkManager requestOrderListOrGroupListWithType:GroupOrderTypeOrder miniType:self.status page:[self getPageCount] result:^(BOOL success, NSArray *listArray) {
        [self hidHud];
        [self.tableView.mj_footer endRefreshing];
        if (success) {
            
            switch(self.status){
                case OrderStatusWaitReceive:
                    [self.firstArray addObjectsFromArray:listArray];
                    self.dataSource = self.firstArray;
                    break;

                case OrderStatusAlreadyReceive:
                    [self.secondArray addObjectsFromArray:listArray];
                    self.dataSource = self.secondArray;
                    break;

                case OrderStatusOutOfDate:
                    [self.thirdArray addObjectsFromArray:listArray];
                    self.dataSource = self.thirdArray;
                    break;
                
                    default:
                    break;
            }
            [self.tableView reloadData];
        }
    }];
    
}

-(void)creatView{
    CGFloat x = CGRectGetMaxX(self.navigationItem.leftBarButtonItem.customView.frame) + ScaleW(44);
    CGFloat y = 0;
    CGFloat width = ScaleW(78);
    CGFloat height = self.navigationController.navigationBar.frame.size.height;
    
    self.headerView = [[WLRecieveOrderHeader alloc] initWithFrame:CGRectMake(x, y, width * 3, height) textArray:@[@"待接单",@"已接单",@"已失效"] selectAction:^(NSUInteger index) {
        if (index == 0) {
            [self setNavigationRightImg:@"Driver_Order_My Travel"];
            self.tableView.tableHeaderView = nil;
            self.status = OrderStatusWaitReceive;
            
            [self loadMoreDataDown:self.status];
            
        }
        else if (index == 1){
            [self setNavigationRightImg:@"Driver_Order_My Travel"];
            self.tableView.tableHeaderView = nil;
            self.status = OrderStatusAlreadyReceive;
            
            [self loadMoreDataDown:self.status];
            
        }
        else if (index == 2){
            if (self.mark == 1) {
                 [self creatWarningView];
            }
            self.status = OrderStatusOutOfDate;
            
            [self loadMoreDataDown:self.status];
            
            [self setNavigationRightImg:@"clear"];
            
        }
        [self.tableView reloadData];
    }];
    [self.navigationItem setTitleView:self.headerView];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [self.view addSubview:self.tableView];
}

-(void)creatWarningView{
    self.warningView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, ScreenWidth, ScaleH(36))];
    self.warningView.backgroundColor = HEXCOLOR(0xfff8d7);
    UILabel *label = [[UILabel alloc] init];
    [self.warningView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.warningView.mas_left).offset(ScaleW(5));
        make.centerY.equalTo(self.warningView.mas_centerY);
    }];
    label.textColor = HEXCOLOR(0xc4502c);
    label.font = WLFontSize(13);
    label.text = @"订单失效率高，会导致订单变少哦！";
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [self.warningView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.warningView.mas_centerY);
        make.right.equalTo(self.warningView.mas_right).offset(-15);
    }];
    [closeBtn setImage:[UIImage imageNamed:@"Driver_Order_Close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableHeaderView = self.warningView;
}
-(void)closeBtnClick{

    self.tableView.tableHeaderView = nil;
    self.tableView.frame = CGRectMake(0,0, ScreenWidth, ScreenHeight - 44);
    self.mark = 0;
}

#pragma mark - 加载数据
-(void)setStatus:(OrderStatus)status{
    _status = status;
}


-(NSInteger)getPageCount{
    NSInteger count = 1;
    if (self.status == OrderStatusWaitReceive) {
        count = [self.pageArray[0] integerValue];
        [self.pageArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld", count + 1]];
    }
    if (self.status == OrderStatusAlreadyReceive) {
        count = [self.pageArray[1] integerValue];
        [self.pageArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",count+ 1]];
    }
    if (self.status == OrderStatusOutOfDate) {
        count = [self.pageArray[2] integerValue];
        [self.pageArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",count + 1]];
    }
    return count;
}

#pragma mark -- UITableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.dataSource.count;
    }
    else{
        return 6;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (self.status == OrderStatusWaitReceive) {
            static NSString *ID = @"ID";
            WLGuideWaitOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[WLGuideWaitOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
            }
            cell.delegate = self;
            cell.orderInfo = self.dataSource[indexPath.row];
            return cell;
        }
        if (self.status == OrderStatusAlreadyReceive) {
            static NSString *ID2 = @"ID2";
            WLGuideReceivedOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
            if (cell == nil) {
                cell = [[WLGuideReceivedOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID2];
            }
            cell.orderInfo = self.dataSource[indexPath.row];
            return cell;
        }
        if (self.status == OrderStatusOutOfDate) {
            static NSString *ID3 = @"ID3";
            WLGuideInvalidOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID3];
            if (cell == nil) {
                cell = [[WLGuideInvalidOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID3];
            }
            cell.orderInfo = self.dataSource[indexPath.row];
            return cell;
        }
    }
    else
    {
        WLGuideRefuseOrderAlertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:refuseOrderCellId];
        cell.reasonLable.text = self.cancleReasonsToDetail[indexPath.row];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.row == 5)
        {
            cell.reasonTextView.hidden = NO;
            cell.reasonTextView.delegate = self;
            self.placeholderLabel = cell.placeholderLabel;
            [cell.selectedButton addTarget:self action:@selector(denyOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (self.status == OrderStatusWaitReceive) {
            return ScaleH(300);
        }
        else{
            return ScaleH(275);
        }
    }
    else if (tableView == self.refuseReasonTableView)
    {
        if (indexPath.row == 5)
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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {

        WLGuideOrdelDetailViewController *detailVc = [[WLGuideOrdelDetailViewController alloc] init];
        detailVc.orderInfo = self.dataSource[indexPath.row];
        detailVc.status = [NSString stringWithFormat:@"%lu",(unsigned long)self.status];
        [self.navigationController pushViewController:detailVc animated:YES];
    }else{
        WLGuideRefuseOrderAlertViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        self.selectedCell.selectedButton.selected = NO;
        cell.selectedButton.selected = YES;
        self.selectedCell = cell;
        self.reasonTextView = cell.reasonTextView;
        if (cell.selectedButton.selected)
        {
            [self.cancleReasonArrToDetail addObject:cell.reasonLable.text];
            
        }else{
            [self.cancleReasonArrToDetail removeObject:cell.reasonLable.text];
            
        }
    }
}

#pragma mark - 取消订单方法
//取消订单方法
static NSString *const refuseOrderCellId = @"refuseOrderCellId";
#pragma mark -- 代理回传
- (void)denyOrder:(WLOrderListInfo *)orderInfoID
{
    //拒绝原因数组
    [self.cancleReasonArrToDetail removeAllObjects];
    //弹出拒绝订单的弹框
    WLGuideRefuseOrderAlertView *refuseOrderAlert = [[WLGuideRefuseOrderAlertView alloc] init];
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
    [refuseOrderAlert.refuseReasonTableView registerClass:[WLGuideRefuseOrderAlertViewCell class] forCellReuseIdentifier:refuseOrderCellId];
    self.refuseReasonTableView = refuseOrderAlert.refuseReasonTableView;

    refuseOrderAlert.refuseButton.tag = [orderInfoID.checkListID integerValue];
    
    //点击弹框的取消按钮
    [refuseOrderAlert.cancleButton addTarget:self action:@selector(refuseOrderAlertHidden) forControlEvents:UIControlEventTouchUpInside];
    //点击确认拒绝按钮的方法
    [refuseOrderAlert.refuseButton addTarget:self action:@selector(confirmCancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

//取消按钮点击方法
- (void)refuseOrderAlertHidden
{
    [self.refuseOrderAlert removeFromSuperview];
    
}

//确认拒绝按钮点击方法
-(void)confirmCancleButtonClick:(UIButton *)button{
    NSMutableArray *cancleReasonsArr = self.cancleReasonArrToDetail;
    for (NSString *reasons in cancleReasonsArr)
    {
        if ([reasons isEqualToString:@"其他"])
        {
            [self.cancleReasonArrToDetail removeObject:reasons];
            NSString *otherReason = [NSString stringWithFormat:@"%@:%@",reasons, self.reasonTextView.text];
            [self.cancleReasonArrToDetail addObject:otherReason];
        }
    }
    
    if (self.cancleReasonArrToDetail.count == 0)
    {
        [self.alert createTip:@"请选择拒绝理由"];
        return;
    }
    [self showHud];

    [WLNetworkManager acceptOrDenyTheOrderWithOrderID:[NSString stringWithFormat:@"%ld",(long)button.tag] accept:NO denyReason:self.cancleReasonArrToDetail[0] result:^(BOOL success, BOOL result) {
        if (success) {
            [self refuseOrderAlertHidden];
            [self.alert createTip:@"拒单成功"];
            [self hidHud];
            self.status = OrderStatusWaitReceive;
            [self loadMoreDataDown:self.status];
        }else{
            [self refuseOrderAlertHidden];
            [self.alert createTip:@"拒单失败"];
            [self hidHud];
        }
    }];
}


-(void)NavigationRightEvent{
    if (self.status == OrderStatusOutOfDate) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否删除所有已失效订单列表" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"全部删除", nil];
        
        [alertView show];
    }
    else{
        WLScheduleListViewController *scheduleVc = [[WLScheduleListViewController alloc] init];
        scheduleVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scheduleVc animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {

        [self showHud];
        
        [WLNetworkManager clearOutOfDateOrderListWithResult:^(BOOL success, BOOL result) {
            if (success && result) {
                [self.thirdArray removeAllObjects];
                self.dataSource = self.thirdArray;
                [self closeBtnClick];
                [self.tableView reloadData];
                [[WL_TipAlert_View sharedAlert] createTip:@"删除成功"];

            }else
            {
                [[WL_TipAlert_View sharedAlert] createTip:@"删除失败"];
            }
            
            [self hidHud];
        }];
    }
    else if (buttonIndex == 0){
        return;
    }
}

#pragma mark - 抢单按钮点击方法
- (void)acceptOrder:(WLGuideWaitOrderTableViewCell *)cell orderInfo:(WLOrderListInfo *)orderInfo
{
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
    self.orderInfo = orderInfo;
    NSString *startString = [self getScheduleTextWithTimeString:self.orderInfo.receiveDate];
    NSString *endString = [self getScheduleTextWithTimeString:self.orderInfo.sendDate];
    rushOrderAlertView.promptMessageLable.text = [NSString stringWithFormat:@"该订单需要在“%@-%@在%@” 出发，是否确认接单", startString, endString, self.orderInfo.startCity];
    
    [rushOrderAlertView.cancleButton addTarget:self action:@selector(cancleRushOrderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rushOrderAlertView.rushButton addTarget:self action:@selector(rushOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rushOrderAlertView = rushOrderAlertView;
}

- (NSString *)getScheduleTextWithTimeString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:  NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    return [NSString stringWithFormat:@"%ld月%ld日", (long)month,day];
    
}

#pragma mark -确定抢单
- (void)rushOrderButtonClick:(UIButton *)button
{
    //隐藏弹框
    self.rushOrderAlertView.hidden = YES;
    //发送接单请求
    [WLNetworkManager acceptOrDenyTheOrderWithOrderID:self.orderInfo.checkListID accept:YES denyReason:nil result:^(BOOL success, BOOL result) {
        if(result){
            WLGuideSuccessOrderController *successVc = [[WLGuideSuccessOrderController alloc] init];
            successVc.orderInfo = self.orderInfo;
            [self.navigationController pushViewController:successVc animated:YES];
            
        }
        else{
            WLGuideFailureOrderController *failureVc = [[WLGuideFailureOrderController alloc] init];
            failureVc.orderInfo = self.orderInfo;
            [self.navigationController pushViewController:failureVc  animated:YES];
        }
        _isShow = YES;
    }];
}

#pragma mark - 隐藏抢单弹窗<取消方法>
- (void)cancleRushOrderButtonClick
{
    self.rushOrderAlertView.hidden = YES;
}

@end
