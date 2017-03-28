//
//  WL_PrivateLetter_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  私信列表主控制器

#import "WL_PrivateLetter_ViewController.h"
#import "WL_privateLetter_Model.h"
#import "WL_privateLetterCell.h"
#import "WL_PrivateDetail_ViewController.h"
#import "WL_EditPrivateLetter_ViewController.h"
#import "WLAllGroupHeader.h"
#import "WLNetworkMessageHandler.h"

@interface WL_PrivateLetter_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *privateLetterTableView;
@property(nonatomic, strong) NSMutableArray *privateLetterArray;
@property(nonatomic, assign) NSUInteger type;
@property(nonatomic, assign) NSUInteger page;
@property(nonatomic, strong) WL_NoData_View *noDataView;
@property (nonatomic, assign) BOOL firstRefresh;

@end

static NSString *cellID = @"cellID";

@implementation WL_PrivateLetter_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    self.title =@"私信";
    [self setNavigationRightImg:@"EditPrivate"];
    self.type = 0;
    self.page = 1;
    self.firstRefresh = YES;
    [self createTopView];
    [self setupTableView];
    [self setupNoDataView];
    [self loadData];
}

-(void)createTopView{

    WS(weakSelf);
    WLAllGroupHeader *header = [[WLAllGroupHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)
                                                             textArray:@[@"全部",@"收到的",@"发出的",@"收藏"]
                                                          selectAction:^(NSUInteger index) {
                                                              weakSelf.type = index;
                                                              weakSelf.firstRefresh = YES;
                                                              [weakSelf loadData];
                                                              
                                                          }];
    [self.view addSubview:header];

}

-(void)setupTableView{
    
    _privateLetterTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40) style:UITableViewStyleGrouped];
    _privateLetterTableView.dataSource = self;
    _privateLetterTableView.delegate = self;
    [_privateLetterTableView registerClass:[WL_privateLetterCell class] forCellReuseIdentifier:cellID];
    _privateLetterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WS(weakSelf);
    _privateLetterTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf loadData];
    }];
    _privateLetterTableView.tableFooterView =[UIView new];
    [self.view addSubview:_privateLetterTableView];
}

-(void)loadData{
    
    WS(weakSelf);
    [self showHud];
    if (self.firstRefresh) {
        [self.privateLetterArray removeAllObjects];
    }
    [WLNetworkMessageHandler requestPrivateLettersWithType:self.type
                                                      page:self.page
                                                  pageSize:10
                                                 dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                     
                                                     [weakSelf hidHud];
                                                     if (!weakSelf.firstRefresh) {
                                                         [weakSelf.privateLetterTableView.mj_footer endRefreshing];
                                                     }
                                                     if (responseType == WLResponseTypeSuccess) {
                                                         
                                                         [weakSelf.privateLetterArray addObjectsFromArray:data];
                                                         if (weakSelf.page ==1 && weakSelf.privateLetterArray.count ==0) {
                                                             
                                                             [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
                                                             weakSelf.privateLetterTableView.hidden =YES;
                                                             
                                                         }else{
                                                             weakSelf.privateLetterTableView.hidden =NO;
                                                             weakSelf.noDataView.hidden =YES;
                                                         }
                                                         if (weakSelf.privateLetterArray.count < 10*weakSelf.page){
                                                             weakSelf.privateLetterTableView.mj_footer.hidden=YES;
                                                         }else{
                                                             weakSelf.privateLetterTableView.mj_footer.hidden=NO;
                                                         }
                                                         [weakSelf.privateLetterTableView reloadData];
                                                         
                                                     }else if (responseType == WLResponseTypeNoNetwork){
                                                         
                                                         [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
                                                     }else{
                                                         
                                                         [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
                                                     }
                                                 }];
    
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.privateLetterArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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

#pragma mark UITableViewDelegate
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

#pragma mark cell删除按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    WS(weakSelf);
    WL_privateLetter_Model *model = self.privateLetterArray[indexPath.section];
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){

        [WLNetworkMessageHandler deletePrivateLetterWithLetterID:model.letterId
                                                  operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                                      if (responseType == WLResponseTypeSuccess) {
                                                          [[WL_TipAlert_View sharedAlert]createTip:@"操作成功"];
                                                          [weakSelf.privateLetterArray removeObject:model];
                                                          [weakSelf.privateLetterTableView beginUpdates];
                                                          [weakSelf.privateLetterTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                          [weakSelf.privateLetterTableView endUpdates];
                                                      }else{
                                                          [[WL_TipAlert_View sharedAlert]createTip:@"操作失败"];
                                                      }
                                                  }];
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    NSString *titleString =@"收藏";
    NSUInteger type = 1;
    if ([model.isCollect integerValue]==1){
         titleString = @"取消收藏";
         type = 0;
    }
    
    UITableViewRowAction *selectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:titleString handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [WLNetworkMessageHandler handlePrivateLetterWithLetterID:model.letterId
                                                            type:type
                                                  operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                                      
                                                      if (responseType == WLResponseTypeSuccess) {
                                                          [[WL_TipAlert_View sharedAlert]createTip:@"操作成功"];
                                                          if (type == 0) {//收藏
                                                              model.isCollect = [NSNumber numberWithInt:0];
                                                          }else{
                                                              model.isCollect = [NSNumber numberWithInt:1];
                                                          }
                                                          [weakSelf.privateLetterTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                          
                                                      }else{
                                                          [[WL_TipAlert_View sharedAlert]createTip:@"操作失败"];
                                                      }
                                                  }];
    }];
    
    selectRowAction.backgroundColor = WLColor(245, 192, 78, 1);
    
    return @[deleteRowAction,selectRowAction];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}

-(void)NavigationRightEvent
{
    WL_EditPrivateLetter_ViewController *VC =[[WL_EditPrivateLetter_ViewController alloc]init];
    [DEFAULTS setObject:@"1" forKey:@"adressbook"];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma makr - 设置无数据提示的显示、隐藏及类型
//无数据提示
- (void)setupNoDataView {
    if (_noDataView == nil) {
        WS(ws);
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40) andRefreshBlock:^{
            [ws loadData];
        }];
        _noDataView.hidden = YES;
        [self.view addSubview:_noDataView];
    }
    
}

- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    if (!hidden) {
        self.noDataView.type = type;
    }
}

-(NSMutableArray *)privateLetterArray
{
    if (_privateLetterArray==nil) {
        _privateLetterArray =[[NSMutableArray alloc]init];
    }
    return _privateLetterArray;
}
@end
