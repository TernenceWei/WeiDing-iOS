//
//  WL_Application_Driver_AcceptOrderTipView.h
//  WeiLvDJS
//
//  Created by whw on 16/12/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

/**< 提示类型 */
typedef NS_ENUM(NSInteger, WLOrderTipType){
    /** 接单提示 */
    WLOrderTipAccept = 200,
    /** 开始提示 */
    WLOrderTipStart,
    /** 结束提示 */
    WLOrderTipEnd,
    /** 金额提示 */
    WLOrderTipMoney,
    /** 删除失效订单提示 */
    WLOrderTipDelete,
    /**< 收款提示 */
    WLReceivedRecord,
    /**< 无法编辑 */
    WLCarTipNOEdit,
    /**< 确认编辑 */
    WLCarTipEdit,
    /**< 确认提交 */
    WLCarTipSubmit,
    /**< 车辆信息新增成功 */
    WLCarAddSuccess,
    /**< 抢单出发 */
    WLBookOrderTipStart,
    /**< 抢单结束 */
    WLBookOrderTipEnd,
};

@interface WL_Application_Driver_OrderTipView : UIView

/**< 底部选择按钮的回调 */
@property (nonatomic, copy) void(^seletedCallBack)(BOOL isAccept);

/**< 自定义构造方法 */
- (instancetype)initWithFrame:(CGRect)frame andTipType:(WLOrderTipType)type;
/**< 出发信息 */
@property (nonatomic, copy) NSString*startInfo;
@end
