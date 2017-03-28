//
//  WL_MessageViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/8/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MessageViewController.h"
#import "KxMenu.h"
#import "RCDSearchFriendViewController.h"
#import "RCDChatViewController.h"
#import "RCDAddressBookViewController.h"
#import "RCDUserInfo.h"
#import "RCDChatListCell.h"
#import "RCDHTTPTOOL.h"
#import "UITabBar+badge.h"
#import "WL_AddFriendViewController.h"
#import "CycleScrollView.h"
#import "WL_PrivateLetter_ViewController.h"
#import "WL_messageTableViewCell.h"
#import "WL_MessageList_Model.h"
#import "WL_CompanyBanner_Model.h"
#import "WL_NoticeDetail_ViewController.h"
#import "WL_Friendlist_Model.h"
#import "WL_Application_Driver_OrderList_ViewController.h"
#import "WL_TabBarController.h"
#import "WL_FundAccount_ViewController.h"
#import "WL_Application_Driver_Order_AcceptOrderDetail_ViewController.h"
#import "WLScheduleListViewController.h"
#import "WL_Application_Driver_Trip_ViewController.h"
#import "WL_ApplicationViewController.h"

@interface WL_MessageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate,EScrollerViewDelegate>

@property(nonatomic, assign) NSUInteger index;
@property (nonatomic,strong) UISearchController *searchVC;
@property(nonatomic, strong) NSMutableArray *bannerArray;
@property(nonatomic, strong) NSMutableArray *pictureArray;
@property(nonatomic, strong) NSMutableArray *noticeArray;
@property(nonatomic, assign) BOOL isClick;
@property(nonatomic, copy)   NSString *lastSearchString;
@property(nonatomic, strong) NSMutableArray *messageArray;
@property(nonatomic, strong) WL_NoData_View *noDataView;
@property(nonatomic, strong) WL_NoData_View *noDataView2;
@property(nonatomic)dispatch_group_t group;
@property(nonatomic, strong) NSMutableArray *searchResultArray;
@property(nonatomic, assign) BOOL delete;
@property(nonatomic, assign) BOOL isNoNet;
@property(nonatomic, assign) BOOL isNoServer;

@end

@implementation WL_MessageViewController

-(NSMutableArray *)pictureArray
{
    if (_pictureArray ==nil) {
        _pictureArray =[[NSMutableArray alloc]init];
    }
    return _pictureArray;
}

-(NSMutableArray *)noticeArray
{
    if (_noticeArray==nil) {
        _noticeArray =[[NSMutableArray alloc]init];
    }
    return _noticeArray;
}

-(NSMutableArray *)messageArray
{
    if (_messageArray==nil) {
        _messageArray =[[NSMutableArray alloc]init];
    }
    return _messageArray;
}

