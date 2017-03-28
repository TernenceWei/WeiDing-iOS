//
//  WL_AddressBook_Organization_Structure_ViewController.m
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  组织架构主控制器

#import "WL_AddressBook_Organization_Structure_ViewController.h"
#import "WL_AddressBook_LinkManDetail_ViewController.h"
#import "WL_AddressBook_Organization_Search_ViewController.h"
#import "WL_AddressBook_Search_View.h"
#import "WL_AddressBook_Organization_Department_Cell.h"
#import "WL_AddressBook_Organization_Staff_Cell.h"
#import "WL_AddressBook_Organization_TitleScrollView.h"
#import "WL_AddressBook_OrganizationStructure_Model.h"
#import "WL_AddressBook_Organization_Department_Model.h"
#import "WL_AddressBook_Organization_Staff_Model.h"
#import "WL_AddressBook_Organization_Title_Model.h"
#import "WLNetworkAddressBookHandler.h"

static NSString *const departmentCellId = @"departmentCellId";
static NSString *const staffCellId = @"staffCellId";

@interface WL_AddressBook_Organization_Structure_ViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 下级部门模型数组 */
@property(nonatomic, strong) NSMutableArray *departments;
/** 员工模型数组 */
@property(nonatomic, strong) NSMutableArray *staffs;
/** 上级部门模型数组 */
@property(nonatomic, strong) NSMutableArray *supDepartments;
/** 内容TableView */
@property(nonatomic, weak) UITableView *organizationStructureTableView;
/** 头部搜索框 */
@property(nonatomic, strong) WL_AddressBook_Search_View *searchView;
//网络请求时用到的提示弹框
@property(nonatomic, strong)WL_TipAlert_View *alert;
/** 无网络的View */
@property(nonatomic, strong)WL_NoData_View *noDataView;

@property (nonatomic, strong) WL_AddressBook_Organization_TitleScrollView *titleView;

@end

@implementation WL_AddressBook_Organization_Structure_ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupSearchView];
    [self sendRequestToGetMyselfPosition];

}

#pragma mark - 右上角自己按钮点击事件
- (void)NavigationRightEvent
{
    if (self.organizationStructureTableView) {
        [self.organizationStructureTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_left);
        }];
//        [self.view setNeedsUpdateConstraints];
//        [self.view updateConstraintsIfNeeded];
        
        //更新LoginView的约束
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            [self.organizationStructureTableView removeFromSuperview];
            
     /**< 解决点击后后面会闪一下的bug */
//            [self creatTableViewToOrganizationStructure];
            [self sendRequestToOrganizationStructureWithDepartMentId:self.department_id];
            [self sendRequestToGetMyselfPosition];
        }];

    }
}

#pragma mark - UI
- (void)setupNavigationBar
{
    self.title = self.company_name;
    self.view.backgroundColor = [WLTools stringToColor:@"#d8d9dd"];
    self.alert = [WL_TipAlert_View sharedAlert];
    
    [self setNavigationRightTitle:@"自己" fontSize:16 titleColor:Color2 isEnable:YES];
}

- (void)setupSearchView
{
    WS(weakSelf);
    self.searchView = [[WL_AddressBook_Search_View alloc] initWithSearchPlaceholder:@"找人"
                                                                    backgroundColor:[UIColor whiteColor]
                                                                              frame:CGRectMake(0, 0, ScreenWidth, 44)
                                                                        clickAction:^{
                                                                            
                                                                            WL_AddressBook_Organization_Search_ViewController *searchVc = [[WL_AddressBook_Organization_Search_ViewController alloc] init];
                                                                            searchVc.company_id = weakSelf.company_id;
                                                                            [weakSelf.navigationController pushViewController:searchVc animated:YES];
                                                                        }];
    
    
    [self.view addSubview:self.searchView];
    
}

- (void)setupTableView
{
    //3.设置tableView
    UITableView *organizationStructureTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //2添加到父控件
    [self.view addSubview:organizationStructureTableView];
    //3,添加约束
    [organizationStructureTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.searchView.mas_bottom).offset(45.5);
    }];
    [organizationStructureTableView registerClass:[WL_AddressBook_Organization_Department_Cell class] forCellReuseIdentifier:departmentCellId];
    [organizationStructureTableView registerClass:[WL_AddressBook_Organization_Staff_Cell class] forCellReuseIdentifier:staffCellId];
    
    self.organizationStructureTableView = organizationStructureTableView;
    organizationStructureTableView.delegate = self;
    organizationStructureTableView.dataSource = self;
    organizationStructureTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    organizationStructureTableView.hidden = YES;
    organizationStructureTableView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
}

- (void)setupTitleView
{
    if (!self.titleView) {
        WS(weakSelf);
        WL_AddressBook_Organization_TitleScrollView *titleView = [[WL_AddressBook_Organization_TitleScrollView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, ScreenWidth, 45) companyName:self.company_name dataArray:self.supDepartments selectAction:^(NSString *departID, NSArray *newArray) {
            
            weakSelf.supDepartments = [newArray mutableCopy];
            [weakSelf.organizationStructureTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.view.mas_left);
            }];
            [weakSelf.view setNeedsUpdateConstraints];
            [weakSelf.view updateConstraintsIfNeeded];
            //更新LoginView的约束
            [UIView animateWithDuration:0.25 animations:^{
                [weakSelf.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [weakSelf.organizationStructureTableView removeFromSuperview];
                [weakSelf setupTableView];
                [weakSelf sendRequestToOrganizationStructureWithDepartMentId:departID];
            }];
        }];
        [self.view addSubview:titleView];
        self.titleView = titleView;
    }
    
    
}

- (void)removeTitleView
{
    if (self.titleView) {
        [self.titleView removeFromSuperview];
        self.titleView = nil;
    }
}

