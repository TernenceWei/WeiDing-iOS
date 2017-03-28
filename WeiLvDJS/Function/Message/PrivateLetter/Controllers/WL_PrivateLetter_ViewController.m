//
//  WL_PrivateLetter_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_PrivateLetter_ViewController.h"

#import "WL_privateLetter_Model.h"

#import "WL_privateLetterCell.h"

#import "WL_PrivateDetail_ViewController.h"

#import "WL_EditPrivateLetter_ViewController.h"

@interface WL_PrivateLetter_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *markLabel;

@property(nonatomic,strong)UITableView *privateLetterTableView;

@property(nonatomic,strong)NSMutableArray *privateLetterArray;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)WL_NoData_View *noDataView;

@end


static NSString *cellID = @"cellID";

@implementation WL_PrivateLetter_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BgViewColor;
    
    self.title =@"私信";
    
    self.type =@"0";
    
    self.page = 1;
    
    [self createTopView];
    
    [self.view addSubview:self.privateLetterTableView];
    
    [self.view addSubview:self.noDataView];
    
    [self setNavigationRightImg:@"EditPrivate"];
    
    [self initData];
}

-(NSMutableArray *)privateLetterArray
{
    if (_privateLetterArray==nil) {
        
        _privateLetterArray =[[NSMutableArray alloc]init];
    }
    
    return _privateLetterArray;
}

-(void)NavigationRightEvent
{
    WL_EditPrivateLetter_ViewController *VC =[[WL_EditPrivateLetter_ViewController alloc]init];
    
    [DEFAULTS setObject:@"1" forKey:@"adressbook"];
    
    [self.navigationController pushViewController:VC animated:YES];
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
        WS(ws);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40) andRefreshBlock:^{
            
            
            [ws initData];
            
        }];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}



-(UITableView *)privateLetterTableView
{
    if (_privateLetterTableView==nil) {
        
        _privateLetterTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40) style:UITableViewStyleGrouped];
        _privateLetterTableView.dataSource=self;
        
        _privateLetterTableView.delegate=self;
        
        [_privateLetterTableView registerClass:[WL_privateLetterCell class] forCellReuseIdentifier:cellID];
        
        _privateLetterTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        
        WS(weakSelf);
        
        _privateLetterTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.page=self.page+1;
            
            
            [weakSelf initData];
            
            
        }];
        
        _privateLetterTableView.tableFooterView =[UIView new];
    }

    return _privateLetterTableView;
}
-(void)createTopView
{

    NSArray *titleArray = [NSArray arrayWithObjects:@"全部",@"收到的",@"发出的",@"收藏", nil];
    
    for (int i = 0; i<=3; i++) {
        
        UIButton *button =[UIButton new];
       
        button.backgroundColor =[WLTools stringToColor:@"#4877e7"];
       
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        
        [button setFrame:CGRectMake(i*ScreenWidth/4, 0, ScreenWidth/4, 40)];
        
        button.tag = 101+i;
        
        [button addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
     
        if (i==0) {
            
            self.markLabel =[[UIView alloc]init];
            
            self.markLabel.backgroundColor =[UIColor whiteColor];
            
            self.markLabel.height = 3;
            
            self.markLabel.y = 40-3;
            
            self.markLabel.width = button.intrinsicContentSize.width;
            
            self.markLabel.centerX = button.centerX;
            
        }
    
    }
      [self.view addSubview:self.markLabel];
}

-(void)typeButtonClick:(UIButton *)button

{
    
    [self.privateLetterArray removeAllObjects];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
       
       self.markLabel.height = 3;
       
       self.markLabel.y = 40-3;
       
       self.markLabel.width = button.intrinsicContentSize.width;
       
       self.markLabel.centerX = button.centerX;

   } completion:^(BOOL finished) {
       
   }];
   
    switch (button.tag) {
        case 101:
            
            self.type =@"0";
            
            break;
        case 102:
            
            self.type =@"1";
            
            break;
        case 103:
            
            self.type =@"2";
            
            break;
        case 104:
            
            self.type =@"3";
            
            break;
        default:
            break;
    }

    [self initData];
}

-(void)initData