-(NSMutableArray *)searchResultArray
{
    if (_searchResultArray==nil) {
        _searchResultArray =[[NSMutableArray alloc]init];
    }
    return _searchResultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavigationLeftImg:@""];
    
    self.navigationItem.title = @"微叮";
    
    self.view.backgroundColor = BgViewColor;

    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //取得第一个Documents文件夹的路径
    
    NSString *filePath = [pathArray objectAtIndex:0];
    
    //把TestPlist文件加入
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"SearchHistory.plist"];
    
    NSFileManager *fileManager = [[NSFileManager  alloc]init];
    
    if (![fileManager fileExistsAtPath:plistPath]) {
        
        [fileManager createFileAtPath:plistPath contents:nil attributes:nil];
        
        NSMutableArray *arr =[[NSMutableArray alloc]init];
        
        [arr writeToFile:plistPath atomically:YES];
    }
    
    
    [self setNavigationRightImg:@"conversation"];
    
    [self createBannerAndTableView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    [self.messageArray removeAllObjects];
    
    [self.pictureArray removeAllObjects];
    
    [self.noticeArray removeAllObjects];
    
    self.group=dispatch_group_create();
    
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    
    WS(weakSelf);
    
    [weakSelf showHud];
    
    dispatch_group_enter(self.group);
    
    dispatch_async(queue, ^{
        
        weakSelf.isNoNet = NO;
        weakSelf.isNoServer = NO;
        [weakSelf loadBannerData];
    });
    
    dispatch_group_enter(self.group);
    
    dispatch_async(queue, ^{
        
        weakSelf.isNoServer = NO;
       
        weakSelf.isNoNet = NO;
        
        [weakSelf loadMessageData];
    });
    
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        
        [weakSelf hidHud];
    
        if (weakSelf.isNoNet)
        {
           [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
            
        }else if (weakSelf.isNoServer)
        {
            [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
            
        }else if (weakSelf.pictureArray.count==0 &&weakSelf.messageArray.count==0) {
            
            [self hideNoData:NO andType:WLNetworkTypeNOData];
            
        }else if (weakSelf.pictureArray.count==0 &&weakSelf.messageArray.count>0)
        {
            
        }else if (weakSelf.pictureArray.count>0 &&weakSelf.messageArray.count==0)
        {
            [self hideNoData:NO andType:WLNetworkTypeNOData];
            
            if (IsiPhone5) {
            
              self.noDataView2.isFive = @"yes";
            
            }
        }
        
         [weakSelf.messageTableView reloadData];

    });
}

-(UIView *)bottomView

{
    if (_bottomView==nil) {
        _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, 64+120, ScreenWidth, 125)];
        _bottomView.backgroundColor =[UIColor whiteColor];
        UILabel *tipLabel =[WLTools allocLabel:@"在这里可以搜到" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake((ScreenWidth-110)/2, 20, 110, 16) textAlignment:NSTextAlignmentCenter];
        [_bottomView addSubview:tipLabel];
        UILabel *line  =[WLTools allocLabel:@"" font:nil textColor:nil frame:CGRectMake((ScreenWidth-150)/2, ViewBelow(tipLabel)+10, 150, 0.5) textAlignment:NSTextAlignmentCenter];
        line.backgroundColor = bordColor;
        [_bottomView addSubview:line];
        CGFloat pad1 = (ScreenWidth -120)/3;
        CGFloat pad2 = (ScreenWidth -80)/3;
        NSArray *titleArray =[NSArray arrayWithObjects:@"联系人",@"私信消息",@"平台公告",@"提醒", nil];
        NSArray *imageArray =[NSArray arrayWithObjects:@"WDFriend", @"PrivateLetter",@"gonggao",@"Notice",nil];
        for (int i =0; i<4; i++) {
            UIImageView *im =[[UIImageView alloc]initWithFrame:CGRectMake(50+i*pad1, ViewBelow(line)+15, 30, 26)];
            im.image = [UIImage imageNamed:imageArray[i]];
            [_bottomView addSubview:im];
            UILabel *la =[[UILabel alloc]initWithFrame:CGRectMake(40+i*pad2, ViewBelow(im)+10, 60, 15)];
            la.centerX = im.centerX;
            la.font =WLFontSize(11);
            la.textColor = [UIColor grayColor];
            la.text = titleArray[i];
            la.textAlignment = NSTextAlignmentCenter;
            [_bottomView addSubview:la];
            
        }
    }

    return _bottomView;
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0,45, ScreenWidth, ScreenHeight-64-45) andRefreshBlock:^{
            
            [weakSelf.messageArray removeAllObjects];
            
            [weakSelf.pictureArray removeAllObjects];
            
            [self.noticeArray removeAllObjects];
            
            [weakSelf showHud];
            
            dispatch_queue_t queue=dispatch_get_global_queue(0, 0);

            dispatch_group_enter(self.group);
            
            dispatch_async(queue, ^{
                
                weakSelf.isNoNet = NO;
                weakSelf.isNoServer = NO;
                
                [weakSelf loadBannerData];
                
            });
            
            dispatch_group_enter(self.group);
            
            dispatch_async(queue, ^{
                
                weakSelf.isNoNet = NO;
               
                weakSelf.isNoServer = NO;
                
                [weakSelf loadMessageData];
            });
            
            dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
                
                [weakSelf hidHud];
                
                if (weakSelf.isNoNet)
                {
                    [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
                    
                }else if (weakSelf.isNoServer)
                {
                    [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
                    
                }else if (weakSelf.pictureArray.count==0 &&weakSelf.messageArray.count==0)
                {
                    
                  [self hideNoData:NO andType:WLNetworkTypeNOData];
                    
                }else if (weakSelf.pictureArray.count==0 &&weakSelf.messageArray.count>0)
                {
                    
                }else if (weakSelf.pictureArray.count>0 &&weakSelf.messageArray.count==0)
                {
                    [self hideNoData:NO andType:WLNetworkTypeNOData];
                    
                    if (IsiPhone5) {
                        
                        self.noDataView.isFive = @"yes";
                        
                    }
                }


                [weakSelf.messageTableView reloadData];
            });
 
        }];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}

