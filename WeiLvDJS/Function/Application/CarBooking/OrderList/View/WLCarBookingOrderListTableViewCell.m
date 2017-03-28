//
//  WLCarBookingOrderListTableViewCell.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingOrderListTableViewCell.h"
#import "WLDataHotelHandler.h"

@interface WLCarBookingOrderListTableViewCell ()

@property (nonatomic, strong) UIView * cellBackView;

@property (nonatomic, strong) UIView * cellTopView;
@property (nonatomic, strong) UILabel * topTiem;
@property (nonatomic, strong) UILabel * topOrderStatus;
@property (nonatomic, strong) UILabel * topOrderEndTime;

@property (nonatomic, strong) UIView * cellMediumView;
@property (nonatomic, strong) UIImageView * roundDotImg1;
@property (nonatomic, strong) UILabel * startPlace;
@property (nonatomic, strong) UIImageView * roundDotImg12;
@property (nonatomic, strong) UILabel * afterPlace;
@property (nonatomic, strong) UIImageView * roundDotImg13;
@property (nonatomic, strong) UILabel * endOfPlace;

@property (nonatomic, strong) UIView * cellBottomView;
@property (nonatomic, strong) UILabel * bottomNeedType;
@property (nonatomic, strong) UILabel * bottomMoney;

@property (nonatomic, strong) NSTimer * timeGo;
@property (nonatomic, assign) NSInteger timeInterval;

@end

@implementation WLCarBookingOrderListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createCell];
    }
    
    return self;
}

+ (WLCarBookingOrderListTableViewCell *)cellcreateTableView:(UITableView *)tableView
{
    WLCarBookingOrderListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CarBookingCell"];
    if (!cell) {
        cell = [[WLCarBookingOrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CarBookingCell"];
    }
    
    return cell;
}

// 左边的距离
#define SplitLeft ScaleW(12)

- (void)createCell
{
    _cellBackView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_cellBackView];
    
    _cellTopView = [[UIView alloc] initWithFrame:CGRectZero];
    [_cellBackView addSubview:_cellTopView];
    _cellTopView.backgroundColor = [UIColor whiteColor];
    
    _cellMediumView = [[UIView alloc] initWithFrame:CGRectZero];
    [_cellBackView addSubview:_cellMediumView];
    _cellMediumView.backgroundColor = [WLTools stringToColor:@"#f8f8f8"];
    
    _cellBottomView = [[UIView alloc] initWithFrame:CGRectZero];
    [_cellBackView addSubview:_cellBottomView];
    _cellBottomView.backgroundColor = [UIColor whiteColor];
    
    UILabel * topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(10))];
    topLabel.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    [_cellBackView addSubview:topLabel];
    
// 左上角时间
    _topTiem = [[UILabel alloc] initWithFrame:CGRectMake(SplitLeft, SplitLeft, ScreenWidth - ScaleW(100), ScaleH(30))];
    [_cellTopView addSubview:_topTiem];
    _topTiem.text = @"1月26日 13:35 - 1月28日";
    _topTiem.textAlignment = NSTextAlignmentLeft;
    _topTiem.font = [UIFont WLFontOfSize:15.0];
    _topTiem.textColor = [WLTools stringToColor:@"#333333"];
    
// 订单状态
    _topOrderStatus = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(150), _topTiem.frame.origin.y, ScaleW(140), _topTiem.frame.size.height)];
    [_cellTopView addSubview:_topOrderStatus];
    //_topOrderStatus.text = @"待支付";//@"等待司机应答";
    _topOrderStatus.textColor = [WLTools stringToColor:@"#00cc99"];
    _topOrderStatus.textAlignment = NSTextAlignmentRight;
    _topOrderStatus.font = [UIFont WLFontOfSize:14.0];
    
