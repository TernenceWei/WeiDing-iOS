//
//  WL_NoData_View.h
//  WeiLv
//
//  Created by wangning on 16/6/17.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WLNetworkType){
    
    WLNetworkTypeNONetWork,//无网络
    WLNetworkTypeNOSearchResult,//无搜索结果
    WLNetworkTypeNOData, //无数据
    WLNetworkTypeSeverError, //服务器出错
    WLNetworkTypeCustom //自定义类型
    
};

@interface WL_NoData_View : UIView

- (instancetype)initWithFrame:(CGRect)frame andRefreshBlock:(void(^)())refresh;

@property (nonatomic,assign)WLNetworkType type;

@property(nonatomic,copy)NSString *isFive;

//当type为Custom的时候  这两个字段为必传
@property (nonatomic,copy) NSString *tipString;
@property (nonatomic,copy) NSString *tipButtonString;
@property(nonatomic,copy)NSString *errorImage;

@end
