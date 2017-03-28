//
//  WLDriverOrderObject.h
//  WeiLvDJS
//
//  Created by ternence on 2016/12/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDriverOrderObject : NSObject
@property (nonatomic, strong) NSString *car_brand;//车的品牌
@property (nonatomic, strong) NSString *car_enabled_at;//车辆首次启用日期
@property (nonatomic, strong) NSString *car_model;//车型//1 大巴
@property (nonatomic, strong) NSString *car_seat_amount;//座位数
@property (nonatomic, strong) NSString *created_at;//创建时间
@property (nonatomic, strong) NSString *customer_adjust_price;//客户调价
@property (nonatomic, strong) NSString *customer_contacts;//客户联系人//用车联系人姓名
@property (nonatomic, strong) NSString *customer_mobile;//客户联系人手机号码
@property (nonatomic, strong) NSString *customer_pay_amount;//客户支付
@property (nonatomic, strong) NSString *dj_group_number;//团号
@property (nonatomic, strong) NSString *end_address;//到达地点
@property (nonatomic, strong) NSString *end_memo_address;//结束详情地址
@property (nonatomic, strong) NSString *end_at;//到达时间
@property (nonatomic, strong) NSString *expiry_at;//过期时间 接单：过期时间//接单有效期 /抢单 支付有效期
@property (nonatomic, strong) NSString *from_company_name;//客户企业名称
//@property (nonatomic, strong) NSString *is_deleted;//过期时间
@property (nonatomic, strong) NSString *is_local;//订单来源//0 本地，1 网络，2 c 端APP
@property (nonatomic, strong) NSString *memo;//备注信息
@property (nonatomic, strong) NSString *number;//派单号
@property (nonatomic, strong) NSString *order_price;//派单价
@property (nonatomic, strong) NSString *pay_at;//结算时间
@property (nonatomic, strong) NSString *pay_status;//结算状态接单/0 =待结算，1 =已结算 // 抢单: 0 = 待支付，1 = 叫车方 已支付，2 已到账
@property (nonatomic, strong) NSDictionary *bid;//抢单 包含抢单状态与价格
@property (nonatomic, copy) NSString *bid_expiry_at;//抢单开始时间
@property (nonatomic, strong) NSString *payment_term;//账期
@property (nonatomic, strong) NSString *reception_status;//接单状态 /派单：0 =待接单，1 =已接单，2= 已拒单，3 =需要单被取消, 4 =已取消（调度中心取逍）,5 = 已关闭 / 抢单：0 =待接单，1 =已接单，4 叫车方取消订单，
@property (nonatomic, strong) NSString *reception_at;
@property (nonatomic, strong) NSString *requisition_number;//需求单号
@property (nonatomic, strong) NSString *revoke_reason;//拒绝原因
@property (nonatomic, strong) NSString *self_adjust_price;//我方调价
@property (nonatomic, strong) NSString *selt_pay_amount;//我方支付
@property (nonatomic, strong) NSString *send_at;//派单时间
@property (nonatomic, strong) NSString *start_address;//出发地点
@property (nonatomic, copy) NSString *start_memo_address;//出发详情地址
@property (nonatomic, strong) NSString *start_at;//订单规定出发时间
@property (nonatomic, strong) NSString *trip_start_at;//司机实际出发时间
@property (nonatomic, strong) NSString *trip_name;//行程名称
@property (nonatomic, strong) NSString *trip_status;//行程状态//0 =待出行，1 =出行中，2 =行程结束
@property (nonatomic, strong) NSString *trip_type;//行程类型//1 线路，2 公里 ，3 天
@property (nonatomic, strong) NSString *updated_at;//更新时间
@property (nonatomic, strong) NSString *use_car_contacts;//用车联系人
@property (nonatomic, strong) NSString *use_car_mobile;//用车联系人手机号码
@property (nonatomic, strong) NSString *trip_end_at;//行程结束时间
@property (nonatomic, strong) NSString *actual_receipt_at;//到账时间
@property (nonatomic, copy) NSString *order_type;//订单类型 1.派单,2.抢单
@property (nonatomic, copy) NSString *start_city;//出发城市
@property (nonatomic, copy) NSString *start_province;//出发省
@property (nonatomic, copy) NSString *via_address;//途经省市
@property (nonatomic, copy) NSString *end_city;//到达城市
@property (nonatomic, copy) NSString *end_province;//到达省
@property (nonatomic, copy) NSString *driver_price;//司机收到的金额
@property (nonatomic, copy) NSString *dispatch_price;//调度收到的金额
@property (nonatomic, strong) NSNumber *commission_rate;//抽成
@property (nonatomic, copy) NSString *notice_count;//通知司机的个数
@property (nonatomic, strong) NSArray * pay_list;//支付列表
/**< 计调人信息 */
@property (nonatomic, strong) NSDictionary *contact;

@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *companyName;

@property (nonatomic, strong) NSArray *trip_img;/**< 保存线路详情图片的数组 */

@end
