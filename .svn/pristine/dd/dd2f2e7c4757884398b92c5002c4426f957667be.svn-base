//
//  WL_MineViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/8/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MineViewController.h"

#import "WL_Mine_HeaderView.h"

#import "WL_MineViewController_CapitalCell.h"

#import "WL_MineViewController_cell.h"

#import "WL_Mine_SetViewController.h"

#import "WL_Mine_UserInfoModel.h"

#import "WL_Mine_PersonInfo_ViewController.h"

#import "WL_Mine_PersonInfo_QRcode_ViewController.h"

#import "WL_FundAccount_ViewController.h"

#import "WL_Deposit_ViewController.h"

#import "WL_MyBalance_ViewController.h"

#import "WLUserTools.h"

#import "WL_Mine_personInfo_userInfoModel.h" //数据模型
#import "WLNetworkAccountHandler.h"
#import "WLFeedBackViewController.h"

@interface WL_MineViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *imageArray;

@property(nonatomic,strong)WL_Mine_UserInfoModel *userInfoModel;

@property(nonatomic,strong)WL_Mine_HeaderView *headerView;

@property(nonatomic,strong)WL_Mine_personInfo_userInfoModel *PersonInfoModel; // 个人资料

@end

@implementation WL_MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor =BgViewColor;
    
    [self setNavigationLeftImg:@""];
   
    [self initUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];
   
    self.navigationController.navigationBar.hidden = YES;
    
    [self initData];
    
    [self loadData];
    [self loadAccountData];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
     self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(UITableView *)tableView
{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-20, ScreenWidth, ScreenHeight-49+20) style:UITableViewStylePlain];
        
        _tableView.delegate =self;
        
        _tableView.dataSource =self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.tableFooterView =[UIView new];
        
        _tableView.backgroundColor = BgViewColor;
        
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.scrollEnabled =NO;
    }

    return _tableView;
}
-(void)initData
{
    self.titleArray = [NSArray arrayWithObjects:@[@"资金账户",@"设置"],@[@"打小报告"], nil];
    
    self.imageArray =[NSArray arrayWithObjects:@[@"zijinzhanghu",@"shezhi"],@[@"daxiaobaogaoImg"], nil];
}
-(void)initUI
{
   
    [self.view addSubview:self.tableView];
    
    WS(ws);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self showHud];
        
        [ws loadData];
        
    }];

    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_header = header;
    
    if (_headerView==nil) {
        if (IsiPhone4||IsiPhone5) {
            
            _headerView =[[WL_Mine_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(294))];
        }else
        {
            _headerView =[[WL_Mine_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(265))];
        }
    }
   
    self.tableView.tableHeaderView = _headerView;
    
    // 设置点击事件
    [_headerView.imageClickButton addTarget:self action:@selector(imageClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView.codeButton addTarget:self action:@selector(imageClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView.codeImgBtn addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadData
{
    [[WLNetworkDriverHandler sharedInstance] requestUserInfoWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        //隐藏菊花
        [self hidHud];
        
        if (responseType == 0) {
            _PersonInfoModel = [[WL_Mine_personInfo_userInfoModel alloc] initWithDict:data];
            
            _headerView.nameLabel.text = ([_PersonInfoModel.nickname isEqual: @""])?_PersonInfoModel.username:_PersonInfoModel.nickname;
            _headerView.contentLabel.text = _PersonInfoModel.note;
            [_headerView.photoImage sd_setImageWithURL:[NSURL URLWithString:_PersonInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
            
            [_tableView reloadData];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"网络请求失败,请稍后重试"];
        }
    }];
}

#pragma mark ---- 头像点击事件，姓名点击事件，

-(void)imageClickButton
{
    WL_Mine_PersonInfo_ViewController *VC=[[WL_Mine_PersonInfo_ViewController alloc]init];
    
    VC.hidesBottomBarWhenPushed =YES;
    
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ---- 二维码图标
-(void)codeButtonClick
{
    //WL_Mine_personInfo_CompanyInfoModel * model = _PersonInfoModel.companyArray[0];
    
    WL_Mine_PersonInfo_QRcode_ViewController *VC =[[WL_Mine_PersonInfo_QRcode_ViewController alloc]init];
    
    VC.hidesBottomBarWhenPushed =YES;
    VC.userName = _PersonInfoModel.username;
    VC.nickName = _PersonInfoModel.nickname;
    VC.phoneNO = [WLUserTools getUserMobile];//model.mobile;
    VC.headImage = _PersonInfoModel.avatar;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}
#pragma mark ----  tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else if (section == 1)
    {
        return 2;
    }
    else if (section == 2)
    {
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 0;
        
    }
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if (section==0) {
        
        return 0.0;
    }
        
    return ScaleH(15);
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
        
//        WL_MineViewController_CapitalCell *cell =[[WL_MineViewController_CapitalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.buttonClickBlock =^(ClickType type)
//        {
//           
//            WlLog(@"222==%ld",(long)type);
//            
//            if (type == ClickTypeBalance) {
//                余额点击，-充值、提现
//                WL_MyBalance_ViewController *VC =[[WL_MyBalance_ViewController alloc]init];
//                
//                VC.hidesBottomBarWhenPushed = YES;
//                
//                [self.navigationController pushViewController:VC animated:YES];
//                
//            }
//            
//        };
        
        return nil;
    }
    
    static NSString *cellID =@"cellIdentifier";
    
    WL_MineViewController_cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[WL_MineViewController_cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    cell.nameLabel.text = self.titleArray[indexPath.section-1][indexPath.row];
    
    cell.leftImageVIew.image =[UIImage imageNamed:self.imageArray[indexPath.section-1][indexPath.row]];
    
    if (indexPath.section ==1 &&indexPath.row==0) {
        
//        [cell setCellString:@"1888.88" isShow:YES];
    }
    
    if (indexPath.section==1 &&indexPath.row==1) {
       
        [cell setCellString:@"" isShow:NO];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1 && indexPath.row ==0) {
        
        WL_FundAccount_ViewController *VC =[[ WL_FundAccount_ViewController alloc]init];
     
        VC.hidesBottomBarWhenPushed =YES;
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }
    else if (indexPath.section ==1 && indexPath.row ==1)
    {
        WL_Mine_SetViewController *setVC =[[WL_Mine_SetViewController alloc]init];
        
        setVC.hidesBottomBarWhenPushed =YES;
        
        [self.navigationController pushViewController:setVC animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        WLFeedBackViewController * nextVC = [[WLFeedBackViewController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)loadAccountData
{
    WS(weakSelf);
    [WLNetworkAccountHandler requestFundAccountWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            
            WLFundAccountObject *object = data;
            WL_MineViewController_cell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            [cell setCellString:object.total_asset isShow:YES];;
            
        }
    }];
}
@end
