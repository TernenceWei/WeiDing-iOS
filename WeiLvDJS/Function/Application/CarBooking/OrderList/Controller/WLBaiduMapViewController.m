//
//  WLBaiduMapViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/2/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLBaiduMapViewController.h"
#import "WLCarLocationListViewController.h"

#import "WLSearchLocationViewController.h"

@interface WLBaiduMapViewController ()

@property (nonatomic, strong) UIView * blackView;
@property (nonatomic, strong) UIButton * cityShowBtn;

@property (nonatomic, strong) NSString * provinceID;
@property (nonatomic, strong) NSString * cityID;
@property (nonatomic, strong) NSString * Downaddress;

@property (nonatomic, strong) BMKMapView* mapView;
@property (nonatomic, strong) BMKLocationService* locService;

@property (nonatomic, strong) BMKGeoCodeSearch * geocodesearch;
@property (nonatomic, strong) BMKGeoCodeSearchOption * geoCodeSearchOption;
@property (nonatomic, strong) BMKUserLocation * UuserLocation;

@property (nonatomic, strong) UILabel * searchText;
@property (nonatomic, assign) BOOL iSLocation;
@property (nonatomic, assign) BOOL iSLocationDW;
@property (nonatomic, strong) WLCityItem * iSLocationStr;

@property (nonatomic, copy)  void(^WCBtnAction)(WLCityItem *);

@end

@implementation WLBaiduMapViewController

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    self.navigationController.navigationBarHidden = NO;
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
    _iSLocation = YES;
     _iSLocationDW = YES;
    
    [self createUI];
    
    //初始化检索对象
    _geocodesearch =[[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    
    _geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
}

- (void)createUI
{
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    _blackView.backgroundColor = [WLTools stringToColor:@""];
    [self.view addSubview:_blackView];
    
    UILabel * thislocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(10), ScaleW(150), ScaleH(20))];
    thislocationLabel.text = @"当前定位";
    thislocationLabel.font = [UIFont WLFontOfSize:12.0];
    [_blackView addSubview:thislocationLabel];
    
    UIView * thislocationView = [[UIView alloc] initWithFrame:CGRectMake(0, thislocationLabel.frame.origin.y + thislocationLabel.frame.size.height + ScaleH(10), _blackView.frame.size.width, ScaleH(50))];
    thislocationView.backgroundColor = [UIColor whiteColor];
    [_blackView addSubview:thislocationView];
    
    _cityShowBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScaleW(10), 0, ScaleW(80), thislocationView.frame.size.height)];
    [_cityShowBtn setTitle:[NSString stringWithFormat:@"%@ ▼",_cityName] forState:UIControlStateNormal];
    [_cityShowBtn setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
    [_cityShowBtn addTarget:self action:@selector(cityShowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [thislocationView addSubview:_cityShowBtn];
    
// 搜索框
    _searchText = [[UILabel alloc] initWithFrame:CGRectMake(_cityShowBtn.frame.origin.x + _cityShowBtn.frame.size.width + ScaleW(10), 0, thislocationView.frame.size.width - _cityShowBtn.frame.size.width - ScaleW(30), thislocationView.frame.size.height)];
    //_searchText.text = @"你要去哪……";
    [thislocationView addSubview:_searchText];
    
    _searchText.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchLocationSureBtnClick)];
    [_searchText addGestureRecognizer:tapGR];
    
//    UIButton * sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(thislocationView.frame.size.width - ScaleW(60), ScaleH(10), ScaleW(50), ScaleH(30))];
//    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [sureBtn addTarget:self action:@selector(searchLocationSureBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [thislocationView addSubview:sureBtn];
    
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, thislocationView.frame.origin.y + thislocationView.frame.size.height + ScaleH(10), ScreenWidth, _blackView.frame.size.height - thislocationView.frame.origin.y - thislocationView.frame.size.height - ScaleH(10))];
    _mapView.showsUserLocation = YES;// 显示定位图层
    _mapView.zoomLevel = 18; // 显示比例
    _mapView.userTrackingMode = BMKUserTrackingModeHeading;// 设置定位的状态
    [_blackView addSubview:_mapView];
    
    //大头针
    UIImageView * pin_redImg = [[UIImageView alloc] initWithFrame:CGRectMake((_mapView.frame.size.width / 2) - ScaleW(8), (_mapView.frame.size.height / 2) - ScaleH(25), ScaleW(16), ScaleH(25))];
    [pin_redImg setImage:[UIImage imageNamed:@"dinweiImg"]];
    [_mapView addSubview:pin_redImg];
    
    UIButton * LocationAgainBtn = [[UIButton alloc] initWithFrame:CGRectMake(_mapView.frame.size.width - ScaleW(120), _mapView.frame.size.height - ScaleW(40), ScaleW(120), ScaleH(30))];
    //[LocationAgainBtn setTitle:@"重新定位" forState:UIControlStateNormal];
    [LocationAgainBtn setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
    [LocationAgainBtn addTarget:self action:@selector(LocationAgainBtnClick) forControlEvents:UIControlEventTouchUpInside];
    LocationAgainBtn.layer.cornerRadius = 15;
    LocationAgainBtn.backgroundColor = [UIColor whiteColor];
    [_mapView addSubview:LocationAgainBtn];
    
    UIImageView * dinweiImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(13), ScaleH(5), ScaleW(13), ScaleH(19))];
    [dinweiImg setImage:[UIImage imageNamed:@"chonxindinweiImg"]];
    [LocationAgainBtn addSubview:dinweiImg];
    
    UILabel * cxdwLabel = [[UILabel alloc] initWithFrame:CGRectMake(dinweiImg.frame.origin.x + dinweiImg.frame.size.width + ScaleW(2), 0, ScaleW(90), LocationAgainBtn.frame.size.height)];
    cxdwLabel.text = @"重新定位";
    cxdwLabel.textColor = [WLTools stringToColor:@"#333333"];
    cxdwLabel.font = [UIFont WLFontOfSize:15.0];
    cxdwLabel.textAlignment = NSTextAlignmentCenter;
    [LocationAgainBtn addSubview:cxdwLabel];
    
    [self customLocationAccuracyCircle];
        
    _mapView.updateTargetScreenPtWhenMapPaddingChanged = YES;
    
    //[_mapView setMapStatus:_mapView.getMapStatus withAnimation:YES withAnimationTime:2];
}

