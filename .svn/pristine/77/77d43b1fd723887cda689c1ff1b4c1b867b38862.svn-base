//
//  WL_AnnouncementList_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AnnouncementList_ViewController.h"

#import "WL_Announce_TableViewCell.h"

#import "WL_Announce_Model.h"

#import "WL_NoticeDetail_ViewController.h"

@interface WL_AnnouncementList_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *announcementTableView;

@property(nonatomic,strong)NSMutableArray *announceArray;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)WL_NoData_View *noDataView;

@end

@implementation WL_AnnouncementList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"微叮公告";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.announcementTableView];
    
    [self.view addSubview:self.noDataView];
    
    self.page = 0;
    
    [self initData];
}

-(NSMutableArray *)announceArray
{
    if (_announceArray==nil) {
        
        _announceArray =[[NSMutableArray alloc]init];
    }
    return _announceArray;
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) andRefreshBlock:^{
            
            [weakSelf initData];
        
        }];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}

-(UITableView *)announcementTableView
{
    if (_announcementTableView==nil) {
        
        _announcementTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        
        _announcementTableView.delegate =self;
        
        _announcementTableView.dataSource =self;
        
        WS(weakSelf);
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.page = 0;
            
            [weakSelf initData];
            
        }];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        // 设置文字
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        
        _announcementTableView.mj_header = header;

        _announcementTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.page=self.page+1;
            
            [weakSelf initData];
        
        }];
    }

    return _announcementTableView;
}
-(void)initData

{
   
    [self showHud];
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"type":@"1",@"page":@(self.page),@"pageSize":@"10"};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:NoticeNoticeListUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        WlLog(@"%@",responseObject);
        
        [weakSelf hidHud];
        
        if (self.page==0) {
            
            [weakSelf.announceArray removeAllObjects];
        }
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];

        if ([net_model.result integerValue]==1) {
            
            for (NSDictionary *dic in net_model.data) {
                
                WL_Announce_Model *model =[WL_Announce_Model mj_objectWithKeyValues:dic];
                
                [self.announceArray addObject:model];
                
            }
            
        }
        
       
        
        if (weakSelf.announceArray.count < (self.page+1)*10) {
            
            weakSelf.announcementTableView.mj_footer.hidden = YES;
            
        }else
        {
            weakSelf.announcementTableView.mj_footer.hidden = NO;
        }
        
        
        if (weakSelf.page==0&&weakSelf.announceArray.count==0) {
            
            weakSelf.announcementTableView.hidden = YES;
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
            
        }else
        {
            weakSelf.announcementTableView.hidden = NO;
            
            weakSelf.noDataView.hidden = YES;
        }
        
        [weakSelf.announcementTableView.mj_header endRefreshing];
        
        [weakSelf.announcementTableView.mj_footer endRefreshing];
        
        [self.announcementTableView reloadData];
        
    } Failure:^(NSError *error) {
        
         [weakSelf hidHud];
        
        [weakSelf.announcementTableView.mj_header endRefreshing];
        
        [weakSelf.announcementTableView.mj_footer endRefreshing];
        
        if (error.code==-1009) {
            
            //weakSelf.announcementTableView.hidden = YES;
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
            
        }else
        {
            //weakSelf.announcementTableView.hidden =YES;
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
        }
 
    }];

}

#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return self.announceArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *padView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    
    padView.backgroundColor = BgViewColor;
    
    return padView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *padView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    
    padView.backgroundColor = BgViewColor;
    
    return padView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"WL_Announce_TableViewCell";
    
    WL_Announce_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[WL_Announce_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    WL_Announce_Model *model = self.announceArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_NoticeDetail_ViewController *VC =[[WL_NoticeDetail_ViewController alloc]init];
    
     WL_Announce_Model *model = self.announceArray[indexPath.row];
    
    VC.typeOfPush = 2;
    
    VC.notice_id = model.notice_id;
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
