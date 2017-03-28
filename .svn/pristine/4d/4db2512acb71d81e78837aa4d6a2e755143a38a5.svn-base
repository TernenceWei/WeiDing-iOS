//
//  WL_ApplicationViewController.m
//  WeiLvDJS
//
//  Created by jyc on 16/8/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_ApplicationViewController.h"
//导入应用模块Nav上的标题View
#import "WL_Application_Title_View.h"
//内容TableView的cell
#import "WL_Applicaton_Main_Content_Cell.h"

#import "WL_Application_Content_Title_View.h"

#import "WL_Application_Content_OtherTitle_View.h"

#import "WL_Application_Content_Footer_View.h"
/** 公司列表cell */
#import "WL_organizationList_Cell.h"
#import "WLNetworkAccountHandler.h"
#import "CycleScrollView.h"
#pragma mark - 导入司机应用下的控制器
/** 接单控制器 */
#import "WL_Application_Driver_OrderList_ViewController.h"
/** 我的行程控制器 */
#import "WL_Application_Driver_Trip_ViewController.h"

/** 司机控制器 */
#import "WL_Application_Driver_Jockey_ViewController.h"


#import "WL_NoticeDetail_ViewController.h"

/** 公司模型 */
#import "WL_Copmany_Model.h"
/** 所在部门 */
#import "WL_Depratment_Model.h"
/** 组织架构 */
#import "WL_Rganization_Model.h"
/** 角色数组 */
#import "WL_Application_Role_Model.h"
/** 司机认证状态 */
#import "WL_Driver_CertificationStatus_Model.h"
/** 导游认证状态模型 */
#import "WL_Guider_CertificationStatus_Model.h"
/** 轮播图模型 */
#import "WL_CompanyBanner_Model.h"
/** 车辆控制器 */
#import "WL_Application_Driver_addCar_viewController.h"

#import "WLCurrentGroupController.h"
#import "WLTouristIncomeController.h"
#import "STPickerCity.h"
/** 导游信息控制器 */
#import "WL_Application_TourGuide_info_ViewController.h"
/** 导游接单控制器 */
#import "WLGuideOrderListViewController.h"
#import "WL_Application_Driver_Bill_ViewController.h"

#import "WLScheduleListViewController.h"
#import "WLBillListViewController.h"
#import "WLReceiveListViewController.h"

#import "WLNetworkManager.h"
#import "WLDriverReceiptController.h"
#import "WLApplicationScanViewController.h"
#import "WLStoreViewController.h"
#import "TOWebViewController.h"
#import "WLApplicationNODataView.h"
#import "WLCarBookingViewController.h"
#import "WLCarBookingOrderListViewController.h" // 叫车订单

#import "WLBaiduMapViewController.h"  //地图
#import "WLApplicationNavButton.h"
//#import <CoreLocation/CoreLocation.h>

@interface WL_ApplicationViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, EScrollerViewDelegate,STPickerCityDelegate,CLLocationManagerDelegate>
/** 选择公司/组织的下拉列表 */
@property(nonatomic, weak)UITableView *organizationListTableView;
/** 内容顶部的TitleView */
@property(nonatomic, weak) WL_Application_Content_Title_View *titleView;
/** 内容CollectionView */
@property(nonatomic, weak)UICollectionView *contentCollectionView;
/** 所属公司id数组 */
@property(nonatomic, strong) NSMutableArray *company_ids;
///** 当前所选公司id */
//@property(nonatomic, strong) NSString *company_id;
/**  司机应用标题数组 */
@property(nonatomic, strong)NSArray *motorcadeArr;
/**  司机应用图片数组 */
@property(nonatomic, strong)NSArray *motorcadeImageArr;
/**  导游应用标题数组 */
@property(nonatomic, strong)NSArray *guideArr;
/**  导游应用图片数组 */
@property(nonatomic, strong)NSArray *guideImageArr;
/**  酒店应用标题数组 */
@property(nonatomic, strong)NSArray *hotelArr;
/**  导游应用图片数组 */
@property(nonatomic, strong)NSArray *hotelImageArr;
/**< 核销应用标题数组 */
@property (nonatomic, strong) NSArray *checkArr;
/**< 核销应用图片数组 */
@property (nonatomic, strong) NSArray *checkImageArr;
/**< 店铺应用标题数组 */
@property (nonatomic, strong) NSArray *storeArr;
/**< 店铺应用图片数组 */
@property (nonatomic, strong) NSArray *storeImageArr;
/**< 叫车应用标题数组 */
@property (nonatomic, strong) NSArray *bookCarPersonArr;
/**< 叫车应用标题数组 */
@property (nonatomic, strong) NSArray *bookCarCompanyArr;
/**< 店铺应用图片数组 */
@property (nonatomic, strong) NSArray *bookCarImageArr;


/** 公司模型数组 */
@property(nonatomic, strong)NSMutableArray <WL_Copmany_Model *>*companys;
/** 公司名称数组 */
@property(nonatomic, strong)NSMutableArray *companyNames;

/** 轮播图模型数组 */
@property(nonatomic, strong) NSMutableArray *banners;
/** 轮播器图片数组 */
@property(nonatomic, strong) NSMutableArray *bannerImages;

/** 下拉列表后覆盖的背景View */
@property(nonatomic, weak)UIView *coverView;
/** 弹框View */
@property(nonatomic, strong)WL_TipAlert_View *alert;
/** 用户的所有角色数组 */
@property(nonatomic, strong) NSMutableArray *roles;
/** 用户的当前公司所有角色数组 */
@property(nonatomic, strong) NSMutableArray *contentRoles;

@property (nonatomic, strong) CLLocationManager* locationManager; // 定位


/** 司机认证状态模型 */
@property(nonatomic, strong) WL_Driver_CertificationStatus_Model *certificationStatus;
/** 导游认证状态模型 */
@property(nonatomic, strong) WL_Guider_CertificationStatus_Model *GuiderStatusModel;

@property(nonatomic, strong) WL_NoData_View *netWrongView;

//没有加入任何组织的imageView
@property(nonatomic, weak) UIImageView *homePageNoDataImage;
//没有角色的imageView
@property(nonatomic, weak) UIImageView *noRoleImage;

@property(nonatomic, weak) UIWindow *myWindow;

/** 导游所选公司id */
@property(nonatomic, strong) NSString *user_company_id;