//自定义精度圈
- (void)customLocationAccuracyCircle {
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.accuracyCircleStrokeColor = [UIColor clearColor];//colorWithRed:1 green:0 blue:0 alpha:0.5];
    param.accuracyCircleFillColor = [UIColor clearColor];//colorWithRed:0 green:1 blue:0 alpha:0.3];
    [_mapView updateLocationViewWithParam:param];
}

- (void)cityShowBtnClick
{
    WLCarLocationListViewController * nextVC = [[WLCarLocationListViewController alloc] init];
    nextVC.company_id = _company_id;
    nextVC.cityArr = _cityArr;
    nextVC.cityItemName = _iSLocationStr;
    [self.navigationController pushViewController:nextVC animated:YES];
    [nextVC wCClickAction:^(WLCityItem *item) {
        _cityName = item.cityName;
        [_cityShowBtn setTitle:[NSString stringWithFormat:@"%@ ▼",item.cityName] forState:UIControlStateNormal];
        [self codeSearch:item.cityName iSCity:YES];
    }];
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
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if (_iSLocation) {
        [_mapView updateLocationData:userLocation];
        _mapView.centerCoordinate = userLocation.location.coordinate;//移动到中心点
        _iSLocation = NO;
    }
    _UuserLocation = userLocation;
}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //WlLog(@"==%f===%f==",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeoCodeSearchOption];
    
    if(flag)
    {
      //NSLog(@"反geo检索发送成功");
    }
    else
    {
      //NSLog(@"反geo检索发送失败");
    }
}

