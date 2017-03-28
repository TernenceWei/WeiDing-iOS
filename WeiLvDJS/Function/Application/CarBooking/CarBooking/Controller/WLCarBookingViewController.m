//
//  WLCarBookingViewController.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingViewController.h"
#import "WLCarBookingHeaderView.h"
#import "WLCarBookingTimeCell.h"
#import "WLCarBookingAddressCell.h"
#import "WLCarBookingPriceCell.h"
#import "WLCarBookingInfoCell.h"
#import "WLNetworkCarBookingHandler.h"
#import "WLBookingCarObject.h"
#import "WLCarBookingDateView.h"
#import "LeoActionPicker.h"
#import "WLCarBookingEditInfoController.h"
#import "WLCarBookingAddressController.h"
#import "WLCarBookingAddCostController.h"
#import "WLNetworkAccountHandler.h"
#import "STPickerCity.h"
#import "HCGDatePickerAppearance.h"
#import "WLCarBookingPictureController.h"
#import "WLCarBookingRemarkCell.h"
#import "WLDataCarBookingHandler.h"
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import <CoreLocation/CLRegion.h>
#import "WLDateManager.h"
#import "WLCityItem.h"
#import "WLDateManager.h"
#import "SDWebImageManager.h"
#import "WLCarBookingViewMode.h"

@interface WLCarBookingViewController ()<UITableViewDataSource, UITableViewDelegate, STPickerCityDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, assign) NSUInteger editTag;
@property (nonatomic, assign) NSInteger selectedSeatIndex;
@property (nonatomic, strong) WLCarBookingHeaderView *headerView;
@property (nonatomic, strong) WLBookingCarObject *object;
@property (nonatomic, strong) HCGDatePickerAppearance *datePicker;
@property (nonatomic, strong) NSDate *beginDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *locationCity;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) NSString *selectStartCity;
@property (nonatomic, strong) NSString *selectEndCity;
@property (nonatomic, assign) BOOL needRefresh;
@property (nonatomic, strong) NSString *contactText;


@end

@implementation WLCarBookingViewController

#pragma mark Life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    [self loadCitys];
    [self setupBaiduMap];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

