//
//  WL_AddressBook_Main_Search_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  点击主页面的搜索框跳转到的控制器

#import "WL_AddressBook_Main_Search_ViewController.h"
#import "WL_AddressBook_LinkManDetail_ViewController.h"
#import "WL_AddressBook_OrganizationDetail_ViewController.h"
#import "WL_AddressBook_Main_Search_More_ViewController.h"
#import "WL_AddressBook_MyAddressBook_Linkman_ViewController.h"

#import "WL_AddressBook_Search_SearchView.h"
#import "WL_AddressBook_SearchRecord_View.h"
#import "WL_AddressBook_Main_Search_Prompt_View.h"
#import "WL_AddressBook_Main_SearchResult_Cell.h"
#import "WL_AddressBook_Organization_DepartmentTitle_Button.h"

#import "WL_AddressBook_SearchResult_Model.h"
#import "WL_AddressBook_SearchResult_Contact_Model.h"
#import "WL_AddressBook_SearchResult_Company_Model.h"
#import "WL_AddressBook_MyAddressBook_AttentionMessage_Model.h"



@interface WL_AddressBook_Main_Search_ViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

/** 标题栏上搜索View */
@property(nonatomic, weak) WL_AddressBook_Search_SearchView *searchView;
/** 标题栏View */
@property(nonatomic, weak) WL_AddressBook_SearchRecord_View *searchRecordView;
/** 提示搜索内容View */
@property(nonatomic, weak) WL_AddressBook_Main_Search_Prompt_View *promptView;
/** 搜索结果View */
@property(nonatomic, weak) UITableView *searchResultTableView;
/** 搜索结果企业模型数组 */
@property(nonatomic, strong) NSMutableArray *myFriends;



/** 搜索记录按钮数组 */
@property(nonatomic, strong) NSMutableArray *searchRecordButtons;
/** 电话号码数组 */
@property(nonatomic, strong) NSMutableArray *mobiles;
/** 搜索出来的企业模型数组 */
@property(nonatomic, strong) NSMutableArray *companys;
/** 搜索出来的首页企业模型数组 */
@property(nonatomic, strong) NSMutableArray *mainCompanys;
/** 搜索出来的好友模型数组 */
@property(nonatomic, strong) NSMutableArray *friends;
/** 搜索出来的首页好友模型数组 */
@property(nonatomic, strong) NSMutableArray *mainFriends;
/** 搜索出来的常用联系人模型数组 */
@property(nonatomic, strong) NSMutableArray *usuallys;
/** 搜索结果手机通讯录联系人数组 */
@property(nonatomic, strong) NSMutableArray *resultMobiles;

//网络请求时用到的提示弹框
@property(nonatomic, strong)WL_TipAlert_View *alert;
/** 无网络的View */
@property(nonatomic, strong)WL_NoData_View *noDataView;
/**< 判断网络是否加载完成 */
@property (nonatomic, assign) BOOL isShowStatus;
@end

@implementation WL_AddressBook_Main_Search_ViewController
static NSString *const CellId = @"searchMainResultCellId";
static NSString *const MainSearchRecordKey = @"mainSearchRecords";

- (void)dealloc
{
    [self.alert removeFromSuperview];
}

- (NSMutableArray *)searchRecordButtons
{
    if (!_searchRecordButtons) {
        _searchRecordButtons = [NSMutableArray array];
    }
    return _searchRecordButtons;
}

- (NSMutableArray *)mainFriends
{
    if (!_mainFriends) {
        _mainFriends = [NSMutableArray array];
    }
    return _mainFriends;
}

- (NSMutableArray *)mainCompanys
{
    if (!_mainCompanys) {
        _mainCompanys = [NSMutableArray array];
    }
    return _mainCompanys;
}

- (NSMutableArray *)resultMobiles
{
    if (!_resultMobiles) {
        _resultMobiles = [NSMutableArray array];
    }
    return _resultMobiles;
}

- (NSMutableArray *)mobiles
{
    if (!_mobiles) {
        _mobiles = [NSMutableArray array];
    }
    return _mobiles;
}

- (NSMutableArray *)companys
{
    if (!_companys) {
        _companys = [NSMutableArray array];
    }
    return _companys;
}

- (NSMutableArray *)friends
{
    if (!_friends) {
        _friends = [NSMutableArray array];
    }
    return _friends;
}

- (NSMutableArray *)usuallys
{
    if (!_usuallys) {
        _usuallys = [NSMutableArray array];
    }
    return _usuallys;
}

- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) andRefreshBlock:^{
            [weakSelf sendRequestToSearchResultWithSearchContent:self.searchView.searchField.text];
        }];
        
        _noDataView.hidden = YES;
        [weakSelf.view addSubview:_noDataView];
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

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.status isEqualToString:@"1"]) {
        self.searchResultTableView.hidden = YES;
        self.searchView.searchField.text = nil;
        self.promptView.hidden = NO;
        if (self.searchRecords.count > 0) {
            self.searchRecordView.hidden = NO;
            for (UIView *view in self.searchRecordView.subviews) {
                if ([self.searchRecordButtons containsObject:view]) {
                    [view removeFromSuperview];
                }
            }
            [self.promptView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(150);
            }];

            
            
            [self addSearchRecordsToSearchRecordView];
            
            [self.status isEqualToString:@"0"];
        }
        else
        {
            self.searchRecordView.hidden = YES;
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //0 .设置默认值
    [self.status isEqualToString:@"0"];
    //1.设置Nav
    [self setupNavToSearchVc];
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
- (void)setupNavToSearchVc
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
    [self setNavigationRightTitle:@"取消" fontSize:18.0 titleColor:Color1 isEnable:YES];
    
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
    WL_AddressBook_Main_Search_Prompt_View *promptView = [[WL_AddressBook_Main_Search_Prompt_View alloc] init];
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
    [searchResultTableView registerClass:[WL_AddressBook_Main_SearchResult_Cell class] forCellReuseIdentifier:CellId];
    searchResultTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
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

#pragma mark - UITextFieldDelegate

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
    if(self.isShowStatus)
    {
        return;
    }
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
    self.isShowStatus = YES;
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            [self.alert createTip:baseModel.msg];
            [self hidHud];
            self.isShowStatus = NO;
            return;
        }
        WL_AddressBook_SearchResult_Model *resultModel =[WL_AddressBook_SearchResult_Model mj_objectWithKeyValues:baseModel.data];
        if (self.companys) {
            [self.companys removeAllObjects];
        }
        if (self.friends) {
            [self.friends removeAllObjects];
        }
        if (self.usuallys) {
            [self.usuallys removeAllObjects];
        }
        self.companys = [WL_AddressBook_SearchResult_Company_Model mj_objectArrayWithKeyValuesArray:resultModel.companyList];
        self.friends = [WL_AddressBook_SearchResult_Contact_Model mj_objectArrayWithKeyValuesArray:resultModel.friendList];
        self.usuallys = [WL_AddressBook_SearchResult_Contact_Model mj_objectArrayWithKeyValuesArray:resultModel.usuallyList];
        //遍历常用联系人列表
        //创建一个常用联系人id的数组
        NSMutableArray *usuallyIds = [NSMutableArray array];
        //遍历常用联系人模型数组
        for (WL_AddressBook_SearchResult_Contact_Model *usuallyModel in self.usuallys) {
            //将数组中的常用联系人ID存放到数组中
            [usuallyIds addObject:usuallyModel.ID];
        }
        //遍历我的好友数组
        //创建一个微叮好友ID的数组
        NSMutableArray *friendIds = [NSMutableArray array];
        
        //遍历微叮好友模型数组
        for (WL_AddressBook_SearchResult_Contact_Model *friendModel in self.friends) {
            //将遍历出来的微叮好友模型id存到数组中
            [friendIds addObject:friendModel.ID];
        }

        //使用一个可变数组接收一下self.usuallys的元素
        NSMutableArray *usuallyArr = [NSMutableArray arrayWithArray:self.usuallys];
        
        //遍历常用联系人id数组
        for (int i = 0; i < usuallyIds.count; i++) {
            //取出遍历元素
            NSString *usuallyId = usuallyIds[i];
            //如果这个元素在好友列表中存在
            
             WL_AddressBook_SearchResult_Contact_Model *usuallyModel = self.usuallys[i];
            
            if ([friendIds containsObject:usuallyId]) {
                //那么常用联系人对应此元素的模型从数组中移除
  
                [usuallyArr removeObject:usuallyModel];
            }
        }
        //将没有重复元素的连个数组拼接成一个数组
        [self.friends addObjectsFromArray:usuallyArr];

        //获取通讯录中获取通讯录中所有联系人的数组
        self.mobiles = [self acquireMessageInMyAddressBook];
        
        [self.resultMobiles removeAllObjects];
        self.resultMobiles = [self acquireSearchResultWithSearchContent:content];
        //所有联系人的模型数组
        [self.friends addObjectsFromArray:self.resultMobiles];
        if (self.friends.count == 0 && self.companys.count == 0)
        {
            [self.alert createTip:@"暂无符合搜索条件的内容"];
            self.searchResultTableView.hidden = YES;
            [self hideNoData:NO andType:WLNetworkTypeNOData];
            [self hidHud];
            self.isShowStatus = NO;
            return;
        }
        
        
        self.searchRecordView.hidden = YES;
        self.promptView.hidden = YES;
        self.searchResultTableView.hidden = NO;
        [self.searchResultTableView reloadData];
        [self hidHud];
        self.isShowStatus = NO;
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
        self.isShowStatus = NO;
    }];
    
}

