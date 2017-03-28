//
//  WL_AddFriendByPhone_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/5.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddFriendByPhone_ViewController.h"
#import "RCDChatViewController.h"

@interface WL_AddFriendByPhone_ViewController ()<UISearchDisplayDelegate,UISearchBarDelegate>


@property (nonatomic,strong) NSMutableArray *saveArr;

//@property (nonatomic,strong) UISearchController *searchVC;

//@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong)NSMutableArray *filterArray;

//显示搜索的显示器
//@property (nonatomic,strong)UISearchDisplayController *searchDisplayController;

@end

@implementation WL_AddFriendByPhone_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BgViewColor;
    
    self.navigationItem.title =@"添加好友";
    //解决 searchBar跳动的问题
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self setExtendedLayoutIncludesOpaqueBars:YES];
    
    _filterArray =[[NSMutableArray alloc]init];
   
    //[self creatTableView];
  
}

//- (void)creatTableView {
//   
//    
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-0.5, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
//    
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
//    _tableView.dataSource =self;
//    
//    _tableView.delegate = self;
//    
//    _tableView.tableFooterView = [UIView new];
//    
//    
//    UISearchBar *searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
//    
//    searchBar.placeholder = @"请输入手机号";
//    
//    self.tableView.tableHeaderView = searchBar;
//    
////    _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
////   
////    _searchDisplayController.searchResultsDelegate = self;
////    
////    _searchDisplayController.searchResultsDataSource = self;
////    
////    _searchDisplayController.delegate =self;
////    
////    [_searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
//    
//    
//     [self.view addSubview:_tableView];
//}
//
//
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//   
//    
//  //  [self.tableView reloadData];
//    
//    return YES;
//}
//
//#pragma mark - UITableView
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//   
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//   
//    if (tableView ==self.tableView) {
//      
//        return self.dataArr.count;
//    }
//    
//    return self.filterArray.count;
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
//    cell.textLabel.text = self.filterArray[indexPath.row];
//    return cell;
//}
////选中cell
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//
//    //创建会话
//    RCDChatViewController *chatViewController =
//    [[RCDChatViewController alloc] init];
//    chatViewController.conversationType = ConversationType_PRIVATE;
//    chatViewController.targetId = @"166";
//   // chatViewController.title = self.userInfo.name;
//    chatViewController.needPopToRootView = YES;
//    chatViewController.displayUserNameInCell = NO;
//    [self.navigationController pushViewController:chatViewController
//                                         animated:YES];
//
//    
//}

//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//   
//    [self.filterArray removeAllObjects];
//    
//    
//    [self.filterArray setArray:[NSArray arrayWithObjects:@"123", nil]];
//    
//
//    
//    return  YES;
//}


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
