//
//  WLCarBookingDriverCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/2/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingDriverCell.h"
#define cellIdentifier @"WLCarBookingDriverCell"

@interface WLCarBookingDriverCell ()

@property (nonatomic, copy) void(^onSelectAction)();
@property (nonatomic, strong) UILabel *driverLabel;
@property (nonatomic, strong) UILabel *carLabel;
@property (nonatomic, strong) UILabel *priceLabel; // 1.0.3版 服务次数
@property (nonatomic, strong) UIImageView * headImg;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * driverPriceLabel;

@end

@implementation WLCarBookingDriverCell


+ (WLCarBookingDriverCell *)cellWithTableView:(UITableView*)tableView
                                 selectAction:(void (^)())selectAction
{
    WLCarBookingDriverCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingDriverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.onSelectAction = selectAction;
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
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleH(10), ScaleW(70), ScaleH(70))];
    _headImg.layer.cornerRadius = 35;
    [_headImg setImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    [self.contentView addSubview:_headImg];
    
    self.driverLabel = [UILabel labelWithText:@"王师傅" textColor:Color2 fontSize:17];
    self.driverLabel.frame = CGRectMake(_headImg.frame.origin.x + _headImg.frame.size.width + ScaleW(12), ScaleH(10), ScreenWidth - ScaleW(100), ScaleH(30));
    [self.contentView addSubview:self.driverLabel];
    
    self.carLabel = [UILabel labelWithText:@"粤B42569" textColor:[WLTools stringToColor:@"#333333"] fontSize:14];
    self.carLabel.frame = CGRectMake(_driverLabel.frame.origin.x, _driverLabel.frame.origin.y + _driverLabel.frame.size.height, ScreenWidth - ScaleW(100), ScaleH(30));
    [self.contentView addSubview:self.carLabel];
    
//    self.priceLabel = [UILabel labelWithText:@"已服务 2000次" textColor:Color2 fontSize:15];
//    self.priceLabel.frame = CGRectMake(_driverLabel.frame.origin.x, ScaleH(80), ScreenWidth - ScaleW(100), ScaleH(40));
//    [self.contentView addSubview:self.priceLabel];
    _moneyLabel = [UILabel labelWithText:@"￥564" textColor:Color2 fontSize:17];
    _moneyLabel.frame = CGRectMake(ScreenWidth - ScaleW(150), _driverLabel.frame.origin.y, ScaleW(140), _driverLabel.frame.size.height);
    _moneyLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_moneyLabel];
    
    _driverPriceLabel = [UILabel labelWithText:@"" textColor:Color3 fontSize:14];
    _driverPriceLabel.font = [UIFont systemFontOfSize:12.0];
    _driverPriceLabel.textAlignment = NSTextAlignmentRight;
    _driverPriceLabel.frame = CGRectMake(ScreenWidth - ScaleW(100), _carLabel.frame.origin.y, ScaleW(80), _carLabel.frame.size.height);
    [self.contentView addSubview:_driverPriceLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(0), ScaleH(84.5), ScreenWidth, ScaleH(0.5))];
    line.backgroundColor = bordColor;
    [self.contentView addSubview:line];
}

- (void)setCellViewPath:(NSIndexPath *)path object:(WLCarBookingDriverObject *)DriverObject
{
    NSString *driverName = [DriverObject.driver_name substringToIndex:1];
    self.driverLabel.text = [driverName stringByAppendingString:@"师傅"];
    NSString *carmode = @"大巴车";
    if (DriverObject.car_model.integerValue == 2) {
        carmode = @"商务车";
    }else if (DriverObject.car_model.integerValue == 4) {
        carmode = @"小轿车";
    }
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:DriverObject.driver_avatar] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@",DriverObject.bid_price];
    self.carLabel.text = [NSString stringWithFormat:@"%@ %@ %@座%@",DriverObject.car_brand,[DriverObject.car_number substringToIndex:2], DriverObject.car_seat_amount,carmode];
    
    if (path.section == 0) {
        // 是否被选择的显示状态
        _driverPriceLabel.text = @"司机报价";
        self.driverLabel.textColor = Color2;
        self.carLabel.textColor = [WLTools stringToColor:@"#333333"];
        _moneyLabel.textColor = Color2;
        _driverPriceLabel.textColor = Color3;
    }
    else if (path.section == 1)
    {
        // 是否被选择的显示状态
        _driverPriceLabel.text = @"报价已失效";
        self.driverLabel.textColor = [WLTools stringToColor:@"#b6b6b6"];
        self.carLabel.textColor = [WLTools stringToColor:@"#b6b6b6"];
        _moneyLabel.textColor = [WLTools stringToColor:@"#b6b6b6"];
        _driverPriceLabel.textColor = [WLTools stringToColor:@"#f63d3d"];
    }
}

// 1.0.2版，1.0.3不用了
- (NSAttributedString *)getPriceTextWithPrice:(NSString *)actualPrice
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = Color3;
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:14];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"报价：" attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0xffad38);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:21];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",actualPrice] attributes:attrs2];
    [mutableString  appendAttributedString:string2];
    
    return mutableString;
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.driverLabel.text = @"";
    self.carLabel.text = @"";
    self.priceLabel.text = @"";
}

- (void)selectBtnClick
{
    self.onSelectAction();
}

@end