#pragma mark ------------------------------UITableViewDataSource----------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.friends.count > 3)
        {
            return 3;
        }
        else
        {
            return self.friends.count;
        }
    }
    else
    {
        if (self.companys.count > 3)
        {
            return 3;
        }
        else
        {
            return self.companys.count;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_Main_SearchResult_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (indexPath.section == 0) {
        cell.searchContactModel = self.friends[indexPath.row];
        
        //如果最后一行
        if (indexPath.row == self.friends.count - 1 && self.friends.count < 4)
        {
            cell.bottomLineView.hidden = NO;
        }
        else
        {
            cell.bottomLineView.hidden = YES;
        }
        
        
    }
    else
    {
        cell.searchCompanyModel = self.companys[indexPath.row];
    }
    
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
    if (section == 0) {
        if (self.friends.count > 3) {
            return 45.5f;
        }
        else
        {
            return 0.001f;
        }
    }
    else
    {
        if (self.companys.count > 3) {
            return 45.5f;
        }
        else
        {
            return 0.001f;
        }

    }
 
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第0分组,进入个人详情页面
    if (indexPath.section == 0)
    {
        WL_AddressBook_Main_SearchResult_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //发送验证请求
        [self sendRequestToAttentionWithPhone:cell.searchContactModel.mobile withName:cell.searchContactModel.name];
    }
    else    //第一分组,进入企业详情页面
    {
        WL_AddressBook_OrganizationDetail_ViewController *organizationDetailVc = [[WL_AddressBook_OrganizationDetail_ViewController alloc] init];
        WL_AddressBook_SearchResult_Company_Model *companyModel = self.companys[indexPath.row];
        organizationDetailVc.company_id = companyModel.ID;
        [self.navigationController pushViewController:organizationDetailVc animated:YES];
        
        //将这条记录保存到沙盒
        //输入框失去第一响应者
        [self.searchView.searchField resignFirstResponder];
        //从沙盒中获取搜索记录数组
        self.searchRecords = [self acquireSearchRecordsFromUserDefault];
        
        //如果数组包含这条记录,就移除
        if ([self.searchRecords containsObject:companyModel.name])
        {
            [self.searchRecords removeObject:companyModel.name];
            [self.searchRecords insertObject:companyModel.name atIndex:0]; //将这条记录插入到数组的第0位
        }
        else //不包含这条记录
        {
            if (self.searchRecords.count > 5)   //如果记录数组大于5,那么,移除最后一个记录
            {
                [self.searchRecords removeLastObject];
                
            }
            [self.searchRecords insertObject:companyModel.name atIndex:0]; //将这条记录插入到数组的第0位
        }
        
        //将数组保存到沙盒中
        [self saveSearchRecordsToUserDefault];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    
    WL_AddressBook_Organization_DepartmentTitle_Button *button = [[WL_AddressBook_Organization_DepartmentTitle_Button alloc] init];
    [footerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footerView.mas_centerX);
        make.centerY.equalTo(footerView.mas_centerY);
        make.width.equalTo(@70);
    }];
    button.nameLable.text = @"查看更多";
    button.nameLable.font = WLFontSize(15);
    button.nameLable.textColor = [WLTools stringToColor:@"#4499ff"];
    if (section == 0) {
        [button addTarget:self action:@selector(moreLinkManButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [button addTarget:self action:@selector(moreCompanyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    if (section == 0) {
        if (self.friends.count > 3) {
            button.hidden = NO;
        }
        else
        {
            button.hidden = YES;
        }
    }
    else
    {
        if (self.companys.count > 3) {
            button.hidden = NO;

        }
        else
        {
            button.hidden = YES;
        }
        
    }

    return footerView;
}


#pragma mark - 更多联系人点击方法
- (void)moreLinkManButtonClick
{
    WlLog(@"更多联系人");
    WL_AddressBook_Main_Search_More_ViewController *searchMoreVc = [[WL_AddressBook_Main_Search_More_ViewController alloc] init];
    searchMoreVc.friends = self.friends;
    searchMoreVc.content = self.searchView.searchField.text;
    searchMoreVc.searchRecords = self.searchRecords;
    [self saveSearchRecordsToUserDefault];
    [self.navigationController pushViewController:searchMoreVc animated:NO];
    
}

#pragma mark - 更多公司点击方法
- (void)moreCompanyButtonClick
{
    WlLog(@"更多公司");
    WL_AddressBook_Main_Search_More_ViewController *searchMoreVc = [[WL_AddressBook_Main_Search_More_ViewController alloc] init];
    searchMoreVc.companys = self.companys;
    searchMoreVc.content = self.searchView.searchField.text;
    searchMoreVc.searchRecords = self.searchRecords;
    [self.navigationController pushViewController:searchMoreVc animated:NO];
}

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
    if (section == 0)
    {
        titleLable.text = @"联系人";

    }
    else
    {
        titleLable.text = @"企业";
    }
    
    headerView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    return headerView;
}

#pragma mark - 保存搜索记录数组到沙盒
- (void)saveSearchRecordsToUserDefault
{
    NSArray *records = [NSArray arrayWithArray:self.searchRecords];
    [DEFAULTS setObject:records forKey:MainSearchRecordKey];
}

#pragma mark - 从沙盒中读取搜索记录数组
- (NSMutableArray *)acquireSearchRecordsFromUserDefault
{
    NSArray *records = [DEFAULTS valueForKey:MainSearchRecordKey];
    self.searchRecords = [NSMutableArray arrayWithArray:records];
    return self.searchRecords;
}

#pragma mark - 从本地通讯录匹配搜索结果
- (NSMutableArray *)acquireSearchResultWithSearchContent:(NSString *)content
{
    [self.resultMobiles removeAllObjects];
    for (WL_AddressBook_SearchResult_Contact_Model *searchResultModel in self.mobiles) {
        //首字母中间变量
        NSString *temp = nil;
        NSString *initialStr = [[NSString alloc] init];
        //遍历姓名中每一个字符
        for(int i =0; i < [searchResultModel.name length]; i++)
        {
            temp = [searchResultModel.name substringWithRange:NSMakeRange(i, 1)];
            //取出姓名中遍历出来字符的首字母<大写>
            NSString *initial = [self firstCharactor:temp];
            
            
            initialStr = [initialStr stringByAppendingString:initial];
            
            
        }
        NSArray *array = [NSArray arrayWithObjects:searchResultModel.mobile, searchResultModel.name, initialStr, nil];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",content];
        NSArray *arrays =  [[NSArray alloc] initWithArray:[array filteredArrayUsingPredicate:predicate]];
        
        if (arrays.count > 0)
        {
            if (![self.resultMobiles containsObject:searchResultModel]) {
                [self.resultMobiles addObject:searchResultModel];
            }
            
            
        }

    }
    
    return self.resultMobiles;

}

#pragma mark - 获取通讯录中所有电话号码的数组
- (NSMutableArray *)acquireMessageInMyAddressBook
{
    [self.mobiles removeAllObjects];
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    int __block tip=0;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook =nil;
    //创建通讯簿的引用
    addBook=ABAddressBookCreateWithOptions(NULL, NULL);
    //创建一个出事信号量为0的信号
    dispatch_semaphore_t sema=dispatch_semaphore_create(0);
    //申请访问权限
    ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
        //greanted为YES是表示用户允许，否则为不允许
        if (!greanted) {
            tip=1;
        }
        //发送一次信号
        dispatch_semaphore_signal(sema);
    });
    //等待信号触发
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (tip)
    {
        //做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\nSettings>General>Privacy" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
    }
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addBook);
    
    //进行遍历
    for (NSInteger i=0; i<number; i++)
    {
        
        //获取联系人对象的引用
        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
        //获取当前联系人的电话 数组
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        
        NSMutableArray *phoneArr = [NSMutableArray array];
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++)
        {
            //获取当前联系人电话
            NSString *mobile = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
            
            NSString *acceptStr = [mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            [phoneArr addObject:acceptStr];
        }
        //获取当前联系人名字
        NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        //获取当前联系人姓氏
        NSString*lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        //创建一个模型
        WL_AddressBook_SearchResult_Contact_Model *searchContentModel = [[WL_AddressBook_SearchResult_Contact_Model alloc] init];
        //姓名同为空
        if (firstName == nil && lastName == nil)
        {
            //电话号码不为空
            if (phoneArr.count > 0)
            {
                searchContentModel.name = phoneArr[0];
            }
            else    //姓名为空,电话为空<现实中应该不存在>
            {
                searchContentModel.name = @"0";
            }
        }
        else if (firstName == nil && lastName != nil) //姓不为空名为空
        {
            searchContentModel.name = lastName;
        }
        else if (firstName != nil && lastName == nil) //姓为空,名不为空
        {
            searchContentModel.name = firstName;
        }
        else    //姓名都不为空
        {
            searchContentModel.name = [NSString stringWithFormat:@"%@%@", firstName, lastName];
        }
        
        //存在电话号码
        if (phoneArr.count > 0)
        {
            searchContentModel.mobile = phoneArr[0];
        }
        else    //不存在电话号码
        {
            searchContentModel.mobile = @"0";
        }
        
        if (![self.mobiles containsObject:searchContentModel]) {
            [self.mobiles addObject:searchContentModel]; //将模型添加到通讯录模型数组中
        }
        
        
    }
    return self.mobiles;
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

//搜索按钮点击
- (void)searchRecordButtonClick:(UIButton *)button
{
    self.searchView.searchField.text = button.titleLabel.text;
    [self sendRequestToSearchResultWithSearchContent:self.searchView.searchField.text];
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

#pragma mark - 发送验证请求
- (void)sendRequestToAttentionWithPhone:(NSString *)phone withName:(NSString *)name
{
    if ([phone isEqualToString:@""] || phone == nil) {
//        [self.alert createTip:@"手机号码不能为空"];
        return;
    }
    if ([phone isEqualToString:@"0"]) {
//        [self.alert createTip:@"手机号码格式不正确"];
        return;
    }
    
    
    //请求URL
    NSString *urlStr = addSearchFriendsUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];////[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    //获取用户电话号码
    NSString *my_phone = [WLUserTools getUserMobile];
    //请求参数集合
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword,
                             @"friend_mobile" : phone,
                             @"my_mobile" : my_phone
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject)
     {
         
         WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (![baseModel.result isEqualToString:@"1"]) {
             [self hidHud];
             return;
         }
         WL_AddressBook_MyAddressBook_AttentionMessage_Model *attentionModel = [WL_AddressBook_MyAddressBook_AttentionMessage_Model mj_objectWithKeyValues:baseModel.data];
         if ([attentionModel.isreg isEqualToString:@"0"])
         {
             //没有注册, 跳转到未注册的控制器去
             WL_AddressBook_MyAddressBook_Linkman_ViewController *myLinkmanVc = [[WL_AddressBook_MyAddressBook_Linkman_ViewController alloc] init];
             myLinkmanVc.name = name;
             myLinkmanVc.phoneNum = phone;
             [self.navigationController pushViewController:myLinkmanVc animated:YES];
             
         }
         else
         {
             //已经注册, 跳转到常用联系人详情去
             WL_AddressBook_LinkManDetail_ViewController *linkManDetailVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
             linkManDetailVc.view_id = attentionModel.user_id;
             if (attentionModel.company.count == 0 || attentionModel.company == nil) {
                 //不在同一个组织
                 linkManDetailVc.isCompany = @"0";
             }
             else
             {
                 //同一个组织
                 linkManDetailVc.isCompany = @"1";
             }
             [self.navigationController pushViewController:linkManDetailVc animated:YES];
         }
         
         [self hidHud];
         //将这条记录保存到沙盒
         //输入框失去第一响应者
         [self.searchView.searchField resignFirstResponder];
         //从沙盒中获取搜索记录数组
         self.searchRecords = [self acquireSearchRecordsFromUserDefault];
         
         //如果数组包含这条记录,就移除
         if ([self.searchRecords containsObject:name]) {
             [self.searchRecords removeObject:name];
             [self.searchRecords insertObject:name atIndex:0];
         }
         else //不包含这条记录
         {
             if (self.searchRecords.count > 5)   //如果记录数组大于5,那么,移除最后一个记录
             {
                 [self.searchRecords removeLastObject];
             }
             [self.searchRecords insertObject:name atIndex:0]; //将这条记录插入到数组的第0位
             
         }
         //将数组保存到沙盒中
         [self saveSearchRecordsToUserDefault];

     }
    Failure:^(NSError *error)
     {
         
     }];
}


@end
