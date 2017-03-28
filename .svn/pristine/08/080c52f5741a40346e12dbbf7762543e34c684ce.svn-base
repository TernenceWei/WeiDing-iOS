//
//  WL_AddressBook_MyFriends_Search_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/23.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_MyFriends_Search_ViewController.h"

#import "WL_AddressBook_LinkManDetail_ViewController.h"


#import "WL_AddressBook_Search_SearchView.h"

#import "WL_AddressBook_SearchRecord_View.h"

#import "WL_AddressBook_Organiztion_Search_Prompt_View.h"

#import "WL_AddressBook_MyFriends_Cell.h"

#import "WL_AddressBook_SearchResult_Model.h"
#import "WL_AddressBook_SearchResult_Contact_Model.h"
#import "WL_AddressBook_OrganizationDetail_ViewController.h"
@interface WL_AddressBook_MyFriends_Search_ViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
/** 标题栏上搜索View */
@property(nonatomic, weak) WL_AddressBook_Search_SearchView *searchView;
/** 标题栏View */
@property(nonatomic, weak) WL_AddressBook_SearchRecord_View *searchRecordView;
/** 提示搜索内容View */
@property(nonatomic, weak) WL_AddressBook_Organiztion_Search_Prompt_View *promptView;
/** 搜索结果View */
@property(nonatomic, weak) UITableView *searchResultTableView;
/** 搜索结果企业模型数组 */
@property(nonatomic, strong) NSMutableArray *myFriends;

/** 搜索记录数组 */
@property(nonatomic, strong) NSMutableArray *searchRecords;

/** 搜索记录按钮数组 */
@property(nonatomic, strong) NSMutableArray *searchRecordButtons;

/** 无网络的View */
@property(nonatomic, strong)WL_NoData_View *noDataView;

//网络请求时用到的提示弹框
@property(nonatomic, strong)WL_TipAlert_View *alert;
@end

@implementation WL_AddressBook_MyFriends_Search_ViewController
static NSString *const CellId = @"searchMyFriendsResultCellId";
static NSString *const SearchRecordKey = @"myFriendsSearchRecords";
- (NSMutableArray *)searchRecordButtons
{
    if (!_searchRecordButtons) {
        _searchRecordButtons = [NSMutableArray array];
    }
    return _searchRecordButtons;
}

- (NSMutableArray *)searchRecords
{
    if (!_searchRecords) {
        _searchRecords = [NSMutableArray array];
    }
    return _searchRecords;
}


- (NSMutableArray *)myFriends
{
    if (!_myFriends) {
        _myFriends = [NSMutableArray array];
    }
    return _myFriends;
}

- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) andRefreshBlock:^{
            [weakSelf sendRequestToSearchResultWithSearchContent:weakSelf.searchView.searchField.text];
        }];
        [weakSelf.view addSubview:_noDataView];
        
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
    //1.设置Nav
    [self setupNavToAttentionCompanySearchVc];
    //2.设置控制器内容View
    [self contentViewToSearchVc];
    
    //注册弹框
    [self creatTipAlertView];
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 设置Nav内容
- (void)setupNavToAttentionCompanySearchVc
{
    //1.添加搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 312,29)];
    
    WL_AddressBook_Search_SearchView *searchView = [[WL_AddressBook_Search_SearchView alloc] init];
    [titleView addSubview:searchView];
    searchView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    searchView.layer.cornerRadius = 5.0f;
    searchView.layer.masksToBounds = YES;
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView.mas_left).offset(-35);
        make.height.equalTo(titleView.mas_height);
        make.centerY.equalTo(titleView.mas_centerY);
        make.width.equalTo(@(300 * AUTO_IPHONE6_WIDTH_375));
    }];
    self.searchView = searchView;
    searchView.searchField.delegate = self;
    [searchView.searchField addTarget:self action:@selector(changeSearchMessage:) forControlEvents:UIControlEventEditingChanged];
    self.navigationItem.titleView = titleView;
    searchView.searchField.returnKeyType = UIReturnKeySearch;
    [searchView.searchField becomeFirstResponder];
    
    //3.左侧箭头隐藏
    [self setNavigationLeftImg:@""];
    [self setNavigationLeftTitle:@"" fontSize:0.1f titleColor:[UIColor clearColor] isEnable:YES];
    //2.添加右侧取消单词的点击
    [self setNavigationRightTitle:@"取消" fontSize:18.0 titleColor:[WLTools stringToColor:@"#ffffff"] isEnable:YES];
    
}
#pragma mark - 设置控制器内容的子控件
- (void)contentViewToSearchVc
{
    //1.设置背景颜色
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    //2.添加一个搜索记录View
    WL_AddressBook_SearchRecord_View *searchRecordView = [[WL_AddressBook_SearchRecord_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150) withArr:self.searchRecords];
    [self.view addSubview:searchRecordView];
    searchRecordView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    [searchRecordView.closeButton addTarget:self action:@selector(removeRecordToSearch) forControlEvents:UIControlEventTouchUpInside];
    self.searchRecordView = searchRecordView;
    
    
    //3.添加一个提示View
    WL_AddressBook_Organiztion_Search_Prompt_View *promptView = [[WL_AddressBook_Organiztion_Search_Prompt_View alloc] initWithFrame:CGRectZero withTitle:@"好友" withIconImageName:@"WL_AddressBook_SearchMyFriends"];
    [self.view addSubview:promptView];
    
    self.searchRecords = [self acquireSearchRecordsFromUserDefault];
    if (self.searchRecords.count == 0 || self.searchRecords == nil) {
        searchRecordView.hidden = YES;
        [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        
    }
    else
    {
        searchRecordView.hidden = NO;
        
        [self addSearchRecordsToSearchRecordView];
        
        [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(searchRecordView.mas_bottom);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    self.promptView = promptView;
    
    //4.先创建一个隐藏的tableView
    UITableView *searchResultTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:searchResultTableView];
    [searchResultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    searchResultTableView.hidden = YES;
    searchResultTableView.delegate = self;
    searchResultTableView.dataSource = self;
    searchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [searchResultTableView registerClass:[WL_AddressBook_MyFriends_Cell class] forCellReuseIdentifier:CellId];
    self.searchResultTableView = searchResultTableView;
    
    
}
#pragma mark - 移除搜索记录
- (void)removeRecordToSearch
{
    [self.searchRecords removeAllObjects];
    [self saveSearchRecordsToUserDefault];
    self.searchRecordView.hidden = YES;
    [self.promptView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchView.searchField resignFirstResponder];
}
#pragma mark - 右侧取消按钮点击事件
- (void)NavigationRightEvent
{
    [self.searchView.searchField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 左侧按钮的点击事件 因为左侧已经隐藏,所以复写父类方法是
- (void)NavigationLeftEvent
{
    
}
#pragma mark - 搜索框输入文字更改调用方法
- (void)changeSearchMessage:(UITextField *)textField
{
    self.noDataView.hidden = YES;
    self.searchRecords = [self acquireSearchRecordsFromUserDefault];
    
    if ([textField.text isEqualToString:@""] || textField.text == nil)
    {
        self.promptView.hidden = NO;
        if (self.searchRecords.count == 0 || self.searchRecords == nil)
        {
            self.searchRecordView.hidden = YES;
            [self.promptView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top);
            }];
            
        }
        else
        {
            self.searchRecordView.hidden = NO;
            [self.promptView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(150);
            }];
            for (UIView *view in self.searchRecordView.subviews) {
                if ([self.searchRecordButtons containsObject:view]) {
                    [view removeFromSuperview];
                }
            }
            
            [self addSearchRecordsToSearchRecordView];
            
        }
        
        self.searchResultTableView.hidden = YES;
        
    }
    else
    {
        [self sendRequestToSearchResultWithSearchContent:textField.text];
    }
    
}

#pragma mark - 点击搜索按钮🔍
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //输入框失去第一响应者
    [textField resignFirstResponder];
    //从沙盒中获取搜索记录数组
    self.searchRecords = [self acquireSearchRecordsFromUserDefault];
    
    //如果数组包含这条记录,就移除
    if ([self.searchRecords containsObject:textField.text]) {
        [self.searchRecords removeObject:textField.text];
        [self.searchRecords insertObject:textField.text atIndex:0];
    }
    else //不包含这条记录
    {
        if (self.searchRecords.count > 5)   //如果记录数组大于5,那么,移除最后一个记录
        {
            [self.searchRecords removeLastObject];
        }
        [self.searchRecords insertObject:textField.text atIndex:0]; //将这条记录插入到数组的第0位
        
    }
    //将数组保存到沙盒中
    [self saveSearchRecordsToUserDefault];
    return YES;
}
#pragma mark - 发送网络请求请求搜索结果数据
- (void)sendRequestToSearchResultWithSearchContent:(NSString *)content
{
    //请求Url
    NSString *urlStr = WLSearchUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    //请求参数集合
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword,
                             @"keyword" : content
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            
            [self hidHud];
            return;
        }
        
        WL_AddressBook_SearchResult_Model *resultModel = [WL_AddressBook_SearchResult_Model mj_objectWithKeyValues:baseModel.data];
        self.myFriends = [WL_AddressBook_SearchResult_Contact_Model mj_objectArrayWithKeyValuesArray:resultModel.friendList];
        if (self.myFriends.count == 0 || self.myFriends == nil) {
            [self.alert createTip:@"暂无搜索记录"];
            self.searchResultTableView.hidden = YES;
            [self hideNoData:NO andType:WLNetworkTypeNOData];
            [self hidHud];
            return;
        }
        
        self.searchRecordView.hidden = YES;
        self.promptView.hidden = YES;
        self.searchResultTableView.hidden = NO;
        [self.searchResultTableView reloadData];
        [self hidHud];
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
#pragma mark ------------------------------UITableViewDataSource----------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_MyFriends_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    cell.searchMyFriendModel = self.myFriends[indexPath.row];
    
    return cell;
}

