//
//  WLTouristGroupHeader.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#ifndef WLTouristGroupHeader_h
#define WLTouristGroupHeader_h

typedef NS_ENUM(NSUInteger, TouristItemType) {
    TouristItemTypeCar = 10,//用车
    TouristItemTypeHotel = 4,//酒店
    TouristItemTypeMeal = 5,//餐饮
    TouristItemTypeTicket = 6,//门票
    TouristItemTypeShopping = 9,//购物
    TouristItemTypeAdditional = -2,//加点
    
};

typedef NS_ENUM(NSUInteger, TouristRoleType) {
    TouristRoleTypeMainGuide,//主导游
    TouristRoleTypeDeputyGuide,//副导游
    TouristRoleTypeMine,//我
    TouristRoleTypeOther,//他人
    
};

typedef NS_ENUM(NSUInteger, TouristGuideOauthStatus) {
    TouristGuideOauthStatusUnknown = 0,//未知
    TouristGuideOauthStatusIning   = 1,//审核中
    TouristGuideOauthStatusAlready = 2,//认证成功
    TouristGuideOauthStatusFailure = 3,//认证失败
    
};

typedef NS_ENUM(NSUInteger, ModifyGroupStatus) {
    ModifyGroupStatusEnd = 0,//下团
    ModifyGroupStatusBegin = 1,//出团
    
};

typedef NS_ENUM(NSUInteger, GroupOrderType) {
    GroupOrderTypeGroup = 1,//出团
    GroupOrderTypeOrder = 2,//接单
    
};

typedef NS_ENUM(NSUInteger, GroupStatus) {
    GroupStatusAll        = 0,//所有出团
    GroupStatusUnPaiDan   = 1,//未派单
    GroupStatusUnQueRen   = 2,//未确认
    GroupStatusUnChuTuan  = 3,//未出团
    GroupStatusUnBaoZhang = 4,//未报账(账单详情是待提交)
    GroupStatusUnShenHe   = 5,//未审核(账单详情是审核中)
    GroupStatusUnJieZhang = 6,//未结账(账单详情是已审核)
    GroupStatusJieZhang   = 7,//已结账
    
    GroupStatusYiShenHe = 9,//已审核
    GroupStatusShenHeFailure   = 8,//审核失败
    
};

typedef NS_ENUM(NSUInteger, OrderStatus) {
    OrderStatusUnSend         = 1,//未派单
    OrderStatusWaitReceive    = 2,//待接单
    OrderStatusAlreadyReceive = 3,//已接单
    OrderStatusOutOfDate      = 4,//已失效（4.5.6）
    OrderStatusJingJiaIng     = 7,//竞价中
    
};

typedef NS_ENUM(NSUInteger, PaymentMode) {
    PaymentModeCheck = 0,//挂账
    PaymentModeCash = 1,//现付
    
};

typedef NS_ENUM(NSUInteger, JourneyStatus) {
    JourneyStatusDaiChuTuan = 1,//待出团
    JourneyStatusChuTuanZhong = 2,//出团中
    JourneyStatusYiXiaTuan = 3,//已下团
};

typedef NS_ENUM(NSUInteger, GroupItemCellType) {
    GroupItemCellTypeTitle,//标题
    GroupItemCellTypeItem,//数据条目
    GroupItemCellTypeContact,//联系人
    GroupItemCellTypeAction,//记账
    GroupItemCellTypeItemMargin,//条目间隔
    GroupItemCellTypeCarTitle,//司机标题
    GroupItemCellTypeCarItem,//司机数据条目
    
};




typedef NS_ENUM(NSUInteger, HotelListStatus) {
    HotelListStatusWaitReceive   = 1,//待接单
    HotelListStatusBidding       = 2,//竞价中
    HotelListStatusOutOfDate     = 3,//已失效
    HotelListStatusUnSettle      = 4,//未记账
    HotelListStatusAlreadySettle = 5,//已结账
    
};

typedef NS_ENUM(NSUInteger, HotelActionType) {
    HotelActionTypeRejectOrder     = 1,//不接单
    HotelActionTypeReceiveOrder    = 2,//确认接单
    HotelActionTypeCancelQuote     = 3,//取消报价
    
};

#endif /* WLTouristGroupHeader_h */
