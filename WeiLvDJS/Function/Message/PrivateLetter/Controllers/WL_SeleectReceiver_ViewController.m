//
//  WL_SeleectReceiver_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SeleectReceiver_ViewController.h"

#import "WL_SelectReceiver_Cell.h"

#import "WL_SelectReceiver_ContactsCell.h"

#import "WL_CompanyList_Model.h"

#import "WL_UsuallyContactsList_Model.h"

#import "WL_Contacts_subTittle_Cell.h"

#import "WL_MyFriendList_ViewController.h"

#import "WL_ShareArray.h"

#import "WL_Save_Model.h"

#import "WL_EditPrivateLetter_ViewController.h"

#import "WL_DepartmentsOfCompany_ViewController.h"

#import "WL_SearchResultModel.h"

#import "WL_MyFriendList_Cell.h"


#define kReuseId0 @"SelectReceiver_Cell0"

#define kReuseId1 @"SelectReceiver_Cell1"

#define kReuseId2 @"SelectReceiver_Cell2"



@interface WL_SeleectReceiver_ViewController ()<UISearchResultsUpdating,UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong) NSMutableArray *saveArr;

@property (nonatomic,strong) UISearchController *searchVC;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property(nonatomic,strong)NSMutableArray *searchArray;

@property(nonatomic,strong)NSMutableArray *companyArray;

@property(nonatomic,strong)UIView *bottomDetailView;//底部的详情view

@property(nonatomic)dispatch_group_t group;

@property(nonatomic,strong)NSMutableArray *usuallyArray;

@property(nonatomic,copy)NSString *usuallyNum;

@property(nonatomic,copy)NSString *friendNum;

@property(nonatomic,strong)UIView *inputAccessoryView;

@property(nonatomic,strong)UILabel *selectedNum;

@property(nonatomic,strong)UIButton *sureButton;

@property(nonatomic,strong)UILabel *selectedNum2;

@property(nonatomic,strong)UIButton *sureButton2;

@property(nonatomic,strong)NSMutableDictionary *originArray;//进入页面时用于存储临时字典

@property(nonatomic,strong)UITableViewController *tableVC;

@property(nonatomic,strong)WL_NoData_View *noDataView;

@end

@implementation WL_SeleectReceiver_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"选择接收人";
    self.view.backgroundColor = BgViewColor;
    
    self.originArray = [NSMutableDictionary dictionaryWithDictionary:[WL_ShareArray shareArray].saveArray];
    
    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.group=dispatch_group_create();
    
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    
    WS(weakSelf);
    
    [weakSelf showHud];
    
    dispatch_group_enter(self.group);
    
    dispatch_async(queue, ^{
        
        
        [weakSelf acquireContacts];
    });
    
    dispatch_group_enter(self.group);
    
    dispatch_async(queue, ^{
        
        [weakSelf companyList];
    });
    
    dispatch_group_enter(self.group);
    
    dispatch_async(queue, ^{
        
        [weakSelf SocialFriendCountFriend];
    });

    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        
        [weakSelf hidHud];
        
        [weakSelf createTableView];
    });
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self setLabelNumber];
    
}
-(void)setLabelNumber
{
    
    self.selectedNum.text = [NSString stringWithFormat:@"已选择:%lu人",(unsigned long)[[WL_ShareArray shareArray].saveArray allKeys].count];
    
    self.selectedNum2.text = [NSString stringWithFormat:@"已选择:%lu人",(unsigned long)[[WL_ShareArray shareArray].saveArray allKeys].count];
    
    if ([[WL_ShareArray shareArray].saveArray allKeys].count>0) {
        
        self.sureButton2.enabled =YES;
        
        self.sureButton.enabled = YES;
        
        self.sureButton.alpha = 1;
        
        self.sureButton2.alpha = 1;
        
    }else if ([[WL_ShareArray shareArray].saveArray allKeys].count==0)
    {
        self.sureButton2.enabled =NO;
        
        self.sureButton.enabled = NO;
        
        self.sureButton.alpha =0.4;
        
        self.sureButton2.alpha =0.4;
    }
    
}

-(void)SocialFriendCountFriend
{
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:SocialFriendCountFriendUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        dispatch_group_leave(self.group);
        
        WlLog(@"%@",responseObject);
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        weakSelf.friendNum = netModel.data;
        
        
    } Failure:^(NSError *error) {
        
        dispatch_group_leave(self.group);
        
    }];
    
}

