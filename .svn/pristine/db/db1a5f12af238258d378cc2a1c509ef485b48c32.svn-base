//
//  WL_FundAccount_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_FundAccount_ViewController.h"

#import "WL_AccountHeaderView.h"

#import "WL_Account_MoneyCell.h"

#import "WL_FundAccount_Cell.h"

#import "WL_Mine_UserInfoModel.h"

#import "WL_BindBankCards_ViewController.h"

#import "WL_SetPayPassWord_ViewController.h"

#import "WL_SetSucess_ViewController.h"

#import "WL_MangerWord_ViewController.h"

#import "WL_BankCardsList_ViewController.h"

#import "WL_Deposit_ViewController.h"

#import "WL_TradeRecord_ViewController.h"

#import "WL_FreezeList_ViewController.h"

#import "WL_MyBalance_ViewController.h"

#import "WL_Mine_personInfo_Authentication_ViewController.h"

#import "WL_BindBankCards_ViewController.h"
@interface WL_FundAccount_ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *imageArray;

@property(nonatomic,strong)NSArray *detailArray;

@property(nonatomic,strong)WL_Mine_UserInfoModel *userInfoModel;

@property(nonatomic,strong)WL_AccountHeaderView *headerView;

@end

@implementation WL_FundAccount_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BgViewColor;
    
    [self initData];
    
    [self initUI];

   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self loadAccountData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

-(UITableView *)tableView
{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight-49+20) style:UITableViewStylePlain];
        
        _tableView.delegate =self;
        
        _tableView.dataSource =self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.tableFooterView =[UIView new];
        
        _tableView.backgroundColor = BgViewColor;
        
        _tableView.showsVerticalScrollIndicator = NO;
    }
    
    return _tableView;
}

-(void)initData
{
    self.titleArray = [NSArray arrayWithObjects:@[@"交易记录",@"银行卡",@"管理密码"], nil];
    
    self.imageArray =[NSArray arrayWithObjects:@[@"AccountTrade",@"AccountCards",@"AccountPassWord"], nil];
    
    self.detailArray = [NSArray arrayWithObjects:@[@"",@"绑定银行卡",@"设置支付密码"], nil];
}

-(void)loadAccountData
{
    
    
    [self showHud];
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *dict =@{@"user_id":userId,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:MinePersonCenterHomeUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result intValue]==1) {
            
            weakSelf.userInfoModel = [WL_Mine_UserInfoModel mj_objectWithKeyValues:network_Model.data];
        }
        
        [weakSelf hidHud];
       
        [weakSelf.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
        self.headerView.meansNum.text= [NSString stringWithFormat:@"%0.2f",[self.userInfoModel.moneyCount floatValue]];
        
        WlLog(@"%@",responseObject);
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
       
        if (error.code ==-1009)
        {
            
            [[WL_TipAlert_View sharedAlert]createTip:@"似乎已断开与互联网的连接"];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:@"服务器错误,请稍后重试"];
        }

        
        [weakSelf.tableView.mj_header endRefreshing];
        
        self.headerView.meansNum.text= @"0.00";
        
        
    }];
    
}



-(void)initUI

