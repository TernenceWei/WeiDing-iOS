//
//  WLGuideOrdelDetailViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/10/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//
#import "WLGuideOrdelDetailViewController.h"
#import "WLGuideDetailTableViewCell.h"
#import "WLGuideDetailFooterView.h"
//线路详情
#import "WLGuideLineViewController.h"

//线路名称模型

#import "WLGuideWaitOrderTableViewCell.h"
#import "WLOrderListInfo.h"
#import "WLNetworkManager.h"
#import "WLGuideSuccessOrderController.h"
#import "WLGuideFailureOrderController.h"
#import "WLGuideRefuseOrderAlertViewCell.h"
#import "WLGuideRefuseOrderAlertView.h"
#import "WL_Application_Driver_Order_OrderDetail_NavTitleView.h"
#import "WL_Application_Driver_Order_Rush_AlertView.h"
#import "WL_WarningView.h"

@interface WLGuideOrdelDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>
{
    dispatch_source_t _timer ;
}

//@property(nonatomic,strong)WLGuideOrderLineView *lineView;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *denyBtn;
@property(nonatomic, strong)UIButton *acceptBtn;

@property(nonatomic, strong)NSMutableArray *sectionArray;
@property(nonatomic, strong)NSMutableArray *leftArray0;
@property(nonatomic, strong)NSMutableArray *leftArray1;
@property(nonatomic, strong)NSMutableArray *leftArray2;
@property(nonatomic, strong)NSMutableArray *leftArray3;
@property(nonatomic, strong)NSMutableArray *leftArray4;
@property(nonatomic, strong)NSMutableArray *leftAllArray;

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
@property(nonatomic, weak)WL_Application_Driver_Order_OrderDetail_NavTitleView *navTitleView;
@property(nonatomic, weak)WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView;
@property(nonatomic, strong)WL_WarningView *warningAlert;

@property (nonatomic, strong) NSTimer *timer1;
@property (nonatomic, assign) long long timeCount;

@end

@implementation WLGuideOrdelDetailViewController
-(NSMutableArray *)sectionArray{
    if (_sectionArray == nil) {
        _sectionArray = [[NSMutableArray alloc] initWithObjects:@"",@"出行人数",@"费用问题",@"订单来源",@"备注信息",nil];
    }
    return _sectionArray;
}
-(NSMutableArray *)leftArray0{
    if (_leftArray0 == nil) {
        _leftArray0 = [[NSMutableArray alloc] initWithObjects:@"",nil];
    }
    return _leftArray0;
}
-(NSMutableArray *)leftArray1{
    if (_leftArray1 == nil) {
        _leftArray1 = [[NSMutableArray alloc] initWithObjects:@"总人数",nil];
    }
    return _leftArray1;
}
-(NSMutableArray *)leftArray2{
    if (_leftArray2 == nil) {
        _leftArray2  = [[NSMutableArray alloc] initWithObjects:@"导服费",@"备用金",@"购物返点",nil];
    }
    return _leftArray2 ;
}
-(NSMutableArray *)leftArray3{
    if (_leftArray3 == nil) {
        _leftArray3 = [[NSMutableArray alloc] initWithObjects:@"旅行社",nil];
    }
    return _leftArray3;
}
-(NSMutableArray *)leftArray4{
    if (_leftArray4 == nil) {
        _leftArray4 = [[NSMutableArray alloc] initWithObjects:@"",nil];
    }
    return _leftArray4;
}
-(NSMutableArray *)leftAllArray{
    if (_leftAllArray == nil) {
        _leftAllArray = [[NSMutableArray alloc] initWithObjects:self.leftArray0,self.leftArray1,self.leftArray2,self.leftArray3,self.leftArray4,nil];
    }
    return _leftAllArray;
}

- (NSMutableArray *)cancleReasonArrToDetail
{
    if (!_cancleReasonArrToDetail) {
        _cancleReasonArrToDetail = [NSMutableArray array];
    }
    return _cancleReasonArrToDetail;
}

