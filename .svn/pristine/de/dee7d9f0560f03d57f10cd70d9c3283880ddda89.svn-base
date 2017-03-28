//
//  WL_MessageViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/8/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  消息主控制器

#import "WL_MessageViewController.h"
#import "UITabBar+badge.h"
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
#import "WLScheduleListViewController.h"
#import "WL_Application_Driver_Trip_ViewController.h"
#import "WL_ApplicationViewController.h"
#import "WLNetworkMessageHandler.h"
#import "WLMessageSearchView.h"
#import "WLNetworkDriverHandler.h"
#import "WL_TradeRecord_ViewController.h"
#import "WLJumpToOrderDetailViewControllerTool.h"
#import "WL_Application_Driver_Jockey_ViewController.h"
#import "WL_Application_Driver_addCar_viewController.h"
#import "WLCarBookingChooseDriverController.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLCarBookingOrderDetailObject.h"
#import "WLCarBookingDriverObject.h"
#import "WLCarBookingOrderDetailController.h"

@interface WL_MessageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate,UIScrollViewDelegate>

@property(nonatomic, assign) NSUInteger index;
@property (nonatomic,strong) UISearchController *searchVC;

@property(nonatomic, strong) NSMutableArray *bannerArray;
@property(nonatomic, strong) NSMutableArray *noticeArray;
@property(nonatomic, strong) NSMutableArray *searchResultArray;
//今天消息列表
@property(nonatomic, strong) NSMutableArray *todayMessageArray;
//历史消息列表
@property (nonatomic, strong) NSMutableArray *historyMmessageArray;
//所有消息的数组
@property (nonatomic, strong) NSMutableArray <WL_MessageList_itemsModel *>*messageArray;


@property(nonatomic, copy)   NSString *lastSearchString;

@property(nonatomic, assign) BOOL isClick;


@property(nonatomic, strong) WL_NoData_View *noDataView;
@property(nonatomic, strong) WL_NoData_View *noDataView2;
@property(nonatomic)dispatch_group_t group;



@property(nonatomic, assign) BOOL delete;
@property(nonatomic, assign) BOOL isNoNet;
@property(nonatomic, assign) BOOL isNoServer;

/**< 轮播图的数据源 */
@property(nonatomic, strong) NSMutableArray *pictureArray;
/**< 轮播图下面的公告 */
@property (nonatomic, weak) UILabel *noticeLabel;
/**< 轮播图 */
@property (nonatomic, weak) CycleScrollView *advertisementBunner;
/**< 组头的图片 */
@property (nonatomic, weak) UIImageView *groupHeadImageView;
//记录下拉刷新的页数
@property (nonatomic, copy) NSString *nextURL;
/**< 记录数据的当前页 */
@property (nonatomic, copy) NSString *currentPage;
@end

@implementation WL_MessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavigationLeftImg:@""];
    self.navigationItem.title = @"微叮";
    self.view.backgroundColor = [WLTools stringToColor:@"#ffffff"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /**< 创建缓存路径 */
    [WLDataManager creatFile];
    
    self.nextURL = nil;
    self.currentPage = nil;
    [self createBannerAndTableView];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hidHud];
    self.nextURL = nil;
    self.currentPage = nil;
    [self loadMessageData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hidHud];
}
#pragma mark network


