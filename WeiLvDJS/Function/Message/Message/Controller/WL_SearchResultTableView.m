//
//  WL_SearchResultTableView.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  消息首页搜索 -> 结果控制器

#import "WL_SearchResultTableView.h"

#import "SearchCusomHistory.h"

#import "WL_Friendlist_Model.h"

#import "WL_SearchFriend_Cell.h"

#import "WL_SearchResult_Cell.h"

#import "WL_LookMore_ViewController.h"

#import "WL_AddressBook_LinkManDetail_ViewController.h"

#import "WL_NoticeDetail_ViewController.h"
#import "WL_MessageList_Model.h"
#import "WL_TabBarController.h"
#import "WL_FundAccount_ViewController.h"
#import "WLScheduleListViewController.h"
#import "WL_Application_Driver_OrderList_ViewController.h"
#import "WL_Application_Driver_Trip_ViewController.h"
#import "WL_TradeRecord_ViewController.h"
#import "WLJumpToOrderDetailViewControllerTool.h"
#import "WL_Application_Driver_Jockey_ViewController.h"
#import "WL_Application_Driver_addCar_viewController.h"
#import "WLCarBookingChooseDriverController.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLCarBookingOrderDetailObject.h"
#import "WLCarBookingDriverObject.h"
#import "WLCarBookingOrderDetailController.h"

@interface WL_SearchResultTableView ()<UITableViewDelegate,UITableViewDataSource>

/**< 自定义历史记录横向流布局 */
@property(nonatomic,strong)SearchCusomHistory *searchCusomView;

/**< 保存搜索历史的数据源 */
@property(nonatomic,strong)NSMutableArray *searchResultArray;

/**< 没有数据时显示的View */
@property(nonatomic,strong)WL_NoData_View *noDataView;

@end

@implementation WL_SearchResultTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchCusomView];
    
    self.tableView.delegate =self;
    
    self.tableView.dataSource = self;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.noDataView];
    
}

//无数据提示
- (WL_NoData_View *)noDataView {
    
    if (_noDataView == nil) {
        
    _noDataView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) andRefreshBlock:^{
        
        }];;
    
    _noDataView.hidden = YES;
    }
    return _noDataView;
}

- (void)reloadDataWithArray:(NSMutableArray *)array
{
    self.searchResultArray = array;
    
    if (self.searchResultArray.count==0) {
        
        [self hideNoData:NO andType:WLNetworkTypeNOData];
        
    }else
    {
    
        self.noDataView.hidden=YES;
    }
   
    [self.tableView reloadData];
}

