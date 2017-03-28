//
//  WL_AddressBook_Main_Search_More_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_Main_Search_More_ViewController.h"


#import "WL_AddressBook_Search_SearchView.h"
//搜索更多结果的cell
#import "WL_AddressBook_Main_SearchResult_Cell.h"

#import "WL_AddressBook_Main_Search_ViewController.h"
#import "WL_AddressBook_MyAddressBook_Linkman_ViewController.h"
#import "WL_AddressBook_LinkManDetail_ViewController.h"
#import "WL_AddressBook_OrganizationDetail_ViewController.h"

#import "WL_AddressBook_MyAddressBook_AttentionMessage_Model.h"
#import "WL_AddressBook_SearchResult_Contact_Model.h"
#import "WL_AddressBook_SearchResult_Company_Model.h"



@interface WL_AddressBook_Main_Search_More_ViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

/** 标题栏上搜索View */
@property(nonatomic, weak) WL_AddressBook_Search_SearchView *searchView;

@end

@implementation WL_AddressBook_Main_Search_More_ViewController
static NSString *const CellId = @"searchMoreResultCellId";
static NSString *const MainSearchRecordKey = @"mainSearchRecords";
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建头部搜索栏
    [self setupNavToSearchVc];
    //创建搜索结果内容TableView
    [self setupContentTableView];
    
}
#pragma mark -创建搜索结果内容TableView
- (void)setupContentTableView
{
    //0.添加头部更多结果标题栏
    UIView *topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@48);
    }];
    topView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    //0.1 在头部添加标题
    UILabel *titleLable = [[UILabel alloc] init];
    [topView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(8);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    titleLable.text = @"搜索结果";
    titleLable.font = WLFontSize(15);
    titleLable.textColor = [WLTools stringToColor:@"#4877e7"];
    titleLable.userInteractionEnabled = YES;
    //标题添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popToResultVc)];
    [titleLable addGestureRecognizer:tap];
    //0.2 在头部添加按钮
    UIButton *titleButton = [[UIButton alloc] init];
    [topView addSubview:titleButton];
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLable.mas_right).offset(5);
        make.centerY.equalTo(titleLable.mas_centerY);
    }];
    
    [titleButton setTitle:@"更多结果" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    titleButton.titleLabel.font = WLFontSize(15);
    [titleButton setTitleColor:[WLTools stringToColor:@"#868686"] forState:UIControlStateNormal];
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];

    //1.创建tableView
    UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //2.添加到父控件
    [self.view addSubview:contentTableView];
    //3.添加约束
    [contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //3.设置tableView的属性
    contentTableView.delegate = self;
    contentTableView.dataSource = self;
    contentTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //4.注册cell
    [contentTableView registerClass:[WL_AddressBook_Main_SearchResult_Cell class] forCellReuseIdentifier:CellId];
    //5.为TableView添加一个空白的View
    UIView *footerView = [[UIView alloc] init];
    
    contentTableView.tableFooterView = footerView;
    
    
}

#pragma mark - popToResultVc
- (void)popToResultVc
{
    WlLog(@"回退");
    WL_AddressBook_Main_Search_ViewController* mainSearchVc =self.navigationController.viewControllers[1];
    
    mainSearchVc.status = @"0";
    mainSearchVc.searchRecords = self.searchRecords;
    
    [self.navigationController popToViewController:mainSearchVc animated:NO];

}

#pragma mark - 创建头部搜索栏
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
    searchView.searchField.text = self.content;
    [searchView.searchField becomeFirstResponder];
    
    //3.左侧箭头隐藏
    [self setNavigationLeftImg:@""];
    [self setNavigationLeftTitle:@"" fontSize:0.1f titleColor:[UIColor clearColor] isEnable:YES];
    //2.添加右侧取消单词的点击
    [self setNavigationRightTitle:@"取消" fontSize:18.0 titleColor:Color1 isEnable:YES];
    
}

#pragma mark - 搜索框输入文字更改调用方法
- (void)changeSearchMessage:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""] || textField.text == nil) {
        WL_AddressBook_Main_Search_ViewController* mainSearchVc =self.navigationController.viewControllers[1];
        
        mainSearchVc.status = @"1";
        mainSearchVc.searchRecords = self.searchRecords;
        [self.navigationController popToViewController:mainSearchVc animated:NO];

    }
    
}

#pragma mark - 左侧按钮的点击事件 因为左侧已经隐藏,所以复写父类方法是
- (void)NavigationLeftEvent
{
    
}

#pragma mark - 右侧取消按钮点击事件
- (void)NavigationRightEvent
{
    [self.searchView.searchField resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -------UITableViewDataSource-----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.friends) {
        return self.friends.count;
    }
    else
    {
        return self.companys.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_Main_SearchResult_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (self.friends)
    {
        cell.searchContactModel = self.friends[indexPath.row];
    }
    else
    {
        cell.searchCompanyModel = self.companys[indexPath.row];
    }
    return cell;
}

#pragma mark -----------UITableViewDelegate-----------------------
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
    if (self.friends)
    {
        titleLable.text = @"联系人";
  
    }
    else
    {
        titleLable.text = @"企业组织";
    }
    
    headerView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    return headerView;
}

- (void)dealloc
{
    WlLog(@"更多搜索结果控制器销毁");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.friends) //如果是联系人的更多结果
    {
//        WL_AddressBook_Main_SearchResult_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        WL_AddressBook_SearchResult_Contact_Model *friendModel = self.friends[indexPath.row];
        //发送验证请求
        [self sendRequestToAttentionWithPhone:friendModel.mobile withName:friendModel.name];
        
    }
    else    //否则就是关注企业的更多结果
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
        if ([self.searchRecords containsObject:companyModel.name]) {
            [self.searchRecords removeObject:companyModel.name];
        }
        else //不包含这条记录
        {
            if (self.searchRecords.count > 5)   //如果记录数组大于5,那么,移除最后一个记录
            {
                [self.searchRecords removeLastObject];
            }
        }
        [self.searchRecords insertObject:companyModel.name atIndex:0]; //将这条记录插入到数组的第0位
        //将数组保存到沙盒中
        [self saveSearchRecordsToUserDefault];
    }
 
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
         if ([self.searchRecords containsObject:name])
         {
             [self.searchRecords removeObject:name];
             [self.searchRecords insertObject:name atIndex:0];
         }
         else //不包含这条记录
         {
             if (self.searchRecords.count > 5)   //如果记录数组大于5,那么,移除最后一个记录
             {
                 [self.searchRecords removeLastObject];
             }   
         }
          [self.searchRecords insertObject:name atIndex:0]; //将这条记录插入到数组的第0位
         //将数组保存到沙盒中
         [self saveSearchRecordsToUserDefault];
 
     }
     Failure:^(NSError *error)
     {
         
     }];
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

#pragma mark - ScrollView<TableView>开始拖拽时调用一次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchView.searchField resignFirstResponder];
}

@end
