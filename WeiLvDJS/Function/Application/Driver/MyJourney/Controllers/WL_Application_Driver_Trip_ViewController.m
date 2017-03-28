//
//  WL_Application_Driver_ Trip_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  [应用] --> [司机] --> [行程] 控制器

#import "WL_Application_Driver_Trip_ViewController.h"

#import "WHUCalendarView.h"

#import "WL_SetOrder_Cell.h"

#import "WL_Comment_Cell.h"

#import "WL_Trip_Cell.h"

#import "WL_Trip_Model.h"

#import "WL_Trip_OrderModel.h"

#import "WL_Trip_ScheduleModel.h"

#import "WL_NotSet_Cell.h"

#import "WHUCalendarCell.h"//日历cell

#import "WL_OrderDetail_ViewController.h"

#import "WL_Settlement_ViewController.h"

#import "WL_Application_Driver_OrderDetail_Guide_Model.h"

#import "WL_Application_Driver_OrderDetail_Dispatcher_Model.h"
@interface WL_Application_Driver_Trip_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    
    WHUCalendarView *calendarView;
    
    NSInteger reloadStatus;
    
    NSTimeInterval blockVal;
    
    NSString *currentYear;
    
    NSString *currentMonth;
    
}

@property(nonatomic,strong)UITableView *tripTableView;

@property(nonatomic,copy)NSString *yearAndMonth;

@property(nonatomic,strong)NSMutableArray *tripArray;

@property(nonatomic,strong)WL_Trip_ScheduleModel *scheduleModel;

@property(nonatomic,strong)WL_Trip_OrderModel *tripOrderModel;

@property(nonatomic,copy)NSString *dateString;

@property(nonatomic,strong)WHUCalendarCell *calendarCell;

@property(nonatomic,strong)WHUCalendarCell *lastCell;

@property(nonatomic,copy)NSString *orderType;//不接单类型

@property(nonatomic,strong)UIButton *saveButton;

@property(nonatomic,copy)NSString *judgeString;

@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Guide_Model *guideModel;

@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Dispatcher_Model *dispatcherModel;
@end

@implementation WL_Application_Driver_Trip_ViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(NSMutableArray *)tripArray
{
    
    if (_tripArray==nil) {
        
        _tripArray =[[NSMutableArray alloc]init];
    }
    return _tripArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Nav内容
    [self setupNav];
    
    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    //下面 显示空
    reloadStatus = 5;
    
    [self createCalendarView];
    
    if (self.someDate) {
        
        [calendarView clickSomeDayWith:self.someDate];
       
    }else
    {
        [calendarView clickTodayReload];
    }

    
  
}

-(void)NavigationLeftEvent
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [DEFAULTS removeObjectForKey:@"date"];
}

- (void)setupNav
{
    self.title = @"我的日程";
    
    self.view.backgroundColor =BgViewColor;
    
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
    
    NSTimeInterval val =0;
    
    if (self.someDate)
    {
  
       self.dateString = [NSString stringWithFormat:@"%@  %@",[self getDateStringFromNsdate:self.someDate],[self weekStringFromDate:self.someDate]];
        
        val = [self.someDate timeIntervalSince1970];
        
        blockVal = val;
        
    }else
    {
        val = [[NSDate date] timeIntervalSince1970];
        
        self.dateString = [NSString stringWithFormat:@"%@  %@",[self getDateStringFromNsdate:[NSDate date]],[self weekStringFromDate:[NSDate date]]];
        
        blockVal =val;
    }
    
    NSString *user_passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"dateTime":@(val)};
    WlLog(@"=-%@=",self.dateString);
    [self getScheduleOrderFromDateTime:paramaters];
    
}

#pragma mark ----今天点击事件
-(void)todayClick
{
    [calendarView backToCurrentMonth];
    
    [calendarView clickTodayReload];
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
//    
//    NSString *year = [NSString stringWithFormat:@"%ld",(long)dateComponent.year];
//    
//    currentYear = year;
//    
//    NSString *month =[NSString stringWithFormat:@"%ld",(long)dateComponent.month];
//    
//    currentMonth = month;
//    
//    NSString *user_passWord =[WLUserTools getUserPassword];
//    
//    //进行RSA加密后的密码字符串
//    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
//    
//    NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"year":year,@"month":month};
//    
//    [self initDateWith:paramaters];

}

#pragma mark ----创建日历页面

