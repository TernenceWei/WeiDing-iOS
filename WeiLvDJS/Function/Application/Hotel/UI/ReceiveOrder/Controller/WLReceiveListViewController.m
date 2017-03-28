//
//  WLReceiveListViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLReceiveListViewController.h"
#import "WLTopGroupChooseView.h"
#import "WLWaitingListCell.h"
#import "WLBiddingListCell.h"
#import "WLHotelSearchView.h"
#import "WLNetworkManager.h"

#import "HcdDateTimePickerView.h"

//导入
#import "UIViewController+LewPopupViewController.h"  
#import "LewPopupViewAnimationFade.h"  
#import "WLHotelPopView.h"

@interface WLReceiveListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) WLTopGroupChooseView * topChooseView;
@property (nonatomic, strong) UITableView *ReceiveListTableView;
@property (nonatomic, strong) WLHotelSearchView *searchView;
@property (nonatomic, strong) NSMutableArray * DataArr;
@property (nonatomic, strong) NSMutableArray * firstDataArr;
@property (nonatomic, strong) NSMutableArray * secondDataArr;
@property (nonatomic, strong) NSMutableArray * thirdDataArr;
@property (nonatomic, strong) NSMutableArray * fourthDataArr;
@property (nonatomic, strong) NSMutableArray * fifthDataArr;
@property (nonatomic, assign) NSInteger thisPage;

@property (nonatomic, strong) UIView * noDataView;

@property (nonatomic, assign) BOOL isWaiting;

@property (nonatomic, assign) HotelListStatus nowStatus;

@property (nonatomic, strong) HcdDateTimePickerView * dateTimePickerView;

@property (nonatomic, strong) NSString * remarkStr;

@end

@implementation WLReceiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isWaiting = YES;
    
    [self setUpNav];
    [self setUI];
    [self refresh];
    [self GetNetData:HotelListStatusWaitReceive];
    
    _nowStatus = HotelListStatusWaitReceive;
    
    _firstDataArr = [[NSMutableArray alloc] init];
    _secondDataArr = [[NSMutableArray alloc] init];
    _thirdDataArr = [[NSMutableArray alloc] init];
    _fourthDataArr = [[NSMutableArray alloc] init];
    _fifthDataArr = [[NSMutableArray alloc] init];
    
    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (NSMutableArray *)DataArr
{
    if (!_DataArr) {
        _DataArr = [NSMutableArray array];
    }
    
    return _DataArr;
}

//- (NSMutableArray *)firstDataArr
//{
//    if (!_firstDataArr) {
//        _firstDataArr = [NSMutableArray array];
//    }
//    
//    return _firstDataArr;
//}

- (NSMutableArray *)secondDataArr
{
    if (!_secondDataArr) {
        _secondDataArr = [NSMutableArray array];
    }
    return _secondDataArr;
}

- (NSMutableArray *)thirdDataArr
{
    if (!_thirdDataArr) {
        _thirdDataArr = [NSMutableArray array];
    }
    return _thirdDataArr;
}

- (NSMutableArray *)fourthDataArr
{
    if (!_fourthDataArr) {
        _fourthDataArr = [NSMutableArray array];
    }
    return _fourthDataArr;
}

- (NSMutableArray *)fifthDataArr
{
    if (!_fifthDataArr) {
        _fifthDataArr = [NSMutableArray array];
    }
    return _fifthDataArr;
}

#pragma mark - 加载数据
//- (void)setNowStatus:(HotelListStatus)nowStatus
//{
//    _nowStatus = nowStatus;
//    [self GetNetData:_nowStatus];
//}

- (void)setUpNav{
    self.title = @"接单";
    self.view.backgroundColor = BgViewColor;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(beginToSearch)];
    self.navigationItem.rightBarButtonItem=item;
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
}

