//
//  WL_AddressBook_NewFriends_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  新的好友主控制器

#import "WL_AddressBook_NewFriends_ViewController.h"
#import "WL_AddressBook_AddFriend_ViewController.h"
#import "WL_AddressBook_LinkManDetail_ViewController.h"
//导入cell
#import "WL_AddressBook_NewFriendsMessage_Cell.h"
#import "WL_AddressBook_NewFriends_Cell.h"
#import "APAddressBook.h"

#import "WL_AddressBook_NewFriend_Model.h"
#import "WL_AddressBook_NewFriend_Company_Model.h"
#import "WL_AddressBook_NewFriends_NotReg_Model.h"
#import "APContact.h"

@interface WL_AddressBook_NewFriends_ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 新的好友列表模型数组 */
@property(nonatomic, strong) NSMutableArray *friendModels;

/** 好友公司的数组 */
@property(nonatomic, strong) NSMutableArray *friendCompanys;
/** 通讯录中所有电话号码的数组 */
@property(nonatomic, strong) NSMutableArray *mobiles;

/** 无网络的View */
@property(nonatomic, strong)WL_NoData_View *noDataView;

@property(nonatomic, copy) NSString *phoneStr;


/** 个人通讯录中已注册App 但是不是好友的模型数组*/
@property(nonatomic, strong) NSMutableArray *notRegModels;


/** 新的好友列表 */
@property(nonatomic, weak) UITableView *friendsTableView;

//网络请求时用到的提示弹框
@property(nonatomic, strong)WL_TipAlert_View *alert;

@end

@implementation WL_AddressBook_NewFriends_ViewController

- (void)dealloc
{
    [self.alert removeFromSuperview];
}

- (NSString *)phoneStr
{
    if (!_phoneStr) {
        _phoneStr = [NSString string];
    }
    return _phoneStr;
}

- (NSMutableArray *)notRegModels
{
    if (!_notRegModels) {
        _notRegModels = [NSMutableArray array];
    }
    return _notRegModels;
}

- (NSMutableArray *)mobiles
{
    if (!_mobiles) {
        _mobiles = [NSMutableArray array];
    }
    return _mobiles;
}

- (NSMutableArray *)friendCompanys
{
    if (!_friendCompanys) {
        _friendCompanys = [NSMutableArray array];
    }
    return _friendCompanys;
}

- (NSMutableArray *)friendModels
{
    if (!_friendModels) {
        _friendModels = [NSMutableArray array];
    }
    return _friendModels;
}

- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            [weakSelf sendRequestToNewFriendList];
        }];
        
        _noDataView.hidden = YES;
        [self.view addSubview:_noDataView];
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
    [self setupNav];
    //2.添加列表
    [self setupTableViewToNewFriends];
    
    //3.发送请求 获取申请添加新好友的列表
    [self sendRequestToNewFriendList];

    //注册弹框
    [self creatTipAlertView];
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 发送请求, 获取手机通讯录中已经注册并且不是好友的列表
- (void)sendRequestToAcquireIsNoRegInMyAddressBook
{
    //请求Url
    NSString *urlStr = IsNoRegInMyAddressBook;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];////[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];////[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    //获取通讯录数据
//    NSMutableArray *phones = [self acquireMessageInMyAddressBook];
    
    NSString *phoneStr = [self acquireMessageStringInMyAddressBook];
    //参数集合
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword,
                             @"data" : phoneStr
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject)
    {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"])
        {
            [self.alert createTip:baseModel.msg];
            [self hidHud];
            return;
        }
        
        self.notRegModels = [WL_AddressBook_NewFriends_NotReg_Model mj_objectArrayWithKeyValuesArray:baseModel.data];
        //如果没有返回好友数据,<证明没有好友>
        if (self.notRegModels.count == 0 && self.friendModels.count == 0) {
            [self hideNoData:NO andType:WLNetworkTypeNOData];
            
            return;
        }
        

        [self.friendsTableView reloadData];

        [self hidHud];
    }
    Failure:^(NSError *error)
    {
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


#pragma mark - 获取通讯录中所有电话号码的数组<修改接口后已废弃>
- (NSMutableArray *)acquireMessageInMyAddressBook
{
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
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++)
        {
            
            NSString *mobile = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
            
            NSString *acceptStr = [mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            [self.mobiles addObject:acceptStr];
        }
    }
    return self.mobiles;
}