#pragma mark - Network
- (void)sendRequestToOrganizationStructureWithDepartMentId:(NSString *)departmentId
{
    if (departmentId == nil) {
        departmentId = @"0";
    }
    [self showHud];
    [WLNetworkAddressBookHandler requestOrganizationStructureWithCompanyID:self.company_id
                                                              departmentID:departmentId
                                                                      type:@"1"
                                                                 dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                                     
                                                                     [self hidHud];
                                                                     if (responseType == WLResponseTypeSuccess && data) {
                                                                         
                                                                         self.noDataView.hidden = YES;
                                                                         WL_AddressBook_OrganizationStructure_Model *organizationStructureModel = data;
                                                                         if (self.departments) {
                                                                             [self.departments removeAllObjects];
                                                                         }
                                                                         self.departments = [WL_AddressBook_Organization_Department_Model mj_objectArrayWithKeyValuesArray:organizationStructureModel.department_list];
                                                                         if (self.staffs) {
                                                                             [self.staffs removeAllObjects];
                                                                         }
                                                                         self.staffs = [WL_AddressBook_Organization_Staff_Model mj_objectArrayWithKeyValuesArray:organizationStructureModel.staff_list];
                                                                         if (self.staffs.count == 0 && self.departments.count == 0) {
                                                                             [self.alert createTip:@"当前组织下暂无员工"];
                                                                             self.organizationStructureTableView.hidden = YES;
                                                                             [self hideNoData:NO andType:WLNetworkTypeNOData];
                                                                             return;
                                                                         }
                                                                         
                                                                         self.organizationStructureTableView.hidden = NO;
                                                                         [self.organizationStructureTableView reloadData];
                                                                         

                                                                     }else{
                                                                         
                                                                         [self setNavigationRightTitle:@"" fontSize:16 titleColor:[WLTools stringToColor:@"#ffffff"] isEnable:NO];
                                                                         [self.alert createTip:message];
                                                                         if (responseType == WLResponseTypeNoNetwork){
                                                                             [self hideNoData:NO andType:WLNetworkTypeNONetWork];
                                                                         }else{
                                                                             [self hideNoData:NO andType:WLNetworkTypeSeverError];
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     
                                                                 }];
    
}

- (void)sendRequestToGetMyselfPosition
{

    [self showHud];
    [WLNetworkAddressBookHandler requestMyPositionWithCompanyID:self.company_id dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        [self hidHud];
        if (responseType == WLResponseTypeSuccess && data) {
            
            self.noDataView.hidden = YES;
//            self.supDepartments = [(NSArray *)data mutableCopy];
            [self setupTitleView];
            [self setupTableView];
            [self sendRequestToOrganizationStructureWithDepartMentId:self.department_id];
            
        }else{
            
            [self setNavigationRightTitle:@"" fontSize:16 titleColor:Color2 isEnable:NO];
            [self.alert createTip:message];
            if (responseType == WLResponseTypeNoNetwork){
                [self hideNoData:NO andType:WLNetworkTypeNONetWork];
            }else{
                [self hideNoData:NO andType:WLNetworkTypeSeverError];
            }
        }
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.departments.count;
    }else{
        return self.staffs.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        WL_AddressBook_Organization_Department_Cell *cell = [tableView dequeueReusableCellWithIdentifier:departmentCellId];
        cell.departmentModel = self.departments[indexPath.row];
        cell.lineView.hidden = indexPath.row == self.departments.count - 1 ? YES : NO;
        return cell;
    }else{
        WL_AddressBook_Organization_Staff_Cell *cell = [tableView dequeueReusableCellWithIdentifier:staffCellId];
        cell.staffModel = self.staffs[indexPath.row];
        cell.lineView.hidden = indexPath.row == self.staffs.count - 1 ? YES : NO;
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 14.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44.0;
    }else{
        return 57.5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 14)];
    footerView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        WL_AddressBook_Organization_Department_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_left);
        }];
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        //更新LoginView的约束
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            [tableView removeFromSuperview];
            [self setupTableView];
            [self sendRequestToOrganizationStructureWithDepartMentId:cell.departmentModel.department_id];
        }];
        
        
        [self.supDepartments addObject:cell.departmentModel];
        [self removeTitleView];
        [self setupTitleView];
        
    }else if (indexPath.section == 1){
        
        WL_AddressBook_Organization_Staff_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
        WL_AddressBook_LinkManDetail_ViewController * linkManDetailVc = [[WL_AddressBook_LinkManDetail_ViewController alloc] init];
        linkManDetailVc.view_id = cell.staffModel.user_id;
        linkManDetailVc.isCompany = @"1";
        linkManDetailVc.addressBook = @"2";
        [self.navigationController pushViewController:linkManDetailVc animated:YES];
        
    }
}

#pragma mark - lazy load
- (NSMutableArray *)supDepartments
{
    if (!_supDepartments)
    {
        _supDepartments = [NSMutableArray array];
    }
    return _supDepartments;
}

- (NSMutableArray *)departments
{
    if (!_departments) {
        _departments = [NSMutableArray array];
    }
    return _departments;
}

- (NSMutableArray *)staffs
{
    if (!_staffs) {
        _staffs = [NSMutableArray array];
    }
    return _staffs;
}

#pragma mark - 设置无数据提示的显示、隐藏及类型
- (WL_NoData_View *)noDataView
{
    if (_noDataView == nil) {
        WS(weakSelf);
        _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, ScreenHeight - 44) andRefreshBlock:^{
        }];
        [weakSelf.view addSubview:_noDataView];
        _noDataView.hidden = YES;
    }
    return _noDataView;
}

- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    if (!hidden) {
        self.noDataView.type = type;
    }
}

- (void)dealloc
{
    [self.alert removeFromSuperview];
}
@end
