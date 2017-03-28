//
//  WLDepositingCell.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLDepositingCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define cellIdentifier @"WLDepositingCell"

@interface WLDepositingCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UILabel *bankNoticeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation WLDepositingCell
- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

+ (WLDepositingCell *)cellWithTableView:(UITableView*)tableView{
    WLDepositingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLDepositingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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

- (void)setObject:(WLDepositListObject *)object
{
    _object = object;
    if (object == nil) {
        return;
    }
    [_iconView sd_setImageWithURL:[NSURL URLWithString:object.bank_logo] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",object.bank_name]]];
    _bankLabel.text = object.bank_name;
    _bankNoticeLabel.text = [NSString stringWithFormat:@"尾号%@储蓄卡", [object.bank_number substringFromIndex:object.bank_number.length - 4]];
    _moneyLabel.text = object.amount;
    
    _statusLabel.text = @"待审核";
    if (object.audit_status.integerValue == 2) {
        _statusLabel.text = @"待付款";
    }else if (object.audit_status.integerValue == 3) {
        _statusLabel.text = @"提现成功";
    }else if (object.audit_status.integerValue == 4) {
        _statusLabel.text = @"提现拒绝";
    }
    
    NSString *createTime = [WLUITool timeStringWithTimeInterval:object.request_at.integerValue];
    NSString *arriveTime = [WLUITool timeStringWithTimeInterval:object.predict_expire_date.integerValue];
    NSArray *textArray = @[@"提现", createTime, arriveTime, object.order_no, object.channel_order_no];
    for (int i = 0; i < 5; i ++) {
        UILabel *label = self.labelArray[i];
        label.text = textArray[i];
    }
}

- (void)setupUI{
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(18), ScaleW(50), ScaleW(50))];
    iconView.image = [UIImage imageNamed:@""];
    iconView.layer.cornerRadius = ScaleW(25);
    iconView.layer.masksToBounds = YES;
    iconView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:iconView];
    _iconView = iconView;
    
    UILabel *bankLabel = [UILabel labelWithText:@"" textColor:Color2 fontSize:15];
    bankLabel.frame = CGRectMake(iconView.right + 5, ScaleH(20), ScreenWidth, ScaleH(30));
    [self.contentView addSubview:bankLabel];
    _bankLabel = bankLabel;
    
    UILabel *bankNoticeLabel = [UILabel labelWithText:@"" textColor:Color3 fontSize:14];
    bankNoticeLabel.frame = CGRectMake(bankLabel.left, bankLabel.bottom, ScreenWidth, ScaleH(30));
    [self.contentView addSubview:bankNoticeLabel];
    _bankNoticeLabel = bankNoticeLabel;
    
    UILabel *moneyLabel = [UILabel labelWithText:@"" textColor:Color2 fontSize:18];
    moneyLabel.frame = CGRectMake(0, bankNoticeLabel.bottom + ScaleH(15), ScreenWidth, ScaleH(30));
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:moneyLabel];
    _moneyLabel = moneyLabel;
    
    UILabel *statusLabel = [UILabel labelWithText:@"" textColor:[UIColor redColor] fontSize:14];
    statusLabel.frame = CGRectMake(0, moneyLabel.bottom, ScreenWidth, ScaleH(25));
    statusLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:statusLabel];
    _statusLabel = statusLabel;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleH(160), ScreenWidth, 1)];
    line.backgroundColor = bordColor;
    [self.contentView addSubview:line];
    
    NSArray *textArray = @[@"交易类型",@"提现",@"提现时间",@"",@"预计到账时间",@"",@"订单号",@"",@"商户订单",@""];
    
    CGFloat height = ScaleH(32);
    for (int i = 0; i < 10; i++) {
        CGFloat beginX = ScaleW(15);
        CGFloat width = ScreenWidth / 2 - beginX;
        UILabel *moneyLabel = [UILabel labelWithText:textArray[i] textColor:Color3 fontSize:14];
        if (i % 2 == 1) {
            beginX = ScreenWidth / 2;
            moneyLabel.textAlignment = NSTextAlignmentRight;
            [self.labelArray addObject:moneyLabel];
        }
        moneyLabel.frame = CGRectMake(beginX, height * (i / 2) + ScaleH(160), width, height);
        [self.contentView addSubview:moneyLabel];
    }
}
@end