//司机认证状态
@property(nonatomic,assign)WLDriverStatus driverStatus;
//车辆认证状态
@property(nonatomic,assign)WLCarStatus carStaus;
/**< 司机ID */
@property (nonatomic, copy) NSString *driver_id;
@property (nonatomic, strong) NSString *storeUrl;
/**< 当前所选公司的模型 */
@property (nonatomic, strong) WL_Copmany_Model *currentCompanyModel;
/**< 选择城市的按钮 */
@property (nonatomic, strong) UIButton *selectCityButton;

@property (nonatomic, strong) WLApplicationNODataView *noDataView;
/**< 保存所有城市的数组 */
@property (nonatomic, copy)  NSArray *cityArray;


@property (nonatomic, strong) WLApplicationNavButton *navBtn;
@end
//(公司/组织下拉框cell的高度)
static  CGFloat const organizationListCellHeight = 48.0f;
//(内容标题View的高度)
static  CGFloat const ContentTitleViewHeight = 40.0f;

@implementation WL_ApplicationViewController

#pragma mark - lazy
- (void)setUser_company_id:(NSString *)user_company_id
{
    _user_company_id = user_company_id;
    [WLKeychainTool saveKeychainValue:_user_company_id key:@"currentCompanyID"];
}

- (void)setCompany_id:(NSString *)company_id
{
    _company_id = company_id;
    [WLKeychainTool saveKeychainValue:_company_id key:@"CompanyID"];
}

//轮播图模型数组
- (NSMutableArray *)banners
{
    if (!_banners) {
        _banners = [NSMutableArray array];
    }
    return _banners;
}

//轮播器图片数组
- (NSMutableArray *)bannerImages
{
    if (!_bannerImages) {
        _bannerImages = [NSMutableArray array];
    }
    return _bannerImages;
}

//用户当前公司所有角色数组
- (NSMutableArray *)contentRoles
{
    if (!_contentRoles) {
        _contentRoles = [NSMutableArray array];
    }
    return _contentRoles;
}

//酒店数组
- (NSArray *)hotelArr
{
    if (!_hotelArr) {
        _hotelArr = [NSMutableArray array];
    }
    return _hotelArr;
}
//酒店图片数组
- (NSArray *)hotelImageArr
{
    if (!_hotelImageArr) {
        _hotelImageArr = [NSMutableArray array];
    }
    return _hotelImageArr;
}

- (WLApplicationNODataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[WLApplicationNODataView alloc]init];
        [self.view addSubview:_noDataView];
        [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(self.view.mas_top).offset(-64);
            make.bottom.equalTo(self.view.mas_bottom).offset(49);
        }];
        _noDataView.hidden = YES;
    }
    return _noDataView;
}


//所属公司id数组
- (NSMutableArray *)company_ids
{
    if (!_company_ids) {
        _company_ids = [NSMutableArray array];
    }
    return _company_ids;
}

//角色数组
- (NSMutableArray *)roles
{
    if (!_roles) {
        _roles = [NSMutableArray array];
    }
    return _roles;
}
//公司数组
- (NSMutableArray *)companys
{
    if (!_companys)
    {
        _companys = [NSMutableArray array];
    }
    return _companys;
}

//公司名称数组
- (NSMutableArray *)companyNames
{
    if (!_companyNames)
    {
        _companyNames = [NSMutableArray array];
    }
    return _companyNames;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    self.company_id = [WLKeychainTool readKeychainValue:@"CompanyID"];
    [self.contentRoles removeAllObjects];
    //每次进入控制器,请求公司列表
    [self sendRequstToMyCompany];
//    if (self.companyNames) {
//        [self.companyNames removeAllObjects];
//        //每次进入控制器,请求公司列表
//        [self sendRequstToMyCompany];
//        //请求角色列表
//        //[self sendRequestToFollowMyCompanyRoles];
//    }
   
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hidHud];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置标题名称为空
    self.navigationItem.title = nil;
    //初始化应用数组
    [self setupArrayToApplication];
    //设置头部标题
    [self setupNavToApplication];
    //设置应用内容
    [self setupContentToApplication];
    //设置组织/公司列表
    [self setupOrganiztionListTableView];
//    [self.view addSubview:self.noDataView];
    
    self.noDataView.tipLabel.text = @"您尚未加入任何企业";
    self.noDataView.hidden = YES;
    //请求用户公司列表数据
    //    [self sendRequstToMyCompany];
    //注册弹框
    [self creatTipAlertView];
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        // 增加数据
        [self.contentCollectionView.mj_header  beginRefreshing];
        
        //网络请求
        [self sendRequstToMyCompany];
        [self.contentCollectionView.mj_header   endRefreshing];
        
    }];
    
    self.contentCollectionView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
}



#pragma mark - 注册弹框
- (void)creatTipAlertView
{
    self.alert = [WL_TipAlert_View sharedAlert];
}