//无数据提示
- (WL_NoData_View *)noDataView2 {
    
    if (_noDataView2 == nil) {
        
        WS(weakSelf);
        
        _noDataView2 = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0,45+150, ScreenWidth, ScreenHeight-64-45-150) andRefreshBlock:^{
            
            [weakSelf.messageArray removeAllObjects];
            
            [weakSelf.pictureArray removeAllObjects];
            
            [self.noticeArray removeAllObjects];
            
            [weakSelf showHud];
            
            dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
            
            dispatch_group_enter(self.group);
            
            dispatch_async(queue, ^{
                
                weakSelf.isNoNet = NO;
                weakSelf.isNoServer = NO;
                
                [weakSelf loadBannerData];
                
            });
            
            dispatch_group_enter(self.group);
            
            dispatch_async(queue, ^{
                
                weakSelf.isNoNet = NO;
                
                weakSelf.isNoServer = NO;
                
                [weakSelf loadMessageData];
            });
            
            dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
                
                [weakSelf hidHud];
                
                if (weakSelf.isNoNet)
                {
                    [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
                    
                }else if (weakSelf.isNoServer)
                {
                    [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
                    
                }else if (weakSelf.pictureArray.count==0 &&weakSelf.messageArray.count==0)
                {
                    
                    [self hideNoData:NO andType:WLNetworkTypeNOData];
                    
                }else if (weakSelf.pictureArray.count==0 &&weakSelf.messageArray.count>0)
                {
                    
                }else if (weakSelf.pictureArray.count>0 &&weakSelf.messageArray.count==0)
                {
                    [self hideNoData:NO andType:WLNetworkTypeNOData];
                    if (IsiPhone5) {
                        self.noDataView2.isFive = @"yes";
                    }
                }
                [weakSelf.messageTableView reloadData];
            });
        }];
        _noDataView2.hidden = YES;
    }
    return _noDataView2;
}


-(void)loadBannerData

{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getUserPassword];
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"type":@"2"};
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:NoticeNoticeBannerUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        WlLog(@"%@",responseObject);
        dispatch_group_leave(self.group);
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([net_model.result integerValue]==1) {
          
        weakSelf.bannerArray = [WL_CompanyBanner_Model mj_objectArrayWithKeyValuesArray:net_model.data];
            
       }
        
        for (WL_CompanyBanner_Model *model in self.bannerArray) {
            
            [weakSelf.pictureArray addObject:model.cover_url];
            
            [self.noticeArray addObject:model];
            
        }
        
    } Failure:^(NSError *error) {
    
        if (error.code==-1009) {
      
            weakSelf.isNoNet = YES;

        }else
        {
    
            weakSelf.isNoServer = YES;
        }
      dispatch_group_leave(self.group);
        
    }];
}

-(void)loadMessageData