{
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"type":self.type,@"page":@(self.page),@"pageSize":@"5"};
    
    WS(weakSelf);
    
    [self showHud];
    
    [[WLHttpManager shareManager]requestWithURL:LetterListUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
       
        WlLog(@"%@",responseObject);
        
        [self hidHud];
        
        WL_Network_Model *net_model =[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([net_model.result integerValue]==1) {
            
            for (NSDictionary *dic in net_model.data) {
              
                WL_privateLetter_Model *model =[WL_privateLetter_Model mj_objectWithKeyValues:dic];
                
                [self.privateLetterArray addObject:model];
                
            }
            
       
        }
        if (self.page ==1 && self.privateLetterArray.count ==0) {
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
            
            weakSelf.privateLetterTableView.hidden =YES;
            
        }else
        {
            weakSelf.privateLetterTableView.hidden =NO;
            
            weakSelf.noDataView.hidden =YES;
        }
        
        
        
        if (weakSelf.privateLetterArray.count < 5*self.page)
        {
            
            weakSelf.privateLetterTableView.mj_footer.hidden=YES;
            
        }
        else
        {
            
            weakSelf.privateLetterTableView.mj_footer.hidden=NO;
        }
        
        
        [weakSelf.privateLetterTableView.mj_footer endRefreshing];
        
        [self.privateLetterTableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidHud];
        
        [weakSelf.privateLetterTableView.mj_footer endRefreshing];
        
        if (error.code==-1009) {
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
            
        }else
        {
            [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
    
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.privateLetterArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *padView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
   
    padView.backgroundColor = BgViewColor;
    
    return padView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_privateLetterCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[WL_privateLetterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       
        
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    WL_privateLetter_Model *model = self.privateLetterArray[indexPath.section];

    cell.model = model;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    WL_privateLetter_Model *model = self.privateLetterArray[indexPath.section];
    
    WL_PrivateDetail_ViewController *VC =[[WL_PrivateDetail_ViewController alloc]init];
    
    VC.model = model;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WL_privateLetter_Model *model = self.privateLetterArray[indexPath.section];

    return [WL_privateLetterCell heightWithModel:model];
    
}

#pragma mark---定制cell删除按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    WS(weakSelf);
    
    WL_privateLetter_Model *model = self.privateLetterArray[indexPath.section];
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSString *userId = [WLUserTools getUserId];
        
        NSString *passWord =[WLUserTools getUserPassword];
        
        //进行RSA加密后的密码字符串
        NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
        
        NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"letterId":model.letterId};
        
        [weakSelf sendWith:LetterDelLetterUrl andDic:paramaters];
        
        
    }];
    
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    NSString *titleString =@"";
    
    NSString *type = @"";
    
    if ([model.isCollect integerValue]==0) {
        
        titleString = @"收藏";
        
        type = @"1";
        
    }else if ([model.isCollect integerValue]==1)
    {
         titleString = @"取消收藏";
        
         type = @"0";
    }
    
    UITableViewRowAction *selectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:titleString handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        NSString *userId = [WLUserTools getUserId];
        
        NSString *passWord =[WLUserTools getUserPassword];
        
        //进行RSA加密后的密码字符串
        NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
        
        NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"type":type,@"letterId":model.letterId};
        
        
        [weakSelf sendWith:LetterHandelCollectUrl andDic:paramaters];
        
        
    }];
    
    selectRowAction.backgroundColor = WLColor(245, 192, 78, 1);
    
    return @[deleteRowAction,selectRowAction];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  UITableViewCellEditingStyleDelete;
}



-(void)sendWith:(NSString *)urlString andDic:(NSDictionary *)dic

{
    
    [self.privateLetterArray removeAllObjects];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:urlString RequestType:RequestTypePost Parameters:dic Success:^(id responseObject) {
        
        if ([responseObject[@"result"]integerValue]==1) {
            
            [[WL_TipAlert_View sharedAlert]createTip:@"操作成功"];
            
            [weakSelf initData];
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:@"操作失败"];
        }
        
    } Failure:^(NSError *error) {
       
        [[WL_TipAlert_View sharedAlert]createTip:@"操作失败"];
        
    }];
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
