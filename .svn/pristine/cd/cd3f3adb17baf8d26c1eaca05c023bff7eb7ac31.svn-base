//
//  WLBaiduMapViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/2/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLBaiduMapViewController.h"

@interface WLBaiduMapViewController ()

@property (nonatomic, strong) UIView * blackView;
@property (nonatomic, strong) BMKMapView* mapView;
@property (nonatomic, strong) BMKLocationService* locService;

@end

@implementation WLBaiduMapViewController

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"当前地址";
    
    [self createUI];
}

- (void)createUI
{
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _blackView.backgroundColor = [WLTools stringToColor:@""];
    [self.view addSubview:_blackView];
    
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, ScaleH(100), ScreenWidth, _blackView.frame.size.height - ScaleH(100))];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeHeading;//设置定位的状态
    [_blackView addSubview:_mapView];
    
    //    UIBarButtonItem* barItem = [[UIBarButtonItem alloc]init];
    //    barItem.target = self;
    //    barItem.action = @selector(customLocationAccuracyCircle);
    //    barItem.title = @"自定义精度圈";
    //    self.navigationItem.rightBarButtonItem = barItem;
    [self customLocationAccuracyCircle];
}

//自定义精度圈
- (void)customLocationAccuracyCircle {
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.accuracyCircleStrokeColor = [UIColor clearColor];//colorWithRed:1 green:0 blue:0 alpha:0.5];
    param.accuracyCircleFillColor = [UIColor clearColor];//colorWithRed:0 green:1 blue:0 alpha:0.3];
    [_mapView updateLocationViewWithParam:param];
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;//移动到中心点
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