{
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getUserPassword];
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"role_type":@"0"};
    WS(weakSelf);
    
    WlLog(@"%@",MessageGetMessageListUrl);
    [[WLHttpManager shareManager]requestWithURL:MessageGetMessageListUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        WlLog(@"%@",responseObject);
        
        dispatch_group_leave(self.group);
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([net_model.result integerValue]==1) {
            
            for (NSDictionary *dic in net_model.data) {
                
                WL_MessageList_Model *model = [WL_MessageList_Model mj_objectWithKeyValues:dic];
                
                [weakSelf.messageArray addObject:model];
            }
            
        }
        if (weakSelf.delete) {
            
            [weakSelf.messageTableView reloadData];
        }
   
    } Failure:^(NSError *error) {
  
    if (error.code==-1009) {

        weakSelf.isNoNet = YES;
    
     }else{
            
        weakSelf.isNoServer = YES;
           
    }
     dispatch_group_leave(self.group);
    }];
}
#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    
    if (self.pictureArray.count>0 &&self.messageArray.count==0) {
        self.noDataView2.hidden = hidden;
        if (!hidden) {
            self.noDataView2.type = type;
        }
    }else{
        self.noDataView.hidden = hidden;
        if (!hidden) {
            self.noDataView.type = type;
            
        }
    }
}

-(void)createBannerAndTableView
{

    _messageTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    _messageTableView.dataSource = self;
    _messageTableView.delegate =self;
    _messageTableView.backgroundColor = [UIColor whiteColor];
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _messageTableView.tableFooterView = [UIView new];
    _messageTableView.showsHorizontalScrollIndicator = NO;
    _messageTableView.showsVerticalScrollIndicator = NO;
    _messageTableView.contentInset = UIEdgeInsetsMake(0, 0, -15, 0);
    [self.view addSubview:_messageTableView];
        
    //创建一个tableViewController自带一个tableView
    self.tableVC = [[WL_SearchResultTableView alloc] initWithStyle:UITableViewStyleGrouped];
    self.tableVC.tableView.height = ScreenHeight-64+20;
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:self.tableVC];
    WS(weakSelf);
    self.tableVC.popSearchTextBlock = ^(NSString *text){
        
        WlLog(@"%@",text);
        weakSelf.searchVC.searchBar.text = text;
    };
        
    self.searchVC.searchBar.delegate =self;
    self.searchVC.searchResultsUpdater =self;
    self.searchVC.delegate =self;
    self.searchVC.dimsBackgroundDuringPresentation = NO;
    self.searchVC.hidesNavigationBarDuringPresentation = YES;
    _messageTableView.tableHeaderView = self.searchVC.searchBar;
    self.searchVC.searchBar.placeholder= @"搜索名字、拼音、手机号";
    self.definesPresentationContext = YES;
    self.searchVC.searchBar.barTintColor = BgViewColor;
    self.search =self.searchVC;
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = BgViewColor.CGColor;
    barImageView.layer.borderWidth = 1;
    [self.view addSubview:self.noDataView];
    [self.view addSubview:self.noDataView2];

}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
 
    if (self.searchVC.searchBar.text.length==0) {
    
        self.bottomView.hidden =NO;
    
        self.searchCusomView.hidden =NO;
        
        self.noDataView.hidden = YES;
    
        return;
    }
    if ([self.searchVC.searchBar.text isEqualToString:self.lastSearchString]) {
        
        return;
    }
    [self.searchResultArray removeAllObjects];
    NSString *userId = [WLUserTools getUserId];
    NSString *passWord =[WLUserTools getUserPassword];
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"keyword":self.searchVC.searchBar.text};
    
    [[WLHttpManager shareManager]requestWithURL:SearchsearchMessageUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        WlLog(@"%@",responseObject);
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];

        if ([net_model.result integerValue]==1) {
            
            self.lastSearchString = self.searchVC.searchBar.text;
            
            if ([net_model.data[@"friendList"] count]>0) {
                
                NSMutableArray *friendList =[WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"friendList"]];
                
                NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:friendList,@"微叮好友",nil];
                
                [self.searchResultArray addObject:dic];
                
            }
            
            if ([net_model.data[@"letterList"] count]>0) {
                
                NSMutableArray *letterList =[WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"letterList"]];
                
                NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:letterList,@"私信",nil];
                
                [self.searchResultArray addObject:dic];

            }
            
            if ([net_model.data[@"messageList"] count]>0) {
                
                NSMutableArray *messageList =[WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"messageList"]];
                
                NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:messageList,@"消息",nil];
                
                [self.searchResultArray addObject:dic];

            }
            
            if ([net_model.data[@"noticeList"] count]>0) {
                
                NSMutableArray *noticeList =[WL_Friendlist_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"noticeList"]];
                
                NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:noticeList,@"公告",nil];
                [self.searchResultArray addObject:dic];
             
            }
 
        }
        self.bottomView.hidden =YES;
        
        self.searchCusomView.hidden =YES;
        
        self.tableVC = (WL_SearchResultTableView *)searchController.searchResultsController;

        [self.tableVC reloadDataWithArray:self.searchResultArray];
       
        self.tableVC.searchText = self.searchVC.searchBar.text;
        
    
    } Failure:^(NSError *error) {
  
    }];
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
    
    self.tableVC.tableView.height = ScreenHeight -64+20;
}

