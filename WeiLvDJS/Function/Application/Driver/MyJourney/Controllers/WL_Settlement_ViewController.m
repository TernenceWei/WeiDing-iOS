//
//  WL_Settlement_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  结算中心

#import "WL_Settlement_ViewController.h"

#import "WL_PayDetail_Cell.h"

#import "WL_PayType_Cell.h"

#import "WL_PayAmountCell.h"

#import "WL_Application_Driver_OrderDetail_Model.h"

#import "WL_TwicePay_ViewController.h"

#import "WL_Warning_Window.h"

@interface WL_Settlement_ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


{
    NSIndexPath *lastIndex;
    
    NSIndexPath *selectIndex;
}

@property(nonatomic,strong)WL_Application_Driver_OrderDetail_Model *orderDetailModel;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *imageArray;

@property(nonatomic,strong)NSMutableArray *sectionArray;

@property(nonatomic,strong)WL_Warning_Window *warningWindow;

@end


static NSString *const cellId = @"cellId";

static NSString *const CellReuseIdentifier = @"WL_PayType_Cell";

static NSString *const cellID = @"cellID";

@implementation WL_Settlement_ViewController


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title =@"结算中心";
   
    self.view.backgroundColor = BgViewColor;
    
    [self initData];
    
    [self initUI];
    
    [self sendRequestToAcceptOrderDetail];
    
    
    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    lastIndex =[NSIndexPath indexPathForRow:0 inSection:1];
    
}

-(void)NavigationLeftEvent
{
    
    [self.navigationController popViewControllerAnimated:YES];

    
    if (self.popBlock) {
        
        self.popBlock(self.sj_order_id);
        
    }
}

-(void)initData

{
    self.titleArray =[NSArray arrayWithObjects:@[@"订单金额",@"实际金额",@"已支付"],@[@"导游支付",@"均由车队支付"],@"金额",nil];
    
    self.imageArray = [NSArray arrayWithObjects:@"",@[@"daoyou",@"chedui"], @"", nil];
    
    self.sectionArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
}


-(WL_Warning_Window *)warningWindow
{
    if (_warningWindow==nil) {
        
        _warningWindow =[[WL_Warning_Window alloc]init];
        
        [_warningWindow setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _warningWindow;
    
}


#pragma mark - 发送订单详情网络请求
- (void)sendRequestToAcceptOrderDetail
{
    //请求Url
    NSString *urlStr = DriverOrderDetailUrl;
   
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
            [[WL_TipAlert_View sharedAlert] createTip:model.msg];
            //隐藏菊花
            [weakSelf hidHud];
            return;
        }
        //将返回的订单详情数据转换为订单详情模型
        WL_Application_Driver_OrderDetail_Model *orderDetailModel = [WL_Application_Driver_OrderDetail_Model mj_objectWithKeyValues:model.data];
        weakSelf.orderDetailModel = orderDetailModel;

        
        [weakSelf.tableView reloadData];
        
        [weakSelf hidHud];
        
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
    }];
    
}




