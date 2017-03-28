//
//  WLCarBookingDetailUserCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingDetailUserCell.h"
#import "WLCarBookingDriverObject.h"

#define cellIdentifier @"WLCarBookingDetailUserCell"

@interface WLCarBookingDetailUserCell ()

@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, copy) void(^onPaymentAction)();

@end

@implementation WLCarBookingDetailUserCell
- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

+ (WLCarBookingDetailUserCell *)cellWithTableView:(UITableView*)tableView
                                    paymentAction:(void (^)())paymentAction
{
    WLCarBookingDetailUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingDetailUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.onPaymentAction = paymentAction;
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
    }
    return self;
}

- (void)setObject:(WLCarBookingOrderDetailObject *)object
{
    _object = object;
    if (object == nil) {
        return;
    }
    [self setupUI];
}

- (void)setupUI{
    
    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    NSString *carMode = [[NSString alloc] init];
    if (self.object.reception_status.integerValue == 1) {
        carMode = @"大巴车";
        if (self.object.car_model.integerValue == 2) {
            carMode = @"商务车";
        }else if (self.object.car_model.integerValue == 4) {
            carMode = @"小轿车";
        }
    }
    
    // -- 1.0.3
    UIImageView * headImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(12), ScaleW(50), ScaleH(50))];
    [headImg setImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    headImg.layer.cornerRadius = 25.0;
    [self.contentView addSubview:headImg];
    
    UILabel * nameLabel = [UILabel labelWithText:self.object.driver_name textColor:Color2 fontSize:14.0];
    nameLabel.frame = CGRectMake(headImg.frame.origin.x + headImg.frame.size.width + ScaleW(10), headImg.frame.origin.y + ScaleH(5), ScaleW(200), ScaleH(20));
    [self.contentView addSubview:nameLabel];
    
    WLCarBookingDriverObject * driverObject = [[WLCarBookingDriverObject alloc] init];
    if (_object.order_bid_list.count != 0) {
        driverObject = _object.order_bid_list[0];
        [headImg sd_setImageWithURL:[NSURL URLWithString:driverObject.driver_avatar] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
        
        NSString *driverName = [driverObject.driver_name substringToIndex:1];
        nameLabel.text = [NSString stringWithFormat:@"%@",[driverName stringByAppendingString:@"师傅"]];
    }
    //UILabel * useHowLabel = [UILabel labelWithText:@"已服务 885次" textColor:Color2 fontSize:14.0];
    //[self.contentView addSubview:useHowLabel];
    

    UIButton * callBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(60), headImg.frame.origin.y, ScaleW(40), ScaleH(40))];
    [callBtn setImage:[UIImage imageNamed:@"dianhuaImg"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:callBtn];
    
    if ([self canCall]) {
        callBtn.hidden = NO;
    }
    else
    {
        callBtn.hidden = YES;
    }
    
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headImg.frame.origin.y + headImg.frame.size.height + ScaleH(13), ScreenWidth, ScaleH(0.5))];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineLabel];
    
    UIButton * showImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, lineLabel.frame.origin.y + lineLabel.frame.size.height, ScreenWidth, ScaleH(60))];
    [showImgBtn addTarget:self action:@selector(showImgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:showImgBtn];
    
    UILabel * howSeat = [UILabel labelWithText:[NSString stringWithFormat:@"%@座%@",self.object.car_seat_amount,carMode] textColor:[WLTools stringToColor:@"#333333"] fontSize:13.0];
    howSeat.frame = CGRectMake(headImg.frame.origin.x, ScaleH(13), ScreenWidth - ScaleW(30), ScaleH(20));
    [showImgBtn addSubview:howSeat];
    
    UILabel * howCar = [UILabel labelWithText:[NSString stringWithFormat:@"%@ 已用%@年 %@",self.object.car_brand,(driverObject.age_limit == nil)?@"":driverObject.age_limit,self.object.car_number] textColor:[WLTools stringToColor:@"#333333"] fontSize:11.0];
    howCar.frame = CGRectMake(howSeat.frame.origin.x, howSeat.frame.origin.y + howSeat.frame.size.height + ScaleH(2), howSeat.frame.size.width, howSeat.frame.size.height);
    [showImgBtn addSubview:howCar];
    
    UIImageView * arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(20), howSeat.frame.origin.y + ScaleH(10), ScaleW(10), ScaleH(20))];
    [arrowImg setImage:[UIImage imageNamed:@"arrow"]];
    [showImgBtn addSubview:arrowImg];
}

- (void)buttonClick
{
    NSString *telPhoneStr;
    if (self.object.order_bid_list.count) {
        WLCarBookingDriverObject * driverObject = _object.order_bid_list[0];
        telPhoneStr = [NSString stringWithFormat:@"tel:%@", driverObject.driver_mobile];
    }
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telPhoneStr]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoneStr]];
    }
}

- (BOOL)canCall
{
    return [[WLDateManager dateDefault] isOverTodayOfTimeString:[NSString stringWithFormat:@"%ld",self.object.start_at.integerValue - 259200]];
}

- (void)showImgBtnClick
{
    self.onPaymentAction();
}

- (void)paymentBtnClick
{
    if (self.object.reception_status.integerValue == 4) {
        [[WL_TipAlert_View sharedAlert] createTip:@"该订单已失效"];
        return;
    }
}

@end