#pragma mark UI
- (void)setupUI{

    self.title = @"叫车";
    self.selectedSeatIndex = -1;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - ScaleH(65) - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BgViewColor;
    [self.view addSubview:self.tableView];
    
    WS(weakSelf);
    self.headerView = [[WLCarBookingHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(100))
                                                       selectAction:^(NSUInteger index) {
                                                           if (index == 0) {//大巴车
                                                               weakSelf.object.car_model = @"1";
                                                           }else if (index == 1){//商务车
                                                               weakSelf.object.car_model = @"2";
                                                           }else if (index == 2){//小汽车
                                                               weakSelf.object.car_model = @"4";
                                                           }
                                                           weakSelf.selectedSeatIndex = -1;
                                                           weakSelf.object.car_seat_amount = nil;
                                                           WLCarBookingPriceCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
                                                           [cell resetSeatCount];
                                                           
                                                           
                                                       }];
    self.tableView.tableHeaderView = self.headerView;
    
    UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScaleW(10), ScreenHeight - ScaleH(55) - 64, ScaleW(355), ScaleH(45))];
    actionBtn.backgroundColor = Color1;
    actionBtn.layer.cornerRadius = ScaleH(22.5);
    actionBtn.layer.masksToBounds = YES;
    [actionBtn setTitle:@"确认叫车" forState:UIControlStateNormal];
    [actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [actionBtn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: actionBtn];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.fillObject && self.needRefresh) {//再来一单，自动填充
        NSUInteger index = self.object.car_model.integerValue == 1 ? 0 : 1;
        [self.headerView selectItem:index];
        
        WLCarBookingTimeCell *timeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        WLCarBookingViewMode *viewMode = [[WLCarBookingViewMode alloc] init];
        NSUInteger startInterval = self.object.start_at.integerValue;
        if ([[WLDateManager dateDefault] currentDateIsLaterThanTimeInterval:self.object.start_at.integerValue]) {
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *selectComps = [[NSDateComponents alloc] init];
            [selectComps setHour:1];
            NSDate *minDate = [calendar dateByAddingComponents:selectComps toDate:[NSDate date] options:0];
            
            NSDate *newDate = [viewMode updateDateWithDate:minDate];
            
            startInterval = [newDate timeIntervalSince1970];
            self.object.start_at = [NSString stringWithFormat:@"%zd",startInterval];
            
        }
        self.beginDate = [NSDate dateWithTimeIntervalSince1970:startInterval];
        
        NSUInteger endInterval = self.object.end_at.integerValue;
        if ([[WLDateManager dateDefault] currentDateIsLaterThanTimeInterval:self.object.end_at.integerValue]) {

            NSDate *newDate = [viewMode updateEndDateWithDate:[NSDate date]];
            endInterval = [newDate timeIntervalSince1970];
            self.object.end_at = [NSString stringWithFormat:@"%zd",endInterval];
        }
        self.endDate = [NSDate dateWithTimeIntervalSince1970:endInterval];
        
        NSString *startTime = [WLUITool timeStringWithTimeInterval:startInterval formatter:@"MM月dd日 HH:mm"];
        [timeCell setTime:startTime index:0];
        NSString *endTime = [WLUITool timeStringWithTimeInterval:endInterval formatter:@"MM月dd日"];
        [timeCell setTime:endTime index:1];
        
        
        if (self.cityArray.count) {
            for (WLCityItem *provinceItem in self.cityArray) {
                
                if ([provinceItem.cityName isEqualToString:self.fillObject.start_province]) {
                    self.object.start_province_id = provinceItem.cityID;
                    NSArray *cityArray = provinceItem.cityItems;
                    
                    for (WLCityItem *cityItem in cityArray) {
                        if ([cityItem.cityName isEqualToString:self.fillObject.start_city]) {
                            self.object.start_city_id = cityItem.cityID;
                        }
                    }
                }
                if ([provinceItem.cityName isEqualToString:self.fillObject.end_province]) {
                    self.object.end_province_id = provinceItem.cityID;
                    NSArray *cityArray = provinceItem.cityItems;
                    
                    for (WLCityItem *cityItem in cityArray) {
                        if ([cityItem.cityName isEqualToString:self.fillObject.end_city]) {
                            self.object.end_city_id = cityItem.cityID;
                        }
                    }
                }
            }
        }
        self.selectStartCity = self.fillObject.start_city;
        self.selectEndCity = self.fillObject.end_city;
        if (self.object.start_memo_address && ![self.object.start_memo_address isEqualToString:@""]) {
            [self.detailArray replaceObjectAtIndex:0 withObject:self.object.start_memo_address];
        }
        if (self.object.end_memo_address && ![self.object.end_memo_address isEqualToString:@""]) {
            [self.detailArray replaceObjectAtIndex:1 withObject:self.object.end_memo_address];
        }
        
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 3)] withRowAnimation:UITableViewRowAnimationFade];
        
        WLCarBookingInfoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        if (self.fillObject.trip_image.count) {
            [cell setImageUrl:[self.fillObject.trip_image firstObject]];
        }else{
            [cell setImage:nil];
        }
        
    }
    
}

#pragma mark Network
- (void)loadCitys
{
    WS(weakSelf);
   [[AppManager sharedInstance] getCityListWithResultBlock:^(NSArray *cityArray) {
       weakSelf.cityArray = cityArray;
   }];
}

