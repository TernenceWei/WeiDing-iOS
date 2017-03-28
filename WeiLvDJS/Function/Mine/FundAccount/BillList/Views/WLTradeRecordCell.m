//
//  WLTradeRecordCell.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTradeRecordCell.h"
#define cellIdentifier @"WLTradeRecordCell"

@interface WLTradeRecordCell ()

@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation WLTradeRecordCell
+ (WLTradeRecordCell *)cellWithTableView:(UITableView*)tableView{
    WLTradeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLTradeRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

- (void)setupUI{
    
    CGFloat height = ScaleH(65);
    NSArray *textArray = @[@"",@"",@"",@""];
    for (int i = 0; i < 4; i ++) {
        CGFloat beginX = ScaleW(12);
        CGFloat width = ScreenWidth / 2 - beginX + ScaleW(50);
        CGFloat height = ScaleH(35);
        CGFloat font = 14;
        UIColor *textColor = Color2;
        if (i == 2) {
            textColor = Color3;
        }else if (i == 3){
            textColor = [UIColor redColor];
        }
        if (i % 2 == 1) {
            beginX = ScreenWidth / 2 - ScaleW(50);
            
        }
        if (i / 2 == 1) {
            height = ScaleH(30);
            font = 12;
        }
        UILabel *label = [UILabel labelWithText:textArray[i] textColor:textColor fontSize:font];
        label.frame = CGRectMake(beginX, height * (i / 2), width, height);
        [self.contentView addSubview:label];
        if (i % 2 == 1) {
            label.textAlignment = NSTextAlignmentRight;
        }
        [self.labelArray addObject:label];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height -1, ScreenWidth, 1)];
    lineView.backgroundColor = bordColor;
    [self.contentView addSubview:lineView];
    
}

- (void)setObject:(WLTradeRecordObject *)object
{
    _object = object;
    NSString *statusString = @"审核中";
    if ([object.trade_status isEqualToString:@"1"]) {
        statusString = @"成功";
    }else if ([object.trade_status isEqualToString:@"2"]) {
        statusString = @"撤销";
    }else if ([object.trade_status isEqualToString:@"3"]) {
        statusString = @"拒绝";
    }else if ([object.trade_status isEqualToString:@"4"]) {
        statusString = @"退回提现";
    }else if ([object.trade_status isEqualToString:@"5"]) {
        statusString = @"冻结中";
    }else if ([object.trade_status isEqualToString:@"6"]) {
        statusString = @"作废";
    }
    NSString *typeString = @"充值";
    NSString *money = object.amount;
    if (object.trade_type.integerValue == 2) {
        typeString = @"提现";
    }else if (object.trade_type.integerValue == 5) {
        typeString = @"备用金";
    }else if (object.trade_type.integerValue == 6) {
        typeString = @"团费结算";
    }else if (object.trade_type.integerValue == 7) {
        typeString = @"订单支付";
    }else if (object.trade_type.integerValue == 8) {
        typeString = @"店铺订单支付";
    }else if (object.trade_type.integerValue == 9) {
        typeString = @"店铺订单退款";
    }else if (object.trade_type.integerValue == 10) {
        typeString = @"员工提成";
    }else if (object.trade_type.integerValue == 11) {
        typeString = @"车费结算";
    }else if (object.trade_type.integerValue == 12) {
        //typeString = @"抢单到账金额";
        typeString = [NSString stringWithFormat:@"车费结算(%@)",object.order_no];

    }else if (object.trade_type.integerValue == 14) {
        typeString = [NSString stringWithFormat:@"车费结算(%@)",object.order_no];
        money             = [NSString stringWithFormat:@"-%@",money];
    }
    NSString *time = [WLUITool timeStringWithTimeInterval:object.updated_at.integerValue formatter:@"YYYY-MM-dd HH:mm:ss"];
    if ([time isEqualToString:@""] || time == nil) {
        time = [WLUITool timeStringWithTimeInterval:object.created_at.integerValue formatter:@"YYYY-MM-dd HH:mm:ss"];
    }
    
    NSArray *textArray = @[typeString, money, time, statusString];
    for (int i = 0; i < 4; i ++) {
        UILabel *label = self.labelArray[i];
        label.text = textArray[i];
    }
    
}

@end