-(void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
   
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[WL_PayDetail_Cell class] forCellReuseIdentifier:cellId];
    
    [self.tableView registerClass:[WL_PayType_Cell class] forCellReuseIdentifier:CellReuseIdentifier];
    
    [self.tableView registerClass:[WL_PayAmountCell class] forCellReuseIdentifier:cellID];
    
    //添加约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(ScreenHeight-64-75);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = BgViewColor;
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    self.tableView.showsVerticalScrollIndicator =NO;
    
    //设置代理与数据源
   
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    
    UIButton *saveButton = [UIButton new];
    
    [saveButton setBackgroundColor:WLColor(140, 157, 244, 1)];
    
    saveButton.layer.cornerRadius = 3.0;
    
    [saveButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-90, 45));
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-15);
        
    }];
    
   
    UIView *footer =[UIView new];
    
    [footer setFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    
    footer.backgroundColor =BgViewColor;
    
    UILabel *leftTip =[UILabel new];
    
    leftTip.font =WLFontSize(12);
    
    leftTip.textColor =[WLTools stringToColor:@"#868686"];
    
    leftTip.text =@"重要提示:";
    
    [footer addSubview:leftTip];
    
    [leftTip mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.mas_equalTo(12.5);
        
        make.top.mas_equalTo(10);
        
    }];
    
    UILabel *leftTipDetail =[UILabel new];
    
    leftTipDetail.font =WLFontSize(12);
    
    leftTipDetail.numberOfLines =0;
    
    leftTipDetail.textColor =[WLTools stringToColor:@"#868686"];
    
    leftTipDetail.text =@"无论导游是否支付部分或者全部费用,剩余尾款均会有派单车队进行支付。";
    
    [footer addSubview:leftTipDetail];
    
    [leftTipDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(leftTip.mas_right);
        
        make.top.mas_equalTo(leftTip.mas_top);
        
        make.width.mas_equalTo(ScreenWidth-12.5-10-50);
        
    }];


    self.tableView.tableFooterView =footer;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section ==0) {
        
        return 2;
        
    }else if (section ==1)
    {
        
        return 2;
    }else
    
        return 1;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *firstView = [[UIView alloc] init];
    UILabel *firstLable = [[UILabel alloc] init];
    
    firstLable.font = WLFontSize(14);
    firstLable.textColor = [WLTools stringToColor:@"#868686"];
    [firstView addSubview:firstLable];
    [firstLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left).mas_offset(12);
        make.centerY.equalTo(firstView.mas_centerY);
    }];
    
    if (section == 0)
    {
        firstLable.text = @"我的订单价";
    }
    if (section == 1)
    {
        firstLable.text = @"当前支付";
    }
    if (section == 2) {
        firstLable.text = @"";
    }
    return firstView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    if (indexPath.section ==0)
    {
    
    WL_PayDetail_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    cell.titleLable.text = self.titleArray[indexPath.section][indexPath.row];
    
        if (indexPath.row ==0)
        {
            cell.receiptLable.text =[NSString stringWithFormat:@"¥%0.2f",[self.orderDetailModel.amount floatValue]];
            
            cell.indicatorImageView.hidden=YES;
            
        }else if (indexPath.row ==1)
            
        {
            
            if ([self.orderDetailModel.actual_amount floatValue]==0.00) {
               
                cell.receiptLable.text =@"待导游记账";
                
            }else
            {
                 cell.receiptLable.text =[NSString stringWithFormat:@"¥%0.2f",[self.orderDetailModel.actual_amount floatValue]];
            }
            
            cell.warningButton.hidden =NO;
            
             [cell.warningButton addTarget:self action:@selector(warningButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            cell.indicatorImageView.hidden=YES;
            
        }
        
        return cell;
        
    }else if(indexPath.section ==1)
    
    {
    
        WL_PayType_Cell *cell =[tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.typeLabel.text = self.titleArray[indexPath.section][indexPath.row];
        
        cell.leftImage.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
        
        
        if (indexPath.row==lastIndex.row) {
            
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            imageView.image=[UIImage imageNamed:@"Driver_Order_Selected"];//把图片置空
            cell.accessoryView=imageView;
            
            lastIndex=indexPath;
            selectIndex=indexPath;
        }else{
            
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            imageView.image=[UIImage imageNamed:@"Driver_Order_NoSelected"];
            cell.accessoryView=imageView;
            
        }

        return cell;
    }else if(indexPath.section ==2)
    {
        WL_PayAmountCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        
        return cell;
    }
        
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    if (section==0) {
      
        return 45;
        
    }else if (section==1)
    {
        return 45;
    }
    return 10.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section ==0 &&indexPath.row==2)
    {
        
        if ([self.orderDetailModel.receipted_amount integerValue]==0) {
            
            [[WL_TipAlert_View sharedAlert]createTip:@"您还没有支付记录"];
            
            return;
            
        }else
        {
            WL_TwicePay_ViewController *VC =[[WL_TwicePay_ViewController alloc]init];
            
            VC.order_id = self.orderDetailModel.sj_order_id;
            
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    }else if (indexPath.section==1) {
        
        if (indexPath.row ==1) {
            
            self.sectionArray =[NSMutableArray arrayWithObjects:@"1",@"2", nil];
            
            [self.tableView reloadData];
            
        }else
        {
            
            if (self.sectionArray.count==2)
            
            {
                self.sectionArray =[NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
                
                [self.tableView reloadData];
                
            }
           
        }
        
       
        
    if (lastIndex.row==indexPath.row) {
        
        WL_PayType_Cell * cell=(WL_PayType_Cell *)[tableView cellForRowAtIndexPath:lastIndex];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        imageView.image=[UIImage imageNamed:@"Driver_Order_NoSelected"];//把图片置空
        
        cell.accessoryView=imageView;
        
        lastIndex=[NSIndexPath indexPathForRow:10000 inSection:0];//把index置为一个不可能相等的数
        
        selectIndex=nil;
    }else{
        
        WL_PayType_Cell * cell2=(WL_PayType_Cell *)[tableView cellForRowAtIndexPath:lastIndex];
       
        UIImageView *imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        imageView2.image=[UIImage imageNamed:@"Driver_Order_NoSelected"];//把图片置空
        
        cell2.accessoryView=imageView2;
        
        WL_PayType_Cell * cell=(WL_PayType_Cell *)[tableView cellForRowAtIndexPath:indexPath];
       
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        imageView.image=[UIImage imageNamed:@"Driver_Order_Selected"];
        
        cell.accessoryView=imageView;
        
        lastIndex=indexPath;
        
        selectIndex=indexPath;
        
    }
      
  
    }

}

-(void)warningButtonClick
{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.warningWindow];
    
    self.warningWindow.tipString = @"若您因为实际出行与订单不符，需要调整订单价格请与导游商议，并由导游记账后更新";
    
    self.warningWindow.buttonTittle =@"知道了";
}

-(void)saveButtonClick
{
    WL_PayAmountCell *cell  =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    
    if (cell.amountTextfield.text.length==0&&self.sectionArray.count==3) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入金额"];
        
        return;
        
    }
    
    
    if (selectIndex==nil) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请选择支付方式"];
        
        return;
        
    }
    
    [self addPayRecord];

}