#pragma mark - 请求用户公司列表数据
- (void)sendRequstToMyCompany
{
    
    //发送请求
    [self showHud];
    [[WLNetworkDriverHandler sharedInstance] requestCompanyListWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        [self hidHud];
        if (responseType == WLResponseTypeSuccess) {
            
            self.netWrongView.hidden = YES;
            self.companys = [data mutableCopy];
            if (self.companys.count == 0) {
                self.noDataView.tipLabel.text = @"您尚未加入任何企业";
                self.noDataView.hidden = NO;
                [self.navBtn setTitle:@"微叮" forState:UIControlStateNormal];
                self.navBtn.hidden = NO;
                [self hidHud];
                return;
                
            }
//            self.homePageNoDataImage.hidden = YES;
            self.organizationListTableView.frame = CGRectMake(0, 0, ScreenWidth, organizationListCellHeight *self.companys.count);
            //如果公司的ID为空说明是第一次进入
            if(!self.company_id||self.company_id.length <= 0)
            {
                 self.currentCompanyModel = [data objectAtIndex:0];
//                 self.company_id = self.currentCompanyModel.company_id;
            }else //取出模型中对应的公司
            {
            
                for ( WL_Copmany_Model *tempCompanyModel in data) {
                    if ([self.company_id isEqualToString:tempCompanyModel.company_id]) {
                        self.currentCompanyModel = tempCompanyModel;
                    }
                }
            }
            
            if (!self.currentCompanyModel) {//如果匹配不到,说明新换了公司,取公司模型的第一个数组
                self.currentCompanyModel = [data objectAtIndex:0];
                self.company_id = self.currentCompanyModel.company_id;
            }

            [self.navBtn setTitle:self.currentCompanyModel.company_name forState:UIControlStateNormal];
            

             [self hidHud];
        }else{
            
            [[WL_TipAlert_View sharedAlert] createTip:@"网络错误!"];
            self.noDataView.hidden = YES;
            self.netWrongView.hidden = NO;
            //隐藏菊花
            [self hidHud];
        }
    }];
    
}
- (void)setCurrentCompanyModel:(WL_Copmany_Model *)currentCompanyModel
{
    _currentCompanyModel = currentCompanyModel;
     self.company_id = currentCompanyModel.company_id;
    [self.contentRoles removeAllObjects];
    if (_currentCompanyModel.role.count > 0) {
        
        for (WL_Application_Role_Model *model in currentCompanyModel.role) {
            if ([model.type isEqualToString:@"100"]) {
                self.storeUrl = model.store_url;
                
            }
            if ([model.type isEqualToString:@"4"]||[model.type isEqualToString:@"1"]||[model.type isEqualToString:@"3"])
            {
            }else
            {
                [self.contentRoles addObject:model];
            }
        }
        self.noDataView.hidden = YES;
        self.navBtn.hidden = NO;
        //请求司机认证状态
        [self sendRequestToDriverStatue];
        //请求导游认证状态
        //        [self sendRequestToGuiderStatus];
        [self.organizationListTableView reloadData];
        [self.contentCollectionView reloadData];
    }else{ //没有角色 选择占位图
        
        self.noDataView.tipLabel.text = @"当前企业尚未给您分配角色";
        self.noDataView.hidden = NO;
    }
   
}
#pragma mark - 请求司机与车辆状态接口
- (void)sendRequestToDriverStatue
{
    if (self.companys.count <= 0 || self.companys == nil) {
        
        return;
    }
    
    [[WLNetworkDriverHandler sharedInstance] requestDriverAndCarStatusWithCompanyID:nil AndResultBlock:^(BOOL success, WLDriverStatus driverStatus, WLCarStatus carStatus,NSNumber *drive_id, NSString *cityString) {
        if (success) {
            self.driverStatus = driverStatus;
            self.carStaus = carStatus;
            //[self.selectCityButton setTitle:(cityString == nil||cityString.length==0)?@"北京市":cityString forState:UIControlStateNormal];
            // 判断定位
//            if (cityString == nil||cityString.length==0) {
//                if (self.driverStatus == 1&&self.carStaus == 1) {
//                    //显示
//                    [self setupBaiduMap];
//                }
//                else
//                {
//                    //不显示
//                }
//            }
//            else
//            {
//                [self.selectCityButton setTitle:cityString forState:UIControlStateNormal];
//            }
            
            if([drive_id isKindOfClass:[NSNumber class]])
            {
                self.driver_id = [drive_id stringValue];
            }else
            {
                self.driver_id = (NSString *)drive_id;
            }
//            self.selectCityButton.hidden = (self.driverStatus == 1&&self.carStaus == 1)?NO:YES;
            [self.organizationListTableView reloadData];
            [self.contentCollectionView reloadData];
        }
    }];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myWindow.mas_left);
        make.right.equalTo(self.myWindow.mas_right);
        make.top.equalTo(self.myWindow.mas_top).offset(64 + self.companys.count * organizationListCellHeight);
        make.bottom.equalTo(self.myWindow.mas_bottom);
    }];
    
    //请求轮播器图片
//    [self sendrequestToNoticeBanner:self.company_id];
    self.bannerImages = @[@"cycle1",@"cycle2",@"cycle3"].mutableCopy;
}

#pragma mark baiduMap
- (void)setupBaiduMap
{
    if([CLLocationManager locationServicesEnabled]){
        if(!_locationManager){
            self.locationManager = [[CLLocationManager alloc] init];
            if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                
                [self.locationManager requestWhenInUseAuthorization];
                //                [self.locationManager requestAlwaysAuthorization];
            }
            [self.locationManager setDelegate:self];
            [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            [self.locationManager setDistanceFilter:100];
            [self.locationManager startUpdatingLocation];
            [self.locationManager startUpdatingHeading];
        }
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@"您没有开启定位功能"
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    
}

// 定位
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [self.locationManager stopUpdatingLocation];
    CLLocation* location = locations.lastObject;
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error || placemarks.count == 0){
            NSLog(@"error = %@",error);
        }else{
            
            CLPlacemark* placemark = placemarks.firstObject;
            NSDictionary *dict = [placemark addressDictionary];
            NSString *city = [dict objectForKey:@"City"];
            if ([city hasSuffix:@"市"]) {
                city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            
            for (WLCityItem *provinceItem in _cityArray) {
                NSArray *cityArray = provinceItem.cityItems;
                for (WLCityItem *cityItem in cityArray) {
                    if ([cityItem.cityName isEqualToString:city]) {
                        
                        [[WLNetworkDriverHandler sharedInstance] updateDriveCityWith:self.company_id province:provinceItem.cityID city:cityItem.cityID resultBlock:^(WLResponseType responseType, NSInteger status, NSString *message) {
                            if (responseType == WLResponseTypeSuccess) {
                                //[[WL_TipAlert_View sharedAlert] createTip:@"更新城市成功"];
                                [self.selectCityButton setTitle:city forState:UIControlStateNormal];
                                [self.locationManager stopUpdatingLocation];
                            }else{
                                [[WL_TipAlert_View sharedAlert] createTip:@"更新城市定位失败"];
                                [self.selectCityButton setTitle:@"定位失败" forState:UIControlStateNormal];
                                [self.locationManager stopUpdatingLocation];
                            }
                        }];
                    }
                    else
                    {
                        [self.selectCityButton setTitle:@"定位失败" forState:UIControlStateNormal];
                        [self.locationManager stopUpdatingLocation];
                    }
                }
            }
        }
    }];
}

#pragma mark - 请求接口获取导游认证状态
- (void)sendRequestToGuiderStatus
{
    [WLNetworkManager requestTouristGuideAuthenticationStatusWithResult:^(BOOL success, TouristGuideOauthStatus status, long long count, NSString *message) {
        
        if (success) {
            self.GuiderStatusModel = [[WL_Guider_CertificationStatus_Model alloc] init];
            if (status == TouristGuideOauthStatusIning ) {
                self.GuiderStatusModel.status = @"1";
            }
            else if (status == TouristGuideOauthStatusAlready){
                self.GuiderStatusModel.status = @"2";
                self.GuiderStatusModel.count_order = [NSString stringWithFormat:@"%lld",count];
            }
            else if (status == TouristGuideOauthStatusFailure){
                self.GuiderStatusModel.status = @"3";
            }
            else
            {
                self.GuiderStatusModel.status = @"0";
            }
        }
        [self.contentCollectionView reloadData];
    }];
}

