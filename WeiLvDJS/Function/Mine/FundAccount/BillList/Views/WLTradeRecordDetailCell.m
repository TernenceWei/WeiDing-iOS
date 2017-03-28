//
//  WLTradeRecordDetailCell.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTradeRecordDetailCell.h"
#define cellIdentifier @"WLTradeRecordDetailCell"

@interface WLTradeRecordDetailCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UILabel *bankNoticeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) NSMutableArray *labelArray;
@end

@implementation WLTradeRecordDetailCell
- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
    
}

+ (WLTradeRecordDetailCell *)cellWithTableView:(UITableView*)tableView{
    WLTradeRecordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLTradeRecordDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        self.clipsToBounds = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(18), ScaleW(50), ScaleW(50))];
    iconView.image = [UIImage imageNamed:@""];
    iconView.layer.cornerRadius = ScaleW(25);
    iconView.layer.masksToBounds = YES;
    iconView.image = [UIImage imageWithColor:Color1];
    [self.contentView addSubview:iconView];
    
    UILabel *bankLabel = [UILabel labelWithText:@"" textColor:Color2 fontSize:15];
    bankLabel.frame = CGRectMake(iconView.right + 5, ScaleH(20), ScreenWidth, ScaleH(30));
    [self.contentView addSubview:bankLabel];
    
    UILabel *bankNoticeLabel = [UILabel labelWithText:@"" textColor:Color3 fontSize:14];
    bankNoticeLabel.frame = CGRectMake(bankLabel.left, bankLabel.bottom, ScreenWidth, ScaleH(30));
    [self.contentView addSubview:bankNoticeLabel];
    
    UILabel *moneyLabel = [UILabel labelWithText:@"" textColor:Color2 fontSize:18];
    moneyLabel.frame = CGRectMake(0, bankNoticeLabel.bottom + ScaleH(15), ScreenWidth, ScaleH(30));
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:moneyLabel];
    
    UILabel *statusLabel = [UILabel labelWithText:@"" textColor:[UIColor redColor] fontSize:14];
    statusLabel.frame = CGRectMake(0, moneyLabel.bottom, ScreenWidth, ScaleH(25));
    statusLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:statusLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleH(160), ScreenWidth, 1)];
    line.backgroundColor = bordColor;
    [self.contentView addSubview:line];
    
    NSArray *textArray = @[@"交易类型",@"",@"交易时间",@"",@"预计到账时间",@"",@"订单号",@"",@"商户订单",@""];
    
    CGFloat height = ScaleH(32);
    for (int i = 0; i < 10; i++) {
        CGFloat beginX = ScaleW(15);
        CGFloat width = ScreenWidth / 2 - beginX;
        UILabel *moneyLabel = [UILabel labelWithText:textArray[i] textColor:Color3 fontSize:14];
        if (i % 2 == 1) {
            
            width = ScreenWidth - ScaleW(15) * 2;
            moneyLabel.textAlignment = NSTextAlignmentRight;
            
        }
        [self.labelArray addObject:moneyLabel];
        moneyLabel.frame = CGRectMake(beginX, height * (i / 2) + ScaleH(160), width, height);
        [self.contentView addSubview:moneyLabel];
    }
    
    _iconView = iconView;
    _bankLabel = bankLabel;
    _bankNoticeLabel = bankNoticeLabel;
    _moneyLabel = moneyLabel;
    _statusLabel = statusLabel;
}

- (void)setDetailObject:(WLTradeRecordDetailObject *)detailObject
{
    _detailObject = detailObject;
    
    if (detailObject == nil) {
        return;
    }
    [_iconView sd_setImageWithURL:[NSURL URLWithString:detailObject.logo] placeholderImage:[UIImage imageNamed:detailObject.placeholderImage]];
    
    _bankLabel.text = detailObject.title;
    _bankNoticeLabel.text = detailObject.subTitle;
    _moneyLabel.text = detailObject.money;
    
    NSString *statusString = @"审核中";
    if (detailObject.status.integerValue == 1) {
        statusString = @"成功";
    }else if (detailObject.status.integerValue == 2) {
        statusString = @"撤销";
    }else if (detailObject.status.integerValue == 3) {
        statusString = @"拒绝";
    }else if (detailObject.status.integerValue == 4) {
        statusString = @"退回提现";
    }else if (detailObject.status.integerValue == 5) {
        statusString = @"冻结中";
    }else if (detailObject.status.integerValue == 6) {
        statusString = @"作废";
    }
    _statusLabel.text = statusString;
//    _statusLabel.textColor = detailObject.status.integerValue == 5?[UIColor redColor]:Color1;
    for (int i = 0; i < self.detailObject.bottomArray.count; i ++) {
        UILabel *label = self.labelArray[i];
        label.text = self.detailObject.bottomArray[i];
    }
    
}

@end
