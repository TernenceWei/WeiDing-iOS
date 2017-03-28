//
//  WLCarBookingAddressController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingAddressController.h"
#import "STPickerCity.h"
#import "WLNetworkAccountHandler.h"
#import "WLDataCarBookingHandler.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <CoreLocation/CoreLocation.h>
#import "WLCityItem.h"

@interface WLCarBookingAddressController ()<UITableViewDataSource, UITableViewDelegate, STPickerCityDelegate,UITextFieldDelegate,BMKPoiSearchDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UITextField *addressField;
@property (nonatomic, strong) NSString *provinceID;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, strong) BMKPoiSearch *searcher;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) NSString *selectCity;
@property (nonatomic, strong) NSString *detailAddress;

@end

@implementation WLCarBookingAddressController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)searchArray
{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (void)setDataArray:(NSArray *)cityArray isStart:(BOOL)isStart selectCity:(NSString *)selectCity
{
    self.cityArray = cityArray;
    self.isStart = isStart;
    self.selectCity = selectCity;
    [self setupBaiduMap];
    [self setupNavigationBar];
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    _searcher.delegate = nil;
}

- (void)setupNavigationBar
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    NSString *city = self.selectCity?self.selectCity:@"深圳";
    self.cityBtn = [UIButton buttonWithTitle:city titleColor:Color2 font:[UIFont WLFontOfSize:14] target:self action:@selector(selectCityBtnClick)];
    self.cityBtn.frame = CGRectMake(ScaleW(8), 20, ScaleW(62), 44);
    [topView addSubview:self.cityBtn];
    
    self.addressField = [[UITextField alloc]initWithFrame:CGRectMake(self.cityBtn.right, 20, ScreenWidth - ScaleW(110), 44)];
    self.addressField.placeholder = @"请输入地点";
    self.addressField.font = [UIFont WLFontOfSize:15];
    self.addressField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.addressField.returnKeyType = UIReturnKeySearch;
    self.addressField.textColor = Color2;
    self.addressField.delegate = self;
    [self.addressField addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
    [topView addSubview:self.addressField];
    [self.addressField becomeFirstResponder];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(ScreenWidth - ScaleW(50), 20, ScaleW(40), 44);
    [cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:Color1 forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont WLFontOfSize:15];
    [topView addSubview:cancelBtn];
}

- (void)setupUI
{
    
    if (self.isStart) {
        self.dataArray = [[[WLDataCarBookingHandler sharedInstance] getStartPointHistory] mutableCopy];
    }else{
        self.dataArray = [[[WLDataCarBookingHandler sharedInstance] getEndPointHistory] mutableCopy];
    }
    self.view.backgroundColor = bordColor;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleW(12) + 64, ScreenWidth - ScaleW(24), ScreenHeight - 64 - ScaleW(12))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)textFieldTextDidChange
{
    NSString *inputString = self.addressField.text;
    if ([inputString isEqualToString:@""]) {
        [self.searchArray removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
    option.pageCapacity = 20;
    option.keyword = inputString;
    option.city = [self.cityBtn titleForState:UIControlStateNormal];
    BOOL flag = [_searcher poiSearchInCity:option];
    NSLog(@"%d?关键词检索发送成功:周边检索发送失败",flag);

}

#pragma mark baiduMap
- (void)setupBaiduMap
{
    //百度地点搜索
    _searcher = [[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    
    if (!self.selectCity) {
        //定位功能
        if([CLLocationManager locationServicesEnabled]){
            if(!_locationManager){
                self.locationManager = [[CLLocationManager alloc] init];
                if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                    
                    [self.locationManager requestWhenInUseAuthorization];
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
    


}

//百度地点搜索结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSArray *results = poiResultList.poiInfoList;
        self.searchArray = [results mutableCopy];
        [self.tableView reloadData];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

//定位结果
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [self.locationManager stopUpdatingLocation];
    CLLocation* location = locations.lastObject;
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error || placemarks.count == 0){
            NSLog(@"error = %@",error);
            [[WL_TipAlert_View sharedAlert] createTip:@"定位失败"];
            [self.locationManager stopUpdatingLocation];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self selectCityBtnClick];
            });
            
        }else{
            
            CLPlacemark* placemark = placemarks.firstObject;
            NSDictionary *dict = [placemark addressDictionary];
            NSString *city = [dict objectForKey:@"City"];
            if ([city hasSuffix:@"市"]) {
                city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            [self.locationManager stopUpdatingLocation];
            [self.cityBtn setTitle:city forState:UIControlStateNormal];
            for (WLCityItem *provinceItem in self.cityArray) {
                NSArray *cityArray = provinceItem.cityItems;
                for (WLCityItem *cityItem in cityArray) {
                    if ([cityItem.cityName isEqualToString:city]) {
                        self.cityID = cityItem.cityID;
                        self.provinceID = provinceItem.cityID;
                        self.city = cityItem.cityName;
                        self.province = provinceItem.cityName;
                        
                    }
                }
            }
            
            
        }
    }];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchArray.count) {
        return self.searchArray.count;
    }
    return self.dataArray.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchArray.count){
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"identifier"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifier"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BMKPoiInfo *info = self.searchArray[indexPath.row];
        cell.textLabel.text = info.name;
        cell.detailTextLabel.text = info.address;
        cell.imageView.image = [UIImage imageNamed:@"address_location"];
        return cell;
    }
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"identifier1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifier1"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"name"];
    cell.detailTextLabel.text = [dict objectForKey:@"address"];
    cell.imageView.image = [UIImage imageNamed:@"bookingCar_history"];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(45);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchArray.count) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.isStart) {
        [[WLDataCarBookingHandler sharedInstance] removeStartPointItem:self.dataArray[indexPath.row]];
    }else{
        [[WLDataCarBookingHandler sharedInstance] removeEndPointItem:self.dataArray[indexPath.row]];
    }
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if (self.searchArray.count) {
        BMKPoiInfo *info = self.searchArray[indexPath.row];
        self.addressField.text = info.name;
        self.detailAddress = info.address;
        NSDictionary *dict = @{@"name":info.name,@"address": info.address};
        if (self.isStart) {
            [[WLDataCarBookingHandler sharedInstance] addNewStartPointItem:dict];
        }else{
            [[WLDataCarBookingHandler sharedInstance] addNewEndPointItem:dict];
        }
    }else{
        NSDictionary *dict = self.dataArray[indexPath.row];
        self.addressField.text = [dict objectForKey:@"name"];
        self.detailAddress = [dict objectForKey:@"address"];
    }
    if (self.provinceID && self.cityID) {
        [self finishInput];
    }else{
        [[WL_TipAlert_View sharedAlert] createTip:@"定位失败,请选择城市"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self selectCityBtnClick];
        });
    }
}

