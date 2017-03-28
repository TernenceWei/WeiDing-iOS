//
//  WL_Application_Driver_OrderCell.m
//  WeiLvDJS
//
//  Created by whw on 16/12/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_OrderCell.h"
@interface WL_Application_Driver_OrderCell ()
{
    dispatch_source_t _timer;/**< 倒计时 */
}
/**< 订单描述Label */
@property (nonatomic, weak) UILabel *orderDescriptionLabel;
/**< 价格Label */
@property (nonatomic, weak) UILabel *priceLabel;
/**< 车辆座位数Label */
@property (nonatomic, weak) UILabel *seatCountLabel;
/** 结束日期Label */
@property(nonatomic, weak)UILabel *arrivalTimeLabel;
/** 目的地城市Label */
@property(nonatomic, weak)UILabel *destinationCityLabel;


@end

@implementation WL_Application_Driver_OrderCell
#pragma mark - 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupUI];
        //设置cell点击不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


#pragma mark - 自定义UI
- (void)setupUI
{
    //将cell分为上中下三部分
    UIView *upView = [[UIView alloc]init];
    UIView *middleView = [[UIView alloc]init];
    UIView *bottomView = [[UIView alloc]init];
    
    //设置背景颜色
    upView.backgroundColor =     [WLTools stringToColor:@"#ffffff"];
    middleView.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
    bottomView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    
    //加到cell上
    [self.contentView addSubview:upView];
    [self.contentView addSubview:middleView];
    [self.contentView addSubview:bottomView];
    
    //自动布局
    [upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.offset(ScaleH(88));
    }];
    
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.offset(ScaleH(80));
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.offset(ScaleH(60));
    }];
    
    //设置upView中的子控件
    UILabel *orderDescriptionLabel = [[UILabel alloc]init];
    UILabel *priceLabel = [[UILabel alloc]init];
    UIImageView *carImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zuowei"]];
    UILabel *seatCountLabel = [[UILabel alloc]init];
    
    orderDescriptionLabel.textColor = [WLTools stringToColor:@"#333333"];
    orderDescriptionLabel.font = [UIFont WLFontOfSize:17];
    
    priceLabel.textColor = [WLTools stringToColor:@"#333333"];
    priceLabel.font = [UIFont WLFontOfSize:17];
    
    seatCountLabel.textColor = [WLTools stringToColor:@"#929292"];
    seatCountLabel.font = [UIFont WLFontOfSize:14];
    
    [upView addSubview:orderDescriptionLabel];
    [upView addSubview:priceLabel];
    [upView addSubview:carImageView];
    [upView addSubview:seatCountLabel];
    
    //设置布局
    [orderDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView).offset(ScaleH(17));
        make.left.equalTo(upView).offset(ScaleW(12));
        make.right.equalTo(upView).offset(- ScaleW(12));
    }];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderDescriptionLabel.mas_bottom).offset(ScaleH(17));
        make.left.equalTo(upView).offset(ScaleW(12));
    }];
    [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceLabel);
        make.left.equalTo(priceLabel.mas_right).offset(ScaleW(20));
    }];
    [seatCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(carImageView);
        make.left.equalTo(carImageView.mas_right).offset(ScaleW(6));
    }];
    
    //设置middleView中的子控件
    UIImageView *startImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qidian"]];
    UILabel *departureTimeLabel = [[UILabel alloc]init];
    UILabel *fromCityLabel = [[UILabel alloc]init];
    UIImageView *endImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhongdian"]];
    UILabel *arrivalTimeLabel = [[UILabel alloc]init];
    UILabel *destinationCityLabel = [[UILabel alloc]init];
    
    departureTimeLabel.textColor = [WLTools stringToColor:@"#333333"];
    departureTimeLabel.font = [UIFont WLFontOfSize:14];
    fromCityLabel.textColor = [WLTools stringToColor:@"#929292"];
    fromCityLabel.font = [UIFont WLFontOfSize:14];
    fromCityLabel.textAlignment = NSTextAlignmentLeft;
    
    arrivalTimeLabel.textColor = [WLTools stringToColor:@"#333333"];
    arrivalTimeLabel.font = [UIFont WLFontOfSize:14];
    destinationCityLabel.textColor = [WLTools stringToColor:@"#929292"];
    destinationCityLabel.font = [UIFont WLFontOfSize:14];
    destinationCityLabel.textAlignment = NSTextAlignmentLeft;
    
    
    [middleView addSubview:startImageView];
    [middleView addSubview:departureTimeLabel];
    [middleView addSubview:fromCityLabel];
    [middleView addSubview:endImageView];
    [middleView addSubview:arrivalTimeLabel];
    [middleView addSubview:destinationCityLabel];
    
    //设置布局
    [startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView).offset(ScaleH(17));
        make.left.equalTo(middleView).offset(ScaleW(12));
        make.width.offset(32);
    }];
    [departureTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(startImageView);
        make.left.equalTo(startImageView.mas_right).offset(ScaleW(16));
        make.width.offset(75);
    }];
    [fromCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(startImageView);
        make.left.equalTo(departureTimeLabel.mas_right).offset(ScaleW(16));
        make.right.equalTo(middleView.mas_right).offset(- ScaleW(12));
    }];
    [endImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startImageView.mas_bottom).offset(ScaleH(15));
        make.left.equalTo(middleView).offset(ScaleW(12));
        make.width.offset(32);
    }];
    [arrivalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(endImageView);
        make.left.equalTo(endImageView.mas_right).offset(ScaleW(16));
        make.width.offset(75);
       
    }];
    [destinationCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(arrivalTimeLabel);
        make.left.equalTo(arrivalTimeLabel.mas_right).offset(ScaleW(16));
        make.right.equalTo(middleView.mas_right).offset(- ScaleW(12));
    }];
    
    //设置bottomView中的子控件
    UIButton *refuseButton = [[UIButton alloc]init];
    UIButton *acceptButton = [[UIButton alloc]init];
    
    [refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [refuseButton setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
    refuseButton.titleLabel.font = WLFontSize(17);
    [refuseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];

    [acceptButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    acceptButton.titleLabel.font = WLFontSize(17);
    [acceptButton setTitleColor:[WLTools stringToColor:@"#929292"] forState:UIControlStateDisabled];
    [acceptButton setBackgroundImage:nil forState:UIControlStateDisabled];
    [acceptButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    
    [bottomView addSubview:refuseButton];
    [bottomView addSubview:acceptButton];
    
    [acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(bottomView.mas_right).offset(- ScaleW(12));
        make.width.offset(ScaleW(120));
    }];
    [refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(acceptButton);
        make.right.equalTo(acceptButton.mas_left).offset(- ScaleW(15));
        make.width.offset(ScaleW(80));
    }];
    
    
    //保存属性
    self.priceLabel            = priceLabel;
    self.refuseButton          = refuseButton;
    self.acceptButton          = acceptButton;
    self.fromCityLabel         = fromCityLabel;
    self.seatCountLabel        = seatCountLabel;
    self.arrivalTimeLabel      = arrivalTimeLabel;
    self.departureTimeLabel    = departureTimeLabel;
    self.destinationCityLabel  = destinationCityLabel;
    self.orderDescriptionLabel = orderDescriptionLabel;
}

#pragma mark - 订单模型
- (void)setOrderModel:(WLDriverOrderObject *)orderModel
{
    _orderModel = orderModel;
    self.orderDescriptionLabel.text = orderModel.trip_name;
    self.fromCityLabel.text = orderModel.start_address;
    self.departureTimeLabel.text = [NSString getDateStringWithTime:orderModel.start_at andFormatter:@"MM月dd日"];
    self.seatCountLabel.text = [NSString stringWithFormat:@"%@座",orderModel.car_seat_amount];
    self.arrivalTimeLabel.text = [NSString getDateStringWithTime:orderModel.end_at andFormatter:@"MM月dd日"];
    self.destinationCityLabel.text = orderModel.end_address;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",orderModel.order_price] ;
    switch ([orderModel.reception_status intValue]) {
        case 0:
        {
            self.orderStatus = [WLTools setupDifferentTime:orderModel.expiry_at] < 0?WL_FailureOrderStatusOverTime:WL_WaitOrderStatus;
        }
            break;
        case 1:
        {
            switch ([orderModel.trip_status intValue])
            {
                case 0:
                    self.orderStatus = WL_AcceptOrderStatusStart;
                    break;
                case 1:
                    self.orderStatus = WL_AcceptOrderStatusTravel;
                    break;
                case 2:
                    self.orderStatus = WL_AcceptOrderStatusEnd;
                    break;
                default:
                    break;
            }
             break;
        }
        case 2:
            self.orderStatus = WL_FailureOrderStatusRefused;
            break;
        case 3:
        case 4:
            self.orderStatus = WL_FailureOrderStatusCanceled;
            break;
        default:
            break;
    }
    
}
#pragma mark - 重写订单状态
- (void)setOrderStatus:(WLOrderStatus)orderStatus
{
    _orderStatus = orderStatus;
    switch (orderStatus) {
            
        case WL_WaitOrderStatus:
            [self setupOrderButtonWithStatus:WL_WaitOrderStatus];
            break;
        case WL_AcceptOrderStatusStart:
            [self setupOrderButtonWithStatus:WL_AcceptOrderStatusStart];
            break;
        case WL_AcceptOrderStatusTravel:
            [self setupOrderButtonWithStatus:WL_AcceptOrderStatusTravel];
            break;
        case WL_AcceptOrderStatusEnd:
            [self setupOrderButtonWithStatus:WL_AcceptOrderStatusEnd];
            break;
        case WL_FailureOrderStatusRefused:
            [self setupOrderButtonWithStatus:WL_FailureOrderStatusRefused];
            break;
        case WL_FailureOrderStatusCanceled:
            [self setupOrderButtonWithStatus:WL_FailureOrderStatusCanceled];
            break;
        case WL_FailureOrderStatusOverTime:
            [self setupOrderButtonWithStatus:WL_FailureOrderStatusOverTime];
            break;
        default:
            
            break;
    }
    
}
#pragma mark - 开启获取验证码定时器
- (void)achieveCaptchaStartTime:(double)differentTime
{
    __block int timeout = differentTime; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{ //处理关闭后的逻辑
                
                
            });
        }
        else
        {
            int minutes = timeout / 61;
            int seconds = timeout % 61;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            NSString *strMinTime = [NSString stringWithFormat:@"%d", minutes];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                //DLog(@"____%@",strTime);
                if (self.orderStatus == WL_WaitOrderStatus) {
                    [self.acceptButton setTitle:[NSString stringWithFormat:@"接单%@:%@",strMinTime, strTime] forState:UIControlStateNormal];
                }
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
#pragma mark - 设置接单拒单显示的样式
- (void)setupOrderButtonWithStatus:(WLOrderStatus)status
{
    
    self.acceptButton.enabled = (status == WL_AcceptOrderStatusEnd || status == WL_FailureOrderStatus ||status == WL_FailureOrderStatusRefused || status == WL_FailureOrderStatusCanceled||status == WL_FailureOrderStatusOverTime)?NO:YES;
    self.refuseButton.hidden = (status == WL_WaitOrderStatus || status == WL_AcceptOrderStatusTravel)?NO:YES;
    [self.acceptButton setBackgroundImage:[UIImage imageNamed:(status == WL_FailureOrderStatus||status ==WL_AcceptOrderStatusEnd||status == WL_FailureOrderStatusRefused || status == WL_FailureOrderStatusCanceled||status == WL_FailureOrderStatusOverTime)?nil:@"jiedan"] forState:UIControlStateNormal];
    
    [self.refuseButton setBackgroundImage:[UIImage imageNamed:(status == WL_WaitOrderStatus)?@"judan":nil] forState:UIControlStateNormal];
    
    switch (status) {
            
        case WL_WaitOrderStatus:
        {
            [self.refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
            [self.refuseButton setTitleColor:[WLTools stringToColor:@"#333333"] forState:UIControlStateNormal];
            [self achieveCaptchaStartTime:[WLTools setupDifferentTime:self.orderModel.expiry_at]];
            break;
        }
        case WL_AcceptOrderStatusStart:
            [self.acceptButton setTitle:@"出发" forState:UIControlStateNormal];
            break;
        case WL_AcceptOrderStatusTravel:
        {
            [self.refuseButton setTitle:@"行程中" forState:UIControlStateNormal];
            [self.refuseButton setBackgroundImage:nil forState:UIControlStateNormal];
            [self.refuseButton setTitleColor:[WLTools stringToColor:@"#00cc99"] forState:UIControlStateNormal];
            [self.acceptButton setTitle:@"结束" forState:UIControlStateNormal];
            break;
        }
        case WL_AcceptOrderStatusEnd:
            [self.acceptButton setTitle:@"已结束" forState:UIControlStateDisabled];
            
            break;
        case WL_FailureOrderStatusCanceled:
            [self.acceptButton setTitle:@"已被取消" forState:UIControlStateDisabled];
            break;
        case WL_FailureOrderStatusRefused:
            [self.acceptButton setTitle:@"已拒绝" forState:UIControlStateDisabled];
            break;
        case WL_FailureOrderStatusOverTime:
            [self.acceptButton setTitle:@"已超时" forState:UIControlStateDisabled];
            break;
        default:
            
            break;
    }
    
    if (status == WL_WaitOrderStatus)
    {
        [self.acceptButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(ScaleW(130));
        }];
    }else if (status == WL_FailureOrderStatus||status == WL_FailureOrderStatusRefused || status == WL_FailureOrderStatusCanceled||status == WL_FailureOrderStatusOverTime)
    {
        [self.acceptButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(ScaleW(100));
        }];
    }else
    {
        [self.acceptButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(ScaleW(80));
        }];
    }
    [self.acceptButton layoutIfNeeded];
}

@end
//    假数据
//    orderDescriptionLabel.text = @"华东五日游 南京出发 含五星两晚酒店 全程导游";
//    priceLabel.text = @"¥ 8200.00";
//    seatCountLabel.text = @"47座";
//    departureTimeLabel.text = @"12月21日";
//    fromCityLabel.text = @"深圳市南山区高新科技园船业路";
//    arrivalTimeLabel.text = @"12月26日";
//    destinationCityLabel.text = @"南京及萨克路299号";