- (void)actionBtnClick:(UIButton *)button
{
    WS(weakSelf);
    NSMutableArray *newArray = [self.addressArray mutableCopy];
    if (newArray.count >= 2) {
        [newArray removeObjectAtIndex:0];
        [newArray removeLastObject];
    }
    NSMutableArray *tempArray = [newArray mutableCopy];
    for (NSString *city in tempArray) {
        if ([city isEqualToString:@"途经城市"]) {
            [newArray removeObject:city];
        }
    }
    
    NSString *visaAddress = @"";
    for (int i = 0; i < newArray.count; i ++) {
        visaAddress = [visaAddress stringByAppendingString:newArray[i]];
        if (i != newArray.count - 1) {
            visaAddress = [visaAddress stringByAppendingString:@","];
        }
    }
    
    self.object.via_address = visaAddress;
    
    if (self.object.start_at == nil) {
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入出发时间"];
        return;
    }
    if (self.object.end_at == nil) {
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入结束时间"];
        return;
    }
    if (self.object.start_province_id == nil) {
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入出发地点"];
        return;
    }
    if (self.object.end_province_id == nil) {
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入结束地点"];
        return;
    }
    if (self.object.car_seat_amount == nil) {
        [[WL_TipAlert_View sharedAlert] createTip:@"请输入座位数"];
        return;
    }
    if (self.object.car_seat_amount.integerValue > 70 || self.object.car_seat_amount.integerValue < 1) {
        [[WL_TipAlert_View sharedAlert] createTip:@"输入的座位数要在1~70之间"];
        return;
    }
    if (self.object.start_at.integerValue > self.object.end_at.integerValue) {
        [[WL_TipAlert_View sharedAlert] createTip:@"出发时间不能大于结束时间"];
        return;
    }
    if ([self.object.use_car_contacts isEqualToString:@"自己"]) {
        self.object.use_car_contacts = @"";
    }
    if (self.companyID) {
        self.object.from_company_id = self.companyID;
    }
    
    
//    self.object.start_at = @"1489715580";

    [self showHud];
    [WLNetworkCarBookingHandler bookingCarWithCarObject:self.object imageArray:self.imageArray dataBlock:^(WLResponseType responseType, id data, NSString *message) {
        [weakSelf hidHud];
        if (responseType == WLResponseTypeSuccess) {
            WLCarBookingAddCostController *costVC = [[WLCarBookingAddCostController alloc] init];
            costVC.object = data;
            costVC.object.fromList = NO;
            costVC.object.companyID = weakSelf.companyID;
            [weakSelf.navigationController pushViewController:costVC animated:YES];
            
            [[WLDataCarBookingHandler sharedInstance] removeCarBookingImageArray];
            [[WLDataCarBookingHandler sharedInstance] removeCarBookingRemark];
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:message];
        }
        
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    if (indexPath.section == 0) {
        WLCarBookingTimeCell *cell = [WLCarBookingTimeCell cellWithTableView:tableView
                                                                 clickAction:^(NSUInteger index) {
                                                                     [weakSelf timeCellActionWithIndex:index];
                                                                 }];
        return cell;
    }else if (indexPath.section == 1){
        WLCarBookingAddressCell *cell = [WLCarBookingAddressCell cellWithTableView:tableView
                                                                        titleArray:self.addressArray
                                                                     addressAction:^(AddressActionType actionType, NSInteger deleteIndex) {
                                                                         
                                                                         [weakSelf addressCellActionWithType:actionType deleteIndex:deleteIndex];
                                                                     }detailArray:self.detailArray];
        return cell;
        
    }else if (indexPath.section == 2){
        NSMutableArray *array = [NSMutableArray array];
        if (self.object.car_seat_amount) {
            [array addObject:self.object.car_seat_amount];
        }
        WLCarBookingPriceCell *cell = [WLCarBookingPriceCell cellWithTableView:tableView
                                                                   clickAction:^{
                                                                       
                                                                       [weakSelf priceCellAction];
                                                                   }placeHoldArray:array];
        cell.onFinishInput = ^(NSString *seatCount){
            
            weakSelf.object.car_seat_amount = seatCount;

        };
        return cell;
        
    }else if (indexPath.section == 3){
        
        
        UIImage *placeImage = [UIImage imageWithData:[self.imageArray firstObject]];
        WLCarBookingInfoCell *cell = [WLCarBookingInfoCell cellWithTableView:tableView
                                                                 clickAction:^(NSUInteger index) {
                                                                     
                                                                     [weakSelf infoCellActionWithIndex:index];
                                                                 }placeHoldText:self.contactText
                                                                     placeImage:placeImage];
        return cell;
        
    }else if (indexPath.section == 4){
        
        NSString *placeHoldText = @"备注";
        if (self.object.memo && ![self.object.memo isEqualToString:@""]) {
            placeHoldText = self.object.memo;
        }
        WLCarBookingRemarkCell *cell = [WLCarBookingRemarkCell cellWithTableView:tableView
                                                                     clickAction:^(NSUInteger index) {
                                                                         
                                                                         [weakSelf infoCellActionWithIndex:1];
                                                                     }placeHoldText:placeHoldText];
        return cell;
        
    }
    return nil;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return ScaleH(45) * self.addressArray.count;;
    }
    if (indexPath.section == 2 || indexPath.section == 4) {
        return ScaleH(45);
    }
    return ScaleH(90);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(15);
}