-(void)addPayRecord
{
    
    NSString *amount =@"";
    
    if (self.sectionArray.count==3)
    {
        WL_PayAmountCell *cell  =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        
        amount = cell.amountTextfield.text;
        
    }else if (self.sectionArray.count==2)
    {
        amount = @"0";
    }
    

    //请求Url
    NSString *urlStr = DriverAddOrderPayRecordUrl;
    
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
                             @"sj_order_id" : self.sj_order_id,
                             @"pay_mode":@(selectIndex.row+1),
                             @"amount":amount};
    
    WS(weakSelf);
    //显示菊花
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        //服务器返回数据失败
        if (![model.status isEqualToString:@"1"])
        {
            //弹框错误信息
            [[WL_TipAlert_View sharedAlert] createTip:model.msg];
           
            [weakSelf hidHud];
            
            return;
        }
        
        [[WL_TipAlert_View sharedAlert] createTip:@"记账成功"];
        
        [weakSelf updateTripStatusWithEnd];
        
        [weakSelf hidHud];
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
    }];

}

-(void)updateTripStatusWithEnd

{

    NSString *user_passWord =[WLUserTools getUserPassword];

    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_passWord publicKey:RSAKey];

    NSDictionary *paramaters =@{@"driver_id":[WLUserTools getUserId],@"user_password":encryptStr,@"sj_order_id":self.sj_order_id,@"order_status_type":@"2",@"remark":@"",@"status":@"3"};

    WS(weakSelf);

    [[WLHttpManager shareManager]requestWithURL:DriverOrderUpdateOrderUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {


        if ([responseObject[@"status"] integerValue]==1)
        {


            if (weakSelf.popBlock)
            {
                
                weakSelf.popBlock(weakSelf.sj_order_id);
                
            }
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:responseObject[@"msg"]];
        }



    } Failure:^(NSError *error) {


        [[WL_TipAlert_View sharedAlert]createTip:@"设置失败"];
    }];
}

#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
    CGRect rect =[self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    [self.tableView scrollRectToVisible:rect animated:YES];
}
#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    self.tableView.contentInset = UIEdgeInsetsZero;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
