//
//  WLScheduleListViewController.m
//  WeiLvDJS
//
//  Created by xiaobai2268 on 2016/10/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLScheduleListViewController.h"

// 日历
#import "WHUCalendarView.h"

// 顶部
#import "WLSetOrderCellTableViewCell.h"

// 有数据
#import "WLTripCell.h"

// 备注
#import "WLCommentCell.h"

// 没有行程
#import "WLNoSetCell.h"

#import "WLOrderListInfo.h"

#import "WLTripModel.h"

// 接口
#import "WLNetworkManager.h"

#import "WLMyScheduleInfo.h"

#import "WLCurrentGroupController.h"

@interface WLScheduleListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    WHUCalendarView * calendarView;
    
    NSInteger reloadStatus;
    
    NSString * chooseDate; // 保存当前选择日期
    
    NSString *currentYear;
    
    NSString *currentMonth;
    
    NSString *currentday;
    
    NSTimeInterval iSReducedTime;
}

@property (nonatomic, strong) UITableView * dateTripTableView;

@property (nonatomic, copy) NSString * yearAndMonth;

@property(nonatomic, strong) NSMutableArray * tripArray;

@property(nonatomic,strong) WLOrderListInfo * tripOrderModel;

@property (nonatomic, strong) WHUCalendarCell * calendarCell;

@property (nonatomic, copy) NSString * dateString;

@property (nonatomic, assign) BOOL orderType;
@property (nonatomic, assign) BOOL iSjudge;

@property (nonatomic, copy) NSString * showRemark;

@property (nonatomic, strong) UIButton * saveButton;

@property(nonatomic,strong)WHUCalendarCell *lastCell; //是否接单的颜色变换

@end

@implementation WLScheduleListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //下面 显示空
    reloadStatus = 5;
    
    // 设置Nav内容
    [self setNav];
    
    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 创建日历表格
    [self createCalendarView];
 
    //由消息首页向出团日程的跳转时
    if (self.someDate) {
        
        [calendarView clickSomeDayWith:self.someDate];
        
        //[calendarView reloadSomeMonthWith:self.someDate];
        
       // calendarView.currentDate = self.someDate;
    }else
    {
       [calendarView clickTodayReload];
    }
}