#pragma mark - ScrollView<TableView>开始拖拽时调用一次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchView.searchField resignFirstResponder];
}

#pragma mark ------------------------------UITableViewDelegate----------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.5f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    UILabel *titleLable = [[UILabel alloc] init];
    [headerView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(16);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    titleLable.font = WLFontSize(15);
    titleLable.textColor = [WLTools stringToColor:@"#868686"];
    titleLable.text = @"微叮好友";
    headerView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    UIView *lineView = [[UIView alloc] init];
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(7.5);
        make.right.equalTo(headerView.mas_right);
        make.bottom.equalTo(headerView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    
    return headerView;
}

//点击cell调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_MyFriends_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.searchRecords = [self acquireSearchRecordsFromUserDefault];
    
    if ([self.searchRecords containsObject:cell.nameLable.text])
    {
        [self.searchRecords removeObject:cell.nameLable.text];
    }
    else
    {
        if (self.searchRecords.count > 5)
        {
            [self.searchRecords removeLastObject];
        }
        
    }
    
    [self.searchRecords insertObject:cell.nameLable.text atIndex:0];
    [self saveSearchRecordsToUserDefault];
    for (UIView *view in self.searchRecordView.subviews) {
        if ([self.searchRecordButtons containsObject:view]) {
            [view removeFromSuperview];
        }
    }
    
    
    [self addSearchRecordsToSearchRecordView];
    [self.searchView.searchField resignFirstResponder];
    
    WL_AddressBook_LinkManDetail_ViewController *linkManDetaiVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
    linkManDetaiVc.view_id = cell.searchMyFriendModel.ID;
    linkManDetaiVc.isCompany = cell.searchMyFriendModel.isCompany;
    [self.navigationController pushViewController:linkManDetaiVc animated:YES];
    
}

#pragma mark - 保存搜索记录数组到沙盒
- (void)saveSearchRecordsToUserDefault
{
    NSArray *records = [NSArray arrayWithArray:self.searchRecords];
    [DEFAULTS setObject:records forKey:SearchRecordKey];
}

#pragma mark - 从沙盒中读取搜索记录数组
- (NSMutableArray *)acquireSearchRecordsFromUserDefault
{
    NSArray *records = [DEFAULTS valueForKey:SearchRecordKey];
    self.searchRecords = [NSMutableArray arrayWithArray:records];
    return self.searchRecords;
}

#pragma mark - 添加标签
- (void)addSearchRecordsToSearchRecordView
{
    [self.searchRecordButtons removeAllObjects];
    for (int i = 0; i < self.searchRecords.count; i++)
    {
        //创建搜索记录按钮
        UIButton *searchContentButton = [[UIButton alloc] init];
        [searchContentButton.titleLabel setPreferredMaxLayoutWidth:60.0f];
        //添加到父控件
        [self.searchRecordView addSubview:searchContentButton];
        //按钮文字<搜索记录>
        [searchContentButton setTitle:self.searchRecords[i] forState:UIControlStateNormal];
        [searchContentButton setTitleColor:[WLTools stringToColor:@"#879efa"] forState:UIControlStateNormal];
        searchContentButton.titleLabel.font = WLFontSize(15);
        //如果是第0个按钮,位置坐标
        if (i == 0)
        {
            [searchContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.searchRecordView.mas_top).offset(62);
                make.left.equalTo(self.searchRecordView.mas_left).offset(12);
            }];
        }
        else if (i < 3) //如果是第1-2个按钮
        {
            //上一个按钮
            UIButton *preButton = self.searchRecordButtons[i - 1];
            //本次按钮的frame
            [searchContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(preButton.mas_centerY);
                make.left.equalTo(preButton.mas_right).offset(40);
            }];
            
        }
        else if (i == 3) //如果是第三个按钮
        {
            [searchContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.searchRecordView.mas_top).offset(112);
                make.left.equalTo(self.searchRecordView.mas_left).offset(12);
            }];
            
        }
        else
        {
            //上一个按钮
            UIButton *preButton = self.searchRecordButtons[i - 1];
            //本次按钮的frame
            [searchContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(preButton.mas_centerY);
                make.left.equalTo(preButton.mas_right).offset(40);
            }];
        }
        
        if (searchContentButton.titleLabel.text.length > 8)
        {
            [searchContentButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@90);
            }];
        }
        
        
        [searchContentButton addTarget:self action:@selector(searchRecordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.searchRecordButtons addObject:searchContentButton];
    }
    
}

- (void)searchRecordButtonClick:(UIButton *)button
{
    self.searchView.searchField.text = button.titleLabel.text;
    [self sendRequestToSearchResultWithSearchContent:self.searchView.searchField.text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
