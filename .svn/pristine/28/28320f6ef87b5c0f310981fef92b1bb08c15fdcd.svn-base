//
//  STPickerCity.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/23.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPickerView.h"
NS_ASSUME_NONNULL_BEGIN
@class STPickerCity;

@protocol  STPickerCityDelegate<NSObject>

- (void)pickerCity:(STPickerCity *)pickerCity
          province:(NSString *)province
              city:(NSString *)city
        provinceID:(NSString *)provinceID
            cityID:(NSString *)cityID;

@end


@interface STPickerCity : STPickerView

/** 1.中间选择框的高度，default is 32*/
@property (nonatomic, assign)CGFloat heightPickerComponent;

@property(nonatomic, weak)id <STPickerCityDelegate>delegate ;

@property (nonatomic, strong) NSString *defaultCityName;

@end
NS_ASSUME_NONNULL_END
