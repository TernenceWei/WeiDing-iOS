//
//  WL_DepositList_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_DepositList_ViewController.h"

#import "WL_TradeRecord_Model.h"

#import "WL_TradeRecord_ViewController_Cell.h"
@interface WL_DepositList_ViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger page;
}

@property(nonatomic,strong)WL_NoData_View *noDataView;

@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,strong)NSMutableArray *baseArray;

@end

@implementation WL_DepositList_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.title =@"提现记录";
    
    self.view.backgroundColor = BgViewColor;
    
    page =1;
    
    [self initData];
}

-(NSMutableArray *)baseArray
{
    if (_baseArray ==nil) {
        
        
        _baseArray =[NSMutableArray arrayWithCapacity:0];
    }
    
    return _baseArray;
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
         WS(ws);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
          
            
            [ws initData];
            
        }];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}



-(UITableView *)tableView
{
    if (_tableView ==nil) {
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        
        _tableView .delegate= self;
        
        _tableView.dataSource =self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        WS(weakSelf);
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            page = 1;
            
            [weakSelf initData];
            
        }];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        // 设置文字
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        
        _tableView.mj_header =header;
        
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            page=page+1;
            
            
            [weakSelf initData];
            
            
        }];
        _tableView.tableFooterView =[UIView new];
        
    }
    
    [self.view addSubview:_tableView];
    
    return _tableView;
}

-(void)initData

{
    
    NSString *user_id =[WLUserTools getUserId];
    
    NSString *user_password = [WLUserTools getUserPassword];
    
    NSString *entr =[MyRSA encryptString:user_password publicKey:RSAKey];
    
    NSDictionary *parameters = @{@"user_id":user_id,@"user_password":entr,@"type":@"2",@"page":@(page)};
    
    WS(weakSelf);
    
    [self showHud];
    
    [[WLHttpManager shareManager]requestWithURL:FreezeLogRecordUrl RequestType:RequestTypePost Parameters:parameters Success:^(id responseObject) {
        
        WL_Network_Model *netWorkModel =[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        WlLog(@"%@",netWorkModel);
        
        
        if (page ==1) {
            
            [weakSelf.baseArray removeAllObjects];
            
        }
        if ([netWorkModel.result isEqualToString:@"1"]) {
            
            for (id obj in netWorkModel.data) {
                
                WL_TradeRecord_Model *model =[WL_TradeRecord_Model mj_objectWithKeyValues:obj];
                
                [weakSelf.baseArray addObject:model];
            }
        }
        
        if (weakSelf.baseArray.count < 10*page)
        {
            
            weakSelf.tableView.mj_footer.hidden=YES;
            
        }
        else
        {
            
            weakSelf.tableView.mj_footer.hidden=NO;
        }
        
        if (weakSelf.baseArray.count == 0 && page == 1)
        {
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
            
        }else
        {
            
        }
        
        [weakSelf hidHud];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
       
        if (error.code ==-1009)
        {
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
            
        }else
        {
           
            [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
            
        }
        [weakSelf.tableView.mj_header endRefreshing];
        
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.baseArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    WL_TradeRecord_ViewController_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[WL_TradeRecord_ViewController_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    
    cell.model = self.baseArray[indexPath.row];
    
    return cell;
}

#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
