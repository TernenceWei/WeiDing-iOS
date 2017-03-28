//
//  WLTouristListCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLTouristListCell.h"

#define cellIdentifier @"WLTouristListCell"

@interface WLTouristListCell ()

@end

@implementation WLTouristListCell

+ (WLTouristListCell *)cellWithTableView:(UITableView*)tableView tag:(NSUInteger)tag{
    
    WLTouristListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLTouristListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.tag = tag;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCellInfo:(WLVisitorListCellInfo *)cellInfo
{
    _cellInfo = cellInfo;
    [self setupUI];
}

- (void)setupUI{
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat lineX = ScaleW(10);
    if (self.tag == 0) {
        lineX = 0;
    }
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);
    line.frame = CGRectMake(lineX, 0, ScreenWidth, 1);
    [self addSubview:line];
    
    CGFloat cellHeight = ScaleH(70);
    
    UIButton *iconBtn = [[UIButton alloc] init];
    [iconBtn setTitle:@"23" forState:UIControlStateNormal];
    [iconBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [iconBtn setBackgroundImage:[UIImage imageWithColor:[self getBgColorWithIndex:0]] forState:UIControlStateNormal];
    CGFloat iconWidth = ScaleW(50);
    iconBtn.frame = CGRectMake(ScaleW(15), (cellHeight - iconWidth) / 2, iconWidth, iconWidth);
    iconBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    iconBtn.titleLabel.font = [UIFont WLFontOfSize:15];
    [self addSubview:iconBtn];
    iconBtn.layer.cornerRadius = iconWidth / 2;
    iconBtn.layer.masksToBounds = YES;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.text = self.cellInfo.name;
    nameLabel.font = [UIFont WLFontOfSize:14];
    CGFloat nameX = CGRectGetMaxX(iconBtn.frame) + ScaleW(10);
    nameLabel.frame = CGRectMake(nameX , ScaleH(15), ScreenWidth / 2, ScaleH(20));
    nameLabel.textColor =HEXCOLOR(0x2f2f2f);
    [self addSubview:nameLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.text = self.cellInfo.phoneNO;
    phoneLabel.font = [UIFont WLFontOfSize:11];
    phoneLabel.frame = CGRectMake(nameX , CGRectGetMaxY(nameLabel.frame) + ScaleH(5), ScreenWidth / 2, ScaleH(20));
    phoneLabel.textColor =HEXCOLOR(0x6f7378);
    [self addSubview:phoneLabel];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textAlignment = NSTextAlignmentRight;
    countLabel.text = [NSString stringWithFormat:@"%@人",self.cellInfo.peopleCount];
    countLabel.font = [UIFont WLFontOfSize:14];
    countLabel.frame = CGRectMake(ScreenWidth - ScaleW(40) -  ScreenWidth / 3, 0, ScreenWidth / 3, cellHeight);
    countLabel.textColor =HEXCOLOR(0x6f7378);
    [self addSubview:countLabel];
    
    UIButton *indicatorBtn = [[UIButton alloc] init];
    [indicatorBtn setImage:[UIImage imageNamed:@"group_indicator"] forState:UIControlStateNormal];
    indicatorBtn.frame = CGRectMake(ScreenWidth - ScaleW(40), 0, ScaleW(20), cellHeight);
    indicatorBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:indicatorBtn];
    
}

- (UIColor *)getBgColorWithIndex:(NSUInteger)index
{
    UIColor *color = HEXCOLOR(0xfe798c);
    NSUInteger temp = index % 6;
    if (temp == 1) {
        color = HEXCOLOR(0x69c95f);
    }else if (temp == 2){
        color = HEXCOLOR(0x879efa);
    }else if (temp == 3){
        color = HEXCOLOR(0xc670db);
    }else if (temp == 4){
        color = HEXCOLOR(0xff7e44);
    }else if (temp == 5){
        color = HEXCOLOR(0x4499ff);
    }
    return color;
}

@end