-(void)createCalendarView
{
    
    self.tripTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight-64-75)style:UITableViewStyleGrouped];
    
    self.tripTableView.backgroundColor = BgViewColor;
    
    self.tripTableView.showsVerticalScrollIndicator =NO;

    self.tripTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tripTableView.scrollEnabled =YES;
    
    self.tripTableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
    
    self.tripTableView.delegate =self;
    
    self.tripTableView.dataSource =self;
    
    [self.view addSubview:self.tripTableView];
    
    calendarView=[[WHUCalendarView alloc]init];
    
    //由消息首页向出团日程的跳转时
    if (self.someDate) {
        
        calendarView.someDate = self.someDate;
      
    }
    
    [calendarView setFrame:CGRectMake(0, 0, ScreenWidth, 380)];
    
    
     [self.tripTableView setTableHeaderView:calendarView];
   
    __weak WHUCalendarView *weak = calendarView;
   
    WS(weakSelf);
    
    calendarView.onDateSelectBlk =^(NSDate *date,WHUCalendarCell *cell)
    {
        
        weakSelf.calendarCell =cell;
        
        weakSelf.dateString =[NSString stringWithFormat:@"%@  %@",[weakSelf getDateStringFromNsdate:date],[weakSelf weekStringFromDate:date]];
        
        NSTimeInterval val =[date timeIntervalSince1970];
        
        blockVal = val;

        NSString *user_passWord =[WLUserTools getUserPassword];
        
        //进行RSA加密后的密码字符串
        NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
        
        NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"dateTime":@(val)};
        
        
        [weakSelf getScheduleOrderFromDateTime:paramaters];
    };
    
    calendarView.changeFrame = ^(CGFloat height,NSDictionary *dict)
    {
        weak.height = height;
    
        [weakSelf.tripTableView setTableHeaderView:weak];
        
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
        
        NSString *user_passWord =[WLUserTools getUserPassword];
        
        //进行RSA加密后的密码字符串
        NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
        
        NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"year":year,@"month":month};
        
        [weakSelf initDateWith:paramaters];
    };
    

    self.saveButton = [UIButton new];
    
    [self.saveButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    self.saveButton.layer.cornerRadius = 3.0;
    
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.saveButton];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.centerX.mas_equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-90, 45));
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-15);
        
    }];
}
//根据date获取 周几
-(NSString *)weekStringFromDate:(NSDate *)date
{
    NSArray *array =@[@"",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit calendarUit =NSCalendarUnitWeekday;
    
    NSDateComponents *components =[calendar components:calendarUit fromDate:date];
    
    return [array objectAtIndex:components.weekday];
}

-(NSString *)getDateStringFromNsdate:(NSDate *)date

{
    NSDateFormatter *formate =[[NSDateFormatter alloc]init];
    
    [formate setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *string =[formate stringFromDate:date];
    
    return  string;
}

-(void)getScheduleOrderFromDateTime:(NSDictionary *)dic
{
    [self showHud];
    
     WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:DriverGetScheduleOrder RequestType:RequestTypePost Parameters:dic Success:^(id responseObject) {
        
        
        
        [weakSelf hidHud];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status integerValue]==1) {
            
            self.tripOrderModel =[WL_Trip_OrderModel mj_objectWithKeyValues:network_Model.data[@"order"]];
            
            self.scheduleModel = [WL_Trip_ScheduleModel mj_objectWithKeyValues:network_Model.data[@"Schedule"]];
            
            
            self.guideModel = [WL_Application_Driver_OrderDetail_Guide_Model mj_objectWithKeyValues:network_Model.data[@"guide"]];
            
            
            self.dispatcherModel = [WL_Application_Driver_OrderDetail_Dispatcher_Model mj_objectWithKeyValues:network_Model.data[@"dispatcher"]];
            
            self.judgeString  = self.scheduleModel.status;
        }else
            
        {
           
            [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
            
        }
        
       // [QXBModelTool createJsonModelWithDictionary:network_Model.data[@"order"] modelName:@"123"];
    
        if (self.tripOrderModel) {
            
            reloadStatus = 1;
            
            self.orderType = @"3";
            
        }else
        {
            
            if ([self.scheduleModel.status integerValue]==0)
            {
                
                if (blockVal <[[NSDate date]timeIntervalSince1970])
                {
                    
                    reloadStatus = 4; //什么也没有 请假
                    
                }else
                {
                    reloadStatus = 2;//显示是否接单
                }
                
            }
        
            if ([self.scheduleModel.status integerValue]==1)
            {
                reloadStatus = 2;//显示是否接单
            }
            
            if ([self.scheduleModel.is_type isEqualToString:@"2"])
            {
                reloadStatus = 2;//显示是否接单
            
            }else if([self.scheduleModel.is_type isEqualToString:@"1"])
            {
                
                if (self.scheduleModel.status &&[self.scheduleModel.status integerValue]==0) {
                    reloadStatus = 4;//什么也没有 请假
                }else
                {
                    reloadStatus =3;//无任何行程信息
                }
                
            }
        }
    
        [weakSelf.tripTableView reloadData];
        
    
        if (reloadStatus == 3||reloadStatus == 4) {
            
            self.saveButton.hidden =YES;
            
            self.tripTableView.height = ScreenHeight-64;
            
        }else
            
        {
            self.saveButton.hidden =NO;
            
            self.tripTableView.height = ScreenHeight-64-75;
        }
    } Failure:^(NSError *error) {
       
        [[WL_TipAlert_View sharedAlert]createTip:@"获取详情信息失败"];
        
        [weakSelf hidHud];
    }];
}
#pragma mark ---网络请求
-(void)initDateWith:(NSDictionary *)dict

