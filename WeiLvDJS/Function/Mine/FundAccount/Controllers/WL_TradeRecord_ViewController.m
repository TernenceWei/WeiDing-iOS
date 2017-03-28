//
//  WL_TradeRecord_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_TradeRecord_ViewController.h"

#import "WL_TradeRecord_ViewController_Cell.h"

#import "WL_ConditionSelectionView.h"

#import "WL_TradeRecord_Model.h"

#import "WL_TransferRecordCell.h"
@interface WL_TradeRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger page;
}
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *titleView;

@property(nonatomic,strong)WL_ConditionSelectionView *conditionView;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,strong)NSMutableArray *baseArray;

@property(nonatomic,strong)WL_NoData_View *noDataView;
@end

@implementation WL_TradeRecord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    
    self.navigationItem.titleView = self.titleView;
    
    page = 1;
    
    self.type =@"0";
    
   
    
    [self initData];
}

-(NSMutableArray *)baseArray
{
    if (_baseArray ==nil) {
        
        
        _baseArray =[NSMutableArray arrayWithCapacity:0];
    }

    return _baseArray;
}

-(UIButton *)titleView
{
    if (_titleView==nil) {
        
        _titleView =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        
        [_titleView setTitle:@"交易记录" forState:UIControlStateNormal];
        
        [_titleView setImage:[UIImage imageNamed:@"Account_down"] forState:UIControlStateNormal];
        
        [_titleView setImage:[UIImage imageNamed:@"Account_up"] forState:UIControlStateSelected];
        
        [_titleView addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _titleView.titleLabel.font =WLFontSize(17);
        
        [_titleView setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0,0)];
        
        [_titleView setImageEdgeInsets:UIEdgeInsetsMake(0,80, 0, 0)];
        
    }
    return _titleView;
    
}

-(void)titleViewClick:(UIButton *)button

{
    [self.view addSubview:self.conditionView];
    
    button.selected =!button.selected;
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [_conditionView.layer addAnimation:animation forKey:nil];

    _conditionView.hidden = !button.selected;
    
}

#pragma mark - 筛选视图 懒加载
-(WL_ConditionSelectionView *)conditionView
{
    if (_conditionView == nil) {
        
        _conditionView =[[WL_ConditionSelectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavHeight)];
        
        _conditionView.hidden = YES;
        
        WS(weakSelf);
        
        _conditionView.tapBlock =^(){
            
          
        };
        _conditionView.confirmButtonClick = ^(UIButton *button)
        {
            
            weakSelf.conditionView.hidden =YES;
            
            weakSelf.titleView.selected = NO;
            
            if ([button.currentTitle isEqualToString:@"充值"]) {
                
                weakSelf.type =@"1";
                
                page = 1;
                
            }else if ([button.currentTitle isEqualToString:@"提现"])
            {
                weakSelf.type =@"2";
                
                page = 1;
                
            }else if ([button.currentTitle isEqualToString:@"收款"])
            {
                weakSelf.type =@"3";
                
                page = 1;
                
            }else if ([button.currentTitle isEqualToString:@"付款"])
            {
                weakSelf.type =@"4";
                
                page = 1;
            }else if ([button.currentTitle isEqualToString:@"全部"])
            {
                weakSelf.type =@"0";
                
                page = 1;
            }else if ([button.currentTitle isEqualToString:@"转账"])
            {
                weakSelf.type =@"5,6";
                
                page = 1;
            }
          
            [weakSelf initData];
            
        };
        
    }
    return _conditionView;
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
         WS(ws);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            
            page = 1;
            
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

        
        weakSelf.tableView.mj_header = header;
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            page=page+1;
            
            
            [weakSelf initData];
            
            
        }];

        _tableView.tableFooterView =[UIView new];
        
    }
    
    [self.view addSubview:_tableView];
    
     [self.view addSubview:self.noDataView];
    
    return _tableView;
}

-(void)initData

{
    
    NSString *user_id =[WLUserTools getUserId];
    
    NSString *user_password = [WLUserTools getUserPassword];
    
    NSString *entr =[MyRSA encryptString:user_password publicKey:RSAKey];
    
    NSDictionary *parameters = @{@"user_id":user_id,@"user_password":entr,@"type":self.type,@"page":@(page)};
    
    WS(weakSelf);
    
    [self showHud];
    
    [[WLHttpManager shareManager]requestWithURL:FinanceRecordUrl RequestType:RequestTypePost Parameters:parameters Success:^(id responseObject) {
       
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
             
             weakSelf.tableView.hidden = YES;
             WlLog(@"暂无明细");
             [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
             
         }else
         {
             weakSelf.tableView.hidden = NO;
             
             weakSelf.noDataView.hidden =YES;
         }
       
        [weakSelf hidHud];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } Failure:^(NSError *error) {
       
        [weakSelf hidHud];
        
        if (error.code ==-1009)
        {
            
            weakSelf.tableView.hidden = YES;
            
            [[WL_TipAlert_View sharedAlert]createTip:@"似乎与互联网断开了链接"];
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:@"服务器错误,请稍后重试"];
        }
        weakSelf.tableView.mj_footer.hidden =YES;
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
        
    }];
}


#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.baseArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // WL_TradeRecord_ViewController_Cell *cell = (WL_TradeRecord_ViewController_Cell*)[tableView cellForRowAtIndexPath:indexPath];
   
    WL_TradeRecord_Model *model = self.baseArray [indexPath.row];
    
    if ([model.finance_type isEqualToString:@"5"]||[model.finance_type isEqualToString:@"6"]) {
        
        return 85;
    }
    
    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    WL_TradeRecord_Model *model = self.baseArray [indexPath.row];
    
    if ([model.finance_type isEqualToString:@"5"]||[model.finance_type isEqualToString:@"6"]) {
        
        static NSString *cellID2 = @"cellID2";

        WL_TransferRecordCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID2];
        
        if (cell==nil) {
            
            cell =[[WL_TransferRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        
        cell.model =model;
        
        return cell;
        
    
    }else
        
    {
       
        static NSString *cellID = @"cellID";
        
        WL_TradeRecord_ViewController_Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell==nil) {
            
            cell =[[WL_TradeRecord_ViewController_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        
        
        cell.model = model;
        
        return cell;
        
    }
    
   
    return nil;
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
