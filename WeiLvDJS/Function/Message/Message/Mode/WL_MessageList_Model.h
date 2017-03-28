#import <Foundation/Foundation.h>

#pragma mark -WL_MessageList_itemsModel
@interface WL_MessageList_itemsModel : NSObject <NSCoding>

@property (nonatomic,copy)NSString *status;//状态// 0 未读，1 已读'
@property (nonatomic,copy)NSString *relation_id;//关联id
@property (nonatomic,copy)NSString *Myid;
@property (nonatomic,copy)NSString *to_user_id;//接收者ID
@property (nonatomic,copy)NSString *title;//标题
@property (nonatomic,copy)NSString *from_user_id;//发送者ID
@property (nonatomic,copy)NSString *from_company_id;//发送者公司的ID
@property (nonatomic,copy)NSString *message;//信息
@property (nonatomic,copy)NSString *msg_type;//消息类型//1=接单提醒，2=撤单提醒（如司机订单被取消），3=出团提醒，4=导游变动提醒，5=身份认证已通过（比如司机身份认证）,6=身份认证未通过（比如司机身份认证），7=资金变动
@property (nonatomic,copy)NSString *role_type;//角色类型// 1 导游，2 司机，3 房销，4 其它
@property (nonatomic,copy)NSString *is_deleted;//是否删除 0:未删除 1:被发送者删除，2 被接收者删除,3 双方都删除
@property (nonatomic,copy)NSString *created_at;//创建时间

@end

#pragma mark -WL_MessageList_selfModel
@interface WL_MessageList_selfModel : NSObject <NSCoding>

@property (nonatomic,copy)NSString *href;//

@end

#pragma mark -WL_MessageList__linksModel
@interface WL_MessageList__linksModel : NSObject <NSCoding>

@property (nonatomic,strong)WL_MessageList_selfModel *Myself;//当前页
@property (nonatomic,strong)WL_MessageList_selfModel *Mylast;//最后一页
@property (nonatomic,strong)WL_MessageList_selfModel *MyNext;//下一页

@end

#pragma mark -WL_MessageList__metaModel
@interface WL_MessageList__metaModel : NSObject <NSCoding>

@property (nonatomic,copy)NSString *currentPage;
@property (nonatomic,copy)NSString *totalCount;
@property (nonatomic,copy)NSString *perPage;
@property (nonatomic,copy)NSString *pageCount;

@end

#pragma mark -WL_MessageList_dataModel
@interface WL_MessageList_dataModel : NSObject <NSCoding>

@property (nonatomic,strong)NSMutableArray *Myitems;
@property (nonatomic,strong)WL_MessageList__linksModel *My_links;
@property (nonatomic,strong)WL_MessageList__metaModel *My_meta;

@end

#pragma mark -WL_MessageList_Model
@interface WL_MessageList_Model : NSObject <NSCoding>

@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,strong)WL_MessageList_dataModel *Mydata;

@end

