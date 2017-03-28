//
//  WLResultWriteOffTableViewCell.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/5.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLResultWriteOffTableViewCell.h"
#import "WLDataHotelHandler.h"

#define cellIdentifier @"WLResultWriteOffTableViewCell"

@interface WLResultWriteOffTableViewCell ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * howLabel;
@property (nonatomic, strong) UILabel * dateLabel;

@end

@implementation WLResultWriteOffTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUI];
    }
    return self;
}

+ (WLResultWriteOffTableViewCell *)cellCreateTableView:(UITableView *)tableView
{
    WLResultWriteOffTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLResultWriteOffTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)setUI
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(10), ScreenWidth - ScaleW(30), ScaleH(20))];
    _titleLabel.text = @"世界之窗白天成人票";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _howLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(60), _titleLabel.frame.origin.y, ScaleW(50), ScaleH(20))];
    _howLabel.text = @"X2";
    _howLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_howLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + ScaleH(10), ScreenWidth - ScaleW(30), ScaleH(20))];
    _dateLabel.text = @"游玩日期：2016.12.12";
    _dateLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_dateLabel];
    
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 69.5, ScreenWidth, 0.5)];
    lineLabel.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [self addSubview:lineLabel];
}

- (void)setCellModel:(WLWriteOffObject *)model
{
    _titleLabel.text = model.prduct_name;//@"世界之窗白天成人票";
    _howLabel.text = [NSString stringWithFormat:@"X%@",model.quantity];//@"X2";
    _dateLabel.text = [NSString stringWithFormat:@"游玩日期：%@",[WLDataHotelHandler TimeIntervalChangeWithYMDString:model.time]];//@"游玩日期：2016.12.12";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