// 倒计时
    _topOrderEndTime = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(200), _topOrderStatus.frame.origin.y + _topOrderStatus.frame.size.height + ScaleH(5), ScaleW(190), ScaleH(10))];
    [_cellTopView addSubview:_topOrderEndTime];
    //_topOrderEndTime.text = @"支付剩余时间：29:35";
    _topOrderEndTime.textColor = [WLTools stringToColor:@"#ffbd66"];
    _topOrderEndTime.textAlignment = NSTextAlignmentRight;
    _topOrderEndTime.font = [UIFont WLFontOfSize:12.0];
    _topOrderEndTime.hidden = YES;
    
//中间
    // 圆点
    _roundDotImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(SplitLeft, ScaleH(15), ScaleW(8), ScaleH(8))];
    [_roundDotImg1 setImage:[UIImage imageNamed:@"startPlace"]];
    [_cellMediumView addSubview:_roundDotImg1];
    
    _startPlace = [[UILabel alloc] initWithFrame:CGRectMake(_roundDotImg1.frame.origin.x + _roundDotImg1.frame.size.width + ScaleW(5), _roundDotImg1.frame.origin.y - ScaleH(5), ScreenWidth - ScaleW(35), ScaleH(20))];
    _startPlace.text = @"深圳北站";
    _startPlace.font = [UIFont WLFontOfSize:13.0];
    _startPlace.textColor = [WLTools stringToColor:@"#929292"];
    [_cellMediumView addSubview:_startPlace];
    
    // 中间圆点
    _roundDotImg12 = [[UIImageView alloc] initWithFrame:CGRectMake(SplitLeft, _roundDotImg1.frame.origin.y + _roundDotImg1.frame.size.height + ScaleH(23), ScaleW(8), ScaleH(8))];
    [_cellMediumView addSubview:_roundDotImg12];
    
    _afterPlace = [[UILabel alloc] initWithFrame:CGRectMake(_startPlace.frame.origin.x, _roundDotImg12.frame.origin.y - ScaleH(5), _startPlace.frame.size.width, _startPlace.frame.size.height)];
    _afterPlace.text = @"南京/上海/杭州";
    _afterPlace.font = [UIFont WLFontOfSize:13.0];
    _afterPlace.textColor = [WLTools stringToColor:@"#929292"];
    [_cellMediumView addSubview:_afterPlace];
    
    // 最后圆点
    _roundDotImg13 = [[UIImageView alloc] initWithFrame:CGRectMake(SplitLeft, _roundDotImg12.frame.origin.y + _roundDotImg12.frame.size.height + ScaleH(23), ScaleW(8), ScaleH(8))];
    [_cellMediumView addSubview:_roundDotImg13];
    
    _endOfPlace = [[UILabel alloc] initWithFrame:CGRectMake(_startPlace.frame.origin.x, _roundDotImg13.frame.origin.y - ScaleH(6), _startPlace.frame.size.width, _startPlace.frame.size.height)];
    _endOfPlace.text = @"罗湖火车站";
    _endOfPlace.font = [UIFont WLFontOfSize:13.0];
    _endOfPlace.textColor = [WLTools stringToColor:@"#929292"];
    [_cellMediumView addSubview:_endOfPlace];
    
// 价钱
    _bottomMoney = [[UILabel alloc] initWithFrame:CGRectZero];
    [_cellBottomView addSubview:_bottomMoney];
    _bottomMoney.text = @"";
    _bottomMoney.textColor = [WLTools stringToColor:@"#333333"];
    _bottomMoney.textAlignment = NSTextAlignmentRight;
    _bottomMoney.font = [UIFont WLFontOfSize:15.0];
    
// 座次
    _bottomNeedType = [[UILabel alloc] initWithFrame:CGRectZero];
    [_cellBottomView addSubview:_bottomNeedType];
    //_bottomNeedType.text = @"大巴车，需45座";
    _bottomNeedType.textColor = [WLTools stringToColor:@"#929292"];
    _bottomNeedType.textAlignment = NSTextAlignmentRight;
    _bottomNeedType.font = [UIFont WLFontOfSize:12.0];
    
    UILabel * topLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(0.5))];
    topLineLabel.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [_cellTopView addSubview:topLineLabel];
    
    UILabel * bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScaleH(44.5), ScreenWidth, ScaleH(0.5))];
    bottomLineLabel.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [_cellBottomView addSubview:bottomLineLabel];
}

