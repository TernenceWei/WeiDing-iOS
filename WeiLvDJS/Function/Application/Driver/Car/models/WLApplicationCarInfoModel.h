#import <Foundation/Foundation.h>

#pragma mark -WLApplicationCarInfoimgsModel
@interface WLApplicationCarInfoimgsModel : NSObject <NSCoding>

@property (nonatomic,copy)NSString *base_url;//图片地址
@property (nonatomic,copy)NSString *Myid;//图片id
@property (nonatomic,copy)NSString *path;//图片路径
@property (nonatomic,copy)NSString *file_type;//5/6 行驶证正/反面照片 7车辆相关图片8车辆营运证
@property (nonatomic,copy)NSString *name;

@end

#pragma mark -WLApplicationCarInfocar_infoModel
@interface WLApplicationCarInfocar_infoModel : NSObject <NSCoding>

@property (nonatomic,copy)NSString *Myid;
@property (nonatomic,copy)NSString *audit_memo;/**< 审核原因 */
@property (nonatomic,copy)NSString *company_id;/**< 当前车调ID */
@property (nonatomic,copy)NSString *driver_user_id;
@property (nonatomic,copy)NSString *brand;//车辆品牌
@property (nonatomic,copy)NSString *memo;//备注
@property (nonatomic,copy)NSString *created_at;
@property (nonatomic,copy)NSString *first_enabled_at;//车辆首次启用日期(时间戳)
@property (nonatomic,copy)NSString *body_name;//资质主体名称
@property (nonatomic,copy)NSString *auditor_id;//审核人ID
@property (nonatomic,copy)NSString *seat_amount;//座位数
@property (nonatomic,copy)NSString *number;//车牌号
@property (nonatomic,copy)NSString *sj_driver_id;//司机ID
@property (nonatomic,copy)NSString *audit_status;//审核状态-1:未认证 0:审核中 1:已认证 2:认证失败 3:已禁用
@property (nonatomic,copy)NSString *is_disabled;//禁用状态 0不禁用 1禁用
@property (nonatomic,copy)NSString *updated_at;
@property (nonatomic,copy)NSString *model;//车辆类型 1大巴 2商务车 3其他
@property (nonatomic,copy)NSString *audit_at;
@property (nonatomic, copy) NSString *day_pricing;//按天计价
@property (nonatomic, copy) NSString *kilometer_pricing;//按路程计价
@property (nonatomic, assign) BOOL is_reception;//是否接单
@property (nonatomic, copy) NSString *reception_lowest;//接单最少乘客

@end

#pragma mark -WLApplicationCarInfodataModel
@interface WLApplicationCarInfodataModel : NSObject <NSCoding>

@property (nonatomic,strong)NSMutableArray *Myimgs;//图片模型
@property (nonatomic,copy)NSString *opt_status;/**< 车辆编辑状态 1:可编辑 2:不可编辑 */
@property (nonatomic,strong)WLApplicationCarInfocar_infoModel *Mycar_info;//车辆信息模型

@end

#pragma mark -WLApplicationCarInfoModel
@interface WLApplicationCarInfoModel : NSObject <NSCoding>

@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,strong)WLApplicationCarInfodataModel *Mydata;

@end

