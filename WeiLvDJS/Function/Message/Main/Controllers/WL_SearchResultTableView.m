//
//  WL_SearchResultTableView.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SearchResultTableView.h"

#import "SearchCusomHistory.h"

#import "WL_Friendlist_Model.h"

#import "WL_SearchFriend_Cell.h"

#import "WL_SearchResult_Cell.h"

#import "WL_LookMore_ViewController.h"

#import "WL_AddressBook_LinkManDetail_ViewController.h"

#import "WL_NoticeDetail_ViewController.h"

@interface WL_SearchResultTableView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)SearchCusomHistory *searchCusomView;

@property(nonatomic,strong)NSMutableArray *searchResultArray;

@property(nonatomic,strong)WL_NoData_View *noDataView;

@end

@implementation WL_SearchResultTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchCusomView];
    
    self.tableView.delegate =self;
    
    self.tableView.dataSource = self;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView =[UIView new];
    
    [self.view addSubview:self.noDataView];
    
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
    _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) andRefreshBlock:^{
        
        }];;
    
    _noDataView.hidden = YES;
    }
    return _noDataView;
}
-(void)reloadDataWithArray:(NSMutableArray *)array
{
    self.searchResultArray = array;
    
    if (self.searchResultArray.count==0) {
        
        [self hideNoData:NO andType:WLNetworkTypeNOData];
        
    }else
    {
    
        self.noDataView.hidden=YES;
    }
   
    [self.tableView reloadData];
}

#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.searchResultArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  
    NSMutableDictionary *dict =self.searchResultArray[section];
    
    NSArray *array =[dict allKeys];
    
    NSArray *arr = [dict objectForKey:array[0]];
    
    if (arr.count>3) {
        
        return 3;
    }else
        
    
    return arr.count;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    NSMutableDictionary *dict =self.searchResultArray[section];
    
    NSArray *array =[dict allKeys];
    
    NSArray *arr = [dict objectForKey:array[0]];
    
    if (arr.count>3) {
        
        return 40;
    }
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    NSMutableDictionary *dict =self.searchResultArray[section];
    
    NSArray *array =[dict allKeys];
    
    NSArray *arr = [dict objectForKey:array[0]];
    
    if (arr.count>3)
    {
        UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        
        v.backgroundColor = BgViewColor;
        
        v.userInteractionEnabled = YES;
        
        UILabel *tapLabel =[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-125)/2, 0,100, 40)];
        
        tapLabel.userInteractionEnabled = YES;
        
        tapLabel.textColor = [WLTools stringToColor:@"#4877e7"];
        
        tapLabel.font =WLFontSize(16);
 
        tapLabel.textAlignment =NSTextAlignmentCenter;
        
        if ([array[0] isEqualToString:@"微叮好友"]) {
         
            tapLabel.text = @"查看更多好友";
            
            tapLabel.tag = 101;
            
        }else if ([array[0] isEqualToString:@"私信"])
        {
            tapLabel.text = @"查看更多消息";
            
            tapLabel.tag = 102;
            
        }else if ([array[0] isEqualToString:@"公告"])
        {
            tapLabel.text = @"查看更多私信";
            
            tapLabel.tag =103;
            
        }else if ([array[0] isEqualToString:@"消息"])
        {
            tapLabel.text = @"查看更多提醒";
            
            tapLabel.tag =104;
        }
        [v addSubview:tapLabel];
        
        UIImageView *imView =[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(tapLabel)+10, (40-15)/2, 7, 15)];
        
        imView.image = [UIImage imageNamed:@"arrow"];
        
        [v addSubview:imView];
        
        UIGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Gesture:)];
        
        [tapLabel addGestureRecognizer:tapGesture];
        
        return v;
    }

    UIView *v =[UIView new];
    
    return v;
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    
    sectionView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [WLTools allocLabel:@"" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake(15, 0, ScreenWidth-15, 45) textAlignment:NSTextAlignmentLeft];
    
    NSMutableDictionary *dict =self.searchResultArray[section];
    
    NSArray *array =[dict allKeys];

    label.text = array[0];
    
    [sectionView addSubview:label];
    
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(10, 44.5, ScreenWidth-10, 0.5)];
    
    line.backgroundColor = bordColor;
    
    [sectionView addSubview:line];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSMutableDictionary *dict =self.searchResultArray[indexPath.section];
    
    NSArray *array =[dict allKeys];
    
    if ([array[0] isEqualToString:@"微叮好友"]) {
        
    }

    static NSString *reuseIdentifier1 = @"reuseIdentifier1";
        
    WL_SearchFriend_Cell *cell =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
        
    if (cell==nil) {
        
      cell =[[WL_SearchFriend_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier1];
    }
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    NSMutableArray *arr = [dict objectForKey:array[0]];

    WL_Friendlist_Model *model = arr[indexPath.row];
            
    cell.model = model;

    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dict =self.searchResultArray[indexPath.section];
    
    NSArray *array =[dict allKeys];
    
    if ([array[0] isEqualToString:@"微叮好友"]) {
      
        NSMutableArray *arr = [dict objectForKey:array[0]];
        
        WL_Friendlist_Model *model = arr[indexPath.row];
        
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        //取得第一个Documents文件夹的路径
        
        NSString *filePath = [pathArray objectAtIndex:0];
        
        //把TestPlist文件加入
        NSString *plistPath = [filePath stringByAppendingPathComponent:@"SearchHistory.plist"];
        
        NSMutableArray *mutableArray =[NSMutableArray arrayWithContentsOfFile:plistPath];
        
        if (![mutableArray containsObject:model.name]) {
            
            [mutableArray addObject:model.name];
        }
  
        [mutableArray writeToFile:plistPath atomically:YES];
        
        WL_AddressBook_LinkManDetail_ViewController *VC =[[WL_AddressBook_LinkManDetail_ViewController alloc]init];
        
        VC.view_id = model.ID;
        
        VC.isCompany = model.isCompany;
        
        VC.hidesBottomBarWhenPushed = YES;
        
        [self.presentingViewController.navigationController pushViewController:VC animated:YES];
    
    }else if ([array[0] isEqualToString:@"公告"])
    {
        WL_NoticeDetail_ViewController *VC =[[WL_NoticeDetail_ViewController alloc]init];
        
         NSMutableArray *arr = [dict objectForKey:array[0]];
        
        WL_Friendlist_Model *model = arr[indexPath.row];
        
        VC.hidesBottomBarWhenPushed = YES;
        
        VC.typeOfPush = 1;
        
        VC.notice_id = model.ID;
        
        [self.presentingViewController.navigationController pushViewController:VC animated:YES];
    }
   
}

-(void)Gesture:(UIGestureRecognizer *)tap
{
    
    WlLog(@"%lu",[tap view].tag);
    
    NSString *type =@"";
    
    if ([tap view].tag ==101) {
        
      type = @"1";
        
    }else if ([tap view].tag ==102)
    {
        type = @"2";
        
    }else if ([tap view].tag ==103)
    {
        type = @"3";
    }else if ([tap view].tag ==104)
    {
        type = @"4";
    }
    
    WL_LookMore_ViewController *VC =[[WL_LookMore_ViewController alloc]init];
    
    WS(weakSelf);
    
    VC.popBlock  = ^(NSString *text){
      
        if (weakSelf.popSearchTextBlock) {
            
           
            weakSelf.popSearchTextBlock(text);
        }
        
    };
    
    VC.searchText = self.searchText;
    
    VC.searchType = type;
    
    VC.hidesBottomBarWhenPushed =YES;

    [self.presentingViewController.navigationController pushViewController:VC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