#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController
{
    
    self.messageTableView.hidden = YES;
    
    if (self.messageArray.count==0) {
        
        self.noDataView.hidden =YES;
    }
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //取得第一个Documents文件夹的路径
    
    NSString *filePath = [pathArray objectAtIndex:0];
    
    //把TestPlist文件加入
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"SearchHistory.plist"];
    
    NSMutableArray *mutableArray =[NSMutableArray arrayWithContentsOfFile:plistPath];
    
    WS(weakSelf);
    
    if (mutableArray.count>0) {
        
        NSArray *arr =[[NSArray alloc]init];
        
        if (mutableArray.count>8) {
            
          arr = [mutableArray subarrayWithRange:NSMakeRange(mutableArray.count-8, 8)];
            
        }else
        {
            arr = [NSArray arrayWithArray:mutableArray];
        }
        
        self.searchCusomView =[[SearchCusomHistory alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth,200) andItems:arr andItemClickBlock:^(NSInteger i) {
        
        weakSelf.searchVC.searchBar.text = arr[i];
        
        }];
        
         [self.view addSubview:self.searchCusomView];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        self.searchCusomView.frame = CGRectMake(0, 64, ScreenWidth, self.searchCusomView.collectionView.contentSize.height);
            
        self.searchCusomView.backgroundColor =BgViewColor;

        self.bottomView.y = 64+self.searchCusomView.collectionView.contentSize.height;
            
        [self.view addSubview:self.bottomView];
            
        });
    
    }else
    {
        self.bottomView.y = 64;
        
        [self.view addSubview:self.bottomView];
    }
    self.searchCusomView.deleteButtonClick  = ^()
    {
        
       [UIView animateWithDuration:0.25 animations:^{
          
           [weakSelf.searchCusomView removeFromSuperview];
           
           weakSelf.bottomView.y = 64;
           
           NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
           
           //取得第一个Documents文件夹的路径
           
           NSString *filePath = [pathArray objectAtIndex:0];
           
           //把TestPlist文件加入
           NSString *plistPath = [filePath stringByAppendingPathComponent:@"SearchHistory.plist"];
           
           NSMutableArray *array =[NSMutableArray arrayWithContentsOfFile:plistPath];
           
           [array removeAllObjects];
           
           [array writeToFile:plistPath atomically:YES];
        
       }];
    };
    
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
    
    self.messageTableView.hidden =NO;
    
    if (self.messageArray.count==0) {
        
      self.noDataView.hidden = NO;
    }
    [self.searchCusomView removeFromSuperview];
 
    [self.bottomView removeFromSuperview];
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    
    self.searchVC.searchBar.barTintColor = BgViewColor;
    
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    
    barImageView.layer.borderColor = BgViewColor.CGColor;
    
    barImageView.layer.borderWidth = 1;
    
    self.messageTableView.hidden =NO;
    
    if (self.messageArray.count==0) {
        
        self.noDataView.hidden = NO;
    }
    
    
    [self.searchCusomView removeFromSuperview];
    
    [self.bottomView removeFromSuperview];
}

