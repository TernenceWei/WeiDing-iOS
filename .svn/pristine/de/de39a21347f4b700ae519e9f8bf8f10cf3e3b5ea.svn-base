//
//  WLRechargeCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLRechargeCell.h"
#define cellIdentifier @"WLRechargeCell"

@interface WLRechargeCell ()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation WLRechargeCell
+ (WLRechargeCell *)cellWithTableView:(UITableView*)tableView{
    WLRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLRechargeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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

- (void)setupUI{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(15), ScreenWidth - ScaleW(20), ScaleH(140))];
    bgView.backgroundColor = WSColor(55, 177, 233);
    bgView.layer.cornerRadius = 6;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    _bgView = bgView;
    
    UILabel *titleLabel =[UILabel new];
    titleLabel.font =WLFontSize(20);
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.text = @"支付宝充值";
    titleLabel.frame = CGRectMake(ScaleW(20), ScaleH(20), ScreenWidth / 3, 40);
    [bgView addSubview:titleLabel];
    _titleLabel = titleLabel;

    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(bgView.width - ScaleW((28 + 36)), bgView.height - ScaleW((20 + 36)), ScaleW(36), ScaleW(36))];
    iconImage.image = [UIImage imageNamed:@"alipayReachageIcon"];
    [bgView addSubview:iconImage];
    _iconImage = iconImage;
}

- (void)setMode:(WLPaymentMode)mode
{
    _mode = mode;
    if (mode == WLPaymentModeWeixin) {
        _titleLabel.text = @"微信";
        _iconImage.image = [UIImage imageNamed:@"weixinReachageIcon"];
        _bgView.backgroundColor = HEXCOLOR(0x38ba40);
    }else{
        
        _titleLabel.text = @"支付宝";
        _iconImage.image = [UIImage imageNamed:@"alipayReachageIcon"];
        _bgView.backgroundColor = WSColor(55, 177, 233);
        
    }
    
}
@end