#pragma  mark delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeySearch) {

        if (self.addressField.text.length && self.provinceID && self.cityID) {
            [self.view endEditing:YES];
//            [self finishInput];
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
    
}

- (void)pickerCity:(STPickerCity *)pickerCity province:(NSString *)province city:(NSString *)city provinceID:(NSString *)provinceID cityID:(NSString *)cityID
{
    [self.cityBtn setTitle:city forState:UIControlStateNormal];
    self.provinceID = provinceID;
    self.cityID = cityID;
    self.province = province;
    self.city = city;
    if (self.addressField.text.length && self.provinceID && self.cityID) {
        [self finishInput];
    }else{
        [self.addressField becomeFirstResponder];
    }
    
    
}

#pragma mark bussiness logic
- (void)selectCityBtnClick
{
    [self.view endEditing:YES];
    self.addressField.text = nil;
    STPickerCity *pickerArea = [[STPickerCity alloc] initWithArray:self.cityArray];
    [pickerArea setDelegate:self];
    [pickerArea setContentMode:STPickerContentModeBottom];
    pickerArea.defaultCityName = [self.cityBtn titleForState:UIControlStateNormal];
    [pickerArea show];
    
}

- (void)finishInput
{
    self.onAddressBlock(self.provinceID,self.cityID,self.addressField.text,self.city,self.detailAddress);
    [self cancelButtonClick];
}

- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