- (void)setCellModel:(WLCarBookingOrderListObject *)model status:(NSInteger)status
{
// top
    NSDateComponents *dateComps = [self TimeIntervalChangeWithYYmmddhhmmssString:model.start_at];
    NSDateComponents *dateCompsEnd = [self TimeIntervalChangeWithYYmmddhhmmssString:model.end_at];
    _topTiem.text = [NSString stringWithFormat:@"%ld月%ld日 %ld:%02ld - %ld月%ld日",(long)[dateComps month],(long)[dateComps day],(long)[dateComps hour],(long)[dateComps minute],(long)[dateCompsEnd month],(long)[dateCompsEnd day]];
    if (status == 1) {//待处理

        if (model.choice_expiry_at.length != 0 && model.choice_expiry_at != nil) {
            _topOrderStatus.text = @"待选择司机";
            _topOrderStatus.height = _topOrderStatus.height - ScaleH(6);
            _topOrderEndTime.top = _topOrderEndTime.top - ScaleH(6);
            _topOrderEndTime.hidden = NO;
            _timeInterval = [WLDataHotelHandler getcountdownData:model.choice_expiry_at];
            [self showTimeGo];
            if (_timeGo == nil) {
                _timeGo = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimeGo) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:_timeGo forMode:NSRunLoopCommonModes];
            }
        }else{
            
            _topOrderStatus.text = @"待司机应答";
        }
        
    }else if (status == 2){//行程中
        
        if (model.trip_status == 0) {
            if (model.pay_status == 0) {
                _topOrderStatus.text = @"(待付款)待出行";
            }
            else
            {
                _topOrderStatus.text = @"待出行";
            }
            
        }else if (model.trip_status == 1) {
            
            if (model.pay_status == 0) {
                _topOrderStatus.text = @"(待付款)行程中";
            }
            else
            {
                _topOrderStatus.text = @"行程中";
            }
        }
    }else if (status == 3){//已完成
        if (model.pay_status == 0) {
            _topOrderStatus.text = @"(待付款)已完成";
        }
        else
        {
            _topOrderStatus.text = @"已完成";
        }
        
    }else if (status == 4){//已取消
        
//        _timeInterval = [WLDataHotelHandler getcountdownData:model.expiry_at];
        if (model.reception_status == 4) {
            _topOrderStatus.text = @"订单取消";
        }else if (model.reception_status == 6){
            _topOrderStatus.text = @"无司机应答";
        }else if (model.reception_status == 7){
            _topOrderStatus.text = @"选择超时";
        }
        
    }
    