- (void)setNav
{
    self.title = @"我的日程";
    
    self.view.backgroundColor = BgViewColor;
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    
    button.layer.borderWidth = 1.0;
    
    button.layer.cornerRadius = 10.0;
    
    button.layer.masksToBounds =YES;
    
    [button addTarget:self action:@selector(todayClick) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = systemFont(12);
    
    [button setTitle:@"今" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -10;
    //将两个BarButtonItem都返回给NavigationItem
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightBarBtn];
    
    //由消息首页向出团日程的跳转时
    if (self.someDate) {
        
        self.dateString = [NSString stringWithFormat:@"%@  %@",[self getDateStringFromNsdate:self.someDate],[self weekStringFromDate:self.someDate]];
        
        [self getScheduleOrderFromDate:[self getDateStringFromNsdate:self.someDate] IsallDate:YES groupID:@""];
        
        chooseDate = [self getDateStringFromNsdate:self.someDate]; // 没有点击，获取当天
        
        
    }else
    {
        // 点击跳到当前日期(并不)
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        //NSDate* date=[format dateFromString:[DEFAULTS objectForKey:@"date"]];
        
        self.dateString = [NSString stringWithFormat:@"%@  %@",[self getDateStringFromNsdate:[NSDate date]],[self weekStringFromDate:[NSDate date]]];
        
        [self getScheduleOrderFromDate:[self getDateStringFromNsdate:[NSDate date]] IsallDate:YES groupID:@""];
        
        chooseDate = [self getDateStringFromNsdate:[NSDate date]]; // 没有点击，获取当天
    }
    
}

#pragma mark ----今天点击事件
-(void)todayClick
{
    [calendarView backToCurrentMonth];
    [calendarView clickTodayReload];
}

-(NSMutableArray *)tripArray
{
    
    if (_tripArray==nil) {
        
        _tripArray =[[NSMutableArray alloc]init];
    }
    return _tripArray;
}

#pragma mark ----创建日历表格
-(void)createCalendarView
{
    self.dateTripTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-75) style:UITableViewStyleGrouped];
    
    self.dateTripTableView.backgroundColor = BgViewColor;
    
    self.dateTripTableView.showsVerticalScrollIndicator =NO;
    
    self.dateTripTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dateTripTableView.scrollEnabled =YES;
    
    self.dateTripTableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
    
    self.dateTripTableView.delegate =self;
    
    self.dateTripTableView.dataSource =self;
    
    [self.view addSubview:self.dateTripTableView];
    
    calendarView=[[WHUCalendarView alloc]init];
    
    //由消息首页向出团日程的跳转时
    if (self.someDate) {
        
        calendarView.someDate = self.someDate;
        
        //calendarView.currentDate = [NSDate date];
    }
    
    [calendarView setFrame:CGRectMake(0, 0, ScreenWidth, 380)];
    
    
    [self.dateTripTableView setTableHeaderView:calendarView];
    
    __weak WHUCalendarView *weak = calendarView;
    
    WS(weakSelf);
    
    // 点击某一天对应数据
    calendarView.onDateSelectBlk =^(NSDate *date,WHUCalendarCell *cell)
    {
        weakSelf.calendarCell =cell;
        
        weakSelf.dateString =[NSString stringWithFormat:@"%@  %@",[weakSelf getDateStringFromNsdate:date],[weakSelf weekStringFromDate:date]];
        
        chooseDate = [weakSelf getDateStringFromNsdate:date];
        
        iSReducedTime = [date timeIntervalSince1970];
        
        [weakSelf getScheduleOrderFromDate:[weakSelf getDateStringFromNsdate:date] IsallDate:NO groupID:@""];
    };
    
    calendarView.changeFrame = ^(CGFloat height,NSDictionary *dict)
    {
        weak.height = height;
        
        [weakSelf.dateTripTableView setTableHeaderView:weak];
        
        weakSelf.yearAndMonth = dict[@"monthStr"];
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"yyyy年MM月"];
        
        NSDate *dat =[formatter dateFromString:weakSelf.yearAndMonth];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:dat];
        
        NSString *year = [NSString stringWithFormat:@"%ld",(long)dateComponent.year];
        
        currentYear = year;
        
        NSString *month =[NSString stringWithFormat:@"%ld",(long)dateComponent.month];
        
        currentMonth = month;
        
        NSString *day =[NSString stringWithFormat:@"%ld",(long)dateComponent.day];
        
        currentday = day;
        
        // 请求数据
        [weakSelf initDateWith:[NSString stringWithFormat:@"%@-%@-%@",year,month,day] IsallDate:YES groupID:@""];
    };
    
    
    self.saveButton = [UIButton new];
    
    [self.saveButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    self.saveButton.layer.cornerRadius = 3.0;
    
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.saveButton.hidden = YES;
    
    [self.view addSubview:self.saveButton];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-90, 45));
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-15);
        
    }];
    
    [weakSelf hidHud];
}

