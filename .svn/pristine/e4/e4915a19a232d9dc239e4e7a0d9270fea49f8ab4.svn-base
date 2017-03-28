//
//  WL_TwicePay_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_TwicePay_ViewController.h"

#import "WL_TwicePayCell.h"

#import "WL_TwicePay_Model.h"

#import "WL_Pay_RecordModel.h"

#import "WL_Application_Driver_OrderDetail_PayRecord_Model.h"
@interface WL_TwicePay_ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)WL_TipAlert_View *alert;

@property(nonatomic,strong)WL_TwicePay_Model *twiceModel;

@property(nonatomic,strong)NSMutableArray *payRecordArray;

@end

@implementation WL_TwicePay_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title =@"已支付详情";
    
    self.view.backgroundColor = BgViewColor;
    
    self.titleArray =[NSArray arrayWithObjects:@"金额",@"付款方",@"支付时间", nil];

    [self initUI];
    
   
    
    [self creatTipAlertView];
}


-(NSMutableArray *)payRecordArray
{
    
    if (_payRecordArray ==nil) {
        
        _payRecordArray =[[NSMutableArray alloc]init];
        
    }
    return _payRecordArray;

}
#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

-(void)initUI
{
    
   self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[WL_TwicePayCell class] forCellReuseIdentifier:@"cellID"];
    
    //添加约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(ScreenHeight-64);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = BgViewColor;
    //设置代理与数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.pay_record.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 3;
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
    
    
    WL_Application_Driver_OrderDetail_PayRecord_Model *model =self.pay_record[section];
    
    switch ([model.type integerValue]) {
        case 1:
            
            firstLable.text = @"导游支付";
            break;
         
        case 2:
            firstLable.text = @"均由车队支付";
            break;
            
        default:
            break;
    }
    
    
    return firstView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WL_TwicePayCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    cell.titleLable.text =self.titleArray[indexPath.row];
    
    WL_Application_Driver_OrderDetail_PayRecord_Model *model =self.pay_record[indexPath.section];
    
    if (indexPath.row ==0)
    {
    
    cell.receiptLable.textColor = [WLTools stringToColor:@"#ff5b3d"];
        
    cell.receiptLable.text =[NSString stringWithFormat:@"¥%@",model.amount];
       
    cell.lineView.hidden=NO;
        
        
    }else if (indexPath.row ==1)
    {
        
        cell.receiptLable.text = [NSString stringWithFormat:@"%@",model.title];
        
        cell.receiptLable.textColor = [WLTools stringToColor:@"#6f7378"];
        
        cell.lineView.hidden =NO;
    
    }else if (indexPath.row ==2)
        
    {
        cell.receiptLable.text = model.time;
        
         cell.receiptLable.textColor = [WLTools stringToColor:@"#6f7378"];
        
        cell.lineView.hidden =YES;
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
