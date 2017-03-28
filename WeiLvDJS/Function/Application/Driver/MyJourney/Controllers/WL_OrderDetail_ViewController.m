//
//  WL_OrderDetail_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_OrderDetail_ViewController.h"

#import "WL_Application_Driver_OrderDetail_Model.h"

#import "WL_Application_Driver_Order_OrderDetail_TopView.h"

#import "WL_Application_Driver_Order_WaitOrderDetail_Cell.h"


#import "WL_OrderStatus_View.h"

#import "WL_OrderDetail_BottomThreeView.h"

#import "WL_OrderDetail_BottomTwoView.h"

#import "WL_PayDetail_Cell.h"

#import "WL_TwicePay_ViewController.h"

#import "WL_Pop_CallWindow.h"

#import "WL_Settlement_ViewController.h"

#import "WL_Application_Driver_OrderDetail_Guide_Model.h"

#import "WL_Application_Driver_OrderDetail_Dispatcher_Model.h"

#import "WL_Application_Driver_OrderDetail_PayRecord_Model.h"

#import "WL_Warning_Window.h"

@interface WL_OrderDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>


@property(nonatomic, strong)WL_Application_Driver_OrderDetail_Model *orderDetailModel;

@property(nonatomic, strong)WL_TipAlert_View *alert;

@property(nonatomic,strong)WL_Pop_CallWindow *CallWindow;

@property(nonatomic,strong)WL_Warning_Window *warningWindow;


@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Dispatcher_Model *dispatcherModel;
@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Guide_Model *guideModel;
@property(nonatomic,copy)NSString *sj_order_id;

@end

@implementation WL_OrderDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title =@"订单详情";
    
    self.view.backgroundColor = BgViewColor;
    
    self.sj_order_id =self.model.sj_order_id;
    
    //发送订单详情网络请求
    [self sendRequestToAcceptOrderDetail];
    //注册弹框
    [self creatTipAlertView];
}


#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

-(void)NavigationLeftEvent

{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.popReloadBlock) {
        
        self.popReloadBlock();
        
    }
}



#pragma mark - 发送订单详情网络请求
- (void)sendRequestToAcceptOrderDetail
{
    //请求Url
    NSString *urlStr = DriverOrderDetailUrl;

    //请求参数
    //司机id
    NSString *driver_id = [WLUserTools getUserId];
    //用户密码
    NSString *user_password = [WLUserTools getUserPassword];
    //RSA加密
    NSString *encriptString = [MyRSA encryptString:user_password publicKey:RSAKey];
    //请求参数集合
    NSDictionary *params = @{
                             @"driver_id" : driver_id,
                             @"user_password" : encriptString,
                             @"sj_order_id" : self.sj_order_id};
    
    WS(weakSelf);
    //显示菊花
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        //服务器返回数据失败
        if (![model.status isEqualToString:@"1"])
        {
            //弹框错误信息
            [weakSelf.alert createTip:model.msg];
            //隐藏菊花
            [weakSelf hidHud];
            return;
        }
        //将返回的订单详情数据转换为订单详情模型
        WL_Application_Driver_OrderDetail_Model *orderDetailModel = [WL_Application_Driver_OrderDetail_Model mj_objectWithKeyValues:model.data];
        
        self.guideModel = [WL_Application_Driver_OrderDetail_Guide_Model mj_objectWithKeyValues:orderDetailModel.guide];
        if (orderDetailModel.guide == nil) {
           
            
        } else
        {
            
        }
        self.dispatcherModel = [WL_Application_Driver_OrderDetail_Dispatcher_Model mj_objectWithKeyValues:orderDetailModel.dispatcher];

        weakSelf.orderDetailModel = orderDetailModel;
        //设置内容
        [weakSelf setupAcceptOrderDetailToContent];
        
        [weakSelf hidHud];
    
    } Failure:^(NSError *error) {
        
         [weakSelf hidHud];
     }];
 }