- (void)setUI
{
    _topChooseView = [[WLTopGroupChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(41)) textArray:@[@"待接单",@"竞价中",@"未结账",@"已结账",@"已失效"] selectAction:^(NSUInteger index) {
        
        if (index == 0) {

            _isWaiting = YES;
            _nowStatus = HotelListStatusWaitReceive;
        }
        else if(index == 1){

            _isWaiting = NO;
            _nowStatus = HotelListStatusBidding;
        }
        else if(index == 2){

            _isWaiting = NO;
            _nowStatus = HotelListStatusUnSettle;
        }
        else if(index == 3){

            _isWaiting = NO;
            _nowStatus = HotelListStatusAlreadySettle;
        }
        else if(index == 4){

            _isWaiting = NO;
            _nowStatus = HotelListStatusOutOfDate;
        }
        _thisPage = 1;
        [self GetNetData:_nowStatus];
        
        //[_ReceiveListTableView reloadData];
    }];
    
    [self.view addSubview:_topChooseView];
    
    
    _ReceiveListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topChooseView.frame), ScreenWidth, ScreenHeight - 44 - 64)];
    _ReceiveListTableView.delegate = self;
    _ReceiveListTableView.dataSource = self;
    _ReceiveListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _ReceiveListTableView.backgroundColor = HEXCOLOR(0xeff1fe);
    [self.view addSubview:_ReceiveListTableView];
    
    _noDataView = [[UIView alloc] init];
    _noDataView.frame = CGRectMake((ScreenWidth/2) - ScaleW(80), (ScreenHeight/2) - ScaleH(150), ScaleW(160), ScaleH(240));
    _noDataView.hidden = YES;
    [self.view addSubview:_noDataView];
    
    UIImageView * nodataImg = [[UIImageView alloc] init];
    nodataImg.frame = CGRectMake(0, 0, ScaleW(143), ScaleH(143));
    [nodataImg setImage:[UIImage imageNamed:@"noordersImg"]];
    [_noDataView addSubview:nodataImg];
    
    UILabel * noorderLabel = [[UILabel alloc] init];
    noorderLabel.frame = CGRectMake(nodataImg.frame.origin.x, nodataImg.frame.origin.y + nodataImg.frame.size.height + ScaleH(10), nodataImg.frame.size.width, ScaleH(20));
    noorderLabel.text = @"没有相关订单";
    noorderLabel.textAlignment = NSTextAlignmentCenter;
    noorderLabel.font = [UIFont WLFontOfSize:17];
    noorderLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    [_noDataView addSubview:noorderLabel];
}

-(void)refresh{
    //注册下拉刷新
    //WS(weakSelf);

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _thisPage = 1;
        [self GetNetData:_nowStatus];
        //[weakSelf loadMoreDataDown:self.status];
    }];
    _ReceiveListTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;

    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    

    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _thisPage ++;
        [self GetNetData:_nowStatus];
        
    }];
    _ReceiveListTableView.mj_footer = footer;
    [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
}


- (void)beginToSearch {
    
    __weak __typeof__(self) weakSelf = self;
    WLHotelSearchView *searchView = [[WLHotelSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) searchBlock:^{
        
    } itemClickBlock:^{
        
    } cancelBlock:^{
        [weakSelf.searchView removeFromSuperview];
        weakSelf.searchView = nil;
    }];
    [self.navigationController.view addSubview:searchView];
    self.searchView = searchView;
}


- (void)GetNetData:(HotelListStatus)nowStatus
{
    [WLNetworkManager requestHotelListWithStatus:nowStatus page:_thisPage result:^(BOOL success, NSArray *listArray, NSUInteger currentPage, NSUInteger totalPage) {

        if (success) {
            _thisPage = currentPage;
            [_DataArr removeAllObjects];
            if (_thisPage == 1) {
                [_firstDataArr removeAllObjects];
                [_secondDataArr removeAllObjects];
                [_thirdDataArr removeAllObjects];
                [_fourthDataArr removeAllObjects];
                [_fifthDataArr removeAllObjects];
            }
            if (_nowStatus == HotelListStatusWaitReceive)
            {
                [_firstDataArr addObjectsFromArray:listArray];
                _DataArr = [_firstDataArr mutableCopy];
            }
            else if (_nowStatus == HotelListStatusBidding)
            {
                [_secondDataArr addObjectsFromArray:listArray];
                _DataArr = [_secondDataArr mutableCopy];
            }
            else if (_nowStatus == HotelListStatusUnSettle)
            {
                [_thirdDataArr addObjectsFromArray:listArray];
                _DataArr = [_thirdDataArr mutableCopy];
            }
            else if (_nowStatus == HotelListStatusAlreadySettle)
            {
                [_fourthDataArr addObjectsFromArray:listArray];
                _DataArr = [_fourthDataArr mutableCopy];
            }
            else if (_nowStatus == HotelListStatusOutOfDate)
            {
                [_fifthDataArr addObjectsFromArray:listArray];
                _DataArr = [_fifthDataArr mutableCopy];
            }
            
        }
        [_ReceiveListTableView reloadData];
        
        [_ReceiveListTableView.mj_footer endRefreshing];
        [_ReceiveListTableView.mj_header endRefreshing];
    }];
}

