//
//  WLCarBookingInfoCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingInfoCell.h"
#import "UIImageView+WebCache.h"

#define cellIdentifier @"WLCarBookingInfoCell"

@interface WLCarBookingInfoCell ()

@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, copy) void(^onClickAction)(NSUInteger index);
@property (nonatomic, strong) NSString *placeHoldText;
@property (nonatomic, strong) UIImage *placeHoldImage;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIButton *leftButton;

@end

@implementation WLCarBookingInfoCell

+ (WLCarBookingInfoCell *)cellWithTableView:(UITableView*)tableView
                                clickAction:(void (^)(NSUInteger))clickAction
                              placeHoldText:(NSString *)placeHoldText
                                 placeImage:(UIImage *)image{
    WLCarBookingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.onClickAction = clickAction;
    cell.placeHoldText = placeHoldText;
    cell.placeHoldImage = image;
    [cell setupUI];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI
{
    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    NSArray *pointArray = @[@"bookingCar_user",@"carBookingImage"];
    for (int i = 0; i < 2; i++) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:pointArray[i]];
        iconView.frame = CGRectMake(ScaleW(20), ScaleH(45) * i + (ScaleH(45) - 17) / 2, 17, 17);
        [self.contentView addSubview:iconView];
        
        UIButton *actionBtn = [[UIButton alloc] init];
        [actionBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        actionBtn.frame = CGRectMake(ScreenWidth - ScaleW(20), ScaleH(45) * i, ScaleW(8), ScaleH(45));
        [self.contentView addSubview:actionBtn];
    }
    
    CGFloat buttonX = ScaleW(45);
    CGFloat buttonH = ScaleH(45);
    NSArray *nameArray = @[@"用车人",@"行程详情"];
    
    for (int i = 0; i < 2; i++) {
        UIButton *beginBtn = [UIButton buttonWithTitle:nameArray[i] titleColor:Color3 font:[UIFont WLFontOfSize:15] target:self action:@selector(buttonClick:)];
        beginBtn.tag = i;
        beginBtn.frame = CGRectMake(buttonX, buttonH * i, ScreenWidth - buttonX - ScaleW(20), buttonH);
        beginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:beginBtn];
        if (i == 1) {
            beginBtn.tag = 2;
            if (self.placeHoldImage) {
                [beginBtn setTitleColor:Color2 forState:UIControlStateNormal];
            }
            self.leftButton = beginBtn;
        }else{
            [beginBtn setTitleColor:Color2 forState:UIControlStateNormal];
        }
        
    }
    
    /*
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"CarBookingSavedUserInfo"];
    NSString *defaultText;
    if (dict) {
        NSString *name = [dict objectForKey:@"name"];
        if (name.length > 8) {
            name = [name substringToIndex:8];
        }
        defaultText = [NSString stringWithFormat:@"%@ %@",name,[dict objectForKey:@"phone"]];
    }else{
        defaultText = [NSString stringWithFormat:@"自己 %@",[WLUserTools getUserMobile]];
    }
     */
    UILabel *rightLabel = [UILabel labelWithText:self.placeHoldText textColor:Color2 fontSize:14];
    rightLabel.frame = CGRectMake(ScaleW(105), 0, ScreenWidth - ScaleW(130), buttonH);
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.numberOfLines = 1;
    [self.contentView addSubview:rightLabel];
    self.rightLabel = rightLabel;
    
    if (self.placeHoldText) {
        NSString *chcc = [[self.placeHoldText componentsSeparatedByString:@" "] firstObject];
        if (![chcc isEqualToString:@"自己"]) {
            [self setText:self.placeHoldText];
        }
    }
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(ScreenWidth - ScaleH(60), ScaleH(52), ScaleH(30), ScaleH(30));
    iconView.layer.cornerRadius = ScaleH(15);
    if (self.placeHoldImage) {
        iconView.image = self.placeHoldImage;
        iconView.hidden = NO;
    }else{
        iconView.hidden = YES;
    }
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.masksToBounds = YES;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
}

- (void)buttonClick:(UIButton * )button
{
    self.onClickAction(button.tag);
}

- (void)setText:(NSString *)text
{
    self.rightLabel.text = text;
}

- (void)setImage:(UIImage *)image
{
    if (image) {
        self.iconView.hidden = NO;
        self.iconView.image = image;
        [self.leftButton setTitleColor:Color2 forState:UIControlStateNormal];
    }else{
        self.iconView.hidden = YES;
        [self.leftButton setTitleColor:Color3 forState:UIControlStateNormal];
    }
    
}

- (void)setImageUrl:(NSString *)imageUrl
{
    if (imageUrl) {
        self.iconView.hidden = NO;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        [self.leftButton setTitleColor:Color2 forState:UIControlStateNormal];
    }else{
        self.iconView.hidden = YES;
        [self.leftButton setTitleColor:Color3 forState:UIControlStateNormal];
    }
}
@end