-(WL_Pop_CallWindow *)CallWindow
{
    
    if (_CallWindow==nil) {
        
        _CallWindow =[[WL_Pop_CallWindow alloc]init];
        
        [_CallWindow setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
    }
    return _CallWindow;
}

-(WL_Warning_Window *)warningWindow
{
    if (_warningWindow==nil) {
        
        _warningWindow =[[WL_Warning_Window alloc]init];
        
        [_warningWindow setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _warningWindow;

}

#pragma mark - 设置页面内容
static NSString *const cellId = @"cellId";
static NSString *const acceptCellId = @"acceptCellId";
static NSString *const remarkCell = @"remarkCell";
- (void)setupAcceptOrderDetailToContent
{
    
   //已结束状态下 创建的底部试图
    
    if ([self.orderDetailModel.trip_status isEqualToString:@"3"]) {
      
        WL_OrderDetail_BottomTwoView *bottomView = [[WL_OrderDetail_BottomTwoView alloc] init];
        
        if (!self.guideModel) {
            
            [bottomView.tourGuideButton setImage:[UIImage imageNamed:@"tripTourGray"] forState:UIControlStateNormal];
            
            bottomView.tourGuideButton.userInteractionEnabled = NO;
            
        }else
        {
            [bottomView.tourGuideButton setImage:[UIImage imageNamed:@"tripTour"] forState:UIControlStateNormal];
            
            bottomView.tourGuideButton.userInteractionEnabled = YES;
        }

        
        bottomView.buttonClick = ^(NSInteger tag)
        {
            if (tag ==101)
            {
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
                
                self.CallWindow.dispatcher_Model =self.dispatcherModel;

            }else if (tag==102)
            {
                [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
                
   
                self.CallWindow.guide_Model = self.guideModel;
            }
        };
        
        [self.view addSubview:bottomView];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.equalTo(@(56));
        }];
        
    }else//已结束以外的都是三个按钮的 视图
    {
       WL_OrderDetail_BottomThreeView *bottomView = [[WL_OrderDetail_BottomThreeView alloc] init];
        
        [self.view addSubview:bottomView];
        
        
        if (!self.guideModel) {
            
            [bottomView.tourGuideButton setImage:[UIImage imageNamed:@"tripTourGray"] forState:UIControlStateNormal];
            
            bottomView.tourGuideButton.userInteractionEnabled = NO;
            
        }else
        {
            [bottomView.tourGuideButton setImage:[UIImage imageNamed:@"tripTour"] forState:UIControlStateNormal];
            
            bottomView.tourGuideButton.userInteractionEnabled = YES;
        }

        __weak WL_OrderDetail_BottomThreeView *weakView =bottomView;
    
        bottomView.buttonClick = ^(ClickType type)
        {
            
        if (type ==0)
        {
            
        [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
            
            
            self.CallWindow.dispatcher_Model =self.dispatcherModel;
                
                
        }else if (type==1)
        {
                
        [[UIApplication sharedApplication].keyWindow addSubview:self.CallWindow];
                
            
            self.CallWindow.guide_Model =self.guideModel;
                
                
        }else if (type==2)
        {
               
           if ([weakView.statusButton.currentTitle isEqualToString:@"出发"])
          {
                    
                    
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出发前,请与导游共同核对上车人数"
                                                                        message:nil
                                                                       delegate:self
                                                              cancelButtonTitle:@"取消"
                                              
                                              
                                                              otherButtonTitles:@"确认出发", nil];
                alert.tag =1001;
                        
                [alert show];

                }else if ([weakView.statusButton.currentTitle isEqualToString:@"结束"])
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
            
        };
        
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.equalTo(@(56));
        }];

        
        if ([self.orderDetailModel.trip_status isEqualToString:@"1"]) {
            
            if ([self.orderDetailModel.beg_buttom integerValue]==1) {
                
                [bottomView.statusButton setTitle:@"出发" forState:UIControlStateNormal];
                
                [bottomView.statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [bottomView.statusButton setBackgroundColor:WLColor(237, 133, 82, 1)];

            }else if ([self.orderDetailModel.beg_buttom integerValue]==2)
            {
                [bottomView.statusButton setTitle:@"出发" forState:UIControlStateNormal];
                
                [bottomView.statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [bottomView.statusButton setBackgroundColor:WLColor(237, 133, 82, 1)];

                bottomView.statusButton.enabled=NO;
                
                bottomView.statusButton.alpha =0.4;
            }
            
        }else if ([self.orderDetailModel.trip_status isEqualToString:@"2"])
        {
            
            [bottomView.statusButton setTitle:@"结束" forState:UIControlStateNormal];
                
            [bottomView.statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            [bottomView.statusButton setBackgroundColor:[WLTools stringToColor:@"#4877e7"]];
 
        }
    }

    //创建 TableView
    UITableView *orderDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    

    [self.view addSubview:orderDetailTableView];
    //添加约束
    [orderDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(ScreenHeight-64-56);
    }];
    orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    orderDetailTableView.backgroundColor = BgViewColor;

    //设置代理与数据源
    orderDetailTableView.delegate = self;
    orderDetailTableView.dataSource = self;
    
   
    //添加蓝色背景 下拉时页面更好看
    UIView *topView =[UIView new];
    
    topView.backgroundColor =[WLTools stringToColor:@"#4877e7"];
    
    [orderDetailTableView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.mas_equalTo(0);
        
        make.width.mas_equalTo(ScreenWidth);
        
        make.height.mas_equalTo(800);
    
        make.bottom.mas_equalTo(orderDetailTableView.mas_top);
    }];
    
    
    //注册cell
    [orderDetailTableView registerClass:[WL_Application_Driver_Order_WaitOrderDetail_Cell  class] forCellReuseIdentifier:cellId];
    
    [orderDetailTableView registerClass:[WL_PayDetail_Cell class] forCellReuseIdentifier:acceptCellId];
    
    [orderDetailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:remarkCell];
    
    //TableView的头视图
    WL_Application_Driver_Order_OrderDetail_TopView *orderDetailTopView = [[WL_Application_Driver_Order_OrderDetail_TopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 280)];
    
    orderDetailTopView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
   
    orderDetailTableView.tableHeaderView = orderDetailTopView;
    //出发城市
    orderDetailTopView.fromCityLable.text = self.orderDetailModel.start_city;
    //到达城市
    orderDetailTopView.endCityLable.text = self.orderDetailModel.end_city;
    //行程里程
    orderDetailTopView.mileageLable.text = [NSString stringWithFormat:@"约%@公里", self.orderDetailModel.mileage];
 
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startdate =[formatter dateFromString:self.orderDetailModel.start_time];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    
    [formatter1 setDateFormat:@"MM月dd日"];
    
    //开始日期
    NSString *startTime = [formatter1 stringFromDate:startdate];
    
    orderDetailTopView.startTimeLable.text = startTime;
    
    //结束日期
    NSDate *endDate =[formatter dateFromString:self.orderDetailModel.end_time];
    
    NSString *endTime = [formatter1 stringFromDate:endDate];
    
    orderDetailTopView.endTimeLable.text = endTime;
    
    //总出游人数
    orderDetailTopView.personCountLable.text = [NSString stringWithFormat:@"共%@人", self.orderDetailModel.persons_count];
    
    //出发地点
    orderDetailTopView.startAddressLable.text = self.orderDetailModel.start_address;
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    
    [formatter2 setDateFormat:@"yyyy年MM月dd日 HH:mm 出发"];
    
    NSString *beginTime = [formatter2 stringFromDate:startdate];
    
    orderDetailTopView.beginTimeLable.text = beginTime;
    
    //结束地点
    orderDetailTopView.endAddressLable.text = self.orderDetailModel.end_address;
    
    //结束时间
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc]init];
    
    [formatter3 setDateFormat:@"yyyy年MM月dd日 HH:mm 结束"];
    
    NSString *arriveTime = [formatter3 stringFromDate:endDate];
    
    orderDetailTopView.arriveTimeLable.text = arriveTime;
    

    //TableView的尾视图
    WL_OrderStatus_View *orderDetailBottomView = [[WL_OrderStatus_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 182)];
    
    orderDetailTableView.tableFooterView = orderDetailBottomView;
    
    if ([self.orderDetailModel.order_status isEqualToString:@"1"])
    {
        orderDetailBottomView.acceptStatusLable.text = @"接单状态: 待接单";
    }
    else if ([self.orderDetailModel.order_status isEqualToString:@"2"])
    {
        orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已拒绝";
    }
    else if ([self.orderDetailModel.order_status isEqualToString:@"3"])
    {
        orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已超时";
    }
    else if ([self.orderDetailModel.order_status isEqualToString:@"4"])
    {
        orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已被抢";
    }
    else if ([self.orderDetailModel.order_status isEqualToString:@"5"])
    {
        orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已接单";
    }
    else if ([self.orderDetailModel.order_status isEqualToString:@"6"])
    {
        orderDetailBottomView.acceptStatusLable.text = @"接单状态: 已被取消";
    }
    
    orderDetailBottomView.receiveOrderTime.text = [NSString stringWithFormat:@"接单时间: %@", self.orderDetailModel.accept_date];
    
    
    if ([self.orderDetailModel.trip_status isEqualToString:@"1"]) {
        
        orderDetailBottomView.tripCondition.text = [NSString stringWithFormat:@"行程状态: %@",@"待出发"];
       
   
    }else if ([self.orderDetailModel.trip_status isEqualToString:@"2"]) {
        
        orderDetailBottomView.tripCondition.text = [NSString stringWithFormat:@"行程状态: %@",@"行程中"];
       
        
    }else if ([self.orderDetailModel.trip_status isEqualToString:@"3"]) {
        
        orderDetailBottomView.tripCondition.text = [NSString stringWithFormat:@"行程状态: %@",@"已结束"];
    }
    
   
    if ([self.orderDetailModel.trip_status isEqualToString:@"3"]) {
        
        if ([self.orderDetailModel.pay_status isEqualToString:@"1"]) {
            
            orderDetailBottomView.payStatus.text = [NSString stringWithFormat:@"支付状态: %@",@"结算中"];
            
        }else if ([self.orderDetailModel.pay_status isEqualToString:@"2"]) {
            
            orderDetailBottomView.payStatus.text = [NSString stringWithFormat:@"支付状态: %@",@"已结清"];
            
        }
 
    }else
    {
        orderDetailBottomView.payStatus.hidden =YES;
        
        orderDetailBottomView.sendOrderTime.y = ViewBelow(orderDetailBottomView.tripCondition)+10;
        
        orderDetailBottomView.receiveOrderTime.y = ViewBelow(orderDetailBottomView.sendOrderTime)+10;
    }
    
  
    
    orderDetailBottomView.sendOrderTime.text =[NSString stringWithFormat:@"派单时间: %@", self.orderDetailModel.create_date];
    
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
        WS(weakSelf);
        
        WL_Settlement_ViewController *VC =[[WL_Settlement_ViewController alloc]init];
        VC.popBlock = ^(NSString *sj_order_id)
        {
            
            weakSelf.sj_order_id = sj_order_id;
            //发送订单详情网络请求
            [weakSelf sendRequestToAcceptOrderDetail];
            
        };
        
        VC.sj_order_id = self.model.sj_order_id;
        
        [self.navigationController pushViewController:VC animated:YES];

    }
    
}
//开始按钮点击
-(void)updateTripStatus

