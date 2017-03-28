//
//  WL_AddressBook_MyFriends_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  微叮好友主控制器

#import "WL_AddressBook_MyFriends_ViewController.h"

#import "WL_AddressBook_LinkManDetail_ViewController.h"
#import "WL_AddressBook_MyFriends_Search_ViewController.h"

#import "WL_AddressBook_MyFriends_Cell.h"
#import "WL_AddressBook_MyFriends_RightList_Cell.h"
#import "WL_AddressBook_Search_View.h"

#import "WL_AddressBook_MyFriend_Model.h"

#import "WL_AddressBook_MyFriendList_Model.h"

#import "WL_AddressBook_MyFriends_addWeiDingFriends_ViewController.h"

@interface WL_AddressBook_MyFriends_ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 微叮好友的分组数 */
@property(nonatomic, strong) NSMutableArray *sections;
/** 微叮好友排序完成的分组数 */
@property(nonatomic, strong) NSArray *sortSections;

/** 微叮好友的每组好友的模型数组 */
@property(nonatomic, strong) NSMutableArray *rows;

/** 微叮好友的模型数组 */
@property(nonatomic, strong) NSMutableArray *myFriendModels;

//TableView
@property(nonatomic, weak) UITableView *myFriendsTableView;
//网络请求时用到的提示弹框
@property(nonatomic, strong)WL_TipAlert_View *alert;

/** 无网络的View */
@property(nonatomic, strong)WL_NoData_View *noDataView;

@end

@implementation WL_AddressBook_MyFriends_ViewController

- (void)dealloc
{
    [self.alert removeFromSuperview];
}

- (NSMutableArray *)myFriendModels
{
    if (!_myFriendModels) {
        _myFriendModels = [NSMutableArray array];
    }
    return _myFriendModels;
}

- (NSMutableArray *)sections
{
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (NSMutableArray *)rows
{
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}

- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            [weakSelf sendRequestToMyFriendList];
        }];
        
        [self.view addSubview:_noDataView];
        
        _noDataView.hidden = YES;
    }
    
    return _noDataView;
}



#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置内容
    [self setupContentViewToMyFriends];
    //发送请求 ,请求好友列表
    [self sendRequestToMyFriendList];
    //注册弹框
    [self creatTipAlertView];
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 发送请求,获取好友列表数据
- (void)sendRequestToMyFriendList
{
    //好友列表Url
    NSString *urlStr = MyFriendListUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    //返回的数据格式
    NSString *sort_mode = @"2";
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword,
                             @"sort_mode" : sort_mode
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"])
        {
            [self hidHud];
            [self.alert createTip:baseModel.msg];
            return;
        }
        
        if ([baseModel.data isKindOfClass:[NSArray class]]) {
            [self.alert createTip:@"暂无微叮好友"];
            [self hideNoData:NO andType:WLNetworkTypeNOData];
            [self hidHud];
            return;
        }

        
//        WL_AddressBook_MyFriendList_Model *friendListModel = [WL_AddressBook_MyFriendList_Model mj_objectWithKeyValues:baseModel.data];
        
        
        for (NSString *s in [baseModel.data allKeys]) {
            [self.sections addObject:s];
        }
        self.sortSections = [self.sections sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        /** 14号字,上下间距为10 */
        UITableView *rightListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:rightListTableView];
        CGFloat rightListHeight = self.sections.count * (14 + 10);
        [rightListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).offset(-7);
            make.centerY.equalTo(self.view.mas_centerY);
            make.width.equalTo(@28);
            make.height.equalTo(@(rightListHeight));
        }];
        rightListTableView.delegate = self;
        rightListTableView.dataSource = self;
        [rightListTableView registerClass:[WL_AddressBook_MyFriends_RightList_Cell class] forCellReuseIdentifier:listCellId];
        rightListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        rightListTableView.backgroundColor = [UIColor clearColor];
        
        for (int i = 0; i < self.sortSections.count; i++) {
            [self.rows addObject:[baseModel.data valueForKey:self.sortSections[i]]];
        }
        [self hidHud];
        [self.myFriendsTableView reloadData];
    } Failure:^(NSError *error) {
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
        //隐藏菊花
        [self hidHud];
    }];
    
}

#pragma mark - 设置内容
- (void)setupContentViewToMyFriends
{
    //1. 标题
    self.title = @"微叮好友";
    //2.设置背景颜色
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    
    //2.设置页面内容
    [self setupChildViewToMyFriends];
  
}

