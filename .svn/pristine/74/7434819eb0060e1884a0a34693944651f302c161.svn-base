//
//  WL_Application_Driver_addCar_viewController.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
@class WL_Application_carListInformation_model;
typedef NS_ENUM (NSUInteger, WLPictureType){
    WLPictureTypeDriver       = 0,//行驶证
    WLPictureTypeCar    = 1,//车辆相关
    WLPictureTypeLicense   = 2,//营运证
};
typedef NS_ENUM (NSUInteger, WLPictureOperation){
    WLPictureOperationAdd       = 1,//新增
    WLPictureOperationEdit    = 2,//更改
    WLPictureOperationDelete   = 3,//删除
};
@interface WL_Application_Driver_addCar_viewController : WL_BaseViewController

@property(nonatomic,assign)BOOL isEdit;//是否在编辑
@property(nonatomic,assign)BOOL isChange;
@property(nonatomic,copy)NSString *carStatus;
@property(nonatomic,copy)NSString *companyId;
/**< 司机id */
@property (nonatomic, copy) NSString *driveId;
@end