- (WL_WarningView *)warningAlert
{
    if (!_warningAlert) {
        _warningAlert = [[WL_WarningView alloc] init];
        [_warningAlert setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    
    
    return _warningAlert;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer1 invalidate];
    self.timer1 = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRightImg:@"lineDetail"];
    // Do any additional setup after loading the view.
    
    [self loadDetailData];
    [self creatView];
    
    self.cancleReasonsToDetail = @[@"导服费太低", @"订单信息不全", @"购物返点未明确", @"行程变化，没有时间", @"不接受纯玩团订单",@"其他原因"];
    
    self.alert = [WL_TipAlert_View sharedAlert];
    [self setTitle];
    

   
}

-(void)NavigationRightEvent{
    WLGuideLineViewController *vc = [[WLGuideLineViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.orderInfo = self.orderInfo;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)setTitle{
    if ([self.status isEqualToString:@"2"]) {
        [self setupContentToNav];
            [self setTimeOut];
    }
    else if ([self.status isEqualToString:@"3"]){
        self.title = @"已接单详情";
    }
    else if([self.status isEqualToString:@"4"]){
        self.title = @"已失效详情";
    }
}


-(void)setLineInfo:(WLGroupDetailInfo *)detailInfo{
    _lineInfo = [detailInfo.lineArray objectAtIndex:0];

}

-(void)creatView{
    self.view.backgroundColor = HEXCOLOR(0xf7f7f8);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [self.view addSubview:self.tableView];
    
    if ([self.status isEqualToString:@"2"]) {
        self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - ScaleH(50));
        [self addButtons];
        
    }
}


#pragma mark 网络请求
-(void)loadDetailData{
    [WLNetworkManager requestGroupInfoWithGroupNO:self.orderInfo.checkListID result:^(BOOL success, WLGroupDetailInfo *info) {
        
        if(success){
            self.detailInfo = info;
            [self setTimeOut];
            [self.tableView reloadData];
            
        }
    }];
}


#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
        return self.sectionArray.count;
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (section == 2) {
            return 3;
        }
        else{
            return 1;
        }
    }
    else{
        return 6;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        
        if (indexPath.section == 0) {
            return 275;
        }
        else{
            return 50;
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (section == 0) {
            return nil;
        }
        else{
            UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(48))];
            headerView.backgroundColor = HEXCOLOR(0xf7f7f8);
            UILabel *headerLabel = [[UILabel alloc] init];
            [headerView addSubview:headerLabel];
            
            [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(headerView.mas_left).offset(ScaleW(10));
                make.top.equalTo(headerView.mas_top).offset(ScaleH(15));
            }];
            headerLabel.textColor = HEXCOLOR(0x868686);
            headerLabel.font = WLFontSize(14);
            headerLabel.text = self.sectionArray[section];
            
            return headerView;
        }
    }
    return nil;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (section == 0) {
            return 0.0f;
        }
        else{
            return ScaleH(48);
        }
    }
    return 0.0f;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        WLGuideDetailFooterView *footerView = [[WLGuideDetailFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(223))];
        footerView.orderInfo = self.orderInfo;
        footerView.detailInfo = self.detailInfo;

        return footerView;
    }
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (section == 4) {
            return ScaleH(223);
        }
        else{
            return 0.0f;
        }
    }
    return 0.0f;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        
        if (indexPath.section == 0) {
            WLGuideDetailTableViewCell *cell = [[WLGuideDetailTableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 275) detailInfo:self.detailInfo selectAction:^{
                
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            
            static NSString *ID = @"ID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.font = WLFontSize(14);
            cell.textLabel.textColor = HEXCOLOR(0x2f2f2f);
            cell.textLabel.text = self.leftAllArray[indexPath.section][indexPath.row];
            
            cell.detailTextLabel.font = WLFontSize(14);
            cell.detailTextLabel.textColor = HEXCOLOR(0xff5b3d);
            if (indexPath.section == 1) {
                cell.detailTextLabel.text = self.detailInfo.peopleNums;
            }else if(indexPath.section == 2){
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.detailInfo.guideMoney];
                }else if (indexPath.row == 1){
                    if (self.detailInfo.spareMoney) {
                        //cell.detailTextLabel.text = self.detailInfo.spareMoney;
                        //cell.detailTextLabel.layer.borderWidth = 0;
                        UILabel * moneytype = [[UILabel alloc] init];
                        moneytype.frame = CGRectMake((ScreenWidth /3)*2 - ScaleW(40), ScaleH(10), ScaleW(85), ScaleH(30));
                        moneytype.text = [NSString stringWithFormat:@"￥%@",self.detailInfo.spareMoney];
                        moneytype.textColor = [WLTools stringToColor:@"#b5b5b5"];
                        moneytype.font = [UIFont WLFontOfSize:13];
                        moneytype.textAlignment = NSTextAlignmentRight;
                        [cell addSubview:moneytype];
                    }
                    cell.accessoryType = UITableViewCellSeparatorStyleSingleLine;
                    cell.detailTextLabel.layer.cornerRadius = 2;
                    cell.detailTextLabel.layer.borderColor = HEXCOLOR(0x879efa).CGColor;
                    cell.detailTextLabel.layer.borderWidth = 1;
                    cell.detailTextLabel.textColor = HEXCOLOR(0x879efa);
                    cell.detailTextLabel.font = WLFontSize(12);
                    if (self.detailInfo.isActivated != nil) {
                        if ([self.detailInfo.isActivated integerValue] == 0) {
                            cell.detailTextLabel.text = @"待确认";
                        }
                        else if ([self.detailInfo.isActivated integerValue] == 1)
                        {
                            cell.detailTextLabel.text = @"冻结";
                        }
                        else if ([self.detailInfo.isActivated integerValue] == 2)
                        {
                            cell.detailTextLabel.text = @"已激活";
                        }
                        else
                        {
                            cell.detailTextLabel.text = @"";
                        }
                    }
                    else
                    {
                        cell.detailTextLabel.text = @"";
                    }
                }
                else if (indexPath.row == 2){
                    cell.detailTextLabel.text = self.detailInfo.returnRate;
                }
            }
            if (indexPath.section == 3) {
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = self.orderInfo.companyName;
                }
                else{
                    //cell.detailTextLabel.text = self.detailInfo.companyName;
                }
            }
            if (indexPath.section == 4) {
                cell.textLabel.text = self.detailInfo.remark;
            }
            return cell;
        }
    }
    else{
        
        WLGuideRefuseOrderAlertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:refuseOrderCellId];
        cell.reasonLable.text = self.cancleReasonsToDetail[indexPath.row];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.row == 5)
        {
            cell.reasonTextView.hidden = NO;
            cell.reasonTextView.delegate = self;
            self.placeholderLabel = cell.placeholderLabel;
            [cell.selectedButton addTarget:self action:@selector(denyOrder) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
        
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            //
        }
        if (indexPath.section == 2 && indexPath.row == 1) {
            [self alertToPrompt];
        }
    }
    else
    {
        WLGuideRefuseOrderAlertViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectedButton.selected = !cell.selectedButton.selected;
        self.reasonTextView = cell.reasonTextView;
        if (cell.selectedButton.selected)
        {
            
            [self.cancleReasonArrToDetail addObject:cell.reasonLable.text];
            
        }
        else
        {
            
            [self.cancleReasonArrToDetail removeObject:cell.reasonLable.text];
            
        }
        
    }
    
}
#pragma mark - 弹框提示导游备用金
- (void)alertToPrompt
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.warningAlert];
    
    self.warningAlert.tipString = @"出团前，备用金将自动转入主导游账户，为冻结状态。出团当天在日程中点击“出团”，即可激活使用";
    self.warningAlert.buttonTittle = @"知道了";
}



