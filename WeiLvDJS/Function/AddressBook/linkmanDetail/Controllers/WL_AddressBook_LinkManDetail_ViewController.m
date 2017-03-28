//
//  WL_AddressBook_LinkMainDetail_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//   联系人详细资料主控制器

#import "WL_AddressBook_LinkManDetail_ViewController.h"

/** 企业详情控制器 */
#import "WL_AddressBook_OrganizationDetail_ViewController.h"
/** 修改备注名称控制器 */
#import "WL_AddressBook_ChangeRemarkName_ViewController.h"
/** 添加好友控制器 */
#import "WL_AddressBook_AddFriend_ViewController.h"
/** 发私信控制器 */
#import "WL_EditPrivateLetter_ViewController.h"
/** tableView的头部视图 */
#import "WL_AddressBook_LinkManDetail_TopView.h"
/** tableView的底部视图 */
#import "WL_AddressBook_LinkManDetail_BottomView.h"
/** 公司信息cell */
#import "WL_AddressBook_CompanyMessage_Cell.h"
#import "WL_AddressBook_DepartMent_Cell.h"
/** 更多操作的弹框 */
#import "WL_AddressBook_LinkManDetail_AlterView.h"
/* 解除好友关系的弹框 */
#import "WL_Application_Driver_Order_Rush_AlertView.h"

/** 模型 */
//常用联系人详情
#import "WL_AddressBook_LinkMan_Model.h"
//常用联系人信息模型
#import "WL_AddressBook_LinkMan_Information_Model.h"
//常用联系人公司模型
#import "WL_AddressBook_LinkMan_Company_Model.h"
//常用联系人部门模型
#import "WL_AddressBook_LinkMan_Department_Model.h"

#import "WL_Save_Model.h"
#import "WL_ShareArray.h"

@interface WL_AddressBook_LinkManDetail_ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 联系人公司数组 */
@property(nonatomic, strong) NSMutableArray<WL_AddressBook_LinkMan_Company_Model *> *companys;
/** 联系人公司id数组 */
@property(nonatomic, strong) NSMutableArray *companyIds;
/** 用户自己的公司数组 */
@property(nonatomic, strong) NSMutableArray<WL_AddressBook_LinkMan_Company_Model *> *myCompanys;
/** 用户自己的公司id数组 */
@property(nonatomic, strong) NSMutableArray *myCompanyIds;
/** tableView的头视图 */
@property(nonatomic, weak) WL_AddressBook_LinkManDetail_TopView *topView;
/** tableView的底部视图 */
@property(nonatomic, weak) WL_AddressBook_LinkManDetail_BottomView *bottomView;
/** tableView */
@property(nonatomic, weak) UITableView *linkDetailTableView;
/** 是否是好友 */
@property(nonatomic, copy) NSString *isFriends;
/** 用户的真实姓名 */
@property(nonatomic, copy) NSString *real_name;
/** 用户的电话号码 */
@property(nonatomic, copy) NSString *user_mobile;
/** 好友的电话号码 */
@property(nonatomic, copy) NSString *friend_mobile;

/** keyWindow */
@property(nonatomic, weak) UIWindow *myWindow;

@property(nonatomic, weak) WL_AddressBook_LinkManDetail_AlterView *alertView;

@property(nonatomic, weak) WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView;

