//
//  WLVisitorCell1.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLVisitorCell1.h"

#define cellIdentifier @"WLVisitorCell1"

@interface WLVisitorCell1 ()

@end

@implementation WLVisitorCell1

+ (WLVisitorCell1 *)cellWithTableView:(UITableView*)tableView{
    
    WLVisitorCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLVisitorCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
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

- (void)setDetailInfo:(WLVisitorDetailInfo *)detailInfo
{
    _detailInfo = detailInfo;
    [self setupUI];
}

- (void)setupUI{
    if (self.detailInfo == nil) {
        return;
    }
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
 
    UIButton *iconBtn = [[UIButton alloc] init];
    [iconBtn setTitle:@"23" forState:UIControlStateNormal];
    [iconBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [iconBtn setBackgroundImage:[UIImage imageWithColor:[self getBgColorWithIndex:0]] forState:UIControlStateNormal];
    CGFloat iconWidth = ScaleW(50);
    iconBtn.frame = CGRectMake(ScaleW(15), ScaleH(20), iconWidth, iconWidth);
    iconBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    iconBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    [self addSubview:iconBtn];
    iconBtn.layer.cornerRadius = iconWidth / 2;
    iconBtn.layer.masksToBounds = YES;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.text = self.detailInfo.name;
    nameLabel.font = [UIFont WLFontOfSize:14];
    CGFloat nameX = CGRectGetMaxX(iconBtn.frame) + ScaleW(10);
    CGFloat nameY = iconBtn.frame.origin.y;
    nameLabel.frame = CGRectMake(nameX , nameY, ScreenWidth / 2, ScaleH(20));
    nameLabel.textColor =HEXCOLOR(0x2f2f2f);
    [self addSubview:nameLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.attributedText = [self getPhoneNOText];
    phoneLabel.frame = CGRectMake(nameX , CGRectGetMaxY(nameLabel.frame) + ScaleH(15), ScreenWidth / 2, ScaleH(20));
    [self addSubview:phoneLabel];
    
    UILabel *idCardLabel = [[UILabel alloc] init];
    idCardLabel.textAlignment = NSTextAlignmentLeft;
    idCardLabel.attributedText = [self getIDNOText];
    idCardLabel.frame = CGRectMake(nameX , CGRectGetMaxY(phoneLabel.frame) + ScaleH(5), ScreenWidth / 2, ScaleH(20));
    [self addSubview:idCardLabel];

    
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

- (NSAttributedString *)getPhoneNOText
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HEXCOLOR(0x2f2f2f);
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:11];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"手机号码：" attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0x4877e7);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:11];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:self.detailInfo.phoneNO attributes:attrs2];
    [mutableString  appendAttributedString:string2];

    return mutableString;
    
}

- (NSAttributedString *)getIDNOText
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HEXCOLOR(0x2f2f2f);
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:11];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"身份证号：" attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0x6f7378);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:11];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:self.detailInfo.IDNO attributes:attrs2];
    [mutableString  appendAttributedString:string2];
    
    return mutableString;
    
}
@end