// 删除订单（已失效）
- (void)deleteAOrderWithChecklistID:(NSString *)CheckID index:(NSInteger )index
{
    [WLNetworkManager deleteAOrderWithChecklistID:CheckID result:^(BOOL success, BOOL result) {
        NSLog(@"==");
        if (success && result) {
            //[self GetNetData:_nowStatus];
            [_DataArr removeObjectAtIndex:index];
            [_ReceiveListTableView reloadData];
        }
    }];
}

//
- (void)modifyOrderStatusWithChecklistID:(NSString *)CheckID type:(HotelActionType)type index:(NSInteger )index remark:(NSString *)reStr
{
    [WLNetworkManager modifyOrderStatusWithChecklistID:CheckID actionType:type remark:reStr result:^(BOOL success, BOOL result, NSString *message) {
        if (success && result) {
            [[WL_TipAlert_View sharedAlert] createTip:@"操作成功"];
            //[self GetNetData:_nowStatus];
            [_DataArr removeObjectAtIndex:index];
            [_ReceiveListTableView reloadData];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:[NSString stringWithFormat:@"%@",message]];
        }
    }];
}

// 发报价
- (void)quoteTheOrderWithChecklistID:(WLHotelOrderInfo *)senderModel index:(NSInteger )index
{
    NSLog(@"==%@",senderModel);
    [WLNetworkManager quoteTheOrderWithChecklistID:senderModel.checkListID acceptSplit:senderModel.isSplitAccept price:senderModel.forcastPrice count:senderModel.forcastCount expiryDate:senderModel.dispatchExpiryDate result:^(BOOL success, BOOL result, NSString *message) {
        NSLog(@"message==%@",message);
        if (success && result) {
            [[WL_TipAlert_View sharedAlert] createTip:@"操作成功"];
            //[self GetNetData:_nowStatus];
            [_DataArr removeObjectAtIndex:index];
            [_ReceiveListTableView reloadData];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:[NSString stringWithFormat:@"%@",message]];
        }
    }];
}