{

    NSString *user_passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"sj_order_id":self.model.sj_order_id,@"order_status_type":@"2",@"remark":@"",@"status":@"2"};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:DriverOrderUpdateOrderUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        
        if ([responseObject[@"status"] integerValue]==1)
        {
             [[WL_TipAlert_View sharedAlert]createTip:responseObject[@"msg"]];
            
            //先删除原来的视图 然后再重新创建
            for (id obj in self.view.subviews) {
                
                [obj removeFromSuperview];
            }
            //成功 之后刷新页面
            [weakSelf sendRequestToAcceptOrderDetail];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:responseObject[@"msg"]];
        }
        
        
        
    } Failure:^(NSError *error) {
        
        
        [[WL_TipAlert_View sharedAlert]createTip:@"设置失败"];
    }];

}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if ([self.orderDetailModel.trip_status integerValue]==3) {
            
            return 4;
        }
        
        return 3;
    }
    else if (section == 1)
    {
        return 3;
    }
    else if (section == 2)
    {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 ) {
        
    WL_PayDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:acceptCellId];
      
        if (indexPath.row ==0)
        {
            
            cell.titleLable.text = @"总金额";

            cell.receiptLable.text =[NSString stringWithFormat:@"¥%0.2f",[self.orderDetailModel.amount floatValue]];
            
            cell.receiptLable.textColor = [WLTools stringToColor:@"#868686"];
            
            cell.lineView.hidden =NO;
            
        }else if (indexPath.row ==1)
            
        {
            cell.titleLable.text = @"实际金额";
            
            if ([self.orderDetailModel.actual_amount floatValue]==0.0) {
               
                cell.receiptLable.text = @"待导游记账";
                
            }else
            {
               cell.receiptLable.text =[NSString stringWithFormat:@"¥%0.2f",[self.orderDetailModel.actual_amount floatValue]];
            }
            
            cell.receiptLable.textColor = [WLTools stringToColor:@"#868686"];
            
            cell.indicatorImageView.hidden=YES;
            
            cell.warningButton.hidden =NO;
            
            [cell.warningButton addTarget:self action:@selector(warningButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            cell.lineView.hidden =NO;
            
        }else if (indexPath.row==2)
            
        {
            cell.titleLable.text = @"已支付";
            
            cell.receiptLable.text =[NSString stringWithFormat:@"¥%0.2f",[self.orderDetailModel.receipted_amount floatValue]];
            
            cell.receiptLable.textColor = [WLTools stringToColor:@"#868686"];
            
            cell.indicatorImageView.hidden=NO;
            
            cell.lineView.hidden =NO;
            
        }else if (indexPath.row==3)
            
        {
            cell.titleLable.text = @"";
            
            //实际金额返回0的时候
            if ([self.orderDetailModel.actual_amount floatValue]==0.0)
            {
                cell.receiptLable.text = @"待导游记账\n待支付";
            }else
            {
            cell.receiptLable.text = [NSString stringWithFormat:@"%0.2f\n待支付",[self.orderDetailModel.actual_amount floatValue]-[self.orderDetailModel.receipted_amount floatValue]];
            }
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:cell.receiptLable.text];
            
            [attrStr addAttribute:NSFontAttributeName value:WLFontSize(14) range:NSMakeRange(cell.receiptLable.text.length-3, 3)];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[WLTools stringToColor:@"#868686"] range:NSMakeRange(cell.receiptLable.text.length-3, 3)];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 6; // 调整行间距
            NSRange range = NSMakeRange(0, [cell.receiptLable.text length]);
            [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
            
            cell.receiptLable.attributedText =attrStr;
            
             cell.receiptLable.textAlignment = NSTextAlignmentRight;
            
            cell.lineView.hidden=YES;
        }
        
    return cell;
    }
    else if(indexPath.section ==1)
    {
        WL_Application_Driver_Order_WaitOrderDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (indexPath.section == 1 && indexPath.row == 0)
        {
            cell.myTitleLable.text = @"订单编码";
            cell.contentLable.text = self.orderDetailModel.order_number;
            cell.lineView.hidden = NO;
        }
        else if (indexPath.section == 1 && indexPath.row == 1)
        {
            cell.myTitleLable.text = @"旅行社";
            cell.contentLable.text = self.orderDetailModel.order_source_travel;
            cell.lineView.hidden = NO;
            
        }else if (indexPath.section ==1&&indexPath.row==2)
        {
            cell.myTitleLable.text = @"车队";
            cell.contentLable.text = self.orderDetailModel.order_source_Fleet;
            cell.lineView.hidden = YES;
        }
        else if (indexPath.section == 2 && indexPath.row == 0)
        {
            cell.myTitleLable.textColor = [WLTools stringToColor:@"#868686"];
            cell.orderDetail = self.orderDetailModel;
            [cell.myTitleLable sizeToFit];
            cell.lineView.hidden = YES;
        }
        return cell;
    }else if (indexPath.section==2)
    {
   
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:remarkCell];
     
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.textColor = [WLTools stringToColor:@"#868686"];
        
        cell.textLabel.text = self.orderDetailModel.remark;
        
        return cell;
    }
    
    return nil;
}