static NSString *const cellId = @"myFriendsCellId";
static NSString *const listCellId = @"listCellId";
#pragma mark - setupChildViewToMyFriends<设置页面子控件>
- (void)setupChildViewToMyFriends
{
    //添加列表一个TableView
    UITableView *myFriendsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:myFriendsTableView];
    [myFriendsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //属性
    myFriendsTableView.delegate = self;
    myFriendsTableView.dataSource = self;
    myFriendsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myFriendsTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    
    //注册cell
    [myFriendsTableView registerClass:[WL_AddressBook_MyFriends_Cell class] forCellReuseIdentifier:cellId];
    //添加头部搜索框
    WL_AddressBook_Search_View *searchView = [[WL_AddressBook_Search_View alloc] initWithSearchPlaceholder:@"微叮好友"
                                                                                           backgroundColor:[WLTools stringToColor:@"#ffffff"]
                                                                                                     frame:CGRectMake(0, 0, ScreenWidth, 37.5) clickAction:^{
                                                                                                         
                                                                                                         WL_AddressBook_MyFriends_Search_ViewController *searchVc = [[WL_AddressBook_MyFriends_Search_ViewController alloc] init];
                                                                                                         [self.navigationController pushViewController:searchVc animated:YES];
                                                                                                     }];
    myFriendsTableView.tableHeaderView = searchView;

    self.myFriendsTableView = myFriendsTableView;
    
    /**< 添加右侧Nav添加好友图标 */
    [self setNavigationRightImg:@"addWeiDingFriends"];
}
#pragma mark - 添加微叮好友
- (void)NavigationRightEvent
{
    WL_AddressBook_MyFriends_addWeiDingFriends_ViewController *addVC = [[WL_AddressBook_MyFriends_addWeiDingFriends_ViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.myFriendsTableView) {
        return self.sections.count;
    }
    else
    {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.rows.count == 0 || self.rows == nil) {
        return 0;
    }
    else
    {
        NSArray *arrays = self.rows[section];
        if (tableView == self.myFriendsTableView) {
            return arrays.count;
        }
        else
        {
            return self.sections.count;
        }
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myFriendsTableView) {
        WL_AddressBook_MyFriends_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        NSArray *models =  self.rows[indexPath.section];
        if (self.myFriendModels) {
            [self.myFriendModels removeAllObjects];
        }
        self.myFriendModels = [WL_AddressBook_MyFriend_Model mj_objectArrayWithKeyValuesArray:models];
        cell.myFriendModel = self.myFriendModels[indexPath.row];
        
        return cell;
    }
    else
    {
        WL_AddressBook_MyFriends_RightList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:listCellId];
        cell.nameLable.text = self.sortSections[indexPath.row];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myFriendsTableView) {
        return 64.0f;
    }
    else
    {
       return 24.0f;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.myFriendsTableView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 33)];
        UILabel *headerLable = [[UILabel alloc] init];
        [headerView addSubview:headerLable];
        [headerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(10);
            make.top.equalTo(headerView.mas_top).offset(15);
        }];
        headerView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
        headerLable.font = WLFontSize(13);
        headerLable.textColor = [WLTools stringToColor:@"#868686"];
        headerLable.text = self.sortSections[section];
        
        return headerView;

    }
    else
    {
        UIView *view = [[UIView alloc] init];
        return view;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.myFriendsTableView) {
        return 33.0f;
    }
    else
    {
        return 0.001f;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myFriendsTableView)
    {
        WL_AddressBook_LinkManDetail_ViewController *myFriendDetailVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
        NSArray *viewIds = self.rows[indexPath.section];
        NSArray *myFriendModels = [WL_AddressBook_MyFriend_Model mj_objectArrayWithKeyValuesArray:viewIds];
        WL_AddressBook_MyFriend_Model *myFriendModel = myFriendModels[indexPath.row];
        myFriendDetailVc.view_id = myFriendModel.user_id;
        myFriendDetailVc.isCompany = myFriendModel.isCompany;
        myFriendDetailVc.addressBook = @"2";
        [self.navigationController pushViewController:myFriendDetailVc animated:YES];
        
        
    }
    else
    {
        //点击cell
        WlLog(@"%zd", indexPath.row);
        [self.myFriendsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
  
    }
}


@end