- (void)loadMessageData{
    
    [self.todayMessageArray removeAllObjects];
    [self.historyMmessageArray removeAllObjects];
    [self.pictureArray removeAllObjects];
    [self.noticeArray removeAllObjects];

    [self showHud];
    self.isNoServer = NO;
    self.isNoNet = NO;

    WS(weakSelf);
    [WLNetworkMessageHandler requestMessageListWithNextUrl:self.nextURL
                                              andDataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                  
                                                  [weakSelf hidHud];
                                                  if (responseType == WLResponseTypeSuccess) {
                                                      WL_MessageList_dataModel *dataModel = data;
                                                      if (dataModel.Myitems.count == 0) {
                                                         [self hideNoData:NO andType:WLNetworkTypeNOData];
                                                      }
                                                      if ([self.currentPage integerValue] == [dataModel.My_meta.pageCount integerValue]) {/*说明是最后一页*/
                                                    
                                                          [weakSelf.messageTableView.mj_header endRefreshing];
                                                          [weakSelf.messageTableView.mj_footer endRefreshing];
                                                          for (WL_MessageList_itemsModel *model in self.messageArray) {
                                                              BOOL result = [NSString isTodayWithTimeString: model.created_at];
                                                              if (result) {
                                                                  [self.todayMessageArray addObject:model];
                                                              }else
                                                              {
                                                                  [self.historyMmessageArray addObject:model];
                                                              }
                                                          }
                                                          [weakSelf.messageTableView reloadData];
                                                          return;
                                                      }
                                                      if (self.nextURL == nil||self.nextURL.length==0) {
                                                          [self.messageArray removeAllObjects];
                                                          self.messageArray = dataModel.Myitems;
                                                      }else{
                                                          [self.messageArray addObjectsFromArray:dataModel.Myitems];
                                                      }
                                                   
                                                      for (WL_MessageList_itemsModel *model in self.messageArray) {
                                                          BOOL result = [NSString isTodayWithTimeString: model.created_at];
                                                          if (result) {
                                                              [self.todayMessageArray addObject:model];
                                                          }else
                                                          {
                                                              [self.historyMmessageArray addObject:model];
                                                          }
                                                      }
                                                      self.currentPage = dataModel.My_meta.currentPage;
                                                      if ([dataModel.My_meta.currentPage integerValue] == [dataModel.My_meta.pageCount integerValue]) {
                                                          
                                                      }else
                                                      {
                                                          self.nextURL = dataModel.My_links.MyNext.href;
                                                      }
                                                      
                                                  }else if (responseType == WLResponseTypeNoNetwork){
                                                    
                                                      self.isNoNet = YES;
                                                  }else{
                                                      self.isNoServer = YES;
                                                  }
                                                  
                                                  if (weakSelf.isNoNet){
                                                      [weakSelf hideNoData:NO andType:WLNetworkTypeNONetWork];
                                                      
                                                  }else if (weakSelf.isNoServer){
                                                      [weakSelf hideNoData:NO andType:WLNetworkTypeSeverError];
                                                      
                                                  }else if (weakSelf.pictureArray.count==0 &&weakSelf.todayMessageArray.count==0&&weakSelf.historyMmessageArray.count==0) {
                                                      
                                                      [self hideNoData:NO andType:WLNetworkTypeNOData];
                                                      
                                                  }
                                                  [weakSelf.messageTableView reloadData];

                                              }];
    

}

#pragma mark UI
-(void)createBannerAndTableView{
    
//    _messageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64-44) style:UITableViewStylePlain];
    /* 隐藏搜索条 */
    _messageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64-60) style:UITableViewStylePlain];
    _messageTableView.dataSource = self;
    _messageTableView.delegate = self;
    _messageTableView.backgroundColor = [UIColor whiteColor];
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _messageTableView.tableFooterView = [UIView new];
    _messageTableView.showsHorizontalScrollIndicator = NO;
    _messageTableView.showsVerticalScrollIndicator = NO;
//    _messageTableView.contentInset = UIEdgeInsetsMake(0, 0, -15, 0);
    [self.view addSubview:_messageTableView];
    
    WS(weakSelf);
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        // 增加数据
        [_messageTableView.mj_header  beginRefreshing];
        //网络请求
        [weakSelf refreshMessageData];
        [_messageTableView.mj_header   endRefreshing];
        
    }];
    
    _messageTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    //上拉刷新
    
   
    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [_messageTableView.mj_footer  beginRefreshing];
        [weakSelf loadMessageData];
         [_messageTableView.mj_footer  endRefreshing];
        
    }];
    _messageTableView.mj_footer = footer;

    /* 隐藏搜索条 */
    //创建一个tableViewController自带一个tableView