-(void)warningButtonClick

{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.warningWindow];
    
    self.warningWindow.tipString = @"若您因为实际出行与订单不符，需要调整订单价格请与导游商议，并由导游记账后更新";
    
    self.warningWindow.buttonTittle =@"知道了";
    
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0 && indexPath.row ==3)
        
    {
        return 72.0;
    }
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *firstView = [[UIView alloc] init];
    UILabel *firstLable = [[UILabel alloc] init];
    [firstView addSubview:firstLable];
    [firstLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left).mas_offset(12);
        make.centerY.equalTo(firstView.mas_centerY);
    }];
    
    if (section == 0)
    {
        firstLable.text = @"支付信息";
    }
    if (section == 1)
    {
        firstLable.text = @"订单来源";
    }
    if (section == 2) {
       
        firstLable.text = @"备注信息";
    }
    return firstView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section ==0 &&indexPath.row==2) {
        
        if ([self.orderDetailModel.receipted_amount integerValue]==0) {
            
            [[WL_TipAlert_View sharedAlert]createTip:@"您还没有支付记录"];
            
            return;
            
        }else
        {
            WL_TwicePay_ViewController *VC =[[WL_TwicePay_ViewController alloc]init];
            
            
            NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
            
            for (id obj in self.orderDetailModel.pay_record) {
                
                WL_Application_Driver_OrderDetail_PayRecord_Model *model =[WL_Application_Driver_OrderDetail_PayRecord_Model mj_objectWithKeyValues:obj];
                
                [array addObject:model];
                
            }
            
            
            VC.pay_record = array;
            
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