-(void)companyList
{
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr};
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL:UserMyCompanyListUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        dispatch_group_leave(self.group);

        WlLog(@"%@",responseObject);
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([netModel.result integerValue]==1) {
            
            for (NSDictionary *dic in netModel.data) {
                
                WL_CompanyList_Model *model =[WL_CompanyList_Model mj_objectWithKeyValues:dic];
                
                [weakSelf.companyArray addObject:model];
                
            }

        }
        
    } Failure:^(NSError *error) {
       
        dispatch_group_leave(self.group);

    }];

}

-(void)acquireContacts

{
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr};
    
    //WS(weakSelf);ContactsUsuallyContactsListUrl
    
    [[WLHttpManager shareManager]requestWithURL:ContactsUsuallyContactsListUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        dispatch_group_leave(self.group);

        
        WlLog(@"%@",responseObject);
        
     WL_Network_Model *usuallyModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if ([usuallyModel.result integerValue]==1) {
           
            for (NSDictionary *dic in usuallyModel.data[@"list"]) {
                
                WL_UsuallyContactsList_Model *model =[WL_UsuallyContactsList_Model mj_objectWithKeyValues:dic];
                
                [self.usuallyArray addObject:model];
                
            }
            self.usuallyNum = usuallyModel.data[@"count"];

        }

    } Failure:^(NSError *error) {
       
        dispatch_group_leave(self.group);
    }];

}

-(NSMutableArray *)usuallyArray
{
    if (_usuallyArray==nil) {
        
        _usuallyArray =[[NSMutableArray alloc]init];
    }
    return _usuallyArray;
}

-(NSMutableArray *)companyArray
{
    if (_companyArray==nil) {
        
        _companyArray =[[NSMutableArray alloc]init];
    }
    return _companyArray;
    
}
-(NSMutableArray *)searchArray
{
    if (_searchArray==nil) {
        
        _searchArray =[[NSMutableArray alloc]init];
    }
    
    return _searchArray;
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
        //WS(ws);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) andRefreshBlock:^{
        
           // [ws initData];
        }];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}

-(void)createTableView

{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
    
    self.tableView.dataSource =self;
    
    self.tableView.delegate =self;
    
    self.tableView.backgroundColor = BgViewColor;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[WL_SelectReceiver_Cell class] forCellReuseIdentifier:kReuseId0];
    
    [self.tableView registerClass:[WL_SelectReceiver_ContactsCell class] forCellReuseIdentifier:kReuseId1];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    //创建一个tableViewController自带一个tableView
    self.tableVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.tableVC.tableView.delegate = self;
    
    self.tableVC.tableView.dataSource = self;
    
    self.tableVC.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50);
    
    self.tableVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableVC.tableView.rowHeight =65;
    
    [self.tableVC.tableView registerClass:[WL_MyFriendList_Cell class] forCellReuseIdentifier:kReuseId2];
    
    [self.tableVC.view addSubview:self.noDataView];
    
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:self.tableVC];
    
    self.searchVC.searchBar.delegate =self;
    
    self.searchVC.searchResultsUpdater =self;
    
    self.searchVC.delegate =self;
    
    self.searchVC.searchBar.placeholder = @"找人";
    
    self.searchVC.hidesNavigationBarDuringPresentation = YES;
    
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    
    self.definesPresentationContext = YES;
    
    self.searchVC.searchBar.barTintColor = BgViewColor;
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = BgViewColor.CGColor;
    
    barImageView.layer.borderWidth = 1;
    
    [self.searchVC.searchBar sizeToFit];
    
    self.bottomDetailView =[[UIView alloc]initWithFrame:CGRectMake(0,ScreenHeight-50-64, ScreenWidth, 50)];
    
    self.bottomDetailView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:self.bottomDetailView];
    
    self.selectedNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
    
    self.selectedNum.font = WLFontSize(14);
    
    self.selectedNum.textColor = [WLTools stringToColor:@"#879efa"];
    
    self.selectedNum.text = @"已选择：";
    
    [self.bottomDetailView addSubview:self.selectedNum];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.sureButton setFrame:CGRectMake(ScreenWidth-110-10, 7.5, 110, 35)];
    
    [self.sureButton setBackgroundColor:[WLTools stringToColor:@"#879efa"]];
    
    self.sureButton.layer.cornerRadius =3.0;
    
    self.sureButton.layer.masksToBounds = YES;
    
    self.sureButton.enabled = NO;
    
    self.sureButton.alpha =0.4;
    
    [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomDetailView addSubview:self.sureButton];
    
   
     [self setLabelNumber];
    
    [self.searchVC.searchBar setInputAccessoryView:self.inputAccessoryView];
    
    
}
- (UIView *)inputAccessoryView{
    
    if (!_inputAccessoryView) {
       
        _inputAccessoryView = [[UIView alloc]initWithFrame:(CGRect){0,0,ScreenWidth,50}];
        
        [_inputAccessoryView setBackgroundColor:[UIColor whiteColor]];
        
        self.selectedNum2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
        
        self.selectedNum2.font = WLFontSize(14);
        
        self.selectedNum2.textColor = [WLTools stringToColor:@"#879efa"];
        
        self.selectedNum2.text = @"已选择：";

        [_inputAccessoryView addSubview:self.selectedNum2];
        
        //self.sureButton2 =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-110-10, 7.5, 110, 35)];
        
        self.sureButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.sureButton2 setFrame:CGRectMake(ScreenWidth-110-10, 7.5, 110, 35)];
        
        [self.sureButton2 setBackgroundColor:[WLTools stringToColor:@"#879efa"]];
        
        self.sureButton2.layer.cornerRadius =3.0;
        
        self.sureButton2.layer.masksToBounds = YES;
        
        self.sureButton2.enabled = NO;
        
        self.sureButton2.alpha = 0.4;
        
        [self.sureButton2 addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.sureButton2 setTitle:@"确认" forState:UIControlStateNormal];
        
        [self.sureButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_inputAccessoryView addSubview:self.sureButton2];
        
    }
    return _inputAccessoryView;
}