#pragma mark - 设置应用数组
- (void)setupArrayToApplication
{
    //车队应用标题数组
    //    NSArray *motorcadeArr = @[@"我的接单", @"我的日程", @"我的账单", @"司机", @"我的车辆"];
    NSArray *motorcadeArr = @[@"我的接单", @"我的账单", @"司机", @"我的车辆"];
    self.motorcadeArr = motorcadeArr;
    //车队应用标题图片数组
    //    NSArray *motorcadeImageArr = @[@"shouyejiedan", @"shouyechutuan", @"wdeshouru", @"siji", @"cheliang"];
    NSArray *motorcadeImageArr = @[@"shouyejiedan",@"wdeshouru", @"siji", @"cheliang"];
    self.motorcadeImageArr = motorcadeImageArr;
    //导游应用标题数组
    NSArray *guideArr = @[@"接单", @"出团", @"我的日程", @"导游", @"我的收入"];
    self.guideArr = guideArr;
    //导游应用标题图片数组
    NSArray *guideImageArr = @[@"Driver_01", @"daoyou_01", @"Driver_02", @"daoyou_03", @"daoyou_04"];
    self.guideImageArr = guideImageArr;
    
    //酒店应用标题数组
    NSArray *hotelArr = @[@"接单", @"账单"];
    self.hotelArr = hotelArr;
    //酒店应用标题图片数组
    NSArray *hotelImageArr = @[@"Driver_01", @"Driver_03"];
    self.hotelImageArr = hotelImageArr;
    
    //核销应用标题数组
    self.checkArr = @[@"核销"];
    self.checkImageArr = @[@"Cancel-after-verification"];
    
    //店铺应用标题数组
    self.storeArr = @[@"店铺"];
    self.storeImageArr = @[@"shop"];
    
    //叫车应用标题数组
    self.bookCarPersonArr = @[ @"个人叫车",@"个人叫车订单" ];
    self.bookCarCompanyArr = @[ @"企业叫车",@"企业叫车订单" ];
    self.bookCarImageArr = @[@"jiaoche",@"jiaochedingdan"];
    
    //获取城市数据
    WS(weakSelf);
    [WLNetworkAccountHandler requestCityListWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
      
        if (responseType == WLResponseTypeSuccess) {
            weakSelf.cityArray = data;
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:@"获取城市数据错误"];
        }
    }];
    
    
}

