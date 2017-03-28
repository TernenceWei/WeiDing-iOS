//
//  WLBaiduMapViewController.h
//  WeiLvDJS
//
//  Created by hsliang on 2017/2/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "WLCityItem.h"

@interface WLBaiduMapViewController : WL_BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSString * company_id;
@property (nonatomic, strong) NSString * cityName;

@property (nonatomic, strong) NSArray * cityArr; // 服务器获得的城市信息列表

@end