-(void)NavigationLeftEvent
{
   // WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[2];
    
    //[VC reloadCellectionViewWith:self.originArray];
    
    //[[WL_ShareArray shareArray].saveArray removeAllObjects];
    
    [WL_ShareArray shareArray].saveArray = [NSMutableDictionary dictionaryWithDictionary:self.originArray];
    
    [self.navigationController popViewControllerAnimated:YES];
 
}

-(void)sureButton:(UIButton *)button
{
    
    if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"1"]) {
        
        NSArray *arr= self.navigationController.viewControllers;
        WlLog(@"%@",arr);
        
        WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[2];
        
        [VC reloadCellectionViewWith:[WL_ShareArray shareArray].saveArray];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([[DEFAULTS objectForKey:@"adressbook"]isEqualToString:@"2"])
    {
        NSArray *arr= self.navigationController.viewControllers;
        WlLog(@"%@",arr);
        
        WL_EditPrivateLetter_ViewController *VC =self.navigationController.viewControllers[3];
        
        [VC reloadCellectionViewWith:[WL_ShareArray shareArray].saveArray];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect rect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.tableVC.tableView.height = ScreenHeight - rect.size.height;
    
}
#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    
    self.tableVC.tableView.height = ScreenHeight -64 -50;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    self.noDataView.hidden =YES;
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"userName":self.searchVC.searchBar.text,@"type":@"1"};
    
    WS(weakSelf);
   
    [[WLHttpManager shareManager]requestWithURL:SearchSearchUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
    
        WlLog(@"%@",responseObject);
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if ([net_model.result integerValue]==1) {
           
        self.searchArray =[WL_SearchResultModel mj_objectArrayWithKeyValuesArray:net_model.data[@"contacts"]];
            
        }
        
        //搜索数据源变了  ->让搜索控制器 内部的结果视图控制器的tableView的刷新
        self.tableVC = (UITableViewController *)searchController.searchResultsController;
        
        [self.tableVC.tableView reloadData];
        
        if (self.searchArray.count==0) {
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNOData];
 
        }else
        {
            
            weakSelf.noDataView.hidden =YES;
        }

    } Failure:^(NSError *error) {
        
        if (error.code==-1009) {
            
            [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
        }else
        {
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


#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.barTintColor = [WLTools stringToColor:@"#4877e7"];
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = [WLTools stringToColor:@"#4877e7"].CGColor;
    
    barImageView.layer.borderWidth = 1;
    
    UIButton *canceLBtn = [self.searchVC.searchBar valueForKey:@"cancelButton"];
    
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [canceLBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (void)didPresentSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.barTintColor = [WLTools stringToColor:@"#4877e7"];
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = [WLTools stringToColor:@"#4877e7"].CGColor;
    
    barImageView.layer.borderWidth = 1;
    
    UIButton *canceLBtn = [self.searchVC.searchBar valueForKey:@"cancelButton"];
    
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [canceLBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)willDismissSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.barTintColor = BgViewColor;
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = BgViewColor.CGColor;
    
    barImageView.layer.borderWidth = 1;
    
   
}
- (void)didDismissSearchController:(UISearchController *)searchController {
   
    self.searchVC.searchBar.barTintColor = BgViewColor;
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = BgViewColor.CGColor;
    
    barImageView.layer.borderWidth = 1;
    
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView ==self.tableView) {
      
        return 3;
    }
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return 0.01;
        
    }
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.tableView) {
        
        return 50;
    }
    
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    if (tableView == self.tableView) {
        
        if (section ==0) {
            
            return 1;
            
        }else if (section==1)
        {
            return self.companyArray.count;
        }
            return self.usuallyArray.count+1;
    }
    
    
    return self.searchArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.tableView)
    {
    if (indexPath.section ==0) {
        
        WL_SelectReceiver_Cell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseId0 forIndexPath:indexPath];
        
        cell.nameLabel.text = @"微叮好友";
        
        [cell.leftImage setFrame:CGRectMake(10, (50-18)/2, 18, 18)];
        
        [cell.nameLabel setFrame:CGRectMake(ViewRight(cell.leftImage)+8, 0, 200, 50)];
        
        cell.numberLabel.text = [NSString stringWithFormat:@"%@人",self.friendNum];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
       
        return cell;
        
    }else if (indexPath.section==1)
    {
       
        WL_CompanyList_Model *model =self.companyArray[indexPath.row];
        
        WL_SelectReceiver_Cell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseId0 forIndexPath:indexPath];
        
        cell.model =model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
               
        
        return cell;
    }
        
        if (indexPath.row==0) {
           
            WL_Contacts_subTittle_Cell *cell = [[WL_Contacts_subTittle_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
            
            cell.leftLabel.text = @"常用联系人";
            
            cell.rightLabel.text  =[NSString stringWithFormat:@"%@人",self.usuallyNum];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            return cell;
        }
        
        
        WL_UsuallyContactsList_Model *model = self.usuallyArray[indexPath.row-1];
        
        WL_SelectReceiver_ContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseId1 forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model =model;
        cell.path = indexPath;
        
        cell.buttonSelectBlock = ^(NSIndexPath *index,UIButton *button)
        {
            
            WL_UsuallyContactsList_Model *mod = self.usuallyArray[index.row-1];
            
            WL_Save_Model *saveMode =[[WL_Save_Model alloc]init];
            
            saveMode.user_id = mod.user_id;
            
            saveMode.photo =mod.photo;
            
            saveMode.real_name = mod.real_name;
            
            saveMode.user_name = mod.user_name;
            
            saveMode.mobile =mod.user_mobile;
            
            if (button.selected) {
                
               [[WL_ShareArray shareArray].saveArray setObject:saveMode forKey:saveMode.user_id];
                
            }else
            {
               [[WL_ShareArray shareArray].saveArray removeObjectForKey:saveMode.user_id];
            }
            
            [self setLabelNumber];
        };
        
        for (NSString *key in [[WL_ShareArray shareArray].saveArray allKeys]) {
            
            if ([model.user_id isEqualToString:key]) {
                
                cell.selectImageView.selected =YES;
            }
            
        }
        
        return cell;
    }
    
    
    WL_MyFriendList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseId2 forIndexPath:indexPath];
    
    cell.selectImageView.selected = NO;
    
    if (cell==nil) {
        
        cell =[[WL_MyFriendList_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseId2];
    }
    
    
    WL_SearchResultModel *mode = self.searchArray[indexPath.row];
    
    cell.searchResult = mode;
    
    cell.path =indexPath;
    
    cell.buttonSelectBlock = ^(NSIndexPath *index,UIButton *button)
    {
        
        WL_SearchResultModel *mod = self.searchArray[index.row];
        
        WL_Save_Model *saveMode =[[WL_Save_Model alloc]init];
        
        saveMode.user_id = mod.user_id;
        
        saveMode.photo =mod.photo;
        
        saveMode.real_name = mod.real_name;
        
        saveMode.user_name = mod.user_name;
        
        saveMode.mobile =mod.user_mobile;
        
        if (button.selected) {
            
            [[WL_ShareArray shareArray].saveArray setObject:saveMode forKey:saveMode.user_id];
            
        }else
        {
            [[WL_ShareArray shareArray].saveArray removeObjectForKey:saveMode.user_id];
        }
        
        [self setLabelNumber];
    };
    
    for (NSString *key in [[WL_ShareArray shareArray].saveArray allKeys]) {
        
        if ([mode.user_id isEqualToString:key]) {
            
            cell.selectImageView.selected =YES;
        }
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
////选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.tableView) {
       
        if (indexPath.section==0) {
            
            WL_MyFriendList_ViewController *VC =[[WL_MyFriendList_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section ==1)
        {
            WL_DepartmentsOfCompany_ViewController *VC =[[WL_DepartmentsOfCompany_ViewController alloc]init];
            
            WL_CompanyList_Model *model  =self.companyArray[indexPath.row];
            
            VC.model = model;
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
       
        
  
    }else
    {
       
    }
      
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
