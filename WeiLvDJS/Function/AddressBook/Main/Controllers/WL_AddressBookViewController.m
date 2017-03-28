//
//  WL_AddressBookViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/8/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  通讯录主页面

#import "WL_AddressBookViewController.h"
/** 导入UI控件头视图 */
//导入tableView的cell
#import "WL_AddressBook_Cell.h"
//导入最近联系人的cell
#import "WL_AddressBook_topContact_Cell.h"
//导入tableView的headerView的头视图
#import "WL_AddressBook_HeaderView.h"
//导入tableView的headerView中入口View的头试图
#import "WL_AddressBook_AccessView.h"
//导入新的好友入口的按钮
#import "WL_AddressBook_NewFriends_Button.h"


/** 导入模型头视图 */
//公司模型
#import "WL_Copmany_Model.h"
//组织架构模型
#import "WL_Rganization_Model.h"
//部门模型
#import "WL_Depratment_Model.h"
//消息联系人模型
#import "WL_TopContact_Model.h"
//常用联系人列表模型
#import "WL_Addressbook_OftenLinkMan_Model.h"
/** 导入控制器头视图 */
//组织架构控制器
#import "WL_AddressBook_Organization_Structure_ViewController.h"
//我的微叮好友列表控制器
#import "WL_AddressBook_MyFriends_ViewController.h"
//我的手机通讯录控制器
#import "WL_AddressBook_MyAddressBook_ViewController.h"
//搜索控制器
#import "WL_AddressBook_Main_Search_ViewController.h"
//关注企业控制器
#import "WL_AddressBook_AttentionCompany_ViewController.h"
//联系人详情控制器
#import "WL_AddressBook_LinkManDetail_ViewController.h"
//新的好友请求控制器
#import "WL_AddressBook_NewFriends_ViewController.h"




@interface WL_AddressBookViewController ()<UITableViewDelegate, UITableViewDataSource>
//添加公司模型数组
@property(nonatomic, strong) NSMutableArray<WL_Copmany_Model *> *companys;
//添加组织架构模型数组
@property(nonatomic, strong) NSMutableArray<WL_Rganization_Model *> *rganizations;
//添加所在部门模型数组
@property(nonatomic, strong) NSMutableArray<WL_Depratment_Model *> *departments;
//添加消息联系人模型数组
@property(nonatomic, strong) NSMutableArray<WL_TopContact_Model *> *topContacts;
//主页面的tableView
@property(nonatomic, weak) UITableView *addressBookTableView;

//网络请求时用到的提示弹框
@property(nonatomic, strong)WL_TipAlert_View *alert;

@end

@implementation WL_AddressBookViewController

- (void)dealloc
{
    [self.alert removeFromSuperview];
}

#pragma mark - lazy
//公司模型数组
- (NSMutableArray<WL_Copmany_Model *> *)companys
{
    if (!_companys) {
        _companys = [NSMutableArray array];
    }
    return _companys;
}
//组织架构模型数组
- (NSMutableArray<WL_Rganization_Model *> *)rganizations
{
    if (!_rganizations) {
        _rganizations = [NSMutableArray array];
    }
    return _rganizations;
}
//所在部门模型数组
- (NSMutableArray<WL_Depratment_Model *> *)departments
{
    if (!_departments) {
        _departments = [NSMutableArray array];
    }
    return _departments;
}
//常用联系人模型数组
- (NSMutableArray<WL_TopContact_Model *> *)topContacts
{
    if (!_topContacts) {
        _topContacts = [NSMutableArray array];
    }
    return _topContacts;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置Nav
    [self setupNavToAddressBook];
    //设置AddressBook的tableView
    [self setupTableViewToAddressBook];
    //注册弹框
    [self creatTipAlertView];
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //请求接口获取公司列表
    [self sendRequestToMyCompanyList];
    //请求接口获取常用联系人列表
    [self sendRequestToMyTopContacts];
    //请求统计的好友请求个数
    [self sendRequestToCountNewFriends];
}

