//
//  WL_LookMore_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  查看更多页面

#import "WL_LookMore_ViewController.h"

#import "WL_Friendlist_Model.h"

#import "WL_SearchFriend_Cell.h"

#import "WL_SearchResult_Cell.h"

#import "WL_MessageViewController.h"

#import "WL_TabBarController.h"

#import "WL_AddressBook_LinkManDetail_ViewController.h"

@interface WL_LookMore_ViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic,strong)UISearchBar *search;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

//@property (nonatomic,strong) UISearchController *searchVC;



@end

@implementation WL_LookMore_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    
    //self.navigationController.navigationBar.hidden =YES;
    
    self.search =[[UISearchBar alloc]initWithFrame:CGRectMake(40, 0, ScreenWidth-90, 44)];
    
    [self.navigationController.navigationBar addSubview:self.search];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        [self.search setFrame:CGRectMake(40, 0, ScreenWidth-90, 44)];
//        
//    }];
    
    self.search.delegate = self;
    
    self.search.tintColor = [WLTools stringToColor:@"#4877e7"];
    
    self.search.text = self.searchText;
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    
    [button addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = systemFont(16);
    
    [button setTitle:@"取消" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -15;
    //将两个BarButtonItem都返回给NavigationItem
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightBarBtn];

    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    
    self.search.hidden = NO;
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.search.hidden = YES;
    
    self.search.delegate = nil;
}


-(NSMutableArray*)dataArray
{
    if (_dataArray==nil) {
        
        _dataArray =[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        
        _tableView.dataSource =self;
        
        _tableView.delegate =self;
        
        _tableView.tableFooterView =[UIView new];
        
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    }

    return _tableView;
}


#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect rect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.tableView.height = ScreenHeight - rect.size.height-64;
    
}
#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    self.tableView.height = ScreenHeight -64;
}
-(void)loadData

{
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"keyword":self.searchText,@"type":self.searchType};
    
    [[WLHttpManager shareManager]requestWithURL:SearchsearchMessageUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([net_model.result integerValue]==1) {
            
        if ([self.searchType isEqualToString:@"1"]) {
        
        self.dataArray = [WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"friendList"] context:nil];
        
        }else if ([self.searchType isEqualToString:@"2"])
        {
           self.dataArray = [WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"letterList"] context:nil];
            
        }else if ([self.searchType isEqualToString:@"3"])
        {
           self.dataArray = [WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"noticeList"] context:nil];
        }else if ([self.searchType isEqualToString:@"4"])
        {
            self.dataArray = [WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"messageList"] context:nil];
        }
    }
        
    [self.tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        
    }];

}

-(void)cancelButtonClick
{
    
    NSArray *Array = self.navigationController.viewControllers;
    
    self.tableView.hidden =YES;
    
    WL_MessageViewController * VC = Array[0];
    
    [self.navigationController popToViewController:VC animated:NO];
    
    self.search.delegate =nil;
    
    //[self.search removeFromSuperview];
    
    VC.search.active = NO;
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    self.search.delegate =nil;
    
    [self.search removeFromSuperview];
    
    if (self.popBlock) {
        
        self.popBlock([NSString stringWithFormat:@"%@%@",searchBar.text,text]);
    }
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataArray.count;
    
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

    return 0.01;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    
    sectionView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [WLTools allocLabel:@"" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake(15, 0, ScreenWidth-15, 45) textAlignment:NSTextAlignmentLeft];

    if ([self.searchType isEqualToString:@"1"]) {
       
        label.text = @"微叮好友";
        
    }else if ([self.searchType isEqualToString:@"2"])
    {
        label.text = @"私信";
        
    }else if ([self.searchType isEqualToString:@"3"])
    {
        label.text = @"公告";
    }else if ([self.searchType isEqualToString:@"4"])
    {
        label.text = @"消息";
    }

    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(10, 44.5, ScreenWidth-10, 0.5)];
    
    line.backgroundColor = bordColor;
    
    [sectionView addSubview:line];
    
    [sectionView addSubview:label];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

   static NSString *reuseIdentifier1 = @"reuseIdentifier1";
        
    WL_SearchFriend_Cell *cell =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
        
    if (cell==nil) {
            
    cell =[[WL_SearchFriend_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier1];
    }
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WL_MessageList_itemsModel *model = self.dataArray[indexPath.row];
        
    cell.model = model;
        
    return cell;
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.searchType isEqualToString:@"1"]) {
        
        WL_Friendlist_Model *model = self.dataArray[indexPath.row];
        
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
        
        VC.isCompany = @"1";
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}


@end