// 点击地图视图
- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus *)status
{
    [_searchText resignFirstResponder];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
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

// 搜索位置
- (void)searchLocationSureBtnClick
{
    WLSearchLocationViewController *addressVC = [[WLSearchLocationViewController alloc] init];
    addressVC.company_id = _company_id;
    addressVC.cityName = _cityName;//_cityShowBtn.titleLabel.text;
    addressVC.cityArr = _cityArr;
    addressVC.cityNameDW = _iSLocationStr; // 定位的城市
    addressVC.onAddressBlock = ^(NSString *address,NSString * cityName){
        
        _cityName = cityName;
        [_cityShowBtn setTitle:[NSString stringWithFormat:@"%@ ▼",cityName] forState:UIControlStateNormal];
        _Downaddress = address;
        [self codeSearch:address iSCity:NO];
    };
    [self.navigationController pushViewController:addressVC animated:NO];
    //[self presentViewController:addressVC animated:YES completion:nil];
}

- (void)codeSearch:(NSString *)address iSCity:(BOOL)iscity
{
    if (iscity) {
        _geoCodeSearchOption.city = address;
        _geoCodeSearchOption.address = address;
    }
    else
    {
        _geoCodeSearchOption.city = _cityShowBtn.titleLabel.text;
        _geoCodeSearchOption.address = address;
    }
    
    BOOL flag = [_geocodesearch geoCode:_geoCodeSearchOption];
    if(flag)
    {
        //NSLog(@"geo检索发送成功");
    }
    else
    {
        //NSLog(@"geo检索发送失败");
    }

    [_searchText resignFirstResponder];
}

// 重新定位
- (void)LocationAgainBtnClick
{
    _iSLocationDW = YES;
    [_mapView updateLocationData:_UuserLocation];
    _mapView.centerCoordinate = _UuserLocation.location.coordinate;//移动到中心点
}

//实现Deleage处理回调结果
//接收正向编码结果

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        //WlLog(@"接收正向编码结果===%@==%@",searcher,result);
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
        if (error == 0) {
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = result.location;
            item.title = result.address;
            [_mapView addAnnotation:item];
            _mapView.centerCoordinate = result.location;
            _searchText.text = _Downaddress;
        }
    }
    else {
        //NSLog(@"接收正向编码结果===抱歉，未找到结果");
        [[WL_TipAlert_View sharedAlert] createTip:@"抱歉，地区内，未找到结果"];
    }
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      //在此处理正常结果
      NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
      [_mapView removeAnnotations:array];
      array = [NSArray arrayWithArray:_mapView.overlays];
      [_mapView removeOverlays:array];
      if (error == 0) {
          BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
          item.coordinate = result.location;
          item.title = result.address;
          [_mapView addAnnotation:item];
          _mapView.centerCoordinate = result.location;
          
          NSString * thiscity = result.addressDetail.city; // 市
          if ([thiscity hasSuffix:@"市"]) {
              thiscity = [thiscity stringByReplacingOccurrencesOfString:@"市" withString:@""];
          }
          
          for (WLCityItem *provinceItem in _cityArr) {
              NSArray *cityArray = provinceItem.cityItems;
              for (WLCityItem *cityItem in cityArray) {
                  if ([cityItem.cityName isEqualToString:thiscity]) {
                      
                      self.cityID = cityItem.cityID;
                      self.provinceID = provinceItem.cityID;
                      _cityName = thiscity;
                      _searchText.text = [NSString stringWithFormat:@"%@%@",result.addressDetail.district,result.sematicDescription];
                      //_searchText.text = [NSString stringWithFormat:@"%@%@%@",result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
                      [_cityShowBtn setTitle:[NSString stringWithFormat:@"%@ ▼",thiscity] forState:UIControlStateNormal];
                      if (_iSLocationDW) {
                          _iSLocationStr = cityItem;
                          _iSLocationDW = NO;
                      }
                  }
                  else
                  {
                      //
                  }
              }
          }
      }
  }
  else {
      //NSLog(@"抱歉，未找到结果");
  }
}

- (void)wCClickAction:(void (^)(WLCityItem *))action
{
    _WCBtnAction = action;
}

//点击控制器的View调用方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //键盘退出
    //textField失去第一响应者
    [_searchText resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchText resignFirstResponder];
    
    return YES;
}

- (void)NavigationLeftEvent
{
    [[WLNetworkDriverHandler sharedInstance] updateDriveCityWith:_company_id province:_provinceID city:_cityID resultBlock:^(WLResponseType responseType, NSInteger status, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            [[WL_TipAlert_View sharedAlert] createTip:@"更新城市成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:@"更新城市失败"];
        }
    }];
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