#pragma mark - 请求统计的好友请求个数
- (void)sendRequestToCountNewFriends
{
    //请求Url
    NSString *urlStr = CountNewFriendUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword
                             };
    
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            [self hidHud];
            return;
        }
        //设置右侧铜铃图片
        WL_AddressBook_NewFriends_Button *newFriendButton = [[WL_AddressBook_NewFriends_Button alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:newFriendButton];
        self.navigationItem.rightBarButtonItem = item;
        [newFriendButton addTarget:self action:@selector(NavigationRightEvent) forControlEvents:UIControlEventTouchUpInside];
        
        if (![baseModel.num isEqualToString:@"0"] && baseModel.num != nil)
        {
            newFriendButton.countToNewFriendsLable.text = baseModel.num;
            newFriendButton.countToNewFriendsLable.hidden = NO;
        }
        else
        {
            newFriendButton.countToNewFriendsLable.hidden = YES;
        }
        
        
        
    } Failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 发送请求获取我的公司列表
- (void)sendRequestToMyCompanyList
{
    //请求Url
    NSString *urlStr = MyCompanyListUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword
                             };
    //发送请求请求公司列表
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        //将返回的json数据转换为基础数据模型
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        switch ([baseModel.result integerValue]) {
            case 1:
                WlLog(@"解析成功");
                
                self.companys = [WL_Copmany_Model mj_objectArrayWithKeyValuesArray:baseModel.data];
                
//                for (WL_Copmany_Model *companyModel in self.companys)
//                {
//                    //组织架构模型
//                    WL_Rganization_Model *rganization = [WL_Rganization_Model mj_objectWithKeyValues:companyModel.rganization];
//                    //添加到数组
//                    [self.rganizations addObject:rganization];
//                    //所在部门模型
//                    WL_Depratment_Model *department = [WL_Depratment_Model mj_objectWithKeyValues:companyModel.department];
//                    //添加到数组
//                    [self.departments addObject:department];
//                }
                [self hidHud];
                self.addressBookTableView.hidden = NO;
                [self.addressBookTableView reloadData];
                break;
            default:
                [self.alert createTip:baseModel.msg];
                [self hidHud];
                break;
        }
        
    } Failure:^(NSError *error) {
        [self hidHud];
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
        }
    }];
    
}

#pragma mark - 请求常用联系人列表
- (void)sendRequestToMyTopContacts
{
    //请求Url

    NSString *urlStr = MyContactListUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword
                             };
    [self showHud];

    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        //如果返回结果状态值为0.那么证明解析失败
        if (baseModel.result.integerValue == 0)
        {
            [self.alert createTip:baseModel.msg];
            [self hidHud];
            WlLog(@"解析失败!");
            return;
        }
        
        WL_Addressbook_OftenLinkMan_Model *ofentLinkMan = [WL_Addressbook_OftenLinkMan_Model mj_objectWithKeyValues:baseModel.data];
        
        
        self.topContacts = [WL_TopContact_Model mj_objectArrayWithKeyValuesArray:ofentLinkMan.list];
        
        
        [self hidHud];
        self.addressBookTableView.hidden = NO;
        [self.addressBookTableView reloadData];
    } Failure:^(NSError *error) {
        [self hidHud];
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
        }
    }];
}

static NSString *const cellId = @"AddressBookCell";
static NSString *const topContactCellId = @"topContactCell";
#pragma mark - 设置AddressBook的tableView
- (void)setupTableViewToAddressBook
{
    //初始化TableView
    UITableView *addressBookTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:addressBookTableView];
    [addressBookTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    addressBookTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    addressBookTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    addressBookTableView.delegate = self;
    addressBookTableView.dataSource = self;
    self.addressBookTableView = addressBookTableView; 
    //注册Cell
    [addressBookTableView registerClass:[WL_AddressBook_Cell class] forCellReuseIdentifier:cellId];
    [addressBookTableView registerClass:[WL_AddressBook_topContact_Cell class] forCellReuseIdentifier:topContactCellId];
    //设置头视图

    WL_AddressBook_HeaderView *headerView = [[WL_AddressBook_HeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 154)];
    //添加头试图搜索框点击方法
    [headerView.searchButton addTarget:self action:@selector(enterToSearchVc) forControlEvents:UIControlEventTouchUpInside];
    //为headerView上的功能入口添加手势
    //1 进入手机通讯录
    UITapGestureRecognizer *enterMobileAddress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterMobileAddressVc)];
    [headerView.mobileAddressView addGestureRecognizer:enterMobileAddress];
    //2 进入微叮好友
    UITapGestureRecognizer *enterFriends = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterFriendsVc)];
    [headerView.enterFriendsView addGestureRecognizer:enterFriends];
    //3 进入商家号
    UITapGestureRecognizer * enterMerchant = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterMerchantVc)];
    [headerView.enterMerchantView addGestureRecognizer:enterMerchant];
    //赋值给头试图
    addressBookTableView.tableHeaderView = headerView;
    addressBookTableView.hidden = NO;
    
}
#pragma mark - 头试图点击方法
/** 进入手机通讯录 */
- (void)enterMobileAddressVc
{
    WlLog(@"进入手机通讯录控制器");
    WL_AddressBook_MyAddressBook_ViewController *myAddressBookVc = [[WL_AddressBook_MyAddressBook_ViewController alloc] init];
    myAddressBookVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myAddressBookVc animated:YES];
  
}
/** 进入搜索控制器 */
- (void)enterToSearchVc
{
    WL_AddressBook_Main_Search_ViewController *searchVc = [[WL_AddressBook_Main_Search_ViewController alloc] init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
    
    
}
/** 进入微叮好友控制器 */
- (void)enterFriendsVc
{
    WlLog(@"进入微叮好友控制器");
    WL_AddressBook_MyFriends_ViewController *myFriends = [[WL_AddressBook_MyFriends_ViewController alloc] init];
    myFriends.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myFriends animated:YES];
}
/** 进入商家号 */
- (void)enterMerchantVc
{
    WlLog(@"进入关注企业控制器");
    WL_AddressBook_AttentionCompany_ViewController *attentionCompanyVc = [[WL_AddressBook_AttentionCompany_ViewController alloc] init];
    attentionCompanyVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:attentionCompanyVc animated:YES];
    
}