#pragma makr - 设置无数据提示的显示、隐藏及类型
- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
    
    self.noDataView.hidden = hidden;
    
    if (!hidden) {
        
        self.noDataView.type = type;
        
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

//    return self.searchResultArray.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  
//    NSMutableDictionary *dict =self.searchResultArray[section];
//    
//    NSArray *array =[dict allKeys];
//    
//    NSArray *arr = [dict objectForKey:array[0]];
//    
//    if (arr.count>3) {
//        
//        return 3;
//    }else
//        
//    
//    return arr.count;
//    if (self.searchResultArray.count > 3) {
//        
//        return 3;
//    }
     return self.searchResultArray.count;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
////    
////    NSMutableDictionary *dict = self.searchResultArray[section];
////    
////    NSArray *array =[dict allKeys];
////    
////    NSArray *arr = [dict objectForKey:array[0]];
////    
////    if (arr.count>3) {
////        
////        return 40;
////    }
////    
////    return 0.01;
//    if (self.searchResultArray.count > 3) {
//        
//        return ScaleH(40);
//    }
//    return 0.01;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if(self.searchResultArray.count > 3)
//    {
//        UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//        
//        v.backgroundColor = BgViewColor;
//        
//        v.userInteractionEnabled = YES;
//        
//        UILabel *tapLabel =[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-125)/2, 0,100, 40)];
//        
//        tapLabel.userInteractionEnabled = YES;
//        
//        tapLabel.textColor = [WLTools stringToColor:@"#4877e7"];
//        
//        tapLabel.font =WLFontSize(16);
//        
//        tapLabel.textAlignment =NSTextAlignmentCenter;
//        tapLabel.text = @"查看更多消息";
//        tapLabel.tag = 102;
//        [v addSubview:tapLabel];
//        UIImageView *imView =[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(tapLabel)+10, (40-15)/2, 7, 15)];
//        
//        imView.image = [UIImage imageNamed:@"arrow"];
//        
//        [v addSubview:imView];
//        
//        UIGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Gesture:)];
//        
//        [tapLabel addGestureRecognizer:tapGesture];
//        
//        return v;
//    }

//    NSMutableDictionary *dict =self.searchResultArray[section];
//    
//    NSArray *array =[dict allKeys];
//    
//    NSArray *arr = [dict objectForKey:array[0]];
//    
//    if (arr.count>3)
//    {
//        UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//        
//        v.backgroundColor = BgViewColor;
//        
//        v.userInteractionEnabled = YES;
//        
//        UILabel *tapLabel =[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-125)/2, 0,100, 40)];
//        
//        tapLabel.userInteractionEnabled = YES;
//        
//        tapLabel.textColor = [WLTools stringToColor:@"#4877e7"];
//        
//        tapLabel.font =WLFontSize(16);
// 
//        tapLabel.textAlignment =NSTextAlignmentCenter;
//        
//        if ([array[0] isEqualToString:@"微叮好友"]) {
//         
//            tapLabel.text = @"查看更多好友";
//            
//            tapLabel.tag = 101;
//            
//        }else if ([array[0] isEqualToString:@"私信"])
//        {
//            tapLabel.text = @"查看更多消息";
//            
//            tapLabel.tag = 102;
//            
//        }else if ([array[0] isEqualToString:@"公告"])
//        {
//            tapLabel.text = @"查看更多私信";
//            
//            tapLabel.tag =103;
//            
//        }else if ([array[0] isEqualToString:@"消息"])
//        {
//            tapLabel.text = @"查看更多提醒";
//            
//            tapLabel.tag =104;
//        }
//        [v addSubview:tapLabel];
//        
//        UIImageView *imView =[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(tapLabel)+10, (40-15)/2, 7, 15)];
//        
//        imView.image = [UIImage imageNamed:@"arrow"];
//        
//        [v addSubview:imView];
//        
//        UIGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Gesture:)];
//        
//        [tapLabel addGestureRecognizer:tapGesture];
//        
//        return v;
//    }

//    UIView *v =[UIView new];
//    
//    return v;
//   
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    
    sectionView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [WLTools allocLabel:@"" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake(15, 0, ScreenWidth-15, 45) textAlignment:NSTextAlignmentLeft];
    
//    NSMutableDictionary *dict =self.searchResultArray[section];
//    
//    NSArray *array =[dict allKeys];
//
//    label.text = array[0];
    label.text = @"消息";
    [sectionView addSubview:label];
    
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(10, 44.5, ScreenWidth-10, 0.5)];
    
    line.backgroundColor = bordColor;
    
    [sectionView addSubview:line];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    NSMutableDictionary *dict =self.searchResultArray[indexPath.section];