#pragma mark - 设置应用内容
static NSString *const contentCellId = @"cellIdToApplicationContent";
//第0组的HeaderView的标记
static NSString *const contentHeaderId = @"headerIdToApplicationContent";
//其余组的HeaderView的标记
static NSString *const contentOtherHeaderId = @"otherHeaderIdToApplicationContent";
//第0组的FooterView的标记
static NSString *const contentFooterId = @"footerIdToApplicationContent";
//其余组的FooterView的标记
static NSString *const contentOtherFooterId = @"otherFooterIdToApplicationContent";
- (void)setupContentToApplication
{
    self.driverStatus= -2;
    self.carStaus = -2;
    //添加一个内容CollectionView
    //设置collectionView的流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //初始化
    UICollectionView *contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    //添加到父控件
    [self.view addSubview:contentCollectionView];
    
    flowLayout.minimumLineSpacing = 1.5;
    flowLayout.minimumInteritemSpacing = 0;
    //设置属性
    //    contentCollectionView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    contentCollectionView.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    contentCollectionView.showsVerticalScrollIndicator = NO;
    contentCollectionView.alwaysBounceVertical = YES;
    //添加约束
    [contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    //    contentCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 20, 1);
    //设置代理与数据源
    contentCollectionView.delegate = self;
    contentCollectionView.dataSource = self;
    //注册item
    [contentCollectionView registerClass:[WL_Applicaton_Main_Content_Cell class] forCellWithReuseIdentifier:contentCellId];
    //注册第0组的header
    [contentCollectionView registerClass:[WL_Application_Content_Title_View class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:contentHeaderId];
    //注册第0组的footer
    [contentCollectionView registerClass:[WL_Application_Content_Footer_View class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:contentFooterId];
    //注册其余组的Header
    [contentCollectionView registerClass:[WL_Application_Content_OtherTitle_View class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:contentOtherHeaderId];
    
    //collectionView是否可以选中/默认为No
    //    contentCollectionView.allowsMultipleSelection = YES;
    
    self.contentCollectionView = contentCollectionView;
    
    
}


#pragma mark - 设置组织/公司列表
static NSString *const cellId = @"OrganiztionListCellId";
- (void)setupOrganiztionListTableView
{
    UIView *coverView = [[UIView alloc] init];
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    self.myWindow = myWindow;
    [myWindow addSubview:coverView];
    
    [coverView layoutIfNeeded];
    coverView.backgroundColor = WLColor(0, 0, 0, 0.5);
    coverView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
    [coverView addGestureRecognizer:tap];
    self.coverView = coverView;
    
    UITableView *organizationListTableView = [[UITableView alloc] init];
    organizationListTableView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    organizationListTableView.alpha = 0.9;
    [self.view addSubview:organizationListTableView];
    
    organizationListTableView.scrollEnabled = NO;
    organizationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [organizationListTableView registerClass:[WL_organizationList_Cell class] forCellReuseIdentifier:cellId];
    organizationListTableView.delegate = self;
    organizationListTableView.dataSource = self;
    organizationListTableView.hidden = YES;
    self.organizationListTableView = organizationListTableView;
    
    
}

#pragma mark - 设置应用页面头部标题
/** 设置头部标题 */
- (void)setupNavToApplication
{
    //移除Nav左侧箭头
    [self setNavigationLeftImg:@""];

    
//    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(60), 44)];
//    UIImage *image = [UIImage imageNamed:@"dingwei"];
//    image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    rightButton.titleLabel.font = [UIFont WLFontOfSize:12];
//    [rightButton setImage:image forState:UIControlStateNormal];
//    [rightButton setTitleColor:Color1 forState:UIControlStateNormal];
//    [rightButton setTitle:@"深圳" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(didClickSelectCityButton:) forControlEvents:UIControlEventTouchUpInside];
//    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, -5);
//    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, -5);
//    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.selectCityButton = rightButton;
//    self.selectCityButton.hidden = YES;
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = item;
    
    self.navBtn = [[WLApplicationNavButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    self.navBtn.hidden = YES;
    [self.navBtn addTarget:self action:@selector(selectedOrganizationClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.navBtn;
    
}

#pragma mark - 点击Nav的TitleView调用的方法
/** 点击头部公司/组织按钮效果 */
- (void)selectedOrganizationClick
{
    //指示器按钮选中状态取反
    self.navBtn.selected = !self.navBtn.selected;
    
    //如果是选中状态
    if (self.navBtn.selected == YES)
    {
        
        self.organizationListTableView.hidden = NO;
        self.coverView.hidden = NO;
    }
    //非选中状态
    else
    {
        self.organizationListTableView.hidden = YES;
        self.coverView.hidden = YES;
    }
}

#pragma mark - 点击控制器的View调用方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self coverViewClick];
}
/**< 选择城市的按钮点击事件 */
- (void)didClickSelectCityButton:(UIButton *)sender
{
    WLBaiduMapViewController * nextVC = [[WLBaiduMapViewController alloc] init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.company_id = self.company_id;
    nextVC.cityName = self.selectCityButton.titleLabel.text;
    nextVC.cityArr = self.cityArray;
    
    [self.navigationController pushViewController:nextVC animated:YES];
//    STPickerCity *pickerArea = [[STPickerCity alloc] initWithArray:self.cityArray];
//    [pickerArea setDelegate:self];
//    [pickerArea setContentMode:STPickerContentModeBottom];
//    [pickerArea show];
}
/**< 选择城市的回调 */
- (void)pickerCity:(STPickerCity *)pickerCity province:(NSString *)province city:(NSString *)city provinceID:(NSString *)provinceID cityID:(NSString *)cityID
{
   //
}
#pragma mark - 隐藏公司/组织列表,指示器关闭方法
- (void)coverViewClick
{
    self.coverView.hidden = YES;
    self.organizationListTableView.hidden = YES;
    self.navBtn.selected = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化cell
    WL_organizationList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    //将模型数组中的元素一一对应传给cell的模型并赋值
//    cell.company = self.currentCompanyModel;
    cell.company = self.companys[indexPath.row];
    //如果cell的字体与Nav的TitleView中的字体一样的话,那么cell的字体显示为蓝色
    if ([cell.organizationNameLable.text isEqualToString:[self.navBtn titleForState:UIControlStateNormal]])
    {
        cell.organizationNameLable.textColor = [WLTools stringToColor:@"#00cc99"];
    }
    else
    {
        cell.organizationNameLable.textColor = [WLTools stringToColor:@"#333333"];
    }
    //判断cell的底部分隔线是否需要隐藏
    //    cell.lineView.hidden = (indexPath.row == self.companys.count - 1 ? YES : NO);
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WL_organizationList_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.navBtn setTitle:cell.organizationNameLable.text forState:UIControlStateNormal];
    self.navBtn.selected = NO;
    self.organizationListTableView.hidden = YES;
    self.coverView.hidden = YES;
    self.driverStatus = -2;
    self.carStaus = -2;
    self.selectCityButton.hidden = YES;
    //切换当前选中的公司模型
    self.currentCompanyModel = self.companys[indexPath.row];
//    self.company_id = self.currentCompanyModel.company_id;
    [self sendRequestToDriverStatue];
    //    [self sendRequestToGuiderStatus];
    //将选中的公司名称记录下来
//    [WLKeychainTool saveKeychainValue:cell.organizationNameLable.text key:@"companyNameSelected"];
    ////[DEFAULTS setObject:cell.organizationNameLable.text forKey:@"companyNameSelected"];
//    [self.organizationListTableView reloadData];
//    [self.contentCollectionView reloadData];
//    
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return organizationListCellHeight;
}

#pragma mark - CollectionView DataSource
/** 设置collcetionView的分组个数 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.contentRoles.count;

}

/** 设置collectionView每组item的个数 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    WL_Application_Role_Model *role = self.contentRoles[section];
    if ([role.type isEqualToString:@"2"])
    {
        return 6;
    }
    else if ([role.type isEqualToString:@"1"])
    {
        return 0;
    }
    return 3;

    
}

/** 设置collectionView的数据 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WL_Applicaton_Main_Content_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:contentCellId forIndexPath:indexPath];
    
    
    //如果公司角色数组有数据
    if (self.contentRoles.count > 0 && self.contentRoles != nil)
    {

        //取出角色数组角色模型

             WL_Application_Role_Model *role = self.contentRoles[indexPath.section];
            //如果group_type是2 司机
            //role.type = @"5";
            if ([role.type isEqualToString:@"2"])
            {
                if (indexPath.item == self.motorcadeArr.count ||indexPath.item == self.motorcadeArr.count+1) {
                    cell.maskView.hidden = NO;
                    return cell;
                }else {
                    cell.maskView.hidden = YES;
                }
                cell.functionLable.text = self.motorcadeArr[indexPath.row];
                cell.iconImageView.image = [UIImage imageNamed:self.motorcadeImageArr[indexPath.row]];
                //司机认证
                if (indexPath.row == 2)
                {
                    cell.driverStatus = self.driverStatus;
                    
                }
                else if (indexPath.row == 3)    //车辆认证
                {
                    cell.carStaus = self.carStaus;
                    
                }
                else
                {
                    [self hideStatusToCell:cell];
                }
                
            }
            //如果group_type是1 导游
            else if ([role.type isEqualToString:@"1"])
            {
//                cell.functionLable.text = self.guideArr[indexPath.row];
//                cell.iconImageView.image = [UIImage imageNamed:self.guideImageArr[indexPath.row]];
                //导游认证
                if (indexPath.row == 3)
                {
                    cell.certificationImageView.hidden = NO;
                    if ([self.GuiderStatusModel.status isEqualToString:@"1"]) {
                        cell.certificationImageView.image = [UIImage imageNamed:@"ShenHezhong"];
                        cell.functionLable.textColor = [WLTools stringToColor:@"#6f7378"];
                    }
                    else if ([self.GuiderStatusModel.status isEqualToString:@"2"]) {
                        cell.certificationImageView.image = [UIImage imageNamed:@"YiRenzheng"];
                        cell.functionLable.textColor = [WLTools stringToColor:@"#6f7378"];
                    }
                    else if ([self.GuiderStatusModel.status isEqualToString:@"3"]) {
                        cell.certificationImageView.image = [UIImage imageNamed:@"renZhengShibai"];
                    }
                    else
                    {
                        cell.certificationImageView.image = [UIImage imageNamed:@"WeiRenzheng"];
                    }
                    
                }
                else
                {
                    cell.certificationImageView.hidden = YES;
                }
            }
            else if ([role.type isEqualToString:@"3"])//房销
            {
//                if (indexPath.item == self.motorcadeArr.count ||indexPath.item == self.motorcadeArr.count+1) {
//                    cell.maskView.hidden = NO;
//                    return cell;
//                }else {
//                    cell.maskView.hidden = YES;
//                }
                
                if (indexPath.item == self.hotelArr.count) {
                    cell.iconImageView.hidden = YES;
                    cell.functionLable.hidden = YES;
                    return cell;
                }else {
                    cell.iconImageView.hidden = NO;
                    cell.functionLable.hidden = NO;
                }
                cell.functionLable.text = self.hotelArr[indexPath.row];
                cell.iconImageView.image = [UIImage imageNamed:self.guideImageArr[indexPath.row]];
                cell.functionLable.textColor = [WLTools stringToColor:@"#000000"];
                cell.certificationImageView.hidden = YES;
                
            }else if([role.type isEqualToString:@"5"])//核销
            {
                if (indexPath.item == self.checkArr.count ||indexPath.item == self.checkArr.count+1) {
                    cell.maskView.hidden = NO;
                    return cell;
                }else {
                    cell.maskView.hidden = YES;
                }
                cell.functionLable.text = self.checkArr[0];
                cell.iconImageView.image = [UIImage imageNamed:self.checkImageArr[0]];
                [self hideStatusToCell:cell];
            }else if([role.type isEqualToString:@"100"])//店铺
            {
                if (indexPath.item == self.storeArr.count ||indexPath.item == self.storeArr.count+1) {
                    cell.maskView.hidden = NO;
                    return cell;
                }else {
                    cell.maskView.hidden = YES;
                }
                cell.functionLable.text = self.storeArr[0];
                cell.iconImageView.image = [UIImage imageNamed:self.storeImageArr[0]];
                [self hideStatusToCell:cell];
            }else if([role.type isEqualToString:@"-1"])//个人叫车
            {
                if (indexPath.item == self.storeArr.count+1) {
                    cell.maskView.hidden = NO;
                    return cell;
                }else {
                    cell.maskView.hidden = YES;
                }
                cell.functionLable.text = self.bookCarPersonArr[indexPath.item];
                cell.iconImageView.image = [UIImage imageNamed:self.bookCarImageArr[indexPath.item]];
                [self hideStatusToCell:cell];
            }else if([role.type isEqualToString:@"9"])//企业叫车
            {
                if (indexPath.item == self.storeArr.count+1) {
                    cell.maskView.hidden = NO;
                    return cell;
                }else {
                    cell.maskView.hidden = YES;
                }
                cell.functionLable.text = self.bookCarCompanyArr[indexPath.item];
                cell.iconImageView.image = [UIImage imageNamed:self.bookCarImageArr[indexPath.item]];
                [self hideStatusToCell:cell];
            }

    }
    return cell;
}
#pragma mark -隐藏认证状态图片
- (void)hideStatusToCell:(WL_Applicaton_Main_Content_Cell *)cell
{
    cell.failedImageView.hidden = YES;
    cell.certificationImageView.hidden = YES;
    cell.certificationStatusImageView.hidden = YES;
}

/** 设置collecionView每个item的大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    return CGSizeMake(100 * AUTO_IPHONE6_WIDTH_375, 120 * AUTO_IPHONE6_WIDTH_375);
    return CGSizeMake((ScreenWidth - 3)/3.0, ScaleH(115));
}
/** 配置item的边距 */
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
////    return UIEdgeInsetsMake(20, 20, 0, 20);
//    return UIEdgeInsetsMake(00, 0, 1, 1);
//}

//自定义HeaderView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if (indexPath.section == 0)
        {
            reuseIdentifier = contentHeaderId;
            WL_Application_Content_Title_View *titleView =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
            self.titleView = titleView;
//            [titleView.selectCityButton addTarget:self action:@selector(didClickSelectCityButton:) forControlEvents:UIControlEventTouchUpInside];
//            titleView.selectCityButton.hidden = (self.driverStatus == 1&&self.carStaus == 1)?NO:YES;
//    
//            titleView.pictures = self.bannerImages;
            titleView.pictures =  @[@"cycle1",@"cycle2",@"cycle3"].mutableCopy;
            [titleView creatScrollViewToTitleView];
            
            titleView.cycle.delegate = self;
            
            if (self.contentRoles.count > 0 && self.contentRoles != nil)
            {
                WL_Application_Role_Model *role = self.contentRoles[indexPath.section];
                
                if ([role.type isEqualToString:@"2"])
                {
                    titleView.titleLable.text = @"司机";
                }
                else if ([role.type isEqualToString:@"1"])
                {
                    titleView.titleLable.text = @"导游";
                }
                else if ([role.type isEqualToString:@"3"])
                {
                    titleView.titleLable.text = @"酒店";
                }else if ([role.type isEqualToString:@"5"])
                {
                    titleView.titleLable.text = @"核销";
                }else if ([role.type isEqualToString:@"100"])
                {
                    titleView.titleLable.text = @"店铺";
                }else if ([role.type isEqualToString:@"9"])
                {
                    titleView.titleLable.text = @"企业叫车";
                }else if ([role.type isEqualToString:@"-1"])
                {
                    titleView.titleLable.text = @"个人叫车";
                }
            }
//            }else
//            {
//            titleView.titleLable.text = @"个人叫车";
//            }
            return titleView;
        }
        else
        {
            reuseIdentifier = contentOtherHeaderId;
            WL_Application_Content_OtherTitle_View *titleView =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
            if (self.contentRoles.count > indexPath.section && self.contentRoles != nil&&indexPath.section<self.contentRoles.count)
            {
                WL_Application_Role_Model *role = self.contentRoles[indexPath.section];
                if ([role.type isEqualToString:@"2"])
                {
                    titleView.titleLable.text = @"司机";
                }
//                else if ([role.type isEqualToString:@"1"])
//                {
//                    titleView.titleLable.text = @"导游";
//                }
                else if ([role.type isEqualToString:@"3"])
                {
                    titleView.titleLable.text = @"酒店";
                }else if ([role.type isEqualToString:@"5"])
                {
                    titleView.titleLable.text = @"核销";
                }else if ([role.type isEqualToString:@"100"])
                {
                    titleView.titleLable.text = @"店铺";
                }else if ([role.type isEqualToString:@"9"])
                {
                    titleView.titleLable.text = @"企业叫车";
                }else if ([role.type isEqualToString:@"-1"])
                {
                    titleView.titleLable.text = @"个人叫车";
                }
            }
//            }else  if(indexPath.section == self.contentRoles.count)
//            {
//                titleView.titleLable.text = @"个人叫车";
//            }
            return titleView;
        }
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        reuseIdentifier = contentFooterId;
        WL_Application_Content_Footer_View *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        footerView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        if (self.contentRoles.count > indexPath.section && self.contentRoles != nil)
        {
            WL_Application_Role_Model *role = self.contentRoles[indexPath.section];
            
            if ([role.type isEqualToString:@"2"])
            {
                if (!(self.carStaus == 1&& self.driverStatus == 1)) {
                    footerView.titleLable.hidden = NO;
                    footerView.promptLable.text = @"您的司机身份和车辆信息全部认证后才可接单, 请分别点击提交审核";
                    return footerView;
                }else
                {
                    footerView.titleLable.hidden = YES;
                    footerView.promptLable.text = nil;
                    return footerView;
                }
               
            }
//            else if([role.type isEqualToString:@"1"])
//            {
//                footerView.titleLable.hidden = NO;
//                footerView.promptLable.text = @"您的导游身份和收入信息全部认证后才可接单, 请分别点击提交审核";
//                return footerView;
//            }
            else if([role.type isEqualToString:@"3"])
            {
                footerView.titleLable.hidden = NO;
                footerView.promptLable.text = @"您的酒店身份和收入信息全部认证后才可接单, 请分别点击提交审核";
                return footerView;
            }
            else
            {
                footerView.titleLable.hidden = YES;
                footerView.promptLable.text = nil;
                return footerView;
            }
            
        }
        
    }
    
    
    return nil;
}

//设置HeaderView的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   
    
    if (section == 0)
    {
//         WL_Application_Role_Model *role = self.contentRoles[indexPath.section];
        return (CGSize){ScreenWidth, 230 * AUTO_IPHONE6_HEIGHT_667};
    }
    else
    {
        return (CGSize){ScreenWidth,ContentTitleViewHeight};
    }
    
}

//设置FooterView的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
   
        WL_Application_Role_Model *role = self.contentRoles[section];
        if ([role.type isEqualToString:@"5"] ||[role.type isEqualToString:@"100"]||[role.type isEqualToString:@"9"]||[role.type isEqualToString:@"-1"]||[role.type isEqualToString:@"1"]) {
            return (CGSize){ScreenWidth, 0.01};
        }
    if ([role.type isEqualToString:@"2"]) {
        if (self.carStaus == 1&& self.driverStatus == 1) {
            return (CGSize){ScreenWidth, 0.01};
        }
    }
   
        return (CGSize){ScreenWidth,70};
  
    
}

//点击collectionView的item方法
//点击item时触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果公司角色数组有数据
    if (self.contentRoles.count > 0 && self.contentRoles != nil)
    {
        //取出角色数组第一个角色模型
        WL_Application_Role_Model *role = self.contentRoles[indexPath.section];
        
        //司机角色

        //role.type = @"5";
        
        if ([role.type isEqualToString:@"2"])
        {
            if (indexPath.row == 0)
            {
                //接单控制器
                WL_Application_Driver_OrderList_ViewController *orderListVc = [[WL_Application_Driver_OrderList_ViewController alloc] init];
                orderListVc.hidesBottomBarWhenPushed = YES;
                orderListVc.company_id = self.company_id;
                orderListVc.driverStatus = self.driverStatus;
                orderListVc.carStaus = self.carStaus;
                if(self.driverStatus == 3||self.carStaus == 3){
                    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的司机或车辆已被禁用!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alerView show];
                   
                }else{
                    
                   [self.navigationController pushViewController:orderListVc animated:YES];
                }
            }
            //            else if (indexPath.row == 1)
            //            {
            //                //我的行程控制器
            //                WL_Application_Driver_Trip_ViewController *tripVc = [[WL_Application_Driver_Trip_ViewController alloc] init];
            //                tripVc.hidesBottomBarWhenPushed = YES;
            //                [self.navigationController pushViewController:tripVc animated:YES];
            //            }
            else if (indexPath.row == 1)
            {
                
                //账单控制器
                WL_Application_Driver_Bill_ViewController *billVc = [[WL_Application_Driver_Bill_ViewController alloc] init];
                billVc.hidesBottomBarWhenPushed = YES;
                billVc.company_id = self.company_id;
                [self.navigationController pushViewController:billVc animated:YES];
            }
            else if (indexPath.row == 2)
            {
                //司机控制器
                WL_Application_Driver_Jockey_ViewController *jockeyVc = [[WL_Application_Driver_Jockey_ViewController alloc] init];
                jockeyVc.driverStatus = self.driverStatus;
                jockeyVc.hidesBottomBarWhenPushed = YES;
                jockeyVc.comPany_id = self.company_id;
                
                [self.navigationController pushViewController:jockeyVc animated:YES];
            }
            else if (indexPath.row == 3)
            {
                if (self.driver_id == nil || self.driver_id.length <= 0) {
                    [[WL_TipAlert_View sharedAlert] createTip:@"请先完成司机的认证,再认证车辆"];
                    return;
                }
                //我的车辆控制器
                WL_Application_Driver_addCar_viewController *addCarVc = [[WL_Application_Driver_addCar_viewController alloc] init];
                addCarVc.companyId = self.company_id;
                addCarVc.carStatus = [NSString stringWithFormat:@"%ld",self.carStaus];
                addCarVc.driveId = self.driver_id;
                addCarVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:addCarVc animated:YES];
            }
            
        }
        else if ([role.type isEqualToString:@"1"])
        {
            if (indexPath.row == 0)
            {
                //接单控制器
                WLGuideOrderListViewController *orderVc = [[WLGuideOrderListViewController alloc] init];
                orderVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:orderVc animated:YES];
                
            }
            else if (indexPath.row == 1)
            {
                //出团控制器
                WLCurrentGroupController *groupVc = [[WLCurrentGroupController alloc] init];
                [groupVc setupGroupListID: nil];
                groupVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:groupVc animated:YES];
                
                
                
            }
            else if (indexPath.row == 2)
            {
                WLScheduleListViewController *ScheduleVc = [[WLScheduleListViewController alloc] init];
                ScheduleVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ScheduleVc animated:YES];
            }
            else if (indexPath.row == 3)
            {
                //导游控制器
                WL_Application_TourGuide_info_ViewController *guideVc = [[WL_Application_TourGuide_info_ViewController alloc] init];
                guideVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:guideVc animated:YES];
            }
            else if (indexPath.row == 4)
            {
                WLTouristIncomeController *myCarVc = [[WLTouristIncomeController alloc] init];
                myCarVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myCarVc animated:YES];
            }
            
        }
        
        else if ([role.type isEqualToString:@"3"])
        {
            if (indexPath.row == 0)
            {
                //接单控制器
                WLReceiveListViewController *orderVc = [[WLReceiveListViewController alloc] init];
                orderVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:orderVc animated:YES];
                
            }
            else if (indexPath.row == 1)
            {
                //账单控制器
                WLBillListViewController *groupVc = [[WLBillListViewController alloc] init];
                groupVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:groupVc animated:YES];
                
            }
            
        }else if([role.type isEqualToString:@"5"])
        {
            if (indexPath.row == 0)
            {
                //核销控制器
                WLApplicationScanViewController *scanVC = [[WLApplicationScanViewController alloc]init];
                scanVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:scanVC animated:YES];
                
            }
        }else if([role.type isEqualToString:@"100"])
        {
            if (indexPath.row == 0)//店铺
            {

                
                TOWebViewController *webVC = [[TOWebViewController alloc]initWithURLString:self.storeUrl];
                webVC.hidesBottomBarWhenPushed = YES;
                webVC.showUrlWhileLoading = NO;
                [self.navigationController pushViewController:webVC animated:YES];
                
            }
        }else if([role.type isEqualToString:@"9"])//企业叫车
        {
            if (indexPath.row == 0)//叫车控制器
            {
                WLCarBookingViewController*carBookingVC = [[WLCarBookingViewController alloc]init];
                carBookingVC.hidesBottomBarWhenPushed = YES;
                carBookingVC.companyID = self.company_id;
                [self.navigationController pushViewController:carBookingVC animated:YES];
            }else if(indexPath.row == 1)
            {
                //我的订单页面
                WLCarBookingOrderListViewController * nextVC = [[WLCarBookingOrderListViewController alloc] init];
                nextVC.hidesBottomBarWhenPushed = YES;
                nextVC.companyID = self.company_id;
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }else if([role.type isEqualToString:@"-1"])
        {
            if (indexPath.row == 0)//叫车控制器
            {
                WLCarBookingViewController*carBookingVC = [[WLCarBookingViewController alloc]init];
                carBookingVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:carBookingVC animated:YES];
            }else if(indexPath.row == 1)
            {
                //我的订单页面
                WLCarBookingOrderListViewController * nextVC = [[WLCarBookingOrderListViewController alloc] init];
                nextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }
    }
    
}
//无数据提示
- (WL_NoData_View *)netWrongView {
    
    if (_netWrongView == nil) {
        
        _netWrongView = [[WL_NoData_View alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) andRefreshBlock:nil];
         [self.view addSubview:_netWrongView];
        _netWrongView.hidden = YES;
    }
    return _netWrongView;
}
#pragma makr - 设置无数据提示的显示、隐藏及类型
//- (void)hideNoData:(BOOL)hidden andType:(WLNetworkType)type {
//    [[[UIDevice currentDevice] systemVersion] floatValue];//判断系统的版本
//    self.noDataView.hidden = hidden;
//    
//    if (!hidden) {
//        
//        self.noDataView.type = type;
//        
//    }
//}

