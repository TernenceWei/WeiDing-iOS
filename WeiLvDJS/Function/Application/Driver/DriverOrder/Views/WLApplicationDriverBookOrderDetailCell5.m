//
//  WLApplicationDriverBookOrderDetailCell5.m
//  WeiLvDJS
//
//  Created by whw on 17/1/21.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationDriverBookOrderDetailCell5.h"

@interface WLApplicationDriverBookOrderDetailCell5 ()

/**< 保存Label的数组 */
@property (nonatomic, strong) NSMutableArray <UILabel *>*labelsArray;


@end

@implementation WLApplicationDriverBookOrderDetailCell5
static NSString *identifier = @"boookOrderDetailCell5";
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

- (void)setBookStatus:(WLBookOrderStatus)bookStatus
{
    _bookStatus = bookStatus;
    switch (bookStatus) {
        case WLWaitOrderStatus:
        {
            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:          %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
        }
            break;
        case WLUnpaidStatus:
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
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:          %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"报价时间:          %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_at"] andFormatter:FormatterString]];
        }
            break;
        case WLOrderStatusStart:
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
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:         %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"报价时间:         %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_at"] andFormatter:FormatterString]];
            self.labelsArray[2].text = [NSString stringWithFormat:@"确认付款:         %@",[NSString getDateStringWithTime:self.orderModel.pay_at andFormatter:FormatterString]];
        }
            break;
        case WLOrderStatusTravel:
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
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:         %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"报价时间:         %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_at"] andFormatter:FormatterString]];
            self.labelsArray[2].text = [NSString stringWithFormat:@"确认付款:         %@",[NSString getDateStringWithTime:self.orderModel.pay_at andFormatter:FormatterString]];
            self.labelsArray[3].text = [NSString stringWithFormat:@"出发时间:         %@",[NSString getDateStringWithTime:self.orderModel.trip_start_at andFormatter:FormatterString]];
        }
            break;
        case WLOrderStatusSettlement:
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
            }];
            [self.labelsArray[4] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[3].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[5] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[4].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:         %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"报价时间:         %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_at"] andFormatter:FormatterString]];
            self.labelsArray[2].text = [NSString stringWithFormat:@"确认付款:         %@",[NSString getDateStringWithTime:self.orderModel.pay_at andFormatter:FormatterString]];
            self.labelsArray[3].text = [NSString stringWithFormat:@"出发时间:         %@",[NSString getDateStringWithTime:self.orderModel.trip_start_at andFormatter:FormatterString]];
            self.labelsArray[4].text = [NSString stringWithFormat:@"结束时间:         %@",[NSString getDateStringWithTime:self.orderModel.trip_end_at andFormatter:FormatterString]];
            NSString *predictString = [NSString stringWithFormat:@"%lf", [self.orderModel.trip_end_at doubleValue]+604800];
             self.labelsArray[5].text = [NSString stringWithFormat:@"预计到账时间: %@",[NSString getDateStringWithTime:predictString andFormatter:@"yyyy-MM-dd"]];
        }
            break;
        case WLOrderStatusFinish:
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
            }];
            [self.labelsArray[4] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[3].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
            }];
            [self.labelsArray[5] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelsArray[4].mas_bottom).offset(ScaleH(18));
                make.left.equalTo(self.contentView).offset(ScaleH(12));
                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
            }];
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:         %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"报价时间:         %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_at"] andFormatter:FormatterString]];
            self.labelsArray[2].text = [NSString stringWithFormat:@"确认付款:         %@",[NSString getDateStringWithTime:self.orderModel.pay_at andFormatter:FormatterString]];
            self.labelsArray[3].text = [NSString stringWithFormat:@"出发时间:         %@",[NSString getDateStringWithTime:self.orderModel.trip_start_at andFormatter:FormatterString]];
            self.labelsArray[4].text = [NSString stringWithFormat:@"结束时间:         %@",[NSString getDateStringWithTime:self.orderModel.trip_end_at andFormatter:FormatterString]];
            self.labelsArray[5].text = [NSString stringWithFormat:@"到账时间:         %@",[NSString getDateStringWithTime:self.orderModel.actual_receipt_at andFormatter:FormatterString]];
        }
            break;
        case WLFailureOrderStatusOverTime:
        case WLFailureOrderStatusUnquoted:
        case WLFailureOrderStatusUnquotedCanceled:
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
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:          %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
            if (bookStatus == WLFailureOrderStatusOverTime) {
                self.labelsArray[1].text = [NSString stringWithFormat:@"失效时间:          %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_expiry_at"] andFormatter:FormatterString]];
            }else if (bookStatus == WLFailureOrderStatusUnquoted){
                self.labelsArray[1].text = [NSString stringWithFormat:@"失效时间:         %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_updated_at"] andFormatter:FormatterString]];
            }else if (bookStatus == WLFailureOrderStatusUnquotedCanceled){
                self.labelsArray[1].text = [NSString stringWithFormat:@"失效时间:          %@",[NSString getDateStringWithTime:self.orderModel.updated_at andFormatter:FormatterString]];
            }
            
        }
            break;
        case WLFailureOrderStatusQuotedCanceled:
        case  WLFailureOrderStatusQuoted:
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
            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:         %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
            self.labelsArray[1].text = [NSString stringWithFormat:@"报价时间:         %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_at"] andFormatter:FormatterString]];
            if(bookStatus == WLFailureOrderStatusQuotedCanceled){
                self.labelsArray[2].text = [NSString stringWithFormat:@"失效时间:         %@",[NSString getDateStringWithTime:self.orderModel.updated_at andFormatter:FormatterString]];
            }else if(bookStatus == WLFailureOrderStatusQuoted){
                self.labelsArray[2].text = [NSString stringWithFormat:@"失效时间:         %@",[NSString getDateStringWithTime:[self.orderModel.bid objectForKey:@"bid_updated_at"] andFormatter:FormatterString]];
            }
        }
            break;
//        case WLFailureOrderStatusCanceled:
//        {
//            [self.labelsArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.contentView).offset(ScaleH(18));
//                make.left.equalTo(self.contentView).offset(ScaleH(12));
//            }];
//            [self.labelsArray[1] mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.labelsArray[0].mas_bottom).offset(ScaleH(18));
//                make.left.equalTo(self.contentView).offset(ScaleH(12));
//            }];
//            [self.labelsArray[2] mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.labelsArray[1].mas_bottom).offset(ScaleH(18));
//                make.left.equalTo(self.contentView).offset(ScaleH(12));
//                make.bottom.equalTo(self.contentView).offset(ScaleH(-18));
//            }];
//            self.labelsArray[0].text = [NSString stringWithFormat:@"派单时间:          %@",[NSString getDateStringWithTime:self.orderModel.send_at andFormatter:FormatterString]];
//            self.labelsArray[1].text = [NSString stringWithFormat:@"接单时间:          %@",[NSString getDateStringWithTime:self.orderModel.reception_at andFormatter:FormatterString]];
//            self.labelsArray[2].text = [NSString stringWithFormat:@"取消时间:          %@",[NSString getDateStringWithTime:self.orderModel.updated_at andFormatter:FormatterString]];
//        }
//            break;
        default:
            break;
    }
     [self.contentView layoutIfNeeded];
}




- (void)setupUI
{
    for (int i= 0; i < 6; i++) {
        
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
    WLApplicationDriverBookOrderDetailCell5 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[WLApplicationDriverBookOrderDetailCell5 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
