//
//  WL_Application_Driver_OrderDetailCell5.m
//  WeiLvDJS
//
//  Created by whw on 16/12/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderDetailCell5.h"

@interface WL_Application_Driver_OrderDetailCell5 ()

/**< 保存Label的数组 */
@property (nonatomic, strong) NSMutableArray <UILabel *>*labelsArray;


@end

@implementation WL_Application_Driver_OrderDetailCell5
static NSString *identifier = @"OrderDetailCell5";
#define FormatterString @"yyyy-MM-dd HH:mm"
#pragma mark - 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        //设置cell点击不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
        [self setupUI];
    }
    return self;
}


- (void)setOrderDetailStatus:(WLOrderDetailStatus)orderDetailStatus
{
    _orderDetailStatus = orderDetailStatus;
    switch (orderDetailStatus) {
        case WLOrderDetailWait:
        {
         [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(self.contentView).offset(ScaleH(18));
             make.left.equalTo(self.contentView).offset(ScaleH(12));
             make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
         }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:    %@",[NSString getDateStringWithTime:self.cellData.send_at andFormatter:FormatterString]];
        }
            break;
        case WLOrderDetailStart:
        {
            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[0].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:   %@",[NSString getDateStringWithTime:self.cellData.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"接单时间:   %@",[NSString getDateStringWithTime:self.cellData.reception_at andFormatter:FormatterString]];
        }
            break;
        case WLOrderDetailTravel:
        {
            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[0].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[1].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:   %@",[NSString getDateStringWithTime:self.cellData.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"接单时间:   %@",[NSString getDateStringWithTime:self.cellData.reception_at andFormatter:FormatterString]];
            self.labelsArray[2].text = [NSString stringWithFormat:@"出发时间:   %@",[NSString getDateStringWithTime:self.cellData.trip_start_at andFormatter:FormatterString]];
        }
        case WLOrderDetailSettlement:
        {
            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[0].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[1].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[2].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:   %@",[NSString getDateStringWithTime:self.cellData.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"接单时间:   %@",[NSString getDateStringWithTime:self.cellData.reception_at andFormatter:FormatterString]];
            self.labelsArray[2].text = [NSString stringWithFormat:@"出发时间:   %@",[NSString getDateStringWithTime:self.cellData.trip_start_at andFormatter:FormatterString]];
            self.labelsArray[3].text = [NSString stringWithFormat:@"结束时间:   %@",[NSString getDateStringWithTime:self.cellData.trip_end_at andFormatter:FormatterString]];
        }
            break;
        case WLOrderDetailFinished:
        {
            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[0].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[1].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[2].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:   %@",[NSString getDateStringWithTime:self.cellData.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"接单时间:   %@",[NSString getDateStringWithTime:self.cellData.reception_at andFormatter:FormatterString]];
            self.labelsArray[2].text = [NSString stringWithFormat:@"出发时间:   %@",[NSString getDateStringWithTime:self.cellData.trip_start_at andFormatter:FormatterString]];
            self.labelsArray[3].text = [NSString stringWithFormat:@"结束时间:   %@",[NSString getDateStringWithTime:self.cellData.trip_end_at andFormatter:FormatterString]];
            self.labelsArray[3].numberOfLines = 0;
        }
            break;
        case WLOrderDetailCancel:
        {
            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[0].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[1].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[1].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(90));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:   %@",[NSString getDateStringWithTime:self.cellData.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"取消时间:   %@",[NSString getDateStringWithTime:self.cellData.reception_at andFormatter:FormatterString]];
            self.labelsArray[2].text = @"取消原因";
            NSData *jsonData = [self.cellData.revoke_reason dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            NSString *reasonStr = [dataArray componentsJoinedByString:@"\n"];
            self.labelsArray[3].text = reasonStr;
        }
            break;
        case WLOrderDetailRefuse:
        {
            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[0].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[2] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[1].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[3] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[1].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(90));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:   %@",[NSString getDateStringWithTime:self.cellData.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"拒绝时间:   %@",[NSString getDateStringWithTime:self.cellData.reception_at andFormatter:FormatterString]];
            self.labelsArray[2].text = @"拒绝原因";
            NSData *jsonData = [self.cellData.revoke_reason dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            NSString *reasonStr = [dataArray componentsJoinedByString:@"\n"];
            self.labelsArray[3].text = reasonStr;
            
            self.labelsArray[3].numberOfLines = 0;
        }
            break;
        case WLOrderDetailOverTime:
        {
            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[0].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:   %@",[NSString getDateStringWithTime:self.cellData.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"失效时间:   %@",[NSString getDateStringWithTime:self.cellData.expiry_at andFormatter:FormatterString]];
        }
            break;
        default:
            break;
    }
    [self.contentView layoutIfNeeded];
    
}

- (void)setupUI
{
    for (int i= 0; i < 4; i++) {
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = Color3;
        timeLabel.font = [UIFont WLFontOfSize:14];
        [self.contentView addSubview:timeLabel];
       
        [self.labelsArray addObject:timeLabel];
    }
}

- (NSMutableArray *)labelsArray
{
    if (_labelsArray == nil) {
        _labelsArray = [NSMutableArray arrayWithCapacity:4];
    }
    return _labelsArray;
}
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    WL_Application_Driver_OrderDetailCell5 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WL_Application_Driver_OrderDetailCell5 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