- (void)dealloc
{
    //销毁弹框
    [self.alert removeFromSuperview];
}

#pragma mark - 查看我的公司角色(没有部门要求)
- (void)sendRequestToFollowMyCompanyRoles
{
    NSString *urlStr = MyCompanyRoles;
    //参数
    //获取userId
    NSString *userId = [WLUserTools getUserId];
    //获取userPassword
    NSString *userPassword = [WLUserTools getUserPassword];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //请求参数字典
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword
                             };
    [self showHud];
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            [self.alert createTip:baseModel.msg];
            [self hidHud];
            return;
        }
        self.roles = [WL_Application_Role_Model mj_objectArrayWithKeyValuesArray:baseModel.data];
        
        
    } Failure:^(NSError *error) {
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
//            [self hideNoData:NO andType:WLNetworkTypeNONetWork];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
//            [self hideNoData:NO andType:WLNetworkTypeSeverError];
        }
        
        //隐藏菊花
        [self hidHud];
    }];
}

#pragma mark - 请求轮播器的图片
- (void)sendrequestToNoticeBanner:(NSString *)company_id
{
    return; 
    //请求地址
    NSString *urlStr = NoticeNoticeBannerUrl;
    //请求参数
    //获取userId
    NSString *userId = [WLUserTools getUserId];
    //获取userPassword
    NSString *userPassword = [WLUserTools getUserPassword];
    //给userPassowrd进行RSA加密
    NSString *rsaUserPassword = [MyRSA encryptString:userPassword publicKey:RSAKey];
    //请求类型
    NSString *type = @"1";
    
    NSDictionary *params = @{
                             @"user_id" : userId,
                             @"user_password" : rsaUserPassword,
                             @"type" : type,
                             @"company_id" : company_id
                             };
    //显示菊花
    [self showHud];
    //发送请求
    [[WLHttpManager shareManager] requestWithURL:urlStr RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        
        WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (![baseModel.result isEqualToString:@"1"]) {
            
            return;
        }
        self.banners = [WL_CompanyBanner_Model mj_objectArrayWithKeyValuesArray:baseModel.data];
        if (self.bannerImages) {
            [self.bannerImages removeAllObjects];
        }
        
        //遍历轮播器模型数组
        for (WL_CompanyBanner_Model *banner in self.banners)
        {
            //将遍历出来的图片添加到轮播器图片数组中
            [self.bannerImages addObject:banner.cover_url];
        }
        
        [self.contentCollectionView reloadData];
        
        
    } Failure:^(NSError *error) {
        //弹框提示错误信息
        if (error.code == -1009)
        {
            [self.alert createTip:@"似乎已断开与互联网的连接"];
        }
        else
        {
            [self.alert createTip:@"服务器错误,请稍后重试"];
        }
        
        //隐藏菊花
        [self hidHud];
        
        
    }];
    
    
    
}

- (void)EScrollerViewDidClicked:(NSUInteger)index
{
    WL_NoticeDetail_ViewController *VC =[[WL_NoticeDetail_ViewController alloc]init];
    
    VC.hidesBottomBarWhenPushed = YES;
    
    VC.typeOfPush = 1;
    WL_CompanyBanner_Model *bannerModel = self.banners[index - 1];
    VC.notice_id = bannerModel.notice_id;
    
    [self.navigationController pushViewController:VC animated:YES];
}


@end
