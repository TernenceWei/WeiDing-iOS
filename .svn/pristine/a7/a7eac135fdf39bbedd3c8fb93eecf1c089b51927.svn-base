//
//  WLCarFrozenCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/2/28.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarFrozenCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define cellIdentifier @"WLCarFrozenCell"

@interface WLCarFrozenCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UILabel *bankNoticeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation WLCarFrozenCell
- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

+ (WLCarFrozenCell *)cellWithTableView:(UITableView*)tableView{
    WLCarFrozenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarFrozenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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

- (void)setObject:(WLCarFrozenListObject *)object
{
    _object = object;
    if (object == nil) {
        return;
    }
    [_iconView sd_setImageWithURL:[NSURL URLWithString:object.company_logo] placeholderImage:nil];
    _bankLabel.text = object.company_name;
    _bankNoticeLabel.text = object.callcar_user;
    _moneyLabel.text = object.amount;
    
    _statusLabel.text = @"审核中";
    if (object.trade_status.integerValue == 1) {
        _statusLabel.text = @"成功";
    }else if (object.trade_status.integerValue == 2) {
        _statusLabel.text = @"撤销";
    }else if (object.trade_status.integerValue == 3) {
        _statusLabel.text = @"拒绝";
    }else if (object.trade_status.integerValue == 4) {
        _statusLabel.text = @"退回提现";
    }else if (object.trade_status.integerValue == 5) {
        _statusLabel.text = @"冻结中";
    }else if (object.trade_status.integerValue == 6) {
        _statusLabel.text = @"已解冻";
    }
    
    
    NSString *openTime = [WLUITool timeStringWithTimeInterval:object.updated_at.integerValue];
    NSString *arriveTime = [WLUITool timeStringWithTimeInterval:object.created_at.integerValue formatter:@"yyyy-MM-dd hh:mm" ];
    NSArray *textArray = @[@"车费结算",arriveTime , object.order_no, openTime];
    for (int i = 0; i < 4; i ++) {
        UILabel *label = self.labelArray[i];
        label.text = textArray[i];
    }
}

- (void)setupUI{
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(18), ScaleW(50), ScaleW(50))];
    iconView.image = [UIImage imageNamed:@""];
    iconView.layer.cornerRadius = ScaleW(25);
    iconView.layer.masksToBounds = YES;
    iconView.backgroundColor = Color1;
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
    
    NSArray *textArray = @[@"交易类型",@"车费结算",@"到账时间",@"",@"订单号",@"",@"解冻时间",@""];
    
    CGFloat height = ScaleH(32);
    for (int i = 0; i < 8; i++) {
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