#pragma mark bussiness logic

- (void)timeCellActionWithIndex:(NSUInteger)index
{
    WS(weakSelf);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];//[NSDate dateWithTimeIntervalSince1970:1489650360];
    
    DatePickerMode mode;
    NSDate *minDate;
    NSDate *maxDate;
    NSDate *selectDate;
    if (index == 0) {//出发时间
        mode = DatePickerTimeMode;
        
        NSDateComponents *minComps = [[NSDateComponents alloc] init];
        [minComps setMinute:15];
        minDate = [calendar dateByAddingComponents:minComps toDate:currentDate options:0];
        
        NSDateComponents *maxComps = [[NSDateComponents alloc] init];
        [maxComps setMonth:3];
        maxDate = [calendar dateByAddingComponents:maxComps toDate:currentDate options:0];

        if (self.beginDate) {
            selectDate = self.beginDate;
        }else{
            NSDateComponents *selectComps = [[NSDateComponents alloc] init];
            [selectComps setHour:1];
            selectDate = [calendar dateByAddingComponents:selectComps toDate:currentDate options:0];
        }
    }else{//结束时间
        mode = DatePickerHourMode;
        
        if (self.beginDate) {
            minDate = [[WLDateManager dateDefault] changeDateToDateWith:self.beginDate andFormatter:@"yyyy-MM-dd"];
        }else{
            minDate = [[WLDateManager dateDefault] changeDateToDateWith:currentDate andFormatter:@"yyyy-MM-dd"];
        }
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:30];
        maxDate = [calendar dateByAddingComponents:comps toDate:minDate options:0];
        
        if (self.endDate) {
            selectDate = self.endDate;
        }else{
            selectDate = minDate;
        }
        
    }
    
    self.datePicker = [[HCGDatePickerAppearance alloc] initWithDatePickerMode:mode minDate:minDate maxDate:maxDate selectDate:selectDate completeBlock:^(BOOL isCancel, NSDate *date) {
        
        [weakSelf.datePicker hide];
        if (!isCancel) {
            WLCarBookingTimeCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            if (index == 0) {
                
                NSString *timeString = [weakSelf getTimeStringWithDate:date formatterString:@"MM月dd日 HH:mm"];
                [cell setTime:timeString index:0];
                
                NSString *timeString1 = [weakSelf getTimeStringWithDate:date formatterString:@"yyyy-MM-dd HH:mm:ss"];
                NSString *time2 = [WLUITool timeIntervalWithTimeString:timeString1 formatter:@"yyyy-MM-dd HH:mm:ss"];
                
                weakSelf.object.start_at = time2;
                weakSelf.beginDate = date;
            }else{
                
                weakSelf.endDate = date;
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:date];
                NSInteger hour = [components hour];
                if (hour == 0) {
                    NSString *timeString = [weakSelf getTimeStringWithDate:date formatterString:@"MM月dd日"];
                    [cell setTime:timeString index:1];
                    
                    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                    NSDateComponents *comps = [[NSDateComponents alloc] init];
                    [comps setHour:23];
                    [comps setMinute:59];
                    date = [calendar dateByAddingComponents:comps toDate:date options:0];
                    
                    NSString *timeString1 = [weakSelf getTimeStringWithDate:date formatterString:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *time2 = [WLUITool timeIntervalWithTimeString:timeString1 formatter:@"yyyy-MM-dd HH:mm:ss"];
                    
                    weakSelf.object.end_at = time2;
                }else{
                    NSString *timeString = [weakSelf getTimeStringWithDate:date formatterString:@"MM月dd日 HH时"];
                    [cell setTime:timeString index:1];
                    
                    NSString *timeString1 = [weakSelf getTimeStringWithDate:date formatterString:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *time2 = [WLUITool timeIntervalWithTimeString:timeString1 formatter:@"yyyy-MM-dd HH:mm:ss"];
                    
                    weakSelf.object.end_at = time2;
                }
                
            }
        }

    }];
    [self.datePicker show];

}