//根据date获取 周几
-(NSString *)weekStringFromDate:(NSDate *)date
{
    NSArray *array =@[@"",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit calendarUit =NSCalendarUnitWeekday;
    
    NSDateComponents *components =[calendar components:calendarUit fromDate:date];
    
    return [array objectAtIndex:components.weekday];
}

-(NSString *)getDateStringFromNsdate:(NSDate *)date

{
    NSDateFormatter *formate =[[NSDateFormatter alloc]init];
    
    [formate setDateFormat:@"yyyy-MM-dd"];
    
    NSString *string =[formate stringFromDate:date];
    
    return  string;
}

#pragma mark ---获取单个日期
-(void)getScheduleOrderFromDate:(NSString *)dateStr IsallDate:(BOOL)allDate groupID:(NSString *)groupID
{
    [self showHud];
    
    WS(weakSelf);
    
    [WLNetworkManager requestMyScheduleWithSelectDate:dateStr allDate:allDate groupID:groupID result:^(BOOL success, WLMyScheduleInfo *scheduleInfo) {
        
        _showRemark = scheduleInfo.remark;
        
        if (scheduleInfo.allSchedule.count != 0) {
            
            //
        }
        else
        {
            //
        }
        
        if (scheduleInfo.groupList.count == 0)
        {
            if ([[self getDateStringFromNsdate:[NSDate date]] isEqualToString:chooseDate]) {
                reloadStatus =2;//显示是否接单
                if ([scheduleInfo.status isEqualToString:@"0"]) {
                    _iSjudge = YES;
                }
                else
                {
                    _iSjudge = NO;
                }
            }
            else if (iSReducedTime < [[NSDate date] timeIntervalSince1970]) {
                reloadStatus =3;//无任何行程信息
            }
            else
            {
                reloadStatus =2;//显示是否接单
                if ([scheduleInfo.status isEqualToString:@"0"]) {
                    _iSjudge = YES;
                }
                else
                {
                    _iSjudge = NO;
                }
            }
        }
        else
        {
            reloadStatus =1;//行程信息
            // 设置数据
            for (WLOrderListInfo * orderModel in scheduleInfo.groupList) {

                _tripOrderModel = [WLOrderListInfo mj_objectWithKeyValues:orderModel];
            }
        }
        
        [weakSelf.dateTripTableView reloadData];
        
        [weakSelf hidHud];
    }];
    
    if (reloadStatus == 3||reloadStatus == 4) {
        
        self.saveButton.hidden =YES;
        
        self.dateTripTableView.height = ScreenHeight-64;
        
    }else
        
    {
        self.saveButton.hidden =NO;
        
        self.dateTripTableView.height = ScreenHeight-64-75;
    }
    /*
    NSLog(@"chooseDate==%@",chooseDate);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.dateTripTableView reloadData];
    });
     */
}

#pragma mark ---网络请求
-(void)initDateWith:(NSString *)dateStr IsallDate:(BOOL)allDate groupID:(NSString *)groupID

{
    
    WS(weakSelf);
    
    [self showHud];
    
    [self.tripArray removeAllObjects];

    [WLNetworkManager requestMyScheduleWithSelectDate:dateStr allDate:allDate groupID:groupID result:^(BOOL success, WLMyScheduleInfo *scheduleInfo) {
        
        //NSLog(@"success==%@",scheduleInfo);

        if (scheduleInfo.allSchedule.count != 0) {
                
            for (WLMySchedule * Smodel in scheduleInfo.allSchedule) {

                WLTripModel *model = [[WLTripModel alloc] init];
                
                model.start_time = Smodel.startTime;
                model.end_time = Smodel.endTime;
                model.status = [NSString stringWithFormat:@"%i",Smodel.receiveVisitors]; // 是否接单
                model.relation_order_id = Smodel.checklistID;
                model.trip_status = [NSString stringWithFormat:@"%lu",(unsigned long)Smodel.journeyStatus]; // 出团状态（1待出团，2出团中，3已下团）

                [weakSelf.tripArray addObject:model];
            }
        }
        else
        {
            //
        }
        calendarView.tripArray = weakSelf.tripArray;
     
        [weakSelf hidHud];
    }];
    
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView

{
    if (reloadStatus ==5) {
        
        return 0;
        
    }else if (reloadStatus ==3||reloadStatus ==4) {
        
        return 1;
    }
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (reloadStatus ==5) {
        
        return 0;
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        
        return 10;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01;//把高度设置很小，效果可以看成footer的高度等于0
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section==0) {
        
        if (reloadStatus ==5) {
            
            return 0;
        }else if (reloadStatus ==1) {
            
            return 200;
            
        }else if(reloadStatus ==3 ||reloadStatus ==4)
            
        {
            return 200;
            
        }else if (reloadStatus ==2)
        {
            
            return 125;
        }
        
    }else if (indexPath.section==1)
        
    {
        return 150;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section==0) {
        
        if (reloadStatus ==1) {
            self.saveButton.hidden = NO;
            static NSString *reuseIdentifier1 = @"reuseIdentifier1";
            
            WLTripCell *cell1 =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
            
            if (cell1==nil) {
                
                cell1 =[[WLTripCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier1];
                
                cell1.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            
            cell1.dateLabel.text = self.dateString;
            
            cell1.orderModel = self.tripOrderModel; //数据
            cell1.startButton.tag = indexPath.row;
            [cell1.startButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell1;
            
        }else if(reloadStatus ==2)
        {
            self.saveButton.hidden = NO;
            static NSString *reuseIdentifier0 = @"reuseIdentifier0";
            
            WLSetOrderCellTableViewCell *cell0 =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier0];
            
            if (cell0==nil) {
                
                cell0 =[[WLSetOrderCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier0];
                
                cell0.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            
            cell0.dateLabel.text = self.dateString;
            
            // 数据
            if (_iSjudge == YES) {
                
                cell0.orderButton.selected =NO;
                
                cell0.rejectButton.selected =YES;
                
                _orderType = NO;
                
            }else{
                
                cell0.orderButton.selected =YES;
                
                cell0.rejectButton.selected =NO;
                
                _orderType = YES;
            }
            
            
            WS(weakSelf);
            
            //接单  不接单 按钮点击
            cell0.rejectAndOrderButton = ^(NSString *type){
                
                if ([type isEqualToString:@"reject"])
                {
                    if (weakSelf.lastCell.isLeave)
                    {
                        weakSelf.lastCell.lbl.textColor =[WLTools stringToColor:@"#4cd661"];
                    }else
                    {
                        weakSelf.lastCell.lbl.textColor = [UIColor grayColor];
                    }
                    
                    weakSelf.calendarCell.lbl.textColor = [WLTools stringToColor:@"#4cd661"];
                    
                    weakSelf.lastCell = weakSelf.calendarCell;
                    
                    _iSjudge = YES;
                    _orderType = NO;
                    
                }else if ([type isEqualToString:@"order"])
                {
                    
                    weakSelf.lastCell.lbl.textColor = [UIColor grayColor];
                    
                    _orderType = YES;
                    
                    _iSjudge = NO;
                }
                
            };
            
            return cell0;
            
            
        }else if (reloadStatus==3||reloadStatus==4)
            
        {
            self.saveButton.hidden =YES;
            static NSString *reuseIdentifier3 = @"reuseIdentifier3";
            
            WLNoSetCell *cell3 =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier3];
            
            if (cell3==nil) {
                
                cell3 =[[WLNoSetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier3];
                
                cell3.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            
            
            if (reloadStatus==3)
            {
                cell3.noLabel.text =@"无任何行程信息";
                
            }else if (reloadStatus==4)
            {
                cell3.noLabel.text =@"请假,无任何行程信息";
            }
            
            return cell3;
            
            
        }else if (reloadStatus==5)
        {
            return nil;
        }
    }else if (indexPath.section ==1)
    {
        
        static NSString *reuseIdentifier10 = @"reuseIdentifier10";
        
        WLCommentCell *cell10 =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier10];
        
        if (cell10==nil) {
            
            cell10 =[[WLCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier10];
            
            cell10.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        
        cell10.commentTextView.text = _showRemark; // 数据
        
        cell10.placeHoderLabel.hidden = cell10.commentTextView.text.length>0 ? YES : NO;
        
        return cell10;
        
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    WLCurrentGroupController *groupVC = [[WLCurrentGroupController alloc] init];
    [groupVC setupGroupListID:self.tripOrderModel.groupListID];
    [self.navigationController pushViewController:groupVC animated:YES];
}

// 点击了出团操作
-(void)startButtonClick:(UIButton *)button
{
    NSInteger thisStatus;
    
    if (self.tripOrderModel.journeyStatus == 1) {
        thisStatus = 1; // 出团
    }
    else if (self.tripOrderModel.journeyStatus == 2)
    {
        thisStatus = 0; // 结束团
    }
    else
    {
        //self.tripOrderModel.journeyStatus == 3; // 已下团
        return;
    }
    
    [WLNetworkManager modifyGroupStatusWithChecklistID:[NSString stringWithFormat:@"%@",self.tripOrderModel.checkListID] status:thisStatus result:^(BOOL success, BOOL result, NSString *message) {
        NSLog(@"点击出团==%i==%i",success,result);
        
        if (success == YES) {
            [[WL_TipAlert_View sharedAlert] createTip:message];
            if (result) {
                self.tripOrderModel.journeyStatus = 2;
                WLTripCell *cell = (WLTripCell *)[self.dateTripTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0]];
                cell.orderModel = self.tripOrderModel;
                
                [self getScheduleOrderFromDate:chooseDate IsallDate:NO groupID:@""];
            }
            
        }
    }];
    
    
}

// 点击保存操作
-(void)saveButtonClick
{
    if (chooseDate == nil) {
        [[WL_TipAlert_View sharedAlert]createTip:@"您还没选择要保存的日程"];
        return;
    }
    
    WLCommentCell *Comment_Cell =[self.dateTripTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    [WLNetworkManager setMyScheduleWithSelectDate:chooseDate receiveVisitors:_orderType remark:[NSString stringWithFormat:@"%@",(Comment_Cell.commentTextView.text.length>0 ? Comment_Cell.commentTextView.text:@"")] result:^(BOOL success, BOOL result) {
        
        if (success == YES && result == YES) {
            [self getScheduleOrderFromDate:chooseDate IsallDate:NO groupID:@""];
            [self initDateWith:[NSString stringWithFormat:@"%@-%@-%@",currentYear,currentMonth,currentday] IsallDate:YES groupID:@""];
        }
    }];
}

#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.dateTripTableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
    CGRect rect =[self.dateTripTableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    [self.dateTripTableView scrollRectToVisible:rect animated:YES];
}

#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    self.dateTripTableView.contentInset = UIEdgeInsetsZero;
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
