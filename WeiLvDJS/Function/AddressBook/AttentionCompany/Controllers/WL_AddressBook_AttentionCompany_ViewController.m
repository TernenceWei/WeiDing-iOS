//
//  WL_AddressBook_AttentionCompany_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  企业主控制器

#import "WL_AddressBook_AttentionCompany_ViewController.h"

/** 跳转的控制器 */
#import "WL_AddressBook_OrganizationDetail_ViewController.h"
#import "WL_AddressBook_AttentionCompany_Search_ViewController.h"
/** UI控件 */
#import "WL_AddressBook_AttentionCompany_Cell.h"
#import "WL_AddressBook_Search_View.h"

/** 模型 */
#import "WL_AddressBook_Company_Model.h"
#import "WL_AddressBook_AllCompanys_Model.h"
#import "WL_AddressBook_FollowCompanys_Model.h"


@interface WL_AddressBook_AttentionCompany_ViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 关注企业列表 */
@property(nonatomic, weak) UITableView *companyTableView;

/** 企业列表的分组数 */
@property(nonatomic, strong) NSMutableArray *sections;
/** 企业列表排序完成的分组数 */
@property(nonatomic, strong) NSArray *sortSections;
/** 企业列表的每组企业的数组 */
@property(nonatomic, strong) NSMutableArray *rows;

/** 企业的模型数组 */
@property(nonatomic, strong) NSMutableArray *companyModel;

/** 被关注企业模型数组 */
@property(nonatomic, strong) NSMutableArray<WL_AddressBook_FollowCompanys_Model *> *followCompanys;

/** 网络请求时需要用到的弹框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

/** 无网络的View */
@property(nonatomic, strong)WL_NoData_View *noDataView;
@end

@implementation WL_AddressBook_AttentionCompany_ViewController

- (NSMutableArray *)companyModel
{
    if (!_companyModel) {
        _companyModel = [NSMutableArray array];
    }
    return _companyModel;
}
- (NSMutableArray *)followCompanys
{
    if (!_followCompanys) {
        _followCompanys = [NSMutableArray array];
    }
    return _followCompanys;
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

        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) andRefreshBlock:^{
            [self sendRequstToFollowCompany];
        
        }];
        
        _noDataView.hidden = YES;
    }
    [self.view addSubview:_noDataView];
    
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
    //设置UI
    [self setupContentViewToAttentionCompany];


    //注册弹框
    [self creatTipAlertView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //发送网络请求请求已关注企业列表
    [self sendRequstToFollowCompany];
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}


#pragma mark - 发送网络请求请求已关注企业列表
- (void)sendRequstToFollowCompany
{
    self.noDataView.hidden = YES;
    //关注企业列表Url
    NSString *urlStr = FollowCompanyListUrl;
    //请求参数
    //从本地获取密码
    NSString *userPassword = [WLUserTools getUserPassword];////[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //从本地获取用户id
    NSString *userId = [WLUserTools getUserId];
    //参数
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword
                             };
    [self showHud];
    //发送请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            [self.alert createTip:baseModel.msg];
            return;
        }
        
        if (self.followCompanys) {
            [self.followCompanys removeAllObjects];
        }
        self.followCompanys = [WL_AddressBook_FollowCompanys_Model mj_objectArrayWithKeyValuesArray:baseModel.data];

 
        //发送网络请求请求企业列表数据
        [self sendRequstToCompany];
    } Failure:^(NSError *error) {
        [self hidHud];
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
    }];
}