#pragma mark - UITableView
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_DataArr.count == 0) {
        _noDataView.hidden = NO;
    }
    else
    {
        _noDataView.hidden = YES;
    }
    return _DataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isWaiting) {
        WLWaitingListCell *cell = [WLWaitingListCell cellCreateTableView:tableView];
        WLHotelOrderInfo  * modell = _DataArr[indexPath.row];

        //[cell setCellModel:modell];
        
        cell.modelInfo = modell;
        
        [cell wCClickAction:^(NSInteger wCNO) {
            [self wChatConnect];
        }];
        
        [cell iPhoneAction:^(NSInteger iPhoneNO) {
            [self callPhone:iPhoneNO];
        }];
        
        [cell sureBtnClickAction:^(WLHotelOrderInfo *StrrCIDM) {
            NSLog(@"确认==");
            
            if (modell.isBidding) {
                //发报价
                [self quoteTheOrderWithChecklistID:StrrCIDM index:indexPath.row];
            }
            else
            {
                //确认订单
                [self modifyOrderStatusWithChecklistID:StrrCIDM.checkListID type:HotelActionTypeReceiveOrder index:indexPath.row remark:@""];
            }
        }];
        
        [cell RefusedBtnClickAction:^(NSString *Strr) {
            //不接单
            //弹框
            [self refuseAction:Strr type:HotelActionTypeRejectOrder index:indexPath.row];
        }];
        
        __block WLReceiveListViewController *weakSelf = self;
        
        [cell ChooseDateClickAction:^{
            _dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
            _dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
                NSLog(@"%@", datetimeStr);
                //weakSelf.timeLbl.text = datetimeStr;
                modell.dispatchExpiryDate = [NSString stringWithFormat:@"%@:00",datetimeStr];
                [weakSelf.ReceiveListTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            
            if (_dateTimePickerView) {
                [self.view addSubview:_dateTimePickerView];
                [_dateTimePickerView showHcdDateTimePicker];
            }
        }];
        
        return cell;
    }
    else
    {
        WLBiddingListCell *cell = [WLBiddingListCell cellCreateTableView:tableView];
        WLHotelOrderInfo  * modell = _DataArr[indexPath.row];
        
        [cell setCellModel:modell Nstatus:_nowStatus];
        
        [cell wCClickAction:^(NSInteger wCNO) {
            [self wChatConnect];
        }];
        
        [cell iPhoneAction:^(NSInteger iPhoneNO) {
            [self callPhone:iPhoneNO];
        }];
        
        [cell qXBtnClickAction:^(NSString *xQID) {
            NSLog(@"取消==%@",xQID);
            if (_nowStatus == HotelListStatusOutOfDate) {
                // 删除订单
                [self deleteAOrderWithChecklistID:xQID index:indexPath.row];
            }
            else if (_nowStatus == HotelListStatusBidding)
            {
                [self refuseAction:xQID type:HotelActionTypeCancelQuote index:indexPath.row];
                //[self modifyOrderStatusWithChecklistID:xQID type:HotelActionTypeCancelQuote index:indexPath.row];
            }
            
        }];
        
        [cell closeVSopenClickAction:^(NSString *isopen) {
            NSLog(@"0000000==%@",isopen);
            modell.isOpen = isopen;
            //[_ReceiveListTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [_ReceiveListTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isWaiting) {
        WLHotelOrderInfo  * model = _DataArr[indexPath.row];
        
        if (model.isBidding) {
            return ScaleH(580);
        }
        else
        {
            return ScaleH(380);
        }
    }
    else
    {
        WLHotelOrderInfo  * model = _DataArr[indexPath.row];
        //NSLog(@"==%ld==%@",(long)indexPath.row,model.isOpen);
        if ([model.isOpen isEqualToString:@"1"]) {
            return ScaleH(230);
        }
        else if ([model.isOpen isEqualToString:@"0"])
        {
            if (model.isBidding) {
                return ScaleH(480);
            }
            else
            return ScaleH(360);
        }
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == self.dataSource.count - 1) {
//        return 0;
//    }
//    return ScaleH(15);
//}

- (void)callPhone:(NSInteger)pNO
{
    NSString *num = [[NSString alloc] initWithFormat:@"tel://%ld",(long)pNO];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

- (void)wChatConnect
{
    // 弹框提示
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"私信功能，敬请期待！！！"
                          delegate:self
                          cancelButtonTitle:@"知道了"
                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)refuseAction:(NSString *)CheckID type:(HotelActionType)type index:(NSInteger )index
{
    __weak __typeof__(self) weakSelf = self;
    WLHotelPopView *popView = [[WLHotelPopView alloc] initWithFrame:CGRectMake(0, 0, ScaleW(328), ScaleH(320))
                                                        placeholder:@"请输入取消报价原因"
                                                      submmitAction:^(NSString *remark) {
                                                          [weakSelf lew_dismissPopupViewWithanimation:weakSelf.lewPopupAnimation];
                                                          
                                                          [self modifyOrderStatusWithChecklistID:CheckID type:type index:index remark:remark];
                                                      }];
    [self lew_presentPopupView:popView animation:[LewPopupViewAnimationFade new] dismissed:nil];
}

#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _ReceiveListTableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
    // 取出键盘最终的frame
    CGRect rect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 取出键盘弹出需要花费的时间
    double duration = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改transform
    
    [UIView animateWithDuration:duration animations:^{

            [_ReceiveListTableView scrollRectToVisible:rect animated:YES];
    }];
    
    
}
#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    _ReceiveListTableView.contentInset = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
