//
//  WLPaymentCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLPaymentCell.h"

#define cellIdentifier @"WLPaymentCell"

@interface WLPaymentCell ()
@property (nonatomic, assign) TouristItemType type;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) NSArray *textArray;
@end

@implementation WLPaymentCell

+ (WLPaymentCell *)cellWithTableView:(UITableView *)tableView
                            itemType:(TouristItemType)itemType
                           textArray:(NSArray *)textArray{
    WLPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = itemType;
    cell.textArray = textArray;
    [cell setupUI];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
    }
    return self;
}

- (void)setupUI{
    self.highlighted = NO;
    if (_textArray == nil) {
        return;
    }
    NSArray *textArray;
    if (self.type == TouristItemTypeCar) {
        textArray = @[@"支付时间",self.textArray[0],@"支付金额",self.textArray[1]];
    }else{
        textArray = @[@"支付方式",self.textArray[0],@"支付金额",self.textArray[1]];
    }
    for (int i = 0; i < 4; i++) {
        [self setupLabelWithIndex:i text:textArray[i]];
    }
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);
    line.frame = CGRectMake(ScaleW(12), ScaleH(45), ScreenWidth, 1);
    [self addSubview:line];
}

- (void)setTotalPrice:(NSString *)price
{
    self.priceLabel.text = price;
}

- (void)setupLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:14];
    CGFloat x = ScaleW(12);
    CGFloat width = ScreenWidth / 2;
    CGFloat height = ScaleH(45);
    if (index % 2 == 0) {
        label.textColor = HEXCOLOR(0x2f2f2f);
        label.textAlignment = NSTextAlignmentLeft;
        
    }else {
        label.textColor = HEXCOLOR(0x868686);
        label.textAlignment = NSTextAlignmentRight;
        x = ScreenWidth - ScaleW(12) - width;
        if (self.type == TouristItemTypeCar) {
            label.textColor = HEXCOLOR(0xff5b3d);
        }
        self.priceLabel = label;
    }
    
    label.frame = CGRectMake(x, height * (index / 2), width, height);
    label.text = text;
    [self addSubview:label];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *subV in self.subviews) {
        [subV removeFromSuperview];
    }
}
@end
