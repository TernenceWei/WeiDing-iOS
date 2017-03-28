//
//  WL_AddressBook_MyAddressBook_Search_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_MyAddressBook_Search_ViewController.h"

#import "WL_AddressBook_LinkManDetail_ViewController.h"

#import "WL_AddressBook_MyAddressBook_Linkman_ViewController.h"


#import "WL_AddressBook_Search_SearchView.h"

#import "WL_AddressBook_SearchRecord_View.h"

#import "WL_AddressBook_Organiztion_Search_Prompt_View.h"

#import "WL_AddressBook_MyAddressBook_Cell.h"

#import "WL_AddressBook_SearchResult_Model.h"
#import "WL_AddressBook_SearchResult_Contact_Model.h"
#import "WL_AddressBook_MyAddressBook_SearchContent_Model.h"
#import "WL_AddressBook_MyAddressBook_AttentionMessage_Model.h"


@interface WL_AddressBook_MyAddressBook_Search_ViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
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

/** 手机通讯录联系人数组 */
@property(nonatomic, strong) NSMutableArray *mobiles;

/** 搜索结果手机通讯录联系人数组 */
@property(nonatomic, strong) NSMutableArray *resultMobiles;

/** 网络请求时需要用到的弹框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;
@end

@implementation WL_AddressBook_MyAddressBook_Search_ViewController
static NSString *const CellId = @"searchMyAddressBookResultCellId";
static NSString *const SearchRecordKey = @"myAddressBookSearchRecords";

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

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置Nav
    [self setupNavToAttentionCompanySearchVc];
    //2.设置控制器内容View
    [self contentViewToSearchVc];
    
    //3
    self.mobiles =  [self acquireMessageInMyAddressBook];
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
    WL_AddressBook_Organiztion_Search_Prompt_View *promptView = [[WL_AddressBook_Organiztion_Search_Prompt_View alloc] initWithFrame:CGRectZero withTitle:@"通讯录" withIconImageName:@"WL_AddressBook_SearchMyAddressBook"];
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
    [searchResultTableView registerClass:[WL_AddressBook_MyAddressBook_Cell class] forCellReuseIdentifier:CellId];
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
        [self acquireSearchResultWithSearchContent:textField.text];
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
#pragma mark - 从本地通讯录匹配搜索结果
- (void)acquireSearchResultWithSearchContent:(NSString *)content
{
    [self.resultMobiles removeAllObjects];
    for (WL_AddressBook_MyAddressBook_SearchContent_Model *searchResultModel in self.mobiles)
    {
        //取出姓名全称<因为姓名基本都包含汉字>
        NSString *name = nil;
        if (searchResultModel.firstName != nil && searchResultModel.lastName != nil) {
            name = [NSString stringWithFormat:@"%@%@", searchResultModel.firstName, searchResultModel.lastName];
        }
        else if (searchResultModel.firstName != nil && searchResultModel.lastName == nil)
        {
            name = searchResultModel.firstName;
        }
        else if (searchResultModel.firstName == nil && searchResultModel.lastName != nil)
        {
             name = searchResultModel.lastName;
        }
        else
        {
            name = searchResultModel.phone;
        }
        
        
        //首字母中间变量
        NSString *temp = nil;
        NSString *initialStr = [[NSString alloc] init];
        //遍历姓名中每一个字符
        for(int i =0; i < [name length]; i++)
        {
            temp = [name substringWithRange:NSMakeRange(i, 1)];
            //取出姓名中遍历出来字符的首字母<大写>
            NSString *initial = [self firstCharactor:temp];

            
            initialStr = [initialStr stringByAppendingString:initial];

  
        }
        NSArray *array = [NSArray arrayWithObjects:searchResultModel.phone, name, initialStr, nil];

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",content];
        NSArray *arrays =  [[NSArray alloc] initWithArray:[array filteredArrayUsingPredicate:predicate]];
        
        if (arrays.count > 0) {
            if (![self.resultMobiles containsObject:searchResultModel]) {
                [self.resultMobiles addObject:searchResultModel];
            }

        }
   
}
    
    
    
    self.searchRecordView.hidden = YES;
    self.promptView.hidden = YES;
    self.searchResultTableView.hidden = NO;
    [self.searchResultTableView reloadData];
    [self hidHud];
    
}
#pragma mark ------------------------------UITableViewDataSource----------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultMobiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_MyAddressBook_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    cell.lineView.hidden = indexPath.row == self.resultMobiles.count - 1 ? YES : NO;
    cell.searchContent = self.resultMobiles[indexPath.row];
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
    titleLable.text = @"手机通讯录";
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
    WL_AddressBook_MyAddressBook_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.searchRecords = [self acquireSearchRecordsFromUserDefault];
    
    if ([self.searchRecords containsObject:cell.nameLabel.text])
    {
        [self.searchRecords removeObject:cell.nameLabel.text];
    }
    else
    {
        if (self.searchRecords.count > 5)
        {
            [self.searchRecords removeLastObject];
        }
        
    }
    
    [self.searchRecords insertObject:cell.nameLabel.text atIndex:0];
    [self saveSearchRecordsToUserDefault];
    for (UIView *view in self.searchRecordView.subviews) {
        if ([self.searchRecordButtons containsObject:view]) {
            [view removeFromSuperview];
        }
    }
    
    
    [self addSearchRecordsToSearchRecordView];
    [self.searchView.searchField resignFirstResponder];
    
    //发送验证请求
    [self sendRequestToAttentionWithPhone:cell.phoneLabel.text withName:cell.nameLabel.text];
    
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
    [self acquireSearchResultWithSearchContent:self.searchView.searchField.text];
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
        //获取当前联系人的名字拼音
        NSString*firstNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonFirstNamePhoneticProperty));
        //获取当前联系人的姓氏拼音
        NSString*lastNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonLastNamePhoneticProperty));
        
        //创建一个模型
        WL_AddressBook_MyAddressBook_SearchContent_Model *searchContentModel = [[WL_AddressBook_MyAddressBook_SearchContent_Model alloc] init];
        searchContentModel.firstName = firstName;
        searchContentModel.lastName = lastName;
        if (phoneArr.count > 0)
        {
            searchContentModel.phone = phoneArr[0];
        }
        else
        {
            searchContentModel.phone = @"0";
        }
        
        searchContentModel.firstNamePhoneic = firstNamePhoneic;
        searchContentModel.lastNamePhoneic = lastNamePhoneic;
        if (![self.mobiles containsObject:searchContentModel])
        {
            [self.mobiles addObject:searchContentModel];
        }
        

    }
    return self.mobiles;
}



#pragma mark - 发送验证请求
- (void)sendRequestToAttentionWithPhone:(NSString *)phone withName:(NSString *)name
{
    
    if ([phone isEqualToString:@""] || phone == nil) {
        [self.alert createTip:@"手机号码不能为空"];
        return;
    }
    if ([phone isEqualToString:@"0"]) {
        [self.alert createTip:@"手机号码格式不正确"];
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
             [self.alert createTip:baseModel.msg];
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
     }
      Failure:^(NSError *error)
     {
         
     }];
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



- (void)dealloc
{
    [self.alert removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
