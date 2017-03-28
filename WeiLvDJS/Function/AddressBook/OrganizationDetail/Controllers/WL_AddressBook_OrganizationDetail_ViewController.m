//
//  WL_AddressBook_OrganizationDetail_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddressBook_OrganizationDetail_ViewController.h"

/** 导入模型 */
#import "WL_AddressBook_OrganizationDetail_Model.h"

#import "WL_AddressBook_OrganizationDetail_Business_Model.h"

/** 导入控件 */
#import "WL_AddressBook_OrganizationDetail_Cell.h"
//头视图
#import "WL_AddressBook_OrganizationDetail_TopView.h"
//底部视图
#import "WL_AddressBook_OrganizationDetail_FooterView.h"

@interface WL_AddressBook_OrganizationDetail_ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property(nonatomic, weak) UITableView *organizationDetailTableView;
/** 模型 */
@property(nonatomic, strong) WL_AddressBook_OrganizationDetail_Model *detailModel;
/** tableView的头视图 */
@property(nonatomic, weak) WL_AddressBook_OrganizationDetail_TopView *topView;
/** tableView的底部视图 */
@property(nonatomic, weak) WL_AddressBook_OrganizationDetail_FooterView *footerView;
/** 开通业务数组 */
@property(nonatomic, strong) NSMutableArray *companyApps;
/** 开通业务名称数组 */
@property(nonatomic, strong) NSMutableArray *companyAppNames;

/** 网络请求时需要用到的弹框 */
@property(nonatomic, strong)WL_TipAlert_View *alert;

/** 无网络的View */
@property(nonatomic, strong)WL_NoData_View *noDataView;


@end

@implementation WL_AddressBook_OrganizationDetail_ViewController

- (NSMutableArray *)companyApps
{
    if (!_companyApps) {
        _companyApps = [NSMutableArray array];
    }
    return _companyApps;
}

- (NSMutableArray *)companyAppNames
{
    if (!_companyAppNames) {
        _companyAppNames = [NSMutableArray array];
    }
    return _companyAppNames;
}

- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        
        WS(weakSelf);
        
        _noDataView = [[WL_NoData_View alloc] initWithFrame:self.view.frame andRefreshBlock:^{
            //发送请求请求企业数据
            [weakSelf sendRequestToOrganizationDetailWith:self.company_id];
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
    
    //设置企业详情页面的子控件
    [self setChildViewToOrganizationDetail];
    //发送请求请求企业数据
    [self sendRequestToOrganizationDetailWith:self.company_id];
    //注册弹框
    [self creatTipAlertView];
}

#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
    
}



static NSString *const cellId = @"cellId";
#pragma mark - 设置企业详情页面的子控件
- (void)setChildViewToOrganizationDetail
{
    //1背景颜色
    self.view.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];
    //2.标题
    self.title = @"详细资料";
    //3.创建TableView
    UITableView *organizationDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:organizationDetailTableView];
    [organizationDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //设置属性
    organizationDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    organizationDetailTableView.delegate = self;
    organizationDetailTableView.dataSource = self;
    organizationDetailTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f7"];
    //注册cell
    [organizationDetailTableView registerClass:[WL_AddressBook_OrganizationDetail_Cell class] forCellReuseIdentifier:cellId];
    //HeaderView
    WL_AddressBook_OrganizationDetail_TopView *topView = [[WL_AddressBook_OrganizationDetail_TopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 106)];
    topView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    self.topView = topView;
    organizationDetailTableView.tableHeaderView = topView;
    //FooterView
    WL_AddressBook_OrganizationDetail_FooterView *footerView = [[WL_AddressBook_OrganizationDetail_FooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 145)];
    self.footerView = footerView;
    [footerView.attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    organizationDetailTableView.tableFooterView = footerView;
    
    organizationDetailTableView.hidden = YES;
    
    self.organizationDetailTableView = organizationDetailTableView;
}

#pragma mark - 点击关注按钮
- (void)attentionButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        [self sendrequestToFollowCompanyWithType:@"1"];
    }
    else
    {
        
        [self sendrequestToFollowCompanyWithType:@"2"];
    }
}

#pragma mark - 发送关注企业请求
- (void)sendrequestToFollowCompanyWithType:(NSString *)type
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
                             @"company_id" : self.company_id,
                             @"type" : type
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([baseModel.result isEqualToString:@"0"]) {
            if ([type isEqualToString:@"1"]) {
                [self.alert createTip:@"关注失败!"];
            }
            else
            {
                [self.alert createTip:@"取消关注失败!"];
            }
            
            [self hidHud];
            return;
        }
        else
        {
            if ([type isEqualToString:@"2"])
            {
 
                [self.alert createTip:@"取消关注成功!"];
                [self.footerView.attentionButton setBackgroundColor:[WLTools stringToColor:@"#ff6f47"]];
                
            }
            else if ([type isEqualToString:@"1"])
            {
                [self.alert createTip:@"关注成功!"];
                [self.footerView.attentionButton setBackgroundColor:[WLTools stringToColor:@"#4791ff"]];
            }
            
        }
        
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

#pragma mark - 发送网络请求,请求企业数据
- (void)sendRequestToOrganizationDetailWith:(NSString *)company_id
{
    //请求Url
    NSString *urlStr = CompanyDetailUrl;
    //请求参数
    NSString *user_id = [WLUserTools getUserId];
    NSString *password = [WLUserTools getUserPassword];
    NSString *rsaPassword = [MyRSA encryptString:password publicKey:RSAKey];
    NSDictionary *params = @{
                             @"user_id" : user_id,
                             @"user_password" : rsaPassword,
                             @"company_id" : company_id
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
        
        self.detailModel = [WL_AddressBook_OrganizationDetail_Model mj_objectWithKeyValues:baseModel.data];
        self.companyApps = [WL_AddressBook_OrganizationDetail_Business_Model mj_objectArrayWithKeyValuesArray:self.detailModel.companyApp];
        for (WL_AddressBook_OrganizationDetail_Business_Model *appModel in self.companyApps) {
            [self.companyAppNames addObject:appModel.app_name];
        }
        
        self.topView.detailModel = self.detailModel;
        self.footerView.detailModel = self.detailModel;
        
        self.organizationDetailTableView.hidden = NO;

        [self.organizationDetailTableView reloadData];
 
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddressBook_OrganizationDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.row == 0)
    {
        cell.detailModel = self.detailModel;
    }
    else
    {
        cell.detailTwoModel = self.detailModel;
        cell.appNames = self.companyAppNames;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.detailModel.cellHeight;
}

- (void)dealloc
{
    [self.alert removeFromSuperview];
}

@end