// Medium
    _startPlace.text = [NSString stringWithFormat:@"%@",model.start_address];//@"深圳北站";

    if ([model.via_address isEqual:@""]) {
        if ([_topOrderStatus.text isEqual:@"待支付"]) {
            _cellBackView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(205));
            _cellTopView.frame = CGRectMake(0, ScaleH(10), ScreenWidth, ScaleH(65));
        }
        else
        {
            _cellBackView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(180));
            _cellTopView.frame = CGRectMake(0, ScaleH(10), ScreenWidth, ScaleH(55));
        }
        //_cellBackView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(210));
        //_cellTopView.frame = CGRectMake(0, ScaleH(10), ScreenWidth, ScaleH(65));
        _cellMediumView.frame = CGRectMake(0, _cellTopView.frame.origin.y + _cellTopView.frame.size.height, ScreenWidth, ScaleH(70));
        _cellBottomView.frame = CGRectMake(0, _cellMediumView.frame.origin.y + _cellMediumView.frame.size.height, ScreenWidth, ScaleH(45));
        _roundDotImg13.hidden = YES;
        _endOfPlace.hidden = YES;
        _afterPlace.text = [NSString stringWithFormat:@"%@",model.end_address];//@"罗湖火车站";
        
        [_roundDotImg12 setImage:[UIImage imageNamed:@"endOfPlace"]];
        [_roundDotImg13 setImage:[UIImage imageNamed:@"endOfPlace"]];
    }
    else
    {
        if ([_topOrderStatus.text isEqual:@"待支付"]) {
            _cellBackView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(215));
            _cellTopView.frame = CGRectMake(0, ScaleH(10), ScreenWidth, ScaleH(65));
        }
        else
        {
            _cellBackView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(200));
            _cellTopView.frame = CGRectMake(0, ScaleH(10), ScreenWidth, ScaleH(55));
        }
        //_cellBackView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(190));
        //_cellTopView.frame = CGRectMake(0, ScaleH(10), ScreenWidth, ScaleH(65));
        _cellMediumView.frame = CGRectMake(0, _cellTopView.frame.origin.y + _cellTopView.frame.size.height, ScreenWidth, ScaleH(100));
        _cellBottomView.frame = CGRectMake(0, _cellMediumView.frame.origin.y + _cellMediumView.frame.size.height, ScreenWidth, ScaleH(45));
        _roundDotImg13.hidden = NO;
        _endOfPlace.hidden = NO;
        _endOfPlace.text = [NSString stringWithFormat:@"%@",model.end_address];//@"罗湖火车站";
        _afterPlace.text = [NSString stringWithFormat:@"%@",model.via_address];
        
        [_roundDotImg12 setImage:[UIImage imageNamed:@"afterPlace"]];
        [_roundDotImg13 setImage:[UIImage imageNamed:@"endOfPlace"]];
    }
    
// bottom

    NSString * carModel = [[NSString alloc] init];
    
    if ([model.car_model isEqual:@"1"]) {
        carModel = @"大巴车";
    }
    else if ([model.car_model isEqual:@"2"]) {
        carModel = @"商务车";
    }
    else if ([model.car_model isEqual:@"4"]) {
        carModel = @"小汽车";
    }
    _bottomNeedType.text = [NSString stringWithFormat:@"%@,需%@座",carModel,model.car_seat_amount];//@"大巴车，需45座";
    if (![model.order_price isEqualToString:@"0.00"]) {
        _bottomMoney.hidden = NO;
        _bottomMoney.text = [NSString stringWithFormat:@"￥%@",model.order_price];
        CGSize size =[[NSString stringWithFormat:@"￥%@",model.order_price] sizeWithAttributes:@{NSFontAttributeName:WLFontSize(15)}];
        _bottomMoney.frame = CGRectMake(ScreenWidth - ScaleW(25) - size.width, SplitLeft, size.width + ScaleW(15), ScaleH(20));
        _bottomNeedType.frame = CGRectMake(_bottomMoney.frame.origin.x - ScaleW(150), SplitLeft + ScaleH(3), ScaleW(145), ScaleH(15));
    }else{
        _bottomMoney.hidden = YES;
        _bottomNeedType.frame = CGRectMake(ScreenWidth - ScaleW(150), SplitLeft + ScaleH(3), ScaleW(145), ScaleH(15));
    }
    
    
}

- (NSDateComponents *)TimeIntervalChangeWithYYmmddhhmmssString:(NSString *)timeString
{
    NSDate * Timedate = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:Timedate];
    return dateComps;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _topOrderStatus.frame = CGRectMake(ScreenWidth - ScaleW(150), _topTiem.frame.origin.y, ScaleW(140), _topTiem.frame.size.height);
    _topOrderEndTime.frame = CGRectMake(ScreenWidth - ScaleW(200), _topOrderStatus.frame.origin.y + _topOrderStatus.frame.size.height + ScaleH(5), ScaleW(190), ScaleH(10));
//    [self.timeGo invalidate];
//    self.timeGo = nil;
    _topOrderEndTime.hidden = YES;
}

- (void)showTimeGo
{
    _topOrderEndTime.text = [NSString stringWithFormat:@"选择剩余时间：%02ld:%02ld",_timeInterval/60,_timeInterval%60];
    
    if (_timeInterval > 0) {
        _timeInterval --;
    }
}


@end