//    self.tableVC = [[WL_SearchResultTableView alloc] initWithStyle:UITableViewStyleGrouped];
//    self.tableVC.tableView.height = ScreenHeight-64+20;
//    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:self.tableVC];
//    self.tableVC.popSearchTextBlock = ^(NSString *text){
//
//        weakSelf.searchVC.searchBar.text = text;
//    };
//        
//    self.searchVC.searchBar.delegate = self;
//    self.searchVC.searchResultsUpdater = self;
//    self.searchVC.delegate = self;
//    self.searchVC.dimsBackgroundDuringPresentation = NO;
//    self.searchVC.hidesNavigationBarDuringPresentation = YES;
//    self.searchVC.searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    _messageTableView.tableHeaderView = self.searchVC.searchBar;
//    self.searchVC.searchBar.placeholder= @"搜索名字、拼音、手机号";
//    self.definesPresentationContext = YES;
//    self.searchVC.searchBar.barTintColor = [WLTools stringToColor:@"#ffffff"];
//    self.search = self.searchVC;
    
    [self.view addSubview:self.noDataView];
    [self.view addSubview:self.noDataView2];

}

- (void)refreshMessageData
{
    self.nextURL = nil;
    self.currentPage = nil;
    [self loadMessageData];
}
#pragma mark UISearchResultsUpdating
/**< 搜索框文字的改变 */
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
    self.lastSearchString = self.searchVC.searchBar.text;
    /**< 保存搜索结果的数组 */
    [self.searchResultArray removeAllObjects];

    WS(weakSelf);
    [WLNetworkMessageHandler searchMessageListWithText:self.searchVC.searchBar.text
                                          andDataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                              if (responseType == WLResponseTypeSuccess) {
                                                  WL_MessageList_dataModel *dataModel = data;
                                                  weakSelf.searchResultArray = dataModel.Myitems;
                                                  weakSelf.bottomView.hidden =YES;
                                                  weakSelf.searchCusomView.hidden =YES;
                                                  weakSelf.tableVC = (WL_SearchResultTableView *)searchController.searchResultsController;
                                                  [weakSelf.tableVC reloadDataWithArray:weakSelf.searchResultArray];
                                                  weakSelf.tableVC.searchText = weakSelf.searchVC.searchBar.text;
                                                  
                                              }else if (responseType == WLResponseTypeNoNetwork){
                                                  
                                                  
                                              }else{
                                                  
                                              }
                                          }];
}