-(void)addButtons{

    self.denyBtn = [[UIButton alloc] init];
    self.denyBtn.frame = CGRectMake(0, ScreenHeight - 64- ScaleH(50), ScaleW(160), ScaleH(50));
    [self.denyBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [self.denyBtn setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [self.denyBtn.titleLabel setFont:WLFontSize(15)];
    self.denyBtn.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:self.denyBtn];
    [self.denyBtn addTarget:self action:@selector(denyOrder) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.acceptBtn = [[UIButton alloc] init];
    self.acceptBtn.frame = CGRectMake(ScaleW(160), ScreenHeight - 64- ScaleH(50), ScaleW(215), ScaleH(50));
    [self.acceptBtn setTitle:@"快速接单" forState:UIControlStateNormal];
    [self.acceptBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    [self.acceptBtn.titleLabel setFont:WLFontSize(18)];
    self.acceptBtn.backgroundColor = HEXCOLOR(0xff7e44);
    [self.view addSubview:self.acceptBtn];
    [self.acceptBtn addTarget:self action:@selector(rushButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 取消订单方法
static NSString *const refuseOrderCellId = @"refuseOrderCellId";
- (void)denyOrder{
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
    WLGuideWaitOrderTableViewCell *cell;
    refuseOrderAlert.refuseButton.tag = [cell.orderID integerValue];
    
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
    WLGuideWaitOrderTableViewCell *cell;
    [WLNetworkManager acceptOrDenyTheOrderWithOrderID:cell.orderID accept:NO denyReason:self.cancleReasonArrToDetail[0] result:^(BOOL success, BOOL result) {
        if (success) {
            [self refuseOrderAlertHidden];
            [self.alert createTip:@"拒单成功"];
            [self hidHud];
            return ;
        }
        else
        {
            [self refuseOrderAlertHidden];
            [self.alert createTip:@"拒单失败"];
            [self hidHud];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


-(void)setTimeOut{
    //获取时间差的秒数
    
    self.timeCount = self.detailInfo.expiryDate.longLongValue;
    if (self.timer1 == nil) {
        [self countTime];
        self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
    }
}

- (void)countTime
{
    int min = (int)(self.timeCount / 60);
    int sec = (int)(self.timeCount - min * 60);
    self.navTitleView.timerLable.text = [NSString stringWithFormat:@"%02d分%02d秒",min, sec];
    
    if (self.timeCount > 0)
    {
         self.timeCount --;
    }
}

#pragma mark - 设置导航内容
- (void)setupContentToNav
{
    WL_Application_Driver_Order_OrderDetail_NavTitleView *navTitleView = [[WL_Application_Driver_Order_OrderDetail_NavTitleView alloc] initWithFrame:CGRectMake(0, 0, 98, 45)];
    self.navigationItem.titleView = navTitleView;
    self.navTitleView = navTitleView;
    if ([self.status isEqualToString:@"2"] ) {
        navTitleView.hidden = NO;
    }else{
        navTitleView.hidden = YES;
    }
    
}

#pragma mark - 抢单按钮点击方法
- (void)rushButtonClick
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
    NSString *departureTimeToMon = [self.orderInfo.receiveDate substringWithRange:NSMakeRange(5, 2)];
    NSString *departureTimeToDay = [self.orderInfo.receiveDate substringWithRange:NSMakeRange(8, 2)];
    //出发时间字符串
    NSString *timeStr = [NSString stringWithFormat:@"%@月%@日", departureTimeToMon, departureTimeToDay];
    
    rushOrderAlertView.promptMessageLable.text = [NSString stringWithFormat:@"该订单需要在“%@－%@” 出发，是否确认接单", timeStr, self.orderInfo.receiveDate];
    
    [rushOrderAlertView.cancleButton addTarget:self action:@selector(cancleRushOrderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rushOrderAlertView.rushButton addTarget:self action:@selector(rushOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rushOrderAlertView = rushOrderAlertView;
}

#pragma mark -确定抢单
- (void)rushOrderButtonClick:(UIButton *)button
{
    //隐藏弹框
    self.rushOrderAlertView.hidden = YES;
    //发送接单请求
//    [self sendRequestToRushOrderWithOrderStatusType:@"1"];
    [WLNetworkManager acceptOrDenyTheOrderWithOrderID:self.orderInfo.checkListID accept:YES denyReason:nil result:^(BOOL success, BOOL result) {
        if(success){
            WLGuideSuccessOrderController *successVc = [[WLGuideSuccessOrderController alloc] init];
            [self.navigationController pushViewController:successVc animated:YES];
            successVc.orderInfo = self.orderInfo;
        }
        else{
            WLGuideFailureOrderController *failureVc = [[WLGuideFailureOrderController alloc] init];
            failureVc.orderInfo = self.orderInfo;
            [self.navigationController pushViewController:failureVc  animated:YES];
        }
    }];
}

#pragma mark - 隐藏抢单弹窗<取消方法>
- (void)cancleRushOrderButtonClick
{
    self.rushOrderAlertView.hidden = YES;
}

- (void)dealloc
{
    
}



@end
