//
//  WLAffirmDriverTableViewCell.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/2/27.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLAffirmDriverTableViewCell.h"
#define cellIdentifier @"WLAffirmDriverTableViewCell"

@interface WLAffirmDriverTableViewCell ()

@property (nonatomic, strong) UILabel *driverLabel;
@property (nonatomic, strong) UILabel *carLabel;
@property (nonatomic, strong) UILabel *priceLabel; // 1.0.3版 服务次数
@property (nonatomic, strong) UIImageView * headImg;
@property (nonatomic, strong) UILabel * moneyLabel;

@end

@implementation WLAffirmDriverTableViewCell

+ (WLAffirmDriverTableViewCell *)cellWithTableView:(UITableView*)tableView
{
    WLAffirmDriverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLAffirmDriverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    }
    return self;
}

- (void)setupUIDatadriverobject:(WLCarBookingDriverObject *)driverobject
{
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleH(12), ScaleW(70), ScaleH(70))];
    _headImg.layer.cornerRadius = 35;
    [_headImg setImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    [self.contentView addSubview:_headImg];
    
    self.driverLabel = [UILabel labelWithText:@"王师傅" textColor:Color2 fontSize:17];
    self.driverLabel.frame = CGRectMake(_headImg.frame.origin.x + _headImg.frame.size.width + ScaleW(12), _headImg.frame.origin.y + ScaleH(5), ScreenWidth - ScaleW(100), ScaleH(30));
    [self.contentView addSubview:self.driverLabel];
    
    self.carLabel = [UILabel labelWithText:@"粤B42569" textColor:Color3 fontSize:15];
    self.carLabel.frame = CGRectMake(_driverLabel.frame.origin.x, ScaleH(40), ScreenWidth - ScaleW(100), ScaleH(30));
//    [self.contentView addSubview:self.carLabel];
    
    //    self.priceLabel = [UILabel labelWithText:@"已服务 2000次" textColor:Color2 fontSize:15];
    //    self.priceLabel.frame = CGRectMake(_driverLabel.frame.origin.x, ScaleH(80), ScreenWidth - ScaleW(100), ScaleH(40));
    //    [self.contentView addSubview:self.priceLabel];
    
    _moneyLabel = [UILabel labelWithText:@"￥564" textColor:Color2 fontSize:17];
    _moneyLabel.frame = CGRectMake(ScreenWidth - ScaleW(150), _driverLabel.frame.origin.y, ScaleW(140), _driverLabel.frame.size.height);
    _moneyLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_moneyLabel];
    
    UILabel * driverPriceLabel = [UILabel labelWithText:@"司机报价" textColor:Color3 fontSize:14];
    driverPriceLabel.font = [UIFont systemFontOfSize:12.0];
    driverPriceLabel.textAlignment = NSTextAlignmentRight;
    driverPriceLabel.frame = CGRectMake(ScreenWidth - ScaleW(100), _carLabel.frame.origin.y, ScaleW(80), _carLabel.frame.size.height);
    [self.contentView addSubview:driverPriceLabel];
    
    UILabel * leftline = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(10), _driverLabel.frame.origin.y + _driverLabel.frame.size.height + ScaleH(40), ScaleW(130), ScaleH(0.5))];
    leftline.backgroundColor = Color4;
    [self.contentView addSubview:leftline];
    
    UILabel *addPriceRecord = [UILabel labelWithText:@"费用包含" textColor:Color3 fontSize:14];
    addPriceRecord.frame = CGRectMake(leftline.frame.origin.x + leftline.frame.size.width + ScaleW(10), leftline.frame.origin.y - ScaleH(10), ScaleW(80), ScaleH(20));
    addPriceRecord.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:addPriceRecord];
    
    UILabel * rightline = [[UILabel alloc] initWithFrame:CGRectMake(addPriceRecord.frame.origin.x + addPriceRecord.frame.size.width + ScaleW(10), leftline.frame.origin.y, leftline.frame.size.width, leftline.frame.size.height)];
    rightline.backgroundColor = Color4;
    [self.contentView addSubview:rightline];
    
    NSString * settingStr = driverobject.cost_memo;
    
    NSArray *arr = [settingStr componentsSeparatedByString:@","];
    
    NSArray * typeArr = [NSArray arrayWithObjects:@"小费",@"油费",@"过路费",@"停车费", nil];
    for (NSInteger i = 0; i < 4; i ++) {
        UIImageView * chooseImg = [[UIImageView alloc] initWithFrame:CGRectMake(((ScreenWidth - ScaleW(20))/4)/4 + ((ScreenWidth - ScaleW(20))/4)*i, addPriceRecord.frame.origin.y + addPriceRecord.frame.size.height + ScaleH(20), ScaleW(20), ScaleH(20))];
        [self.contentView addSubview:chooseImg];
        
        NSString * sssI = [NSString stringWithFormat:@"%ld",i + 1];
        [arr containsObject:sssI]?[chooseImg setImage:[UIImage imageNamed:@"feiyongbaohan"]]:[chooseImg setImage:[UIImage imageNamed:@"feiyongbubaohan"]];
        
        UILabel * chooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(chooseImg.frame.origin.x + chooseImg.frame.size.width + ScaleW(5), chooseImg.frame.origin.y, ScaleW(60), ScaleH(20))];
        chooseLabel.text = typeArr[i];
        chooseLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:chooseLabel];
        
        [arr containsObject:sssI]?[chooseLabel setTextColor:[WLTools stringToColor:@"#333333"]]:[chooseLabel setTextColor:[WLTools stringToColor:@"#b6b6b6"]];
    }
    
    NSString *driverName = [driverobject.driver_name substringToIndex:1];
    self.driverLabel.text = [driverName stringByAppendingString:@"师傅"];
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@",driverobject.bid_price];
}

- (void)setCellDatadriverobject:(WLCarBookingDriverObject *)driverobject
{
    [self setupUIDatadriverobject:driverobject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
