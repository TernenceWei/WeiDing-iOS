//
//  WLNetworkDriverHandler.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLNetworkUrlHeader.h"
#import "WLNetworkTool.h"

#import "WLDriverInfoModel.h"

typedef NS_ENUM (NSUInteger, WLDriverStatus){
    WLDriverStatusUnAutherized          = -1,      //未认证
    WLDriverStatusReviewing             = 0,       //审核中
    WLDriverStatusAutherized            = 1,       //已认证
    WLDriverStatusAuthenticationFailed  = 2,       //认证失败
    WLDriverStatusForbidden             = 3,       //已禁用
};

typedef NS_ENUM (NSUInteger, WLCarStatus){
    WLCarStatusUnAutherized          = -1,       //未认证
    WLCarStatusReviewing             = 0,        //审核中
    WLCarStatusAutherized            = 1,        //已认证
    WLCarStatusAuthenticationFailed  = 2,        //认证失败
    WLCarStatusForbidden             = 3,        //已禁用
};


@interface WLNetworkDriverHandler : NSObject
+ (instancetype)sharedInstance;

/**
 应用首页获取公司列表
 
 @param resultBlock 公司列表与角色
 */
- (void)requestCompanyListWithDataBlock:(CompletionDataBlock)block;
/**
 司机首页用于获取司机和车辆的认证状态

 @param resultBlock 司机状态和车辆状态
 */
- (void)requestDriverAndCarStatusWithCompanyID:(NSString *) companyID AndResultBlock:(void (^)(BOOL, WLDriverStatus, WLCarStatus,NSNumber *drive_id, NSString *))resultBlock;
/**< 更新司机选择的城市 */
- (void)updateDriveCityWith:(NSString *)company_id province:(NSString *)province_id city:(NSString *)city_id resultBlock:(StatusBlock)block;
/***获取车辆信息***/
- (void)requestCarInfoWithCompanyID:(NSString *)companyID AndDataBlock:(CompletionDataBlock)block;

/**< 编辑车辆图片 */
- (void)editCarPicturesWithDict:(NSDictionary *)params
                    resultBlock:(OperationBlock)block;


/**
 新增车辆信息

 @param params
 @param block
 */
- (void)addCarInfoWithDict:(NSDictionary *)params
               resultBlock:(OperationBlock)block;


/**
 编辑车辆信息

 @param params
 @param block 
 */
- (void)editCarInfoWithDict:(NSDictionary *)params
                resultBlock:(OperationBlock)block;


/***
 获取司机信息
 **/
- (void)requestDriverInfoWithResultBlock:(void(^)(BOOL success,NSString * message,NSDictionary * dataDic))resultBlock;

/***
 编辑提交司机信息
 **/
- (void)requestEditDriverInfoWith:(WLDriverInfoModel *)edit ResultBlock:(void(^)(BOOL success,NSString * message))resultBlock;

/***
 新增司机信息
 **/
- (void)requestAddDriverInfoWith:(WLDriverInfoModel *)edit ResultBlock:(void(^)(BOOL success,NSString * message))resultBlock;

/***
 单独修改司机证件照
 **/
- (void)requesteditImgDriverInfoWith:(NSString *)driverId fileid:(NSString *)fileid type:(NSString *)type changeImg:(UIImage *)image ResultBlock:(void(^)(BOOL success,NSString * message))resultBlock;
/**
 设置司机接单参数
 @param car_id 车辆ID
 @param is_reception 是否接单
 @param reception_lowest 最少接单人数
 @param block 请求状态回调
 */
- (void)setAcceptOrderParasWithCarID:(NSString *)car_id
                        Is_reception:(BOOL)is_reception
                    Reception_lowest:(NSString *)reception_lowest
                         statusBlock:(StatusBlock)block;

/**
 获取订单列表

 @param type 待接单@“1”，已接单@“2”，已失效@“3”
 @param nextUrl 下拉刷新的时候传nil，上拉刷新的时候传上次返回给你的字符串
 @param block 订单列表和下页url
 */
- (void)requestOrderListWithType:(NSString *)type nextUrl:(NSString *)nextUrl dataBlock:(CompletionDataBlock)block;


/**
 获取订单详情

 @param orderID orderID
 @param block
 */
- (void)requestOrderDetailWithOrderID:(NSString *)orderID dataBlock:(CompletionDataBlock)block;
/**
 竞价验证
 @param orderID 订单号
 @param companyID 公司ID
 @param block
 */
- (void)bidCheckOrderWithOrderID:(NSString *)orderID companyID:(NSString *)companyID  statusBlock:(StatusBlock)block;
/**
 竞价 报价
 @param orderID 订单号
 @param companyID 公司ID
  @param bid_price 报价价格
 @param block
 */
- (void)bidOrderWithOrderID:(NSString *)orderID companyID:(NSString *)companyID andBid_price:(NSString *)bid_price  Cost_memo:(NSString *)cost_memo statusBlock:(StatusBlock)block;
/**
抢单
 @param orderID 订单号
 @param companyID 公司ID
 @param block
 */
- (void)bookOrderWithOrderID:(NSString *)orderID companyID:(NSString *)companyID statusBlock:(StatusBlock)block;
/**
 接单或拒单

 @param orderID 订单号
 @param orderOperation 接单传@“1”，拒单传@“2”
 @param block
 */
- (void)modifyOrderStatusWithOrderID:(NSString *)orderID
                      orderOperation:(NSString *)orderOperation
                        refuseReason:(NSString *)reason
                            dataBlock:(CompletionDataBlock)block;


/**
 出发或结束

 @param orderID 订单号
 @param tripOperation 出发传@“1”，结束传@“2”
 @param money 客户支付金额
 @param block
 */
- (void)modifyOrderStatusWithOrderID:(NSString *)orderID
                       tripOperation:(NSString *)tripOperation
                               money:(NSString *)money
                           dataBlock:(CompletionDataBlock)block;


/**
 清空已失效订单

 @param operationBlock 
 */
- (void)deleteOutOfDateOrderListWithOperationBlock:(OperationBlock)operationBlock;



/**
 获取账单列表

 @param type 1未结算2已结算
 @param dataBlock 
 */
- (void)requestDriverBillListWithType:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock;


/**
 获取账单统计

 @param dataBlock 
 */
- (void)requestDriverBillStatisticsWithDataBlock:(CompletionDataBlock)dataBlock;

/**
 获取个人资料
 
 @param dataBlock
 */
- (void)requestUserInfoWithDataBlock:(CompletionDataBlock)dataBlock;

/**
 获取个人二维码
 
 @param dataBlock
 */
- (void)requestQRcodeWithDataBlock:(CompletionDataBlock)dataBlock;

// 上传步骤1
- (void)sengheadImgWithData:(UIImage *)Img block:(void(^)(BOOL success, NSString * base_url, NSString *path))resultBlock;

// 上传步骤2
- (void)sengheadImgAgainWithData:(NSString *)baseurl path:(NSString *)patt block:(void(^)(BOOL success,NSString * message))resultBlock;

/***
 新增司机信息
 **/
- (void)requestChangePersonalInfoWith:(NSDictionary *)params iSEmail:(BOOL)isemail ResultBlock:(void(^)(BOOL success,NSString * message))resultBlock;


/***
 提交意见
 **/
- (void)requestFeedBackWith:(NSString *)contentStr ResultBlock:(void(^)(BOOL success, NSInteger status,NSString * message))resultBlock;


@end