#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.showsCancelButton = YES;
    self.messageTableView.hidden = YES;
    if (self.todayMessageArray.count==0&&self.historyMmessageArray.count==0) {
        self.noDataView.hidden =YES;
    }
    
    NSMutableArray *mutableArray = [WLDataManager getMainMessageSearchData];
    
    WS(weakSelf);
    if (mutableArray.count>0) {
        NSArray *arr =[[NSArray alloc]init];
        if (mutableArray.count>8) {
          arr = [mutableArray subarrayWithRange:NSMakeRange(mutableArray.count - 8, 8)];
        }else{
            arr = [NSArray arrayWithArray:mutableArray];
        }
        
        self.searchCusomView =[[SearchCusomHistory alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth,200) andItems:arr andItemClickBlock:^(NSInteger i) {
            
            weakSelf.searchVC.searchBar.text = arr[i];
        
        }];
        [self.view addSubview:self.searchCusomView];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchCusomView.frame = CGRectMake(0, 64, ScreenWidth, self.searchCusomView.collectionView.contentSize.height);
            self.searchCusomView.backgroundColor = BgViewColor;
            self.bottomView.y = 64+self.searchCusomView.collectionView.contentSize.height;
            [self.view addSubview:self.bottomView];
            
        });
    
    }else{
        self.bottomView.y = 64;
        [self.view addSubview:self.bottomView];
    }
    self.searchCusomView.deleteButtonClick  = ^(){
        
       [UIView animateWithDuration:0.25 animations:^{
          
           [weakSelf.searchCusomView removeFromSuperview];
           weakSelf.bottomView.y = 64;
        
           [WLDataManager clearAllMessageSearchData];
        
       }];
    };
    
    UIButton *canceLBtn = [self.searchVC.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.barTintColor = [WLTools stringToColor:@"#4877e7"];
    self.searchVC.searchBar.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    UIButton *canceLBtn = [self.searchVC.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
}

-(void)willDismissSearchController:(UISearchController *)searchController
{
    self.searchVC.searchBar.showsCancelButton = NO;
    self.searchVC.searchBar.barTintColor = BgViewColor;
    
    
    if(searchController.searchBar.text.length)
    {
        //保存到沙盒(逻辑封装在里面)
        [WLDataManager saveMainMessageSearchWithData:searchController.searchBar.text];
    }
    if (self.todayMessageArray.count==0&&self.historyMmessageArray.count==0) {
      self.noDataView.hidden = NO;
    }
    [self.searchCusomView removeFromSuperview];
    [self.bottomView removeFromSuperview];
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    
    self.messageTableView.hidden =NO;
    if (self.todayMessageArray.count==0&&self.historyMmessageArray.count==0) {
        self.noDataView.hidden = NO;
    }
    [self.searchCusomView removeFromSuperview];
    [self.bottomView removeFromSuperview];
}
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//   
//
//    [self.searchVC.searchBar resignFirstResponder];
//}

#pragma mark tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.messageTableView) {
        if (self.todayMessageArray.count!=0&&self.historyMmessageArray.count!=0)
        {
             return 2;
        }else if((self.todayMessageArray.count!=0&&self.historyMmessageArray.count==0)||(self.todayMessageArray.count==0&&self.historyMmessageArray.count!=0))
        {
            return 1;
        }else if(self.todayMessageArray.count==0&&self.historyMmessageArray.count==0)
        {
            return 0;
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.messageTableView)
    {
        if (section == 0)
        {
            if (self.todayMessageArray.count!=0&&self.historyMmessageArray.count==0) {
                return self.todayMessageArray.count;
            }else if (self.todayMessageArray.count==0&&self.historyMmessageArray.count!=0)
            {
                return self.historyMmessageArray.count;
            }
            return self.todayMessageArray.count;
        }else if (section == 1)
        {
          return self.historyMmessageArray.count;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.messageTableView) {
        
        /**< 消息页面的cell */
        static NSString *cellID = @"cellID";
        WL_messageTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell =[[WL_messageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        WL_MessageList_itemsModel *model;
        
        if (indexPath.section == 0)
        {
            if (self.todayMessageArray.count!=0&&self.historyMmessageArray.count==0) {
                
                model = self.todayMessageArray[indexPath.row];
                
            }else if (self.todayMessageArray.count==0&&self.historyMmessageArray.count!=0)
            {
                model = self.historyMmessageArray[indexPath.row];
                
            }else if(self.todayMessageArray.count!=0&&self.historyMmessageArray.count!=0)
            {
                model = self.todayMessageArray[indexPath.row];
            }
            
        }else if (indexPath.section == 1)
        {
            if (self.historyMmessageArray.count!=0) {
                 model = self.historyMmessageArray[indexPath.row];
            }
           
        }
        cell.model = model;
        cell.indexPath = indexPath;
        
        return cell;
    }
    
    /**< 搜索界面的cell */
    static NSString *cellID = @"UITableView";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
    
    
    
//    if (tableView == self.messageTableView) {
    
//        /**< 轮播图的cell */
//        if (indexPath.section==0) {
//            static NSString *cellID = @"UITableViewCell";
//            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
//            
//            if (cell==nil) {
//                cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//                /**< 广告轮播图 */
////                cell.contentView.subviews
////                CycleScrollView *advertisementBunner = [[CycleScrollView alloc]initWithFrameRect:CGRectMake(0,0, ScreenWidth, ScaleH(151)) ImageArray:self.pictureArray];
//               
//                 CycleScrollView *advertisementBunner = [[CycleScrollView alloc]initWithFrameRect:CGRectMake(0,0, ScreenWidth, ScaleH(157)) ImageArray:@[@"cycle1",@"cycle2",@"cycle3"]];
//                
//                advertisementBunner.delegate = self;
//                self.advertisementBunner = advertisementBunner;
//                cell.contentView.userInteractionEnabled = YES;
//                [cell.contentView addSubview:advertisementBunner];
//                
//                /**< 轮播图下面的公告 */
//                UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,ScaleH(CGRectGetMaxY(advertisementBunner.frame)-49), ScreenWidth, ScaleH(49))];
//                
//                noticeLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
////                noticeLabel.backgroundColor = [WLTools stringToColor:@"#333333"];
////                noticeLabel.backgroundColor = [UIColor clearColor];
//                noticeLabel.textColor = [UIColor whiteColor];
//                noticeLabel.font = systemFont(17);
//                noticeLabel.text = @"   公告:春节旅游旺季平台奖励通知事项";
//                noticeLabel.textAlignment = NSTextAlignmentLeft;
//                noticeLabel.userInteractionEnabled = NO;
//                cell.selectionStyle =  UITableViewCellSelectionStyleNone;
////                [cell.contentView addSubview:noticeLabel];
////                self.noticeLabel = noticeLabel;
//            }
////            [self.advertisementBunner initView:self.pictureArray];
//            [self.advertisementBunner initView:@[@"cycle1",@"cycle2",@"cycle3"]];
//            return cell;
//            
//        }
//        

}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.messageTableView) {
//        if(section == 0)
//        {
//            return 0.01;
//        }else
//        {
//            return ScaleH(43.5);
//        }
         return ScaleH(43.5);
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (tableView==self.messageTableView) {
//        return 15;
//    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.messageTableView) {
        if (section >= 0) {
            UIView *padView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(60))];
            UIImageView *groupHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleH(13.5), 0, 0)];
            if (section == 0)
            {
                if (self.todayMessageArray.count!=0&&self.historyMmessageArray.count==0) {
                    groupHeadImageView.image = [UIImage imageNamed:@"jintian"];
                }else if (self.todayMessageArray.count==0&&self.historyMmessageArray.count!=0)
                {
                     groupHeadImageView.image = [UIImage imageNamed:@"lishi"];
                }else if(self.todayMessageArray.count!=0&&self.historyMmessageArray.count!=0)
                {
                   groupHeadImageView.image = [UIImage imageNamed:@"jintian"];
                }
                
            }else if(section == 1)
            {
                groupHeadImageView.image = [UIImage imageNamed:@"lishi"];
            }
           
            [groupHeadImageView sizeToFit];
            [padView addSubview:groupHeadImageView];
            self.groupHeadImageView = groupHeadImageView;
            padView.backgroundColor = Color5;
            return padView;
        }
        return nil;
    }
    return nil;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (tableView== self.messageTableView) {
//        UIView *padView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
//        padView.backgroundColor =BgViewColor;
//        return padView;
//    }
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.messageTableView) {
//        if (indexPath.section==0) {
//            return ScaleH(157);
//        }
        WL_MessageList_itemsModel *model;
        
        if (indexPath.section == 0)
        {
            
            if (self.todayMessageArray.count!=0&&self.historyMmessageArray.count==0) {
                model = self.todayMessageArray[indexPath.row];
                
            }else if (self.todayMessageArray.count==0&&self.historyMmessageArray.count!=0)
            {
                model = self.historyMmessageArray[indexPath.row];
                
            }else if(self.todayMessageArray.count!=0&&self.historyMmessageArray.count!=0)
            {
                model = self.todayMessageArray[indexPath.row];
            }
            
        }else if (indexPath.section == 1)
        {
            if (self.historyMmessageArray.count!=0) {
                model = self.historyMmessageArray[indexPath.row];
            }
            
        }
        return [WL_messageTableViewCell getCellHeightWithContentString:model.message];
     
    }
    return ScaleH(45);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>=0) {
        
        WL_MessageList_itemsModel *model;
        if (indexPath.section == 0)
        {
            if (self.todayMessageArray.count!=0&&self.historyMmessageArray.count==0) {
                
                model = self.todayMessageArray[indexPath.row];
                
            }else if (self.todayMessageArray.count==0&&self.historyMmessageArray.count!=0)
            {
                model = self.historyMmessageArray[indexPath.row];
            }else if(self.todayMessageArray.count!=0&&self.historyMmessageArray.count!=0)
            {
                model = self.todayMessageArray[indexPath.row];
            }
            
        }else if (indexPath.section == 1)
        {
            model = self.historyMmessageArray[indexPath.row];
        }
        
        //改变消息状态
        [self showHud];
        [WLNetworkMessageHandler changeMessageStatusWithMessageID:model.Myid andStatus:@"1" andDataBlock:^(WLResponseType responseType, id data, NSString *message) {
            if (responseType == WLResponseTypeSuccess) {
                [self hidHud];
            }
        }];
    
    //导游
    if ([model.role_type integerValue]==1)
    {
        //接单提醒  跳转接单列表
        if([model.msg_type integerValue]==1) {
            
         //身份变动提醒 跳转应用首页
        }else if ([model.msg_type integerValue]==2){
            
            WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
            
            [ShareApplicationDelegate window].rootViewController = tabBar;
            
//            UINavigationController *nav = tabBar.viewControllers[1];
            
//            WL_ApplicationViewController *VC = (WL_ApplicationViewController*)nav.childViewControllers[0];
            
//            VC.company_id = @"2";
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
            
            NSDate *date =[fotmatter dateFromString:model.created_at];
            
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
       
        switch ([model.msg_type integerValue]) {
            case 1:
            case 2:
            {
             [KJumpTool jumpToDriveOrderDetailViewControllerWithOrderID:model.relation_id andNaVC:self.navigationController];
                break;
            }
            case 3:
            {
                WL_Application_Driver_Trip_ViewController *VC =[[WL_Application_Driver_Trip_ViewController alloc]init];
                
                VC.hidesBottomBarWhenPushed = YES;
                
                NSDateFormatter *fotmatter =[[NSDateFormatter alloc]init];
                
                [fotmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                NSDate *date =[fotmatter dateFromString:model.created_at];
                
                VC.someDate = date;
                
                [self.navigationController pushViewController:VC animated:YES];
            }
            case 4:
                break;
            case 5:
            case 6://司机身份认证消息
            {
                if ([model.from_company_id integerValue]<= 0 || model.from_company_id == nil) {
                    [[WL_TipAlert_View sharedAlert] createTip:@"该消息已过期,请刷新页面"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] requestDriverAndCarStatusWithCompanyID:model.from_company_id AndResultBlock:^(BOOL  success, WLDriverStatus driverStatus, WLCarStatus carStatus,NSNumber *drive_id, NSString *cityString) {
                    if (success) {
                        WL_Application_Driver_Jockey_ViewController *jockeyVc = [[WL_Application_Driver_Jockey_ViewController alloc] init];
                        jockeyVc.driverStatus = driverStatus;
                        jockeyVc.hidesBottomBarWhenPushed = YES;
                        jockeyVc.comPany_id = model.from_company_id;
                        
                        [self.navigationController pushViewController:jockeyVc animated:YES];
                      
                    }else{
                      [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请稍后再试"];
                    }
                }];
                break;
            }
            case 7:
            {
                WL_TradeRecord_ViewController *VC =[[WL_TradeRecord_ViewController alloc]init];
                
                [self.navigationController pushViewController:VC animated:YES];
                break;
            }
            case 8:
            case 9:
            case 10:
            case 11:
            case 18:
            {
                [KJumpTool jumpToDriveBookOrderDetailViewControllerWithOrderID:model.relation_id andNaVC:self.navigationController];
                break;
            }
            case 12:
            case 13://车辆认证消息
            {
                if ([model.from_company_id integerValue]<= 0 || model.from_company_id == nil) {
                    [[WL_TipAlert_View sharedAlert] createTip:@"该消息已过期,请刷新页面"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] requestDriverAndCarStatusWithCompanyID:model.from_company_id AndResultBlock:^(BOOL success, WLDriverStatus driverStatus, WLCarStatus carStatus,NSNumber *drive_id, NSString *cityString) {
                    if (success) {
                        WL_Application_Driver_addCar_viewController *addCarVc = [[WL_Application_Driver_addCar_viewController alloc] init];
                        addCarVc.companyId = model.from_company_id;
                        addCarVc.carStatus = [NSString stringWithFormat:@"%ld",carStatus];
                        if([drive_id isKindOfClass:[NSNumber class]])
                        {
                            addCarVc.driveId  = [drive_id stringValue];
                        }else
                        {
                            addCarVc.driveId = (NSString *)drive_id;
                        }
        
                        addCarVc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:addCarVc animated:YES];
                        
                    }else{
                        [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请稍后再试"];
                    }
                }];
                break;
            }
            default:
                break;
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
    else if ([model.role_type integerValue]==6)/**< 叫车 */
    {
        [self isUptime:model.relation_id];
    }
        
    }
}

- (void)isUptime:(NSString *)thisId;
{
    [WLNetworkCarBookingHandler requestOrderDetailWithOrderID:thisId dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            WLCarBookingOrderDetailObject * object = data;
            
            WLCarBookingDriverObject *oobject = [[WLCarBookingDriverObject alloc] init];
            if (object.order_bid_list.count != 0) {
                oobject = object.order_bid_list[0];
            }
            
            NSInteger bitstatus = [oobject.bid_status integerValue];
            if (bitstatus == 1) {
                WLCarBookingChooseDriverController *detailVC = [[WLCarBookingChooseDriverController alloc] init];
                detailVC.orderID = thisId;
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
            else
            {
                WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
                detailVC.orderID = thisId;
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
            
            
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:message];
            
        }
    }];
}

#pragma mark 定制cell删除按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>=0) {
        UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
    
            WL_MessageList_itemsModel *model;
            if (indexPath.section == 0)
            {
                if (self.todayMessageArray.count!=0&&self.historyMmessageArray.count==0) {
                    
                    model = self.todayMessageArray[indexPath.row];
                    
                }else if (self.todayMessageArray.count==0&&self.historyMmessageArray.count!=0)
                {
                    model = self.historyMmessageArray[indexPath.row];
                }else if (self.todayMessageArray.count!=0&&self.historyMmessageArray.count!=0)
                {
                    model = self.todayMessageArray[indexPath.row];
                }
                
            }else if (indexPath.section == 1)
            {
                model = self.historyMmessageArray[indexPath.row];
            }
            
            WS(weakSelf);
            self.delete = YES;
            [self showHud];
            [WLNetworkMessageHandler deleteMessageWithMessageID:model.Myid
                                             WithOperationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                                 if (responseType == WLResponseTypeSuccess && result) {
                                                    
                                                     [weakSelf hidHud];
                                                      weakSelf.nextURL = nil;
                                                     [weakSelf loadMessageData];
                                                    
                                                 }
                                                 [[WL_TipAlert_View sharedAlert]createTip:message];
                                             }];
            
            
        }];
        
        deleteRowAction.backgroundColor = [UIColor redColor];
        return @[deleteRowAction];
        
    }
    return [NSArray arrayWithObjects:@"", nil];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}


