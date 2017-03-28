//
//  WLWriteOffListViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/5.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLWriteOffListViewController.h"
#import "WLWriteOffDetailViewController.h"
#import "WL_Application_Driver_Bill_TableHeaderView.h"
#import "WLNetworkWriteOffHandler.h"
#import "WLWriteOffListObject.h"

@interface WLWriteOffListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * listTable;
/** 列表中每组的表头View */
@property(nonatomic, weak) WL_Application_Driver_Bill_TableHeaderView *titleView;

/** 是否展开 */
@property (nonatomic, strong)NSMutableArray<NSNumber *> *isExpland;//是否展开

@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation WLWriteOffListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    self.titleItem.title = @"核销记录";
    
    _isExpland = [NSMutableArray arrayWithObjects:@"1",@"1",@"0", nil];
    _dataArr = [[NSMutableArray alloc] init];
    
    [self setUI];
    [self setNet];
}

- (void)setUI
{
    //_listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 30) style:UITableViewStyleGrouped];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    [self.view addSubview:_listTable];
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (void)setNet
{
    [WLNetworkWriteOffHandler requestWriteOffListWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            //_dataArr = [[NSMutableArray alloc] init];
            _dataArr = [data copy];
        }
        else if (responseType == WLResponseTypeNoNetwork)
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"无网络"];
        }
        else if (responseType == WLResponseTypeNoNetwork)
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"服务器错误"];
        }
        
        [_listTable reloadData];
    }];
}

- (NSMutableArray<NSNumber *> *)isExpland
{
    if (!_isExpland) {
        _isExpland = [NSMutableArray array];
    }
    return _isExpland;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.isExpland[section] boolValue])
    {
        WLWriteOffListObject * dataa =_dataArr[section];
        return dataa.items.count;
    }
    else
    {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //tableView每个分组的头部视图
    WL_Application_Driver_Bill_TableHeaderView *titleView = [[WL_Application_Driver_Bill_TableHeaderView alloc] init];
        
    titleView.backgroundColor = [WLTools stringToColor:@"#f0f3f8"];
    titleView.indicatorButton.tag = section;
    if ([self.isExpland[section] isEqual: @0])
    {
        titleView.indicatorButton.selected = NO;
    }
    else
    {
        titleView.indicatorButton.selected = YES;
    }
    [titleView.indicatorButton addTarget:self action:@selector(indicatorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    WLWriteOffListObject * dataa =_dataArr[section];

    titleView.titleLable.text = [NSString stringWithFormat:@"%@年%@月",dataa.year,dataa.month];//@"2016年10月";
    titleView.balanceTitleLable.text = @"核销: ";
    titleView.balanceLable.text = [NSString stringWithFormat:@"%@单",dataa.num];//@"200单";

    
    
    self.titleView = titleView;
    return titleView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_listTable dequeueReusableCellWithIdentifier:@"listCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"listCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//选中不变颜色
    
    WLWriteOffListObject * dataa =_dataArr[indexPath.section];
    WLWriteOffListItemObject * model = dataa.items[indexPath.row];
    
    cell.textLabel.text = model.date;//@"10月28日";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@单",model.num];//@"1500单";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLWriteOffListObject * dataa =_dataArr[indexPath.section];
    WLWriteOffListItemObject * model = dataa.items[indexPath.row];
    
    WLWriteOffDetailViewController * nextVC = [[WLWriteOffDetailViewController alloc] init];
    nextVC.dataStr = model.date;
    nextVC.howStr = model.num;
    [self.navigationController pushViewController:nextVC animated:YES];
}

//每个与账单titleView上的指示器按钮被点击
- (void)indicatorButtonClick:(UIButton *)button
{
    NSInteger section = button.tag;
    button.selected = !button.selected;
    if (button.selected)
    {
        self.isExpland[section] = @1;
        
        [self.listTable reloadData];
        
    }
    else
    {
        self.isExpland[section] = @0;
        
        [self.listTable reloadData];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