- (void)addressCellActionWithType:(AddressActionType)type deleteIndex:(NSUInteger)deleteIndex
{
    WS(weakSelf);
    switch (type) {
        case AddressActionTypeInputStartingPoint:{
            
            WLCarBookingAddressController *addressVC = [[WLCarBookingAddressController alloc] init];
            [addressVC setDataArray:self.cityArray isStart:YES selectCity:self.selectStartCity];
            addressVC.onAddressBlock = ^(NSString *provinceID, NSString *cityID, NSString *address,NSString *city,NSString *detailAddress){
                
                WlLog(@"%@",detailAddress);
                weakSelf.needRefresh = NO;
                weakSelf.object.start_province_id = provinceID;
                weakSelf.object.start_city_id = cityID;
                weakSelf.object.start_address = address;
                weakSelf.object.start_memo_address = detailAddress;
                weakSelf.selectStartCity = city;
                [weakSelf.addressArray replaceObjectAtIndex:0 withObject:address];
                [weakSelf.detailArray replaceObjectAtIndex:0 withObject:detailAddress];
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            };
            [self presentViewController:addressVC animated:YES completion:nil];
            break;
        }
        case AddressActionTypeInputTerminalPoint:{
            
            WLCarBookingAddressController *addressVC = [[WLCarBookingAddressController alloc] init];
            [addressVC setDataArray:self.cityArray isStart:NO selectCity:self.selectEndCity];
            addressVC.onAddressBlock = ^(NSString *provinceID, NSString *cityID, NSString *address,NSString *city,NSString *detailAddress){
                
                weakSelf.needRefresh = NO;
                weakSelf.object.end_province_id = provinceID;
                weakSelf.object.end_city_id = cityID;
                weakSelf.object.end_address = address;
                weakSelf.object.end_memo_address = detailAddress;
                weakSelf.selectEndCity = city;
                [weakSelf.addressArray replaceObjectAtIndex:weakSelf.addressArray.count - 1 withObject:address];
                [weakSelf.detailArray replaceObjectAtIndex:1 withObject:detailAddress];
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            };
            [self presentViewController:addressVC animated:YES completion:nil];
            break;
        }
        case AddressActionTypeAddPoint:{
            [self.addressArray insertObject:@"途经城市" atIndex:self.addressArray.count - 1];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case AddressActionTypeDeletePoint:{
            [self.addressArray removeObjectAtIndex:deleteIndex];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case AddressActionTypeInputVisaPoint:{
            self.editTag = deleteIndex;
            [self addVisaAddress];
            break;
        }
            
            
        default:
            break;
    }
    
}

- (void)priceCellAction
{
//    WS(weakSelf);
//    NSMutableArray *seatArray = [self.busSeatArray mutableCopy];
//    if (self.object.car_model.integerValue == CarModelCar) {
//        seatArray = [self.carArray mutableCopy];
//    }else if (self.object.car_model.integerValue == CarModelVehicle){
//        seatArray = [self.busscarSeatArray mutableCopy];
//    }
//    NSMutableArray *countArray = [NSMutableArray array];
//    for (int i = 0; i < seatArray.count; i++) {
//        [countArray addObject:[NSString stringWithFormat:@"%@个座位",seatArray[i]]];
//    }
//    NSInteger initIndex = self.selectedSeatIndex == -1 ? 0 : self.selectedSeatIndex;
//    [LeoActionPicker showPickerWithSender:self.tableView Title:nil Array:countArray InitIndex:initIndex Block:^(NSInteger index) {
//        WLCarBookingPriceCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//        NSString *seat;
//        if (weakSelf.object.car_model.integerValue == CarModelCar) {
//            seat = weakSelf.carArray[index];
//        }else if (weakSelf.object.car_model.integerValue == CarModelVehicle){
//            seat = weakSelf.busscarSeatArray[index];
//        }else if (weakSelf.object.car_model.integerValue == CarModelBus){
//            seat = weakSelf.busSeatArray[index];
//        }
//        weakSelf.selectedSeatIndex = index;
//        [cell setSeatCount:seat.integerValue];
//        weakSelf.object.car_seat_amount = seat;
//    }];
}

- (void)infoCellActionWithIndex:(NSUInteger)index
{
    WS(weakSelf);
    if (index == 2) {
        
        WLCarBookingPictureController *costVC = [[WLCarBookingPictureController alloc] init];
        [costVC setSaveAction:^(NSArray *imageArray) {
            
            weakSelf.needRefresh = NO;
            weakSelf.imageArray = [imageArray mutableCopy];
            WLCarBookingInfoCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
            if (imageArray.count) {
                UIImage *image = [UIImage imageWithData:[imageArray firstObject]];
                [cell setImage:image];
            }else{
                [cell setImage:nil];
            }
            
        }];
        costVC.fillArray = self.fillObject.trip_image;
        [self.navigationController pushViewController:costVC animated:YES];
        

        
    }else{
        
        WLCarBookingEditInfoController *infoVC = [[WLCarBookingEditInfoController alloc] init];
        [infoVC setOriginalName:self.object.use_car_contacts phone:self.object.use_car_mobile];
        [infoVC setSaveAction:^(NSString *firstTitle, NSString *secondTitle) {
            
            weakSelf.needRefresh = NO;
            NSString *text = firstTitle;
            if (index == 0) {
                weakSelf.object.use_car_contacts = firstTitle;
                weakSelf.object.use_car_mobile = secondTitle;
                if (firstTitle.length > 8) {
                    firstTitle = [firstTitle substringToIndex:8];
                }
                text = [NSString stringWithFormat:@"%@ %@",firstTitle, secondTitle];
                
                WLCarBookingInfoCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
                [cell setText:text];
            }else{
                weakSelf.object.memo = firstTitle;
                
                WLCarBookingRemarkCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
                [cell setRemark:text];
            }
            
            
        } remark:index == 1];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    
}

- (void)addVisaAddress
{
    if (self.cityArray.count == 0) {
        [[WL_TipAlert_View sharedAlert] createTip:@"网络异常，请稍微再试~"];
        return;
    }
    STPickerCity *pickerArea = [[STPickerCity alloc] initWithArray:self.cityArray];
    [pickerArea setDelegate:self];
    [pickerArea setContentMode:STPickerContentModeBottom];
    pickerArea.defaultCityName = self.locationCity;
    [pickerArea show];
    if (self.editTag && self.editTag < self.addressArray.count - 1) {
        NSString *city = self.addressArray[self.editTag];
        if (![city isEqualToString:@"途经城市"]) {
            pickerArea.defaultCityName = city;
        }
        
    }
}

- (void)pickerCity:(STPickerCity *)pickerCity province:(NSString *)province city:(NSString *)city provinceID:(NSString *)provinceID cityID:(NSString *)cityID
{
    [self.addressArray replaceObjectAtIndex:self.editTag  withObject:city];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

}

#pragma mark private method
- (NSString *)getTimeStringWithDate:(NSDate *)date formatterString:(NSString *)formatterString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterString];
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = - ScaleH(40);
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

#pragma mark baiduMap
- (void)setupBaiduMap
{

    //定位功能
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

//定位结果
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [self.locationManager stopUpdatingLocation];
    CLLocation* location = locations.lastObject;
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error || placemarks.count == 0){
            NSLog(@"error = %@",error);
            [[WL_TipAlert_View sharedAlert] createTip:@"定位失败"];

        }else{
            
            CLPlacemark* placemark = placemarks.firstObject;
            NSDictionary *dict = [placemark addressDictionary];
            NSString *city = [dict objectForKey:@"City"];
            if ([city hasSuffix:@"市"]) {
                city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            [self.locationManager stopUpdatingLocation];
            self.locationCity = city;
        }
    }];
}