{
    
    WS(weakSelf);
    
    [self showHud];
    
    [self.tripArray removeAllObjects];
    
    [[WLHttpManager shareManager]requestWithURL:DriverGetScheduleUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {

         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];

        if ([network_Model.status integerValue]==1) {
            
            for (NSDictionary *di in network_Model.data) {
                
                WL_Trip_Model *model =[WL_Trip_Model mj_objectWithKeyValues:di];
                
                [weakSelf.tripArray addObject:model];
                
            }
            
            calendarView.tripArray = weakSelf.tripArray;
            
           
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
        }
        
       
       [weakSelf hidHud];
        
    } Failure:^(NSError *error) {
        
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
       
            static NSString *reuseIdentifier1 = @"reuseIdentifier1";
            
            WL_Trip_Cell *cell1 =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
            
            if (cell1==nil) {
                
                cell1 =[[WL_Trip_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier1];
                
                cell1.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            
            cell1.dateLabel.text = self.dateString;
            
            cell1.guide_Model =self.guideModel;
            
            cell1.dispatcher_Model =self.dispatcherModel;

            
            cell1.orderModel = self.tripOrderModel;
            
            
            cell1.scheduleModel = self.scheduleModel;
            
            [cell1.startButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell1;

        }else if(reloadStatus ==2)
        {
        
        static NSString *reuseIdentifier0 = @"reuseIdentifier0";
        
        WL_SetOrder_Cell *cell0 =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier0];
        
        if (cell0==nil) {
            
            cell0 =[[WL_SetOrder_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier0];
            
            cell0.selectionStyle =UITableViewCellSelectionStyleNone;
        }
      
         cell0.dateLabel.text = self.dateString;
            
            if ([self.judgeString isEqualToString:@"0"]) {
                
                cell0.orderButton.selected =NO;
                
                cell0.rejectButton.selected =YES;
                
                self.orderType =@"2";
                
            }else{
                
                cell0.orderButton.selected =YES;
                
                cell0.rejectButton.selected =NO;
                
                self.orderType = @"1";
            }
            
    
        WS(weakSelf);
            
          //接单  不接单 按钮点击
        cell0.rejectAndOrderButton = ^(NSString *type){
           
            if ([type isEqualToString:@"reject"])
            {
                if (weakSelf.lastCell.isLeave) {
                   
                    weakSelf.lastCell.lbl.textColor =[WLTools stringToColor:@"#4cd661"];
                    weakSelf.calendarCell.lbl.textColor = [WLTools stringToColor:@"#4cd661"];
                    
                    weakSelf.lastCell = weakSelf.calendarCell;
                    
                    weakSelf.orderType =@"2";
                    
                    weakSelf.judgeString = @"0";
                    
                }else
                {
                
                weakSelf.lastCell.lbl.textColor = [UIColor grayColor];
                
                weakSelf.calendarCell.lbl.textColor = [WLTools stringToColor:@"#4cd661"];
                
                weakSelf.lastCell = weakSelf.calendarCell;
                
                weakSelf.orderType =@"2";
                    
               weakSelf.judgeString = @"0";
                }
        
            }else if ([type isEqualToString:@"order"])
            {
                
               weakSelf.orderType = @"1";
                
              weakSelf.judgeString = @"5";//(else区别于0)
            }
            
        };
            
         return cell0;
            
            
    }else if (reloadStatus==3||reloadStatus==4)
        
    {
        
        static NSString *reuseIdentifier3 = @"reuseIdentifier3";
        
        WL_NotSet_Cell *cell3 =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier3];
        
        if (cell3==nil) {
            
            cell3 =[[WL_NotSet_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier3];
            
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
        
        WL_Comment_Cell *cell10 =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier10];
        
        if (cell10==nil) {
            
            cell10 =[[WL_Comment_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier10];
            
            cell10.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        
        cell10.commentTextView.text = self.scheduleModel.remark;
        
        cell10.placeHoderLabel.hidden = cell10.commentTextView.text.length>0 ? YES : NO;
        
        return cell10;
        
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell =[self.tripTableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[WL_Trip_Cell class]]) {
        
    
        WL_OrderDetail_ViewController *VC =[[WL_OrderDetail_ViewController alloc]init];
        
        WS(weakSelf);
        
        VC.popReloadBlock =^()
        {
            
            NSString *user_passWord =[WLUserTools getUserPassword];
            
            //进行RSA加密后的密码字符串
            NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
            
            NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"dateTime":@(blockVal)};
            
            
            [weakSelf getScheduleOrderFromDateTime:paramaters];
            
            
            NSDictionary *paramaters2 =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"year":currentYear,@"month":currentMonth};
            
            
            [weakSelf initDateWith:paramaters2];
            
        };
    
        VC.model =self.tripOrderModel;
        
        VC.timeInterval = blockVal;
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
}

#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tripTableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
    CGRect rect =[self.tripTableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    [self.tripTableView scrollRectToVisible:rect animated:YES];
   
    
}
#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    self.tripTableView.contentInset = UIEdgeInsetsZero;
}

-(void)saveButtonClick
{
    
    if (blockVal==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"您还没选择要保存的日程"];
        
        return;
    }
    
    if (reloadStatus ==2 && self.calendarCell.isLeave==NO && [self.orderType isEqualToString:@"1"])
    {
        
       // [[WL_TipAlert_View sharedAlert]createTip:@"当前已是接单状态"];
        
       //return;
        
    }
    
    [self UpdateSchedule:self.orderType];
}

-(void)startButtonClick:(UIButton *)button

{
    if ([button.currentTitle isEqualToString:@"出发"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出发前,请与导游共同核对上车人数"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                              
                              
                                              otherButtonTitles:@"确认出发", nil];
        alert.tag =1001;
        
        
        [alert show];
        
        
    }else if ([button.currentTitle isEqualToString:@"结束"])
    {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请确保您已经将该团送达了目的地,是否结算并结束行程？"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                              
                              
                                              otherButtonTitles:@"结算", nil];
        alert.tag =1002;
        
        
        [alert show];
        
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    if (alertView.tag==1001) {
      
        if (buttonIndex ==0)
        {
            
        }else if (buttonIndex==1)
            
        {
            [self updateTripStatus];
            
        }

        
    }else if (alertView.tag==1002)
    {
      
        if (buttonIndex ==0)
        {
            
        }else if (buttonIndex==1)
            
        {
            WL_Settlement_ViewController *VC =[[WL_Settlement_ViewController alloc]init];
            
            WS(weakSelf);
            
            VC.popBlock = ^(NSString *sj_order_id)
            {
                
                NSString *user_passWord =[WLUserTools getUserPassword];
                
                //进行RSA加密后的密码字符串
                NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
                
                NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"dateTime":@(blockVal)};
                
                
                [weakSelf getScheduleOrderFromDateTime:paramaters];
                
                
                NSDictionary *paramaters2 =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"year":currentYear,@"month":currentMonth};
                [weakSelf initDateWith:paramaters2];
                
            };
            
            VC.sj_order_id = self.tripOrderModel.sj_order_id;
            
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
        

            
        }

}
//开始按钮点击
-(void)updateTripStatus

{
    
    NSString *user_passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"sj_order_id":self.tripOrderModel.sj_order_id,@"order_status_type":@"2",@"remark":@"",@"status":@"2"};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:DriverOrderUpdateOrderUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        
        if ([responseObject[@"status"] integerValue]==1)
        {
            
            NSString *user_passWord =[WLUserTools getUserPassword];
            
            //进行RSA加密后的密码字符串
            NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
            
            NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"dateTime":@(blockVal)};
            
            
            [weakSelf getScheduleOrderFromDateTime:paramaters];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:responseObject[@"msg"]];
        }
        
    } Failure:^(NSError *error) {
        
        
        [[WL_TipAlert_View sharedAlert]createTip:@"设置失败"];
    }];

}

-(void)UpdateSchedule:(NSString *)type

{
    
    WL_Comment_Cell *Comment_Cell =[self.tripTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    
    NSString *user_passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"start_time":@(blockVal),@"type":self.orderType,@"remark":Comment_Cell.commentTextView.text.length>0 ? Comment_Cell.commentTextView.text :@"",@"schedule_id":self.scheduleModel.schedule_id ? self.scheduleModel.schedule_id : @""};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:DriverUpdateScheduleUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        
        if ([responseObject[@"status"] integerValue]==1)
        {
            
            [[WL_TipAlert_View sharedAlert]createTip:responseObject[@"msg"]];
            
            NSString *user_passWord =[WLUserTools getUserPassword];
            
            //进行RSA加密后的密码字符串
            NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
            
            NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"dateTime":@(blockVal)};
            
            [weakSelf getScheduleOrderFromDateTime:paramaters];
            
            
            NSDictionary *paramaters2 =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"year":currentYear,@"month":currentMonth};
            [weakSelf initDateWith:paramaters2];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:responseObject[@"msg"]];
        }
    
    } Failure:^(NSError *error) {
      
        
         [[WL_TipAlert_View sharedAlert]createTip:@"设置失败"];
    }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   
}

@end