#pragma mark - 获取通讯录中所有电话号码的拼接字符串<修改接口后启用>
- (NSString *)acquireMessageStringInMyAddressBook
{

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
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++)
        {
            
            NSString *mobile = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
            
            NSString *acceptStr = [mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
            acceptStr = [acceptStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
            acceptStr = [acceptStr stringByReplacingOccurrencesOfString:@")" withString:@""];
            NSString *strUrl = [acceptStr stringByReplacingOccurrencesOfString:@" " withString:@""];
          self.phoneStr = [self.phoneStr stringByAppendingString:[NSString stringWithFormat:@"%@,", strUrl]];

            [self.mobiles addObject:acceptStr];
        }
    }
    return self.phoneStr;
}

#pragma mark - 发送请求 获取申请添加新好友的列表
- (void)sendRequestToNewFriendList
{
    self.noDataView.hidden = YES;
    //申请添加新好友列表Url
    NSString *urlStr = NewFriendListUrl;
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
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject)
     {
         
         WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (![baseModel.result isEqualToString:@"1"])
         {
             [self.alert createTip:baseModel.msg];
             [self hidHud];
             return;
         }
         self.friendModels = [WL_AddressBook_NewFriend_Model mj_objectArrayWithKeyValuesArray:baseModel.data];
         for (WL_AddressBook_NewFriend_Model *friendModel  in self.friendModels) {
             if (friendModel.companyInfo) {
                 WL_AddressBook_NewFriend_Company_Model *companyModel = friendModel.companyInfo;
                 [self.friendCompanys addObject:companyModel];
             }
             else
             {
                 WL_AddressBook_NewFriend_Company_Model *companyModel = [[WL_AddressBook_NewFriend_Company_Model alloc] init];
                 [self.friendCompanys addObject:companyModel];
             }
         
         }
         //4.发送请求, 获取手机通讯录中已经注册并且不是好友的列表
         [self sendRequestToAcquireIsNoRegInMyAddressBook];
         
         
         if (self.friendModels.count == 0)
         {
             WlLog(@"没有添加好友请求数据");
         }
         else
         {
             
         }

         NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
         
         [self.friendsTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
         
         
         [self hidHud];
     }
      Failure:^(NSError *error)
     {
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

#pragma mark - setupNav
- (void)setupNav
{
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    self.title = @"新的好友";
    
}

static NSString *const newFriendsMessageCellId = @"newFriendsMessageCellId";
static NSString *const newFriendsCellId = @"newFriendsCellId";
#pragma mark - 设置新的好友列表
- (void)setupTableViewToNewFriends
{
    UITableView *newFriendsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:newFriendsTableView];
    [newFriendsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    newFriendsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    newFriendsTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    newFriendsTableView.delegate = self;
    newFriendsTableView.dataSource = self;
    [newFriendsTableView registerClass:[WL_AddressBook_NewFriendsMessage_Cell class] forCellReuseIdentifier:newFriendsMessageCellId];
    [newFriendsTableView registerClass:[WL_AddressBook_NewFriends_Cell class] forCellReuseIdentifier:newFriendsCellId];
    self.friendsTableView = newFriendsTableView;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.friendModels.count;
    }
    else
    {
        return self.notRegModels.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        WL_AddressBook_NewFriendsMessage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:newFriendsMessageCellId];
        cell.friendModel = self.friendModels[indexPath.row];
        if (self.friendCompanys.count > 0) {
            cell.companyModel = self.friendCompanys[indexPath.row];
            cell.companyIconImageView.hidden = NO;
        }
        else
        {
            cell.companyIconImageView.hidden = YES;
        }
        
        //最后一行cell的分隔线隐藏
        indexPath.row == (self.friendModels.count - 1) ? cell.lineView.hidden = YES : NO;
        cell.addButton.tag = [cell.friendModel.message_id integerValue];
        [cell.addButton addTarget:self action:@selector(passedValidationFriend:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else

    {
        WL_AddressBook_NewFriends_Cell *cell = [tableView dequeueReusableCellWithIdentifier:newFriendsCellId];
        cell.notRegModel = self.notRegModels[indexPath.row];
        //最后一行cell的分隔线隐藏
         indexPath.row == (self.notRegModels.count - 1) ? cell.lineView.hidden = YES : NO;
        [cell.addButton addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
}

#pragma mark - 跳转添加好友页面
- (void)addFriend:(UIButton *)button
{
    WL_AddressBook_NewFriends_Cell *cell = (WL_AddressBook_NewFriends_Cell *)button.superview.superview;
    WL_AddressBook_AddFriend_ViewController *addFriendVc = [[WL_AddressBook_AddFriend_ViewController alloc] init];
    addFriendVc.view_id = cell.notRegModel.user_id;
    addFriendVc.friend_mobile = cell.notRegModel.user_mobile;
    addFriendVc.real_name = [WLUserTools getRealName];
    addFriendVc.user_mobile = [WLUserTools getUserMobile];
    [self.navigationController pushViewController:addFriendVc animated:YES];
}

#pragma mark - 通过好友验证点击方法
- (void)passedValidationFriend:(UIButton *)button
{
    //通过button的父视图的方式来取到cell
    WL_AddressBook_NewFriendsMessage_Cell *cell = (WL_AddressBook_NewFriendsMessage_Cell *)button.superview.superview;
    //1.接收并同意对方加为好友的Url
    NSString *urlStr = AgreeFriendUrl;
    //2.请求参数
    //用户id
    NSString *user_id = [WLUserTools getUserId];
    //用户密码
    NSString *user_password = [WLUserTools getUserPassword];
    //RSA加密
    NSString *rsaPassword = [MyRSA encryptString:user_password publicKey:RSAKey];
    //申请记录id
    NSString *message_id = cell.friendModel.message_id;
    //好友id
    NSString *friend_id = cell.friendModel.user_id;
    //参数集合
    NSDictionary *params = @{
                             @"user_id" : user_id,
                             @"user_password" : rsaPassword,
                             @"message_id" : message_id,
                             @"friend_id" : friend_id
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject)
    {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            [self.alert createTip:baseModel.msg];
            [self hidHud];
            return;
        }
        [self sendRequestToNewFriendList];
    }
    Failure:^(NSError *error)
    {
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
        }
        [self hidHud];
    }];

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 90.5f;
    }
    else
    {
        return 75.5f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 33)];
    UILabel *headerLable = [[UILabel alloc] init];
    [headerView addSubview:headerLable];
    [headerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(11.5);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    headerView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    headerLable.font = WLFontSize(14);
    headerLable.textColor = [WLTools stringToColor:@"#868686"];
    if (section == 0)
    {
        headerLable.text = @"新的朋友";
    }
    else
    {
        headerLable.text = @"添加朋友";
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        WL_AddressBook_NewFriendsMessage_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //进入联系人详情页面
        //已经注册, 跳转到常用联系人详情去
        WL_AddressBook_LinkManDetail_ViewController *linkManDetailVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
        linkManDetailVc.view_id = cell.friendModel.user_id;
        linkManDetailVc.isCompany = cell.friendModel.isCompany;
        [self.navigationController pushViewController:linkManDetailVc animated:YES];

    }
    else if (indexPath.section == 1)
    {
        WL_AddressBook_NewFriends_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
         WL_AddressBook_LinkManDetail_ViewController *linkManDetailVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
        linkManDetailVc.view_id = cell.notRegModel.user_id;
        //是否一个组织
        linkManDetailVc.isCompany = cell.notRegModel.isCompany;
        [self.navigationController pushViewController:linkManDetailVc animated:YES];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

    WL_AddressBook_NewFriendsMessage_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    return [self creatRightAttentionWithTitle:@"删除" withMessageId:cell.friendModel.message_id withColor:[WLTools stringToColor:@"#f7585e"] withType:@"2"];

    
    
    
}

- (NSArray *)creatRightAttentionWithTitle:(NSString *)title withMessageId:(NSString *)messageId withColor:(UIColor *)color withType:(NSString *)type
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:title handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //已关注公司 点击后,发送网络请求,取消关注cell所在的公司,刷新表格
        [self sendRequestToDeleteNewFriendRecordWithMessageId:messageId];
    }];
    deleteRowAction.backgroundColor = color;
    
    return @[deleteRowAction];
}

#pragma mark - 发送请求删除好友请求数据
- (void)sendRequestToDeleteNewFriendRecordWithMessageId:(NSString *)messageId
{
    //请求url
    NSString *urlStr = DeleteNewFriendRecordUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword,
                             @"message_id" : messageId
                             };
    [self showHud];
    //发送网络请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject)
    {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"])
        {
            [self.alert createTip:baseModel.msg];
            [self hidHud];
            return;
        }
        
        [self sendRequestToNewFriendList];

        [self hidHud];
    }
    Failure:^(NSError *error)
    {
        [self hidHud];
        [self.friendsTableView reloadData];
    }];

    
}






@end