#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UITableView *tableview = (UITableView *)scrollView;
    CGFloat sectionHeaderHeight = 0.01;
    CGFloat sectionFooterHeight = 15;
    CGFloat offsetY = tableview.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight){
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight){
        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height) {
        // tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
    }
}

#pragma mark private method
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

-(void)NavigationRightEvent
{
    WL_PrivateLetter_ViewController *VC =[[WL_PrivateLetter_ViewController alloc]init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    if (self.pictureArray.count>0&&self.todayMessageArray.count==0&&self.historyMmessageArray.count==0) {
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 键盘
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect rect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableVC.tableView.height = ScreenHeight - rect.size.height;
    
}

- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    self.tableVC.tableView.height = ScreenHeight -64+20;
}

#pragma mark 懒加载
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

- (NSMutableArray *)todayMessageArray
{
    if (_todayMessageArray == nil) {
        _todayMessageArray =[[NSMutableArray alloc]init];
    }
    return _todayMessageArray;
}
-(NSMutableArray *)historyMmessageArray
{
    if (_historyMmessageArray == nil) {
        _historyMmessageArray = [[NSMutableArray alloc]init];
    }
    return _historyMmessageArray;
}
- (NSMutableArray *)messageArray
{
    if (_messageArray == nil) {
        _messageArray = [[NSMutableArray alloc]init];
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

-(UIView *)bottomView{
    
    if (_bottomView==nil) {
        _bottomView = [[WLMessageSearchView alloc] initWithFrame:CGRectMake(0, 64+120, ScreenWidth, 125)];
    }
    return _bottomView;
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
        _noDataView = [self creatNoDataViewWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64)];
    }
    return _noDataView;
}

//无数据提示
- (WL_NoData_View *)noDataView2 {
    
    if (_noDataView2 == nil) {
        
        _noDataView2 = [self creatNoDataViewWithFrame:CGRectMake(0,ScaleH(157), ScreenWidth, ScaleH(ScreenHeight-157) - 64)];
    }
    return _noDataView2;
}
/**< 创建一个无数据的View */
- (WL_NoData_View *)creatNoDataViewWithFrame:(CGRect )frame
{
    WL_NoData_View *noDataView = [[WL_NoData_View alloc] initWithFrame:frame andRefreshBlock:nil];

    noDataView.hidden = YES;
    return noDataView;
}
@end