#pragma mark Lazy load
- (NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

- (NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)setCompanyID:(NSString *)companyID
{
    _companyID = companyID;
    if (!self.fillObject) {//正常途径进入
        self.addressArray = [@[@"出发地点",@"结束地点"] mutableCopy];
        self.detailArray = [@[@"",@""] mutableCopy];
        self.object = [[WLBookingCarObject alloc] init];
        self.object.car_model = @"1";
        self.object.use_car_contacts = @"自己";
        self.object.use_car_mobile = [WLUserTools getUserMobile];

        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"CarBookingSavedUserInfo"];
        if (dict) {
            NSString *name = [dict objectForKey:@"name"];
            NSString *phone = [dict objectForKey:@"phone"];
            self.object.use_car_contacts = name;
            self.object.use_car_mobile = phone;
            if (name.length > 8) {
                name = [name substringToIndex:8];
            }
            self.contactText = [NSString stringWithFormat:@"%@ %@",name,phone];
            
        }else{
            self.contactText = [NSString stringWithFormat:@"自己 %@",[WLUserTools getUserMobile]];
        }
        
        [[WLDataCarBookingHandler sharedInstance] removeCarBookingImageArray];
        [[WLDataCarBookingHandler sharedInstance] removeCarBookingRemark];
    }
}