//    
//    NSArray *array =[dict allKeys];
//    
//    if ([array[0] isEqualToString:@"微叮好友"]) {
//        
//    }

    static NSString *reuseIdentifier1 = @"reuseIdentifier1";
        
    WL_SearchFriend_Cell *cell =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
        
    if (cell== nil) {
        
      cell =[[WL_SearchFriend_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier1];
    }
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//    NSMutableArray *arr = [dict objectForKey:array[0]];

//    WL_Friendlist_Model *model = self.searchResultArray[indexPath.row];
    WL_MessageList_itemsModel *model = self.searchResultArray[indexPath.row];
    
    cell.model = model;

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_MessageList_itemsModel *model = self.searchResultArray[indexPath.row];
    
    //导游
    if ([model.role_type integerValue]==1)
    {
        //接单提醒  跳转接单列表
        if([model.msg_type integerValue]==1) {
            
            //身份变动提醒 跳转应用首页
        }else if ([model.msg_type integerValue]==2){
            
            WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
            
            [ShareApplicationDelegate window].rootViewController = tabBar;
            
            //            UINavigationController *nav = tabBar.viewControllers[1];
            
            //            WL_ApplicationViewController *VC = (WL_ApplicationViewController*)nav.childViewControllers[0];
            
            //            VC.company_id = @"2";
            tabBar.selectedIndex =1;
            //资金变动提醒  跳转自己账户
        }else if ([model.msg_type integerValue]==3){
            
            WL_FundAccount_ViewController *VC = [[WL_FundAccount_ViewController alloc]init];
            
            [self.presentingViewController.navigationController pushViewController:VC animated:YES];
            //出团提醒 跳转到有日历行程 并选中 出团日期
        }else if ([model.msg_type integerValue]==4)
        {
            
            WLScheduleListViewController *VC =[[WLScheduleListViewController alloc]init];
            
            VC.hidesBottomBarWhenPushed = YES;
            
            NSDateFormatter *fotmatter =[[NSDateFormatter alloc]init];
            
            [fotmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *date =[fotmatter dateFromString:model.created_at];
            
            VC.someDate = date;
            
            [self.presentingViewController.navigationController pushViewController:VC animated:YES];
            
            //预付款提醒
        }else if ([model.msg_type integerValue]==5)
        {
            
            //备用金提醒 跳转订单详情
        }else if ([model.msg_type integerValue]==6)
        {
            
        }
        
        //司机 
    }else if ([model.role_type integerValue]==2)
    {
        switch ([model.msg_type integerValue]) {
            case 1:
            case 2:
            {
                [KJumpTool jumpToDriveOrderDetailViewControllerWithOrderID:model.relation_id andNaVC:self.presentingViewController.navigationController];
                break;
            }
            case 3:
            {
                WL_Application_Driver_Trip_ViewController *VC =[[WL_Application_Driver_Trip_ViewController alloc]init];
                
                VC.hidesBottomBarWhenPushed = YES;
                
                NSDateFormatter *fotmatter =[[NSDateFormatter alloc]init];
                
                [fotmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                NSDate *date =[fotmatter dateFromString:model.created_at];
                
                VC.someDate = date;
                
                [self.presentingViewController.navigationController pushViewController:VC animated:YES];
            }
            case 4:
                break;
            case 5:
            case 6://司机身份认证消息
            {
                if ([model.from_company_id integerValue]<= 0 || model.from_company_id == nil) {
                    [[WL_TipAlert_View sharedAlert] createTip:@"该消息已过期,请刷新页面"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] requestDriverAndCarStatusWithCompanyID:model.from_company_id AndResultBlock:^(BOOL success, WLDriverStatus driverStatus, WLCarStatus carStatus,NSNumber *drive_id, NSString *cityString) {
                    if (success) {
                        WL_Application_Driver_Jockey_ViewController *jockeyVc = [[WL_Application_Driver_Jockey_ViewController alloc] init];
                        jockeyVc.driverStatus = driverStatus;
                        jockeyVc.hidesBottomBarWhenPushed = YES;
                        jockeyVc.comPany_id = model.from_company_id;
                        
                        [self.presentingViewController.navigationController pushViewController:jockeyVc animated:YES];
                        
                    }else{
                        [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请稍后再试"];
                    }
                }];
                break;
            }
            case 7:
            {
                WL_TradeRecord_ViewController *VC =[[WL_TradeRecord_ViewController alloc]init];
                
                [self.presentingViewController.navigationController pushViewController:VC animated:YES];
                break;
            }
            case 8:
            case 9:
            case 10:
            case 11:
            case 18:
            {
                [KJumpTool jumpToDriveBookOrderDetailViewControllerWithOrderID:model.relation_id andNaVC:self.presentingViewController.navigationController];
                break;
            }
            case 12:
            case 13://车辆认证消息
            {
                if ([model.from_company_id integerValue]<= 0 || model.from_company_id == nil) {
                    [[WL_TipAlert_View sharedAlert] createTip:@"该消息已过期,请刷新页面"];
                    return;
                }
                [[WLNetworkDriverHandler sharedInstance] requestDriverAndCarStatusWithCompanyID:model.from_company_id AndResultBlock:^(BOOL success, WLDriverStatus driverStatus, WLCarStatus carStatus,NSNumber *drive_id, NSString *cityString) {
                    if (success) {
                        WL_Application_Driver_addCar_viewController *addCarVc = [[WL_Application_Driver_addCar_viewController alloc] init];
                        addCarVc.companyId = model.from_company_id;
                        addCarVc.carStatus = [NSString stringWithFormat:@"%ld",carStatus];
                        if([drive_id isKindOfClass:[NSNumber class]])
                        {
                            addCarVc.driveId  = [drive_id stringValue];
                        }else
                        {
                            addCarVc.driveId = (NSString *)drive_id;
                        }
                        
                        addCarVc.hidesBottomBarWhenPushed = YES;
                        [self.presentingViewController.navigationController pushViewController:addCarVc animated:YES];
                        
                    }else{
                        [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请稍后再试"];
                    }
                }];
                break;
            }
                
            default:
                break;
        }
        //酒店
    }else if ([model.role_type integerValue]==3)
    {
        
        //接单提醒
        if([model.msg_type integerValue]==1) {
            
            
            //身份认证提醒
        }else if ([model.msg_type integerValue]==2){
            
            WL_TabBarController *tabBar = [[WL_TabBarController alloc] init];
            
            [ShareApplicationDelegate window].rootViewController = tabBar;
            
            
            
            tabBar.selectedIndex =1;
            //资金变动提醒
        }else if ([model.msg_type integerValue]==3){
            
            WL_FundAccount_ViewController *VC = [[WL_FundAccount_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
            //出团提醒
        }else if ([model.msg_type integerValue]==4)
        {
            
            //预付款提醒
        }else if ([model.msg_type integerValue]==5)
        {
            //备用金提醒
        }else if ([model.msg_type integerValue]==6)
        {
            
        }
    }else if ([model.role_type integerValue]==6)
    {
        [self isUptime:model.relation_id];
    }
    
}

- (void)isUptime:(NSString *)thisId;
{
    [WLNetworkCarBookingHandler requestOrderDetailWithOrderID:thisId dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            WLCarBookingOrderDetailObject * object = data;
            
            WLCarBookingDriverObject *oobject = [[WLCarBookingDriverObject alloc] init];
            if (object.order_bid_list.count != 0) {
                oobject = object.order_bid_list[0];
            }
            
            NSInteger bitstatus = [oobject.bid_status integerValue];
            if (bitstatus == 1) {
                WLCarBookingChooseDriverController *detailVC = [[WLCarBookingChooseDriverController alloc] init];
                detailVC.orderID = thisId;
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.presentingViewController.navigationController pushViewController:detailVC animated:YES];
            }
            else
            {
                WLCarBookingOrderDetailController *detailVC = [[WLCarBookingOrderDetailController alloc] init];
                detailVC.orderID = thisId;
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.presentingViewController.navigationController pushViewController:detailVC animated:YES];
            }
            
            
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:message];
            
        }
    }];
}

//    NSMutableDictionary *dict =self.searchResultArray[indexPath.section];
//    
//    NSArray *array =[dict allKeys];
//    
//    if ([array[0] isEqualToString:@"微叮好友"]) {
//      
//        NSMutableArray *arr = [dict objectForKey:array[0]];
//        
//        WL_Friendlist_Model *model = arr[indexPath.row];
//        
//        [WLDataManager saveMainMessageSearchWithData:model.name];
//        
//        /**< 跳转到联系人详情控制器 */
//        WL_AddressBook_LinkManDetail_ViewController *VC =[[WL_AddressBook_LinkManDetail_ViewController alloc]init];
//        
//        VC.view_id = model.ID;
//        
//        VC.isCompany = model.isCompany;
//        
//        VC.hidesBottomBarWhenPushed = YES;
//        
//        [self.presentingViewController.navigationController pushViewController:VC animated:YES];
//    
//    }else if ([array[0] isEqualToString:@"公告"])
//    {
//        /**< 跳转到公告控制器 */
//        WL_NoticeDetail_ViewController *VC =[[WL_NoticeDetail_ViewController alloc]init];
//        
//         NSMutableArray *arr = [dict objectForKey:array[0]];
//        
//        WL_Friendlist_Model *model = arr[indexPath.row];
//        
//        VC.hidesBottomBarWhenPushed = YES;
//        
//        VC.typeOfPush = 1;
//        
//        VC.notice_id = model.ID;
//        
//        [self.presentingViewController.navigationController pushViewController:VC animated:YES];
//    }


-(void)Gesture:(UIGestureRecognizer *)tap
{
    
    
    
    NSString *type =@"";
    
    if ([tap view].tag ==101) {
        
      type = @"1";
        
    }else if ([tap view].tag ==102)
    {
        type = @"2";
        
    }else if ([tap view].tag ==103)
    {
        type = @"3";
    }else if ([tap view].tag ==104)
    {
        type = @"4";
    }
    
    /**< 查看更多控制器 */
    WL_LookMore_ViewController *VC =[[WL_LookMore_ViewController alloc]init];
    
    WS(weakSelf);
    
    VC.popBlock  = ^(NSString *text){
      
        if (weakSelf.popSearchTextBlock) {
            
           
            weakSelf.popSearchTextBlock(text);
        }
        
    };
    
    VC.searchText = self.searchText;
    
    VC.searchType = type;
    
    VC.hidesBottomBarWhenPushed =YES;

    [self.presentingViewController.navigationController pushViewController:VC animated:YES];

}


@end