/** 网络请求时需要用到的弹框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

@property(nonatomic, weak) UIView  *backgroundView;
@end

@implementation WL_AddressBook_LinkManDetail_ViewController

#pragma mark - lazy
- (NSMutableArray<WL_AddressBook_LinkMan_Company_Model *> *)companys
{
    if (!_companys) {
        _companys = [NSMutableArray array];
    }
    return _companys;
}

- (NSMutableArray *)companyIds
{
    if (!_companyIds) {
        _companyIds = [NSMutableArray array];
    }
    return _companyIds;
}
- (NSMutableArray<WL_AddressBook_LinkMan_Company_Model *> *)myCompanys
{
    if (!_myCompanys) {
        _myCompanys = [NSMutableArray array];
    }
    return _myCompanys;
}
- (NSMutableArray *)myCompanyIds
{
    if (!_myCompanyIds) {
        _myCompanyIds = [NSMutableArray array];
    }
    return _myCompanyIds;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //发送请求,请求自己的组织数据
    [self sendRequstToLinkManDetailWithViewId:[WLUserTools getUserId]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupUIToLinkManDetail];
    //注册弹框
    [self creatTipAlertView];
}


#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}

#pragma mark - 设置UI
static NSString *const CompanyCellId = @"companyCell";
static NSString *const DepartMentCellId = @"departMentCell";
- (void)setupUIToLinkManDetail
{
    //1.设置背景颜色
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    self.title = @"详细资料";
    
    //设置TableView
    UITableView *linkDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:linkDetailTableView];
    [linkDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    linkDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    linkDetailTableView.delegate = self;
    linkDetailTableView.dataSource = self;
    [linkDetailTableView registerClass:[WL_AddressBook_CompanyMessage_Cell class] forCellReuseIdentifier:CompanyCellId];
    [linkDetailTableView registerClass:[WL_AddressBook_DepartMent_Cell class] forCellReuseIdentifier:DepartMentCellId];
    self.linkDetailTableView = linkDetailTableView;
    self.linkDetailTableView.hidden = YES;
    
    //头试图
    WL_AddressBook_LinkManDetail_TopView *topView = [[WL_AddressBook_LinkManDetail_TopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 106)];
    [topView.addFriendsButton addTarget:self action:@selector(addFriendsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    linkDetailTableView.tableHeaderView = topView;
    self.topView = topView;
    
    //底部视图
    WL_AddressBook_LinkManDetail_BottomView *bottomView = [[WL_AddressBook_LinkManDetail_BottomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    linkDetailTableView.tableFooterView = bottomView;
    self.bottomView = bottomView;
    [bottomView.telPhoneButton addTarget:self action:@selector(telPhoneToContactFriend) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.sendMessageButton addTarget:self action:@selector(sendMessageToContentFriend) forControlEvents:UIControlEventTouchUpInside];
    
    //底部蒙版
    UIView *backgroundView = [[UIView alloc] init];
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    self.myWindow = myWindow;
    [myWindow addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWindow.mas_left);
        make.right.equalTo(myWindow.mas_right);
        make.top.equalTo(myWindow.mas_top);
        make.bottom.equalTo(myWindow.mas_bottom);
    }];
    backgroundView.backgroundColor = [WLTools stringToColor:@"#000000"];
    backgroundView.alpha = 0.2;
    backgroundView.hidden = YES;
    self.backgroundView = backgroundView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAlertView)];
    [backgroundView addGestureRecognizer:tap];

    WL_AddressBook_LinkManDetail_AlterView *alertView = [[WL_AddressBook_LinkManDetail_AlterView alloc] init];
    [myWindow addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myWindow.mas_left);
        make.right.equalTo(myWindow.mas_right);
        make.top.equalTo(myWindow.mas_bottom);
        make.height.equalTo(@180);
        
    }];
    self.alertView = alertView;
  
}

#pragma mark - 打电话方法
- (void)telPhoneToContactFriend
{
    NSString *telPhoneStr = [NSString stringWithFormat:@"tel:%@", self.friend_mobile];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telPhoneStr]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoneStr]];
    }
}

#pragma mark - 发私信方法
- (void)sendMessageToContentFriend
{
    WL_EditPrivateLetter_ViewController *editPrivateVc = [[WL_EditPrivateLetter_ViewController alloc] init];
    
    WL_Save_Model * saveModel = [[WL_Save_Model alloc] init];
    
    saveModel.photo = self.topView.informationModel.photo;
    
    if (saveModel.real_name == nil) {
        saveModel.real_name = @"";
    }
    else
    {
        saveModel.real_name = self.topView.informationModel.real_name;
    }
    
    
    saveModel.user_id = self.view_id;
    saveModel.user_name = self.topView.informationModel.user_name;
    saveModel.mobile = self.topView.informationModel.user_mobile;
    NSMutableDictionary *dicts = [NSMutableDictionary dictionaryWithObject:saveModel forKey:saveModel.user_id];
    if ([self.addressBook isEqualToString:@"1"]) {
        [DEFAULTS setValue:self.addressBook forKey:@"adressbook"];
    }
    else
    {
        [DEFAULTS setValue:@"2" forKey:@"adressbook"];
    }
    
    [self.navigationController pushViewController:editPrivateVc animated:YES];
     [editPrivateVc reloadCellectionViewWith:dicts];
}

#pragma mark - 添加好友点击事件
- (void)addFriendsButtonClick
{
    if ([self.view_id isEqualToString:[WLUserTools getUserId]])
    {
        [self.alert createTip:@"不可添加自己为好友"];
    }
    else
    {
        WL_AddressBook_AddFriend_ViewController *addFriendVc = [[WL_AddressBook_AddFriend_ViewController alloc] init];
        addFriendVc.view_id = self.view_id;
        addFriendVc.friend_mobile = self.friend_mobile;
        addFriendVc.real_name = self.real_name;
        addFriendVc.user_mobile = self.user_mobile;
        [self.navigationController pushViewController:addFriendVc animated:YES];
    }
    
    
}

#pragma mark - 移除控制器
- (void)removeAlertView
{
    self.backgroundView.hidden = YES;
    [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.myWindow.mas_bottom);
    }];
    [self.myWindow setNeedsUpdateConstraints];
    [self.myWindow updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.myWindow layoutIfNeeded];
    }];
  
}

#pragma mark - 右侧点击事件
- (void)NavigationRightEvent
{
    if ( [self.isFriends isEqualToString:@"1"]) {
        self.backgroundView.hidden = NO;
        //如果是好友,那么底部的弹框是3项,有一个解除好友关系,如果不是好友,那么久2项
        [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.myWindow.mas_bottom).offset(-180);
        }];
        [self.myWindow setNeedsUpdateConstraints];
        [self.myWindow updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            [self.myWindow layoutIfNeeded];
        }];
        
    }
    
}

#pragma mark - 发送请求,请求数据
- (void)sendRequstToLinkManDetailWithViewId:(NSString *)view_id
{
    //请求Url
    NSString *urlStr = LinkManDetailUrl;
    //参数
    NSString *user_id = [WLUserTools getUserId];
    NSString *password = [WLUserTools getUserPassword];
    NSString *rsaPassword = [MyRSA encryptString:password publicKey:RSAKey];
    
    NSDictionary *params = @{
                             @"user_id" : user_id,
                             @"user_password" : rsaPassword,
                             @"view_id" : view_id
                             };
    
    //发送请求
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
       
        if ([view_id isEqualToString: user_id]) //请求在自己的数据
        {
            WL_AddressBook_LinkMan_Model *linkManModel = [WL_AddressBook_LinkMan_Model mj_objectWithKeyValues:baseModel.data];
            self.real_name = linkManModel.userInfo.real_name;
            self.user_mobile = linkManModel.userInfo.user_mobile;
            self.friend_mobile = linkManModel.userInfo.user_mobile;
            if (self.myCompanys) {
                [self.myCompanys removeAllObjects];
            }
            if (self.myCompanyIds) {
                [self.myCompanyIds removeAllObjects];
            }
            self.myCompanys = [WL_AddressBook_LinkMan_Company_Model mj_objectArrayWithKeyValuesArray:linkManModel.company];
            
            for (WL_AddressBook_LinkMan_Company_Model *myCompanysModel in self.myCompanys) {
                //将自己的组织id存放到数组中
                [self.myCompanyIds addObject:myCompanysModel.company_id];
            }
            if ([self.view_id isEqualToString:view_id])
            {
                WlLog(@"请求自己数据!");
                self.companyIds = [NSMutableArray arrayWithArray:self.myCompanys];
                self.linkDetailTableView.hidden = NO;
                [self hidHud];
                [self.linkDetailTableView reloadData];
                self.topView.informationModel = linkManModel.userInfo;
                self.isFriends = linkManModel.userInfo.isFriend;
                
            }
            else
            {
                [self sendRequstToLinkManDetailWithViewId:self.view_id];
            }
            
        }
        else    //请求联系人数据
        {
            
            WL_AddressBook_LinkMan_Model *linkManModel = [WL_AddressBook_LinkMan_Model mj_objectWithKeyValues:baseModel.data];
            self.friend_mobile = linkManModel.userInfo.user_mobile;
            if (self.companys) {
                [self.companys removeAllObjects];
            }
            if (self.companyIds) {
                [self.companyIds removeAllObjects];
            }
            self.companys = [WL_AddressBook_LinkMan_Company_Model mj_objectArrayWithKeyValuesArray:linkManModel.company];
            
            self.topView.informationModel = linkManModel.userInfo;
            self.isFriends = linkManModel.userInfo.isFriend;
            [self.alertView.cancelFriendsButton addTarget:self action:@selector(cancelFriendsButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView.remarkNameButton addTarget:self action:@selector(remarkNameButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView.cancleButton addTarget:self action:@selector(removeAlertView) forControlEvents:UIControlEventTouchUpInside];
            //如果是好友
            if ([self.isFriends isEqualToString:@"1"]) {
                [self setNavigationRightTitle:@"更多" fontSize:16 titleColor:[UIColor whiteColor] isEnable:YES];
            }
            else
            {
                [self setNavigationRightTitle:@"" fontSize:16 titleColor:[UIColor whiteColor] isEnable:NO];
            }
            
            if ([self.isCompany isEqualToString:@"1"]) //同组织
            {
                for (WL_AddressBook_LinkMan_Company_Model *companysModel in self.companys)
                {
                    //如果联系人的组织id 包含在 自己的组织id数组中<同组织>
                    if ([self.myCompanyIds containsObject:companysModel.company_id])
                    {
                        //添加到公司id数组中
                        [self.companyIds addObject:companysModel];
                    }
                }
            }
            else    //不同组织
            {
                if ([linkManModel.userInfo.isFriend isEqualToString:@"1"])  //是好友
                {
                    for (WL_AddressBook_LinkMan_Company_Model *companysModel in self.companys)
                    {
                            //添加到公司id数组中
                            [self.companyIds addObject:companysModel];
                    }
                }
                else    //不是好友
                {
                    //不显示组织
                    [self.companyIds removeAllObjects];
                    self.bottomView.sendMessageButton.userInteractionEnabled = NO;
                    [self.bottomView.sendMessageButton setBackgroundColor:[UIColor grayColor]];
                    
                }
            }
            self.linkDetailTableView.hidden = NO;
            [self.linkDetailTableView reloadData];
        }
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.companyIds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WL_AddressBook_CompanyMessage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CompanyCellId];
        cell.companyModel = self.companyIds[indexPath.section];
        NSArray *departments = [WL_AddressBook_LinkMan_Department_Model mj_objectArrayWithKeyValuesArray:cell.companyModel.department];
        if (departments.count > 0)
        {
            cell.departmentModel = departments[0];
        }
        else
        {
            
        }
            
        return cell;
    }
    else
    {
        WL_AddressBook_DepartMent_Cell *cell = [tableView dequeueReusableCellWithIdentifier:DepartMentCellId];
        
        cell.companyModel = self.companyIds[indexPath.section];
        if (indexPath.row == 1) //部门
        {
            NSArray *departments = [WL_AddressBook_LinkMan_Department_Model mj_objectArrayWithKeyValuesArray:cell.companyModel.department];
            if (departments.count > 0)
            {
                cell.departmentModel = departments[0];
            }
            else
            {
                cell.titleLable.text = @"部门";
            }
        }
        else    //职位
        {
            cell.companyModel = self.companyIds[indexPath.section];
        }

        if (indexPath.row == 2) {
            cell.lineView.hidden = YES;
        }
        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        WL_AddressBook_CompanyMessage_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        WL_AddressBook_OrganizationDetail_ViewController *organizationDetailVc = [[WL_AddressBook_OrganizationDetail_ViewController alloc] init];
        organizationDetailVc.hidesBottomBarWhenPushed = YES;
        organizationDetailVc.company_id = cell.company_id;
        [self.navigationController pushViewController:organizationDetailVc animated:YES];
    }
}

#pragma mark - 解除绑定好友按钮点击事件
- (void)cancelFriendsButtonClick
{
    [self removeAlertView];
    WL_Application_Driver_Order_Rush_AlertView *rushOrderAlertView = [[WL_Application_Driver_Order_Rush_AlertView alloc] init];
    rushOrderAlertView.backgroundColor = WLColor(0, 0, 0, 0.2);
    [self.myWindow addSubview:rushOrderAlertView];
    [rushOrderAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myWindow.mas_left);
        make.right.equalTo(self.myWindow.mas_right);
        make.top.equalTo(self.myWindow.mas_top);
        make.bottom.equalTo(self.myWindow.mas_bottom);
    }];
    rushOrderAlertView.promptLable.hidden = NO;
    rushOrderAlertView.promptMessageLable.text = @"确定要解除好友关系?";
    
    rushOrderAlertView.promptMessageLable.textAlignment = NSTextAlignmentCenter;
    [rushOrderAlertView.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [rushOrderAlertView.cancleButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rushOrderAlertView.rushButton setTitle:@"确定" forState:UIControlStateNormal];
    [rushOrderAlertView.rushButton addTarget:self action:@selector(sendRequestToEditingFriend) forControlEvents:UIControlEventTouchUpInside];
    self.rushOrderAlertView = rushOrderAlertView;
 
}

- (void)cancleButtonClick
{
    [self.rushOrderAlertView removeFromSuperview];
}

- (void)sendRequestToEditingFriend
{
    [self.rushOrderAlertView removeFromSuperview];
    //发送解除好友请求
    NSString *urlStr = EditingFriendUrl;
    //请求参数
    NSString *user_id = [WLUserTools getUserId];
    NSString *password = [WLUserTools getUserPassword];
    NSString *rsaPassword = [MyRSA encryptString:password publicKey:RSAKey];
    NSString *view_id = self.view_id;
    NSDictionary *params = @{
                             @"user_id" : user_id,
                             @"user_password" : rsaPassword,
                             @"friend_id" : view_id
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            [self hidHud];
            [self.alert createTip:[NSString stringWithFormat:@"%@", baseModel.msg]];
            return;
        }
        [self hidHud];
        [self.alert createTip:@"解除好友成功"];
        [self sendRequstToLinkManDetailWithViewId:[WLUserTools getUserId]];
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

#pragma mark - 修改备注名称按钮点击事件
- (void)remarkNameButtonClick
{
    //弹框隐藏,
    [self removeAlertView];
    //跳转控制器
    WL_AddressBook_ChangeRemarkName_ViewController *changeRemarkNameVc = [[WL_AddressBook_ChangeRemarkName_ViewController alloc] init];
    changeRemarkNameVc.view_id = self.view_id;
    [self.navigationController pushViewController:changeRemarkNameVc animated:YES];
}

- (void)dealloc
{
    [self.backgroundView removeFromSuperview];
    [self.alertView removeFromSuperview];
}

@end