/**
 再来一单
 */
- (void)setFillObject:(WLCarBookingOrderDetailObject *)fillObject
{
    _fillObject = fillObject;
    
    self.needRefresh = YES;
    
    self.object = [[WLBookingCarObject alloc] init];
    self.object.from_company_id = fillObject.from_company_id;
    self.object.car_model = fillObject.car_model;
    self.object.start_at = fillObject.start_at;
    self.object.end_at = fillObject.end_at;
    
    self.detailArray = [@[@"",@""] mutableCopy];
    
    [self.addressArray addObject:fillObject.start_address];
    NSArray *visArray = [fillObject.via_address componentsSeparatedByString:@","];
    for (NSString *visCity in visArray) {
        if (![visCity isEqualToString:@""]) {
            [self.addressArray addObject:visCity];
        }
        
    }
    [self.addressArray addObject:fillObject.end_address];
    
    self.object.start_address = fillObject.start_address;
    self.object.start_memo_address = fillObject.start_memo_address;
    self.object.end_address = fillObject.end_address;
    self.object.end_memo_address = fillObject.end_memo_address;
    self.object.via_address = fillObject.via_address;
    self.object.car_seat_amount = fillObject.car_seat_amount;
    self.object.use_car_contacts = fillObject.use_car_contacts;
    self.object.use_car_mobile = fillObject.use_car_mobile;
    if (![fillObject.memo isEqualToString:@"查看行程详情"]) {
        self.object.memo = fillObject.memo;
    }
    if (![fillObject.memo isEqualToString:@""] && fillObject.memo != nil && ![fillObject.memo isEqualToString:@"查看行程详情"]) {
        [[WLDataCarBookingHandler sharedInstance] saveCarBookingRemark:fillObject.memo];
    }
    
    if (self.object.use_car_contacts && ![self.object.use_car_contacts isEqualToString:@""]) {
        self.contactText = [NSString stringWithFormat:@"%@ %@",self.object.use_car_contacts, self.object.use_car_mobile];
    }else{
        self.contactText = [NSString stringWithFormat:@"自己 %@", self.object.use_car_mobile];
    }
    
    WS(weakSelf);
    
    NSMutableArray *tempArray = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();

    if (self.fillObject.trip_image.count) {

        [self showHud];
        [self.fillObject.trip_image enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            dispatch_group_enter(group);
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:obj] options:SDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    dispatch_group_leave(group);
                    
                    NSData *data = UIImageJPEGRepresentation(image, 0.8);
                    if (image) {
                        [tempArray addObject:image];
                    }
                    if (data) {
                        [weakSelf.imageArray addObject:data];
                    }
                }];
            });
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        WlLog(@"任务完成");
        [weakSelf hidHud];
        [[WLDataCarBookingHandler sharedInstance] saveCarBookingImageArray:tempArray];
    });
    
   
}
/*
 UIImageView *imageView = [[UIImageView alloc] init];
 [imageView sd_setImageWithURL:[NSURL URLWithString:obj] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
 
 NSData *data = UIImageJPEGRepresentation(image, 0.8);
 [tempArray addObject:image];
 [weakSelf.imageArray addObject:data];
 if (idx == weakSelf.fillObject.trip_image.count - 1) {
 
 [[WLDataCarBookingHandler sharedInstance] saveCarBookingImageArray:tempArray];
 
 }
 
 }];
 */


@end
