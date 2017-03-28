//
//  WL_FundAccount_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_FundAccount_ViewController.h"
#import "WL_AccountHeaderView.h"
#import "WLFundAccountCell.h"
#import "WLFundAccountObject.h"
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
#import "WLNetworkAccountHandler.h"
#import "WL_ChangePassWord_ViewController.h"
#import "WLNetworkWriteOffHandler.h"
#import "WLWriteOffListObject.h"
#import "WL_BankCardsList_ViewController.h"

@interface WL_FundAccount_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellModelArray;
@property (nonatomic, strong) WLFundAccountObject *accountObject;
@property (nonatomic, strong) WL_AccountHeaderView *headerView;

@end

@implementation WL_FundAccount_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


-(void)setupUI
{
    WLFundAccountCellModel *accountModel = [WLFundAccountCellModel modelWithIconImage:@"accountBillDetail"
                                                                     leftTitle:@"账单明细"
                                                                    rightTitle:nil];
    WLFundAccountCellModel *realNameModel = [WLFundAccountCellModel modelWithIconImage:@"accountRealName"
                                                                            leftTitle:@"实名认证"
                                                                           rightTitle:@"未认证"];
    WLFundAccountCellModel *bankModel = [WLFundAccountCellModel modelWithIconImage:@"accountBankcard"
                                                                            leftTitle:@"银行卡"
                                                                           rightTitle:@"绑定银行卡"];
    WLFundAccountCellModel *passwordModel = [WLFundAccountCellModel modelWithIconImage:@"accountPassword"
                                                                            leftTitle:@"支付密码"
                                                                           rightTitle:@"设置支付密码"];
    self.cellModelArray = [NSMutableArray arrayWithArray:@[accountModel,realNameModel,bankModel,passwordModel]];

    self.view.backgroundColor = BgViewColor;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight-49+20) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView =[UIView new];
    _tableView.backgroundColor = BgViewColor;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    WS(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    self.headerView =[[WL_AccountHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240 + 70)
                                                      headerType:HeaderTypeAccountHome
                                                          action:^(ActionType type) {
                                                              switch (type) {
                                                                  case ActionTypeBack:{
                                                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                                                      break;
                                                                  }
                                                                  case ActionTypeBalance:{
                                                                      WL_MyBalance_ViewController *BalanceVC =[[WL_MyBalance_ViewController alloc]init];
                                                                      BalanceVC.object = weakSelf.accountObject;
                                                                      [weakSelf.navigationController pushViewController:BalanceVC animated:YES];
                                                                      break;
                                                                  }
                                                                  case ActionTypeFrozenAmount:{
                                                                      WL_FreezeList_ViewController *VC =[[WL_FreezeList_ViewController alloc]init];
                                                                      [weakSelf.navigationController pushViewController:VC animated:YES];
                                                                      break;
                                                                  }
                                                                      
                                                                  default:
                                                                      break;
                                                              }
        
    }];
    self.tableView.tableHeaderView = self.headerView;
    
    
    
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLFundAccountCell *cell = [WLFundAccountCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.cellModel = self.cellModelArray[0];
    }else{
        cell.cellModel = self.cellModelArray[indexPath.row + 1];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(55);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    return v;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {//账单明细
        
        WL_TradeRecord_ViewController *VC =[[WL_TradeRecord_ViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else {
        if (indexPath.row == 0){//实名认证
            [self realNameCellClickAction];
            
        }else if (indexPath.row == 1){//绑定银行卡
            
            [self bankCardCellClickAction];
            
        }else if (indexPath.row == 2){//支付密码
            
            [self paymentCodeCellClickAction];
        }
    }
    
}

#pragma mark private method
//实名认证
- (void)realNameCellClickAction
{
    if (!self.accountObject.is_validated.boolValue) {
        WL_Mine_personInfo_Authentication_ViewController *VC =[[WL_Mine_personInfo_Authentication_ViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        [[WL_TipAlert_View sharedAlert] createTip:@"已实名认证"];
    }
}

//绑定银行卡
-(void)bankCardCellClickAction{

    if (self.accountObject.is_validated.boolValue) {
        
        WL_BindBankCards_ViewController *VC =[[WL_BindBankCards_ViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        //跳转去实名认证
        [[WL_TipAlert_View sharedAlert] createTip:@"请先实名认证"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WL_Mine_personInfo_Authentication_ViewController *VC =[[WL_Mine_personInfo_Authentication_ViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        });
        
    }
}

//设置支付密码
-(void)paymentCodeCellClickAction
{
    if (self.accountObject.is_validated.boolValue) {
        if (self.accountObject.is_set_paypwd.boolValue) {//已设置支付密码

            WL_ChangePassWord_ViewController *VC =[[WL_ChangePassWord_ViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else{//未设置支付密码
        
            WL_SetPayPassWord_ViewController *VC =[[WL_SetPayPassWord_ViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else{
        //跳转去实名认证
        [[WL_TipAlert_View sharedAlert] createTip:@"请先实名认证"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WL_Mine_personInfo_Authentication_ViewController *VC =[[WL_Mine_personInfo_Authentication_ViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        });
    }
    
}

#pragma mark network
//获取账户总资产，可用余额，冻结金额等
-(void)loadData
{
    [self showHud];
    WS(weakSelf);
    [WLNetworkAccountHandler requestFundAccountWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        [weakSelf hidHud];
        [weakSelf.tableView.mj_header endRefreshing];
        
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.accountObject = (WLFundAccountObject *)data;
            weakSelf.headerView.model = weakSelf.accountObject;
            
            [WLUserTools saveRealName:weakSelf.accountObject.real_name];
            [WLUserTools saveIDCard:weakSelf.accountObject.id_card];

            if (weakSelf.accountObject.is_validated.boolValue) {
                WLFundAccountCellModel *model = weakSelf.cellModelArray[1];
                model.rightTitle = [NSString stringWithFormat:@"已认证 - %@",weakSelf.accountObject.real_name];
            }
            if (weakSelf.accountObject.bankcard_status.boolValue) {
                WLFundAccountCellModel *model = weakSelf.cellModelArray[2];
                
                model.rightTitle = @"等待审核";
                if (weakSelf.accountObject.bankcard_status.integerValue == 1) {
                    model.rightTitle = [NSString stringWithFormat:@"%@ - 尾号%@银行卡",weakSelf.accountObject.bank_name,[weakSelf.accountObject.bank_number substringFromIndex:weakSelf.accountObject.bank_number.length - 4]];
                    
                }
            }
            if (weakSelf.accountObject.is_set_paypwd.boolValue) {
                WLFundAccountCellModel *model = weakSelf.cellModelArray[3];
                model.rightTitle = @"已设置";
            }
            [weakSelf.tableView reloadData];
            
        }else{
            weakSelf.headerView.model = nil;
        }
    }];
    
}
@end