{
    [self.view addSubview:self.tableView];
    
    
    WS(ws);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [ws loadAccountData];
        
    }];

    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    ws.tableView.mj_header =header;
   
    
    self.headerView =[[WL_AccountHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 240)];
   
    self.tableView.tableHeaderView = self.headerView;
    

    [self.headerView.backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)backButtonClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ----  tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section==0) {
        
        return 1;
        
    }
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 70;
        
    }
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if (section==0) {
        
        return 0.0;
    }
    
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        
        return nil;
        
    }
    
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    return v;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        WL_Account_MoneyCell *cell =[[WL_Account_MoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.buttonClickBlock =^(ClickType type)
        {
            
            if (type == ClickTypeBalance) {
                
                WL_MyBalance_ViewController *VC =[[WL_MyBalance_ViewController alloc]init];
                
                [self.navigationController pushViewController:VC animated:YES];
                
            }else if (type == ClickTypeFrozen_amount)
            {
                WL_FreezeList_ViewController *VC =[[WL_FreezeList_ViewController alloc]init];
                
                [self.navigationController pushViewController:VC animated:YES];
            }
            
            
            WlLog(@"%ld",(long)type);
            
        };

        NSString *balanceString = [NSString stringWithFormat:@"%0.2f",[_userInfoModel.leave_amount floatValue]];
        
        cell.balanceLabel.text = [NSString stringWithFormat:@"%@\n余额",balanceString];
        
        [self getAttributedStringFrom:cell.balanceLabel];
        
        NSString *frozenString = [NSString stringWithFormat:@"%0.2f",[_userInfoModel.frozen_amount floatValue]];
        
        cell.frozen_amount.text = [NSString stringWithFormat:@"%@\n冻结",frozenString];
        
        [self getAttributedStringFrom:cell.frozen_amount];
        
        cell.awardLabel.text = @"0.00\n奖励";
        
        [self getAttributedStringFrom:cell.awardLabel];
        
        return cell;
    }
    
    
    
    static NSString *cellID =@"cellIdentifier";
    
    WL_FundAccount_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[WL_FundAccount_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.nameLabel.text = self.titleArray[indexPath.section-1][indexPath.row];
    
    cell.leftImageVIew.image =[UIImage imageNamed:self.imageArray[indexPath.section-1][indexPath.row]];
    
    cell.rightLabel.text =self.detailArray[indexPath.section-1][indexPath.row];
    
    if (indexPath.section ==1 &&indexPath.row==2) {
        
        cell.line.hidden =YES;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section==1 &&indexPath.row==0) {
        
        WL_TradeRecord_ViewController *VC =[[WL_TradeRecord_ViewController alloc]init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.section==1 &&indexPath.row==1)
    {
        
       //检查是否实名认证 --- 然后检查是否设置过支付密码 －－－最后检查是否绑定了银行卡
        
        [self checkRealName];
       
        
    }else if (indexPath.section==1 &&indexPath.row==2)
    {
       //检查是否设置过 支付密码
        [self checkPayPassWord];
    }
}

-(void)getAttributedStringFrom:(UILabel *)label
{
    
    NSMutableAttributedString *attrawardLabel = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    [attrawardLabel addAttribute:NSFontAttributeName value:WLFontSize(13) range:NSMakeRange(label.text.length-2, 2)];
    [attrawardLabel addAttribute:NSForegroundColorAttributeName value:[WLTools stringToColor:@"#6f7378"] range:NSMakeRange(label.text.length-2, 2)];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 10; // 调整行间距
    NSRange rang = NSMakeRange(0, [label.text length]);
    [attrawardLabel addAttribute:NSParagraphStyleAttributeName value:paragraph range:rang];
    
    label.attributedText =attrawardLabel;
    
    label.textAlignment =NSTextAlignmentCenter;
}

-(void)checkRealName
{
    
        NSString *user_id = [WLUserTools getUserId];
        
        NSString *user_PassWord= [WLUserTools getUserPassword];
        
        //进行RSA加密后的密码字符串
        NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
        
        NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
        
        WS(weakSelf);
        
        [weakSelf showHud];
        
        [[WLHttpManager shareManager]requestWithURL:CheckRealNameUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
            
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
            
           

            if ([network_Model.result isEqualToString:@"1"])
            {
                
                [self checkPayPasswordAboutBankCard];
                
            }else
            {
                
                [weakSelf hidHud];
                
                //跳转去实名认证
                WL_Mine_personInfo_Authentication_ViewController *VC =[[WL_Mine_personInfo_Authentication_ViewController alloc]init];
                
            
                [self.navigationController pushViewController:VC animated:YES];
            }
            
           
            
        } Failure:^(NSError *error) {
            
            [weakSelf hidHud];
            
            [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
            
        }];
    
}

#pragma  mark ---检查是否设置了支付密码，跳转银行卡之前的验证

-(void)checkPayPasswordAboutBankCard
{
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:CheckPassWordUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
           
            [self checkBindBankCard];
            
         

        }else
        {
          
            [weakSelf hidHud];
            
            WL_SetPayPassWord_ViewController *VC =[[WL_SetPayPassWord_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
        [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
        
    }];
}
#pragma mark ----  检查是否绑定了银行卡
-(void)checkBindBankCard
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];
    
    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    
    [[WLHttpManager shareManager]requestWithURL:CheckBindBankUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
           
            if ([network_Model.data[@"is_bind"]integerValue]==1) {
                
                WL_BankCardsList_ViewController *VC =[[WL_BankCardsList_ViewController alloc]init];
                
                [self.navigationController pushViewController:VC animated:YES];
                
            }else
            
            {
                WL_BindBankCards_ViewController *VC =[[WL_BindBankCards_ViewController alloc]init];
                
                [self.navigationController pushViewController:VC animated:YES];
                
                
            }
    
        
        }else
        {
            
              [[WL_TipAlert_View sharedAlert]createTip:network_Model.msg];
        }
       [weakSelf hidHud];
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
        [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
        
    }];
    
    
}
#pragma mark ----  检查是否设置了支付密码
-(void)checkPayPassWord
{
    
    NSString *user_id = [WLUserTools getUserId];
    
    NSString *user_PassWord= [WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:user_PassWord publicKey:RSAKey];

    NSDictionary *dict = @{@"user_id":user_id,@"user_password":encryptStr};
    
    WS(weakSelf);
    [weakSelf showHud];
    
    [[WLHttpManager shareManager]requestWithURL:CheckPassWordUrl RequestType:RequestTypePost Parameters:dict Success:^(id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.result isEqualToString:@"1"]) {
            
            [weakSelf hidHud];
            
            
            WL_MangerWord_ViewController *VC =[[WL_MangerWord_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];

           
            
        }else
        {
           [weakSelf hidHud];
           
            
            WL_SetPayPassWord_ViewController *VC =[[WL_SetPayPassWord_ViewController alloc]init];
            
        
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
  
        
        
    } Failure:^(NSError *error) {
       
        [weakSelf hidHud];
        
        [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
