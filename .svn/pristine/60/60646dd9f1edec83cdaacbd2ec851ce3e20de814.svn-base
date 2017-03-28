//
//  STPickerCity.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/23.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "STPickerCity.h"
#import "WLCityItem.h"

@interface STPickerCity()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *cityArray;
/** 2.当前省数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayProvince;
/** 3.当前城市数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayCity;

/** 6.省份 */
@property (nonatomic, strong, nullable)NSString *province;
/** 7.城市 */
@property (nonatomic, strong, nullable)NSString *city;

@property (nonatomic, assign) NSInteger index0;
@property (nonatomic, assign) NSInteger index1;

@end

@implementation STPickerCity

#pragma mark - --- init 视图初始化 ---

- (NSMutableArray *)getStringArrayWithArray:(NSArray *)array
{
    NSMutableArray *objectArray = [NSMutableArray array];
    for (WLCityItem *item in array) {
        [objectArray addObject:item.cityName];
    }
    return objectArray;
    
}

- (void)setDefaultCityName:(NSString *)defaultCityName
{
    _defaultCityName = defaultCityName;
    NSInteger provinceID = 0;
    NSInteger cityID = 0;
    for (int i = 0; i < self.cityArray.count; i++) {
        WLCityItem *provinceItem = self.cityArray[i];
        NSArray *citys = provinceItem.cityItems;
        for (int j = 0; j < citys.count; j++) {
            WLCityItem *cityItem = citys[j];
            if ([defaultCityName isEqualToString:cityItem.cityName]) {
                provinceID = i;
                cityID = j;
                self.province = provinceItem.cityName;
                self.city = cityItem.cityName;
            }
        }
    }
    [self.pickerView selectRow:provinceID inComponent:0 animated:YES];
    [self.arrayCity removeAllObjects];
    self.index0 = provinceID;
    self.index1 = cityID;
    WLCityItem *provinceItem = self.cityArray[provinceID];
    self.arrayCity = [self getStringArrayWithArray:provinceItem.cityItems];
    
    [self.pickerView reloadComponent:1];
    [self.pickerView selectRow:cityID inComponent:1 animated:YES];

    
}

- (void)setupUIWithDataArray:(NSArray *)array
{
    self.cityArray = array;
    self.arrayProvince = [self getStringArrayWithArray:self.cityArray];
    WLCityItem *provinceItem = self.cityArray[0];
    self.arrayCity = [self getStringArrayWithArray:provinceItem.cityItems];

    self.province = self.arrayProvince[0];
    self.city = self.arrayCity[0];

    // 2.设置视图的默认属性
    _heightPickerComponent = 32;
//    [self setTitle:@"请选择省份城市"];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}
#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.arrayProvince.count;
    }else {
        return self.arrayCity.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {

        [self.arrayCity removeAllObjects];
        WLCityItem *provinceItem = self.cityArray[row];
        self.arrayCity = [self getStringArrayWithArray:provinceItem.cityItems];
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        
    }else{
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  self.arrayProvince[row];
    }else if (component == 1){
        text =  self.arrayCity[row];
    }
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    WLCityItem *provinceItem = self.cityArray[self.index0];
    
    WLCityItem *cityItem = provinceItem.cityItems[self.index1];
    [self.delegate pickerCity:self province:self.province city:self.city provinceID:provinceItem.cityID cityID:cityItem.cityID];
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    self.index0 = index0;
    self.index1 = index1;
    self.province = self.arrayProvince[index0];
    self.city = self.arrayCity[index1];

    NSString *title = [NSString stringWithFormat:@"%@ %@", self.province, self.city];
    [self setTitle:title];
    
}

#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 ---


- (NSMutableArray *)arrayProvince
{
    if (!_arrayProvince) {
        _arrayProvince = [NSMutableArray array];
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity
{
    if (!_arrayCity) {
        _arrayCity = [NSMutableArray array];
    }
    return _arrayCity;
}

@end