#pragma mark - 发送网络请求请求企业列表数据
- (void)sendRequstToCompany
{
    //企业列表URL
    NSString *urlStr = CompanyListUrl;
    //请求参数
    NSString *user_id = [WLUserTools getUserId];
    NSString *user_password = [WLUserTools getUserPassword];
    NSString *rsaUserPassword = [MyRSA encryptString:user_password publicKey:RSAKey];
    NSDictionary *params = @{
                             @"user_id" : user_id,
                             @"user_password" : rsaUserPassword
                             };
    //发送网络请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject)
    {
        self.noDataView.hidden = YES;
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (![baseModel.result isEqualToString:@"1"]) {
            [self hidHud];
            [self.alert createTip:baseModel.msg];
            return;
        }
        
        if ([baseModel.result isKindOfClass:[NSArray class]]) {

                [self.alert createTip:@"暂无企业数据"];
                [self hideNoData:NO andType:WLNetworkTypeNOData];
                [self hidHud];
                return;

        }
        
        WL_AddressBook_AllCompanys_Model *companysModel = [WL_AddressBook_AllCompanys_Model mj_objectWithKeyValues:baseModel.data];
        
        if (self.sections) {
            [self.sections removeAllObjects];
        }
        
        for (NSString *s in [baseModel.data allKeys]) {
            [self.sections addObject:s];
            
        }
        //将模型中的数据按照字母A-Z排序
        self.sortSections = [self.sections sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        if (self.rows) {
            [self.rows removeAllObjects];
        }
        for (int i = 0; i < self.sortSections.count; i++) {
            NSArray *arr =  [companysModel valueForKey:self.sections[i]];
            self.companyModel = [WL_AddressBook_Company_Model mj_objectArrayWithKeyValuesArray:arr];
            [self.rows addObject:self.companyModel];
        }

        [self hidHud];
        self.companyTableView.hidden = NO;
        [self.companyTableView reloadData];
    }
    Failure:^(NSError *error)
    {
        [self hidHud];
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
    }];
    
    
}



#pragma mark - setupContentViewToAttentionCompany
- (void)setupContentViewToAttentionCompany
{
    //设置背景颜色
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    //设置标题
    self.title = @"企业号";
    //设置TableView
    [self setupTableView];
}