#pragma mark - UITableViewDataSource 方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (section == 0)
        {
            return self.companys.count;
        }
        else
        {
            return self.topContacts.count;
        }
//    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        WL_AddressBook_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        //赋值
        cell.company = self.companys[indexPath.row];
        //判断,最后一行底部分隔线隐藏
//        indexPath.row == self.companys.count - 1 ? cell.lineView.hidden = YES : NO;
        cell.lineView.hidden = indexPath.row == self.companys.count - 1 ? YES : NO;
        return cell;
    }
    else
    {
        WL_AddressBook_topContact_Cell *cell = [tableView dequeueReusableCellWithIdentifier:topContactCellId];
        cell.topContact = self.topContacts[indexPath.row];
        //判断,最后一行底部分隔线隐藏
//        indexPath.row == self.topContacts.count - 1 ? cell.lineView.hidden = YES : NO;
         cell.lineView.hidden = indexPath.row == self.topContacts.count - 1 ? YES : NO;
        return cell;
    }

}

#pragma mark - 设置通讯录控制器的Nav
- (void)setupNavToAddressBook
{
    //移除左侧返回按钮
    [self setNavigationLeftImg:@""];
    
    [self setNavigationRightTitle:@"新好友" fontSize:14 titleColor:Color1 isEnable:YES];
}

#pragma mark - 右侧导航点击事件
- (void)NavigationRightEvent
{
    //点击进入新的好友界面
    WL_AddressBook_NewFriends_ViewController *newFriendsVc = [[WL_AddressBook_NewFriends_ViewController alloc] init];
    newFriendsVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newFriendsVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        WL_AddressBook_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        WL_AddressBook_Organization_Structure_ViewController *organizationStructureVc = [[WL_AddressBook_Organization_Structure_ViewController alloc] init];
        organizationStructureVc.hidesBottomBarWhenPushed = YES;
        //公司id
        organizationStructureVc.company_id = cell.company.company_id;
        //公司名称
        organizationStructureVc.company_name = cell.company.company_name;
        //部门id
//        organizationStructureVc.department_id = cell.company.department.parent_id;
        [self.navigationController pushViewController:organizationStructureVc animated:YES];
    }
    else
    {
        WL_AddressBook_topContact_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        WL_AddressBook_LinkManDetail_ViewController *linkManDetailVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
        linkManDetailVc.view_id = cell.view_id;
        linkManDetailVc.addressBook = @"1";
        linkManDetailVc.isCompany = cell.isCompany;
        linkManDetailVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:linkManDetailVc animated:YES];
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    UILabel *titleLable = [[UILabel alloc] init];
    [topView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(12.5);
        make.right.equalTo(topView.mas_right);
        make.top.equalTo(topView.mas_top);
        make.bottom.equalTo(topView.mas_bottom);
    }];
    titleLable.font = WLFontSize(15);
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.textColor = [WLTools stringToColor:@"#030303"];
    if (section == 0)
    {
        titleLable.text = @"组织架构";
    }
    else if (section == 1)
    {
        titleLable.text = @"常用联系人";
    }
 
    return topView;
}



@end