-(void)NavigationRightEvent
{
    WL_PrivateLetter_ViewController *VC =[[WL_PrivateLetter_ViewController alloc]init];
    
    VC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:VC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.messageTableView) {
        
       return self.messageArray.count+1;
    }
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (tableView==self.messageTableView) {
       
        if (indexPath.section==0) {
            
            static NSString *cellID = @"UITableViewCell";
            
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
            
            if (cell==nil) {
                
                cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
           
            CycleScrollView *advertisementBunner = [[CycleScrollView alloc]initWithFrameRect:CGRectMake(0,0, ScreenWidth, 150) ImageArray:self.pictureArray];
            
            advertisementBunner.delegate =self;
            
            cell.contentView.userInteractionEnabled = YES;
            
            [cell.contentView addSubview:advertisementBunner];
            
            return cell;
            
        }
        
        static NSString *cellID = @"cellID";
        
        WL_messageTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell==nil) {
            
            cell =[[WL_messageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        WL_MessageList_Model *model = self.messageArray[indexPath.section-1];
        
        cell.model =model;
        
        cell.indexPath =indexPath;
        
        return cell;

        
       
    }
    static NSString *cellID = @"UITableView";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {

        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
    
   }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView==self.messageTableView) {
        
        return 0.01;
    }
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==self.messageTableView) {
        
        return 15;
    }
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView==self.messageTableView) {
        
        UIView *padView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
        
        padView.backgroundColor =BgViewColor;
        
        return padView;
    }
    
    return nil;
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if (tableView== self.messageTableView) {
        
        UIView *padView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
        
        padView.backgroundColor =BgViewColor;
        
        return padView;
    }
    
    
    return nil;
    
}
#pragma mark---定制cell删除按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section>0) {
        
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
       
       WL_MessageList_Model *model = self.messageArray[indexPath.section];
        
        NSString *userId = [WLUserTools getUserId];
        
        NSString *passWord =[WLUserTools getUserPassword];
        
        //进行RSA加密后的密码字符串
        NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
        
        NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"message_ids":model.message_id};
        
        WS(weakSelf);
        
        self.delete = YES;
        
        WlLog(@"%@",MessageGetMessageListUrl);
        
        [[WLHttpManager shareManager]requestWithURL:MessageDeleteMessageUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
            WlLog(@"%@",responseObject);
            
            WL_Network_Model *net_Model =[WL_Network_Model mj_objectWithKeyValues:responseObject];
            
            if ([net_Model.result integerValue]==1) {
              
                
                [weakSelf.messageArray removeAllObjects];
                
                [weakSelf.pictureArray removeAllObjects];
                
                [weakSelf showHud];
                
                dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
                
                
                dispatch_group_enter(self.group);
                
                dispatch_async(queue, ^{
                    
                    
                    [weakSelf loadBannerData];
                });
                
                dispatch_group_enter(self.group);
                
                dispatch_async(queue, ^{
                    
                    [weakSelf loadMessageData];
                });
                
                dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
                    
                    [weakSelf hidHud];
                    
                    if (weakSelf.isNoNet)
                    {
                        [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
                        
                    }else if (weakSelf.isNoServer)
                    {
                        [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
                        
                    }else if (weakSelf.pictureArray.count==0 &&weakSelf.messageArray.count==0)
                    {
                        
                        [self hideNoData:NO andType:WLNetworkTypeNOData];
                        
                    }else if (weakSelf.pictureArray.count==0 &&weakSelf.messageArray.count>0)
                    {
                        
                    }else if (weakSelf.pictureArray.count>0 &&weakSelf.messageArray.count==0)
                    {
                        [self hideNoData:NO andType:WLNetworkTypeNOData];
                        
                        if (IsiPhone5) {
                            
                            self.noDataView2.isFive = @"yes";
                            
                        }
                    }
                    
                    [weakSelf.messageTableView reloadData];
                });

                [[WL_TipAlert_View sharedAlert]createTip:net_Model.msg];
                
            }else
            {
              [[WL_TipAlert_View sharedAlert]createTip:net_Model.msg];
            }
            
            
            
        } Failure:^(NSError *error) {
            
       [[WL_TipAlert_View sharedAlert]createTip:@"删除失败"];
        
        }];
     }];
    
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    return @[deleteRowAction];
        
    }
    
    return [NSArray arrayWithObjects:@"", nil];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  UITableViewCellEditingStyleDelete;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (tableView==self.messageTableView) {
        
        if (indexPath.section==0) {
            
            return 150;
        }

        WL_MessageList_Model *model = self.messageArray[indexPath.section-1];
        
        return [WL_messageTableViewCell heightWithModel:model.msg_content];
    }

    return 45;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

       UITableView *tableview = (UITableView *)scrollView;
       CGFloat sectionHeaderHeight = 0.01;
       CGFloat sectionFooterHeight = 15;
        CGFloat offsetY = tableview.contentOffset.y;
        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
        {
            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
        {
           // tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
        }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WlLog(@"%@",indexPath);
    
    if (indexPath.section>0) {
        
     WL_MessageList_Model *model = self.messageArray[indexPath.section-1];
    
    //导游
    if ([model.role_type integerValue]==1)
    {
        //接单提醒  跳转接单列表
        if([model.msg_type integerValue]==1) {
            
         //身份变动提醒 跳转应用首页
        }else if ([model.msg_type integerValue]==2){
            
            WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
            
            [ShareApplicationDelegate window].rootViewController = tabBar;
            
            UINavigationController *nav = tabBar.viewControllers[1];
            
            WL_ApplicationViewController *VC =(WL_ApplicationViewController*)nav.childViewControllers[0];
            
            VC.company_id = @"2";
            
            WlLog(@"%@",nav.childViewControllers);
            
            tabBar.selectedIndex =1;
         //资金变动提醒  跳转自己账户
        }else if ([model.msg_type integerValue]==3){
            
            WL_FundAccount_ViewController *VC = [[WL_FundAccount_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
         //出团提醒 跳转到有日历行程 并选中 出团日期
        }else if ([model.msg_type integerValue]==4)
        {
         
            WLScheduleListViewController *VC =[[WLScheduleListViewController alloc]init];
            
            VC.hidesBottomBarWhenPushed = YES;
            
            NSDateFormatter *fotmatter =[[NSDateFormatter alloc]init];
            
            [fotmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *date =[fotmatter dateFromString:model.create_date];
            
            VC.someDate = date;
            
            [self.navigationController pushViewController:VC animated:YES];

          //预付款提醒
        }else if ([model.msg_type integerValue]==5)
        {
          
            //备用金提醒 跳转订单详情
        }else if ([model.msg_type integerValue]==6)
        {
            
        }
        
     //司机
    }else if ([model.role_type integerValue]==2)
    {
        //接单提醒 接单列表
        if([model.msg_type integerValue]==1) {
         
            WL_Application_Driver_OrderList_ViewController *VC =[[WL_Application_Driver_OrderList_ViewController alloc]init];
            
            VC.orderStatus = WL_WaitOrderStatus;
            
            VC.company_id = @"1";
    
            [self.navigationController pushViewController:VC animated:YES];
         
            //身份认证提醒，进入应用页面
        }else if ([model.msg_type integerValue]==2){
            
            WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
            
            [ShareApplicationDelegate window].rootViewController = tabBar;
            
            tabBar.selectedIndex =1;
            
            UINavigationController *nav = tabBar.viewControllers[1];
            
            WL_ApplicationViewController *VC =(WL_ApplicationViewController*)nav.childViewControllers[0];
            
            VC.company_id = @"2";
           
       //资金变动提醒
        }else if ([model.msg_type integerValue]==3){
           
            WL_FundAccount_ViewController *VC = [[WL_FundAccount_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
         //出团提醒
        }else if ([model.msg_type integerValue]==4)
        {
            
            WL_Application_Driver_Trip_ViewController *VC =[[WL_Application_Driver_Trip_ViewController alloc]init];
            
            VC.hidesBottomBarWhenPushed = YES;
            
            NSDateFormatter *fotmatter =[[NSDateFormatter alloc]init];
            
            [fotmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *date =[fotmatter dateFromString:model.create_date];
            
            VC.someDate = date;
            
            [self.navigationController pushViewController:VC animated:YES];
           //预付款提醒
        }else if ([model.msg_type integerValue]==5)
        {
           //订单详情
//            WL_Application_Driver_Order_AcceptOrderDetail_ViewController *VC = [[WL_Application_Driver_Order_AcceptOrderDetail_ViewController alloc]init];
//            
//            VC.sj_order_id = @"29";
//            
//            VC.hidesBottomBarWhenPushed =YES;
//            
//            [self.navigationController pushViewController:VC animated:YES];
            
            WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
            
            [ShareApplicationDelegate window].rootViewController = tabBar;
            
            tabBar.selectedIndex =1;
          //备用金提醒
        }else if ([model.msg_type integerValue]==6)
        {
           //订单详情
//            WL_Application_Driver_Order_AcceptOrderDetail_ViewController *VC = [[WL_Application_Driver_Order_AcceptOrderDetail_ViewController alloc]init];
//            
//            VC.sj_order_id = @"29";
//            
//            VC.hidesBottomBarWhenPushed =YES;
//            
//            [self.navigationController pushViewController:VC animated:YES];
            WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
            
            [ShareApplicationDelegate window].rootViewController = tabBar;
            
            UINavigationController *nav = tabBar.viewControllers[1];
            
            WL_ApplicationViewController *VC =(WL_ApplicationViewController*)nav.childViewControllers[0];
            
            VC.company_id = @"2";
            
            VC.type = 1;
            
            WlLog(@"%@",nav.childViewControllers);
            
            tabBar.selectedIndex =1;
        }
        
    //酒店
    }else if ([model.role_type integerValue]==3)
    {
       
        //接单提醒
        if([model.msg_type integerValue]==1) {
            
            
            
          //身份认证提醒
        }else if ([model.msg_type integerValue]==2){
            
            WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
            
            [ShareApplicationDelegate window].rootViewController = tabBar;
            
            UINavigationController *nav = tabBar.viewControllers[1];
            
            WL_ApplicationViewController *VC =(WL_ApplicationViewController*)nav.childViewControllers[0];
            
            VC.company_id = @"2";
            
            WlLog(@"%@",nav.childViewControllers);
            
            tabBar.selectedIndex =1;
        //资金变动提醒
        }else if ([model.msg_type integerValue]==3){
            
            WL_FundAccount_ViewController *VC = [[WL_FundAccount_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
         
            //出团提醒
        }else if ([model.msg_type integerValue]==4)
        {
          
            //预付款提醒
        }else if ([model.msg_type integerValue]==5)
        {
           //备用金提醒
        }else if ([model.msg_type integerValue]==6)
        {
            
        }
    }

    }
}
-(void)EScrollerViewDidClicked:(NSUInteger)index
{

    if (self.noticeArray.count==0) {
        
        return;
    }
    
    WL_NoticeDetail_ViewController *VC =[[WL_NoticeDetail_ViewController alloc]init];
    
    WL_CompanyBanner_Model *model = self.noticeArray[index-1];
    
    VC.hidesBottomBarWhenPushed = YES;
    
    VC.typeOfPush = 1;
    
    VC.notice_id = model.notice_id;
    
    [self.navigationController pushViewController:VC animated:YES];
}
@end