static NSString *const cellId = @"companys";
#pragma mark - 设置列表
- (void)setupTableView
{
    //设置TableView
    UITableView *companyTableView = [[UITableView alloc] init];
    [self.view addSubview:companyTableView];
    [companyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top);
    }];
    
    companyTableView.delegate = self;
    companyTableView.dataSource = self;
    companyTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    //隐藏分隔线
    companyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [companyTableView registerClass:[WL_AddressBook_AttentionCompany_Cell class] forCellReuseIdentifier:cellId];
    //添加头部搜索框
    WL_AddressBook_Search_View *searchView = [[WL_AddressBook_Search_View alloc] initWithSearchPlaceholder:@"商家号" backgroundColor:[WLTools stringToColor:@"#ffffff"] frame:CGRectMake(0, 0, ScreenWidth, 37.5) clickAction:^{
        WL_AddressBook_AttentionCompany_Search_ViewController *searchVc = [[WL_AddressBook_AttentionCompany_Search_ViewController alloc] init];
        [self.navigationController pushViewController:searchVc animated:YES];
    }];
    companyTableView.tableHeaderView = searchView;
    //tableView赋值给全局变量
    self.companyTableView = companyTableView;
    companyTableView.hidden = YES;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.followCompanys.count;
    }
    else
    {
        NSArray *arrays = self.rows[section - 1];
        return arrays.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_AttentionCompany_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.section == 0)
    {
        cell.followCompanyModel = self.followCompanys[indexPath.row];
        cell.lineView.hidden = indexPath.row == self.followCompanys.count - 1 ? YES : NO;
        
    }
    else
    {
        NSArray *models =  self.rows[indexPath.section - 1];
        cell.companyModel = models[indexPath.row];
        cell.lineView.hidden = indexPath.row == models.count - 1 ? YES : NO;


    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 33)];
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AttentionCompany"]];
        [headerView addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(10);
            make.top.equalTo(headerView.mas_top).offset(15);
        }];
        UILabel *headerLable = [[UILabel alloc] init];
        [headerView addSubview:headerLable];
        [headerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(30);
            make.top.equalTo(headerView.mas_top).offset(15);
        }];
        headerView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
        headerLable.font = WLFontSize(13);
        headerLable.textColor = [WLTools stringToColor:@"#868686"];
        headerLable.text = @"我关注的";
        UIView *lineView = [[UIView alloc] init];
        [headerView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left);
            make.right.equalTo(headerView.mas_right);
            make.bottom.equalTo(headerView.mas_bottom);
            make.height.equalTo(@0.5);
        }];
        lineView.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
        return headerView;
    }
    else
    {
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
        headerLable.text = self.sortSections[section - 1];
        return headerView;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.0f;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 43.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_OrganizationDetail_ViewController *organizationDetailVc = [[WL_AddressBook_OrganizationDetail_ViewController alloc] init];

    if (indexPath.section == 0) {
        
        WL_AddressBook_FollowCompanys_Model *followCompanyModel = self.followCompanys[indexPath.row];
        organizationDetailVc.company_id = followCompanyModel.company_id;
    }
    else
    {
        NSArray *models =  self.rows[indexPath.section - 1];
        self.companyModel = [WL_AddressBook_Company_Model mj_objectArrayWithKeyValuesArray:models];
        WL_AddressBook_Company_Model *companyModel = self.companyModel[indexPath.row];
        organizationDetailVc.company_id = companyModel.company_id;
    }
    
    [self.navigationController pushViewController:organizationDetailVc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_AttentionCompany_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        return [self creatRightAttentionWithTitle:@"取消关注" withCompanyId:cell.followCompanyModel.company_id withColor:[WLTools stringToColor:@"#f7585e"] withType:@"2"];
    }
    else
    {
        if ([cell.companyModel.isFollow isEqualToString:@"0"])
        {
            return [self creatRightAttentionWithTitle:@"  关注  " withCompanyId:cell.companyModel.company_id withColor:[WLTools stringToColor:@"#fbbc24"] withType:@"1"];
        }
        else
        {
            return [self creatRightAttentionWithTitle:@"取消关注" withCompanyId:cell.companyModel.company_id withColor:[WLTools stringToColor:@"#f7585e"] withType:@"2"];
        }
        
    }
 
}

- (NSArray *)creatRightAttentionWithTitle:(NSString *)title withCompanyId:(NSString *)company_id withColor:(UIColor *)color withType:(NSString *)type
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:title handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //已关注公司 点击后,发送网络请求,取消关注cell所在的公司,刷新表格
        [self sendRequestToFollowCompanyWithCompanyId:company_id withType:type];
    }];
    deleteRowAction.backgroundColor = color;
    
    return @[deleteRowAction];
}

#pragma mark - 发送请求关注公司
- (void)sendRequestToFollowCompanyWithCompanyId:(NSString *)company_id withType:(NSString *)type
{
    //1.请求Url
    NSString *urlStr = CompanyFollowUrl;
    //2.请求参数
    NSString *user_id = [WLUserTools getUserId];
    NSString *userPassword = [WLUserTools getUserPassword];
    NSString *rsaPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    NSDictionary *params = @{
                             @"user_id" : user_id,
                             @"user_password" : rsaPassword,
                             @"company_id" : company_id,
                             @"type" : type
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        self.noDataView.hidden = YES;
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([baseModel.result isEqualToString:@"0"]) {
            if ([type isEqualToString:@"1"]) {
                [self.alert createTip:@"关注失败!"];
            }
            else
            {
                [self.alert createTip:@"取消关注失败!"];
            }
            
            [self.companyTableView reloadData];
            [self hidHud];
            return;
        }
        else
        {
            if ([type isEqualToString:@"1"])
            {
                [self.alert createTip:@"关注成功!"];
                
            }
            else
            {
                [self.alert createTip:@"取消关注成功!"];
            }
            
            [self sendRequstToFollowCompany];
        }
        
        [self hidHud];
    } Failure:^(NSError *error) {
        [self hidHud];
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
    }];
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
