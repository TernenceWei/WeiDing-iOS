//
//  WLApplicationDriverBookOrderCell.m
//  WeiLvDJS
//
//  Created by whw on 17/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

//#import "WLApplicationDriverBookOrderCell.h"
#import "WLJumpToOrderDetailViewControllerTool.h"
@interface WLApplicationDriverBookOrderCell ()
{
    dispatch_source_t _timer;/**< 倒计时 */
}
@property (nonatomic, weak) UILabel *startCityLabel;
@property (nonatomic, weak) UIButton *visaButton;
@property (nonatomic, weak) UILabel *endCityLabel;

@property (nonatomic, weak) UILabel *departureTimeLabel;
@property (nonatomic, weak) UILabel *fromCityLabel;
@property (nonatomic, weak) UILabel *arrivalTimeLabel;
@property (nonatomic, weak) UILabel *destinationCityLabel;

@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *seatCountLabel;
/**< 表示状态的Label */
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UILabel *quoteLabel;/**< 是否报价 */
@property (nonatomic, weak) UILabel *carTypeLabel;/**<车辆类型 */

@property (nonatomic, weak) UIView *bottomView;/**< 底部View */

@property (nonatomic, copy) NSString *bid_status;//报价状态
@property (nonatomic, copy) NSString *bid_price;//报价金额
@end


@implementation WLApplicationDriverBookOrderCell

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
        make.height.offset(ScaleH(80));
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
        make.height.offset(ScaleH(80));
    }];
    
//upView子控件
    UILabel *startCityLabel = [[UILabel alloc]init];
    UIButton *visaButton = [[UIButton alloc]init];
    UILabel *endCityLabel = [[UILabel alloc]init];
    
    startCityLabel.textColor = Color2;
    startCityLabel.font = [UIFont WLFontOfSize:20];
    [visaButton setTitleColor:Color3 forState:UIControlStateNormal];
    visaButton.titleLabel.font = [UIFont WLFontOfSize:14];
    visaButton.userInteractionEnabled = NO;
    [visaButton setBackgroundImage:[UIImage imageNamed:@"longArrow"] forState:UIControlStateNormal];
    endCityLabel.textColor = Color2;
    endCityLabel.font = [UIFont WLFontOfSize:20];
    
    [upView addSubview:startCityLabel];
    [upView addSubview:visaButton];
    [upView addSubview:endCityLabel];
    
    [startCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(upView);
        make.left.equalTo(upView).offset(ScaleW(12));
    }];
    [visaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(upView);
    }];
    [endCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(upView);
        make.right.equalTo(upView).offset(- ScaleW(12));
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
        make.width.offset(ScaleW(32));
    }];
    [departureTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(startImageView);
        make.left.equalTo(startImageView.mas_right).offset(ScaleW(16));
        make.width.offset(ScaleW(75));
    }];
    [fromCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(startImageView);
        make.left.equalTo(departureTimeLabel.mas_right).offset(ScaleW(16));
        make.right.equalTo(middleView.mas_right).offset(- ScaleW(12));
    }];
    [endImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startImageView.mas_bottom).offset(ScaleH(15));
        make.left.equalTo(middleView).offset(ScaleW(12));
        make.width.offset(ScaleW(32));
    }];
    [arrivalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(endImageView);
        make.left.equalTo(endImageView.mas_right).offset(ScaleW(16));
        make.width.offset(ScaleW(75));
        
    }];
    [destinationCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(arrivalTimeLabel);
        make.left.equalTo(arrivalTimeLabel.mas_right).offset(ScaleW(16));
        make.right.equalTo(middleView.mas_right).offset(- ScaleW(12));
    }];
//设置底部子控件
    UILabel *quoteLabel = [[UILabel alloc]init];
    UILabel *priceLabel = [[UILabel alloc]init];
    UILabel *carTypeLabel = [[UILabel alloc]init];
    UIImageView *carImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zuowei"]];
    UILabel *seatCountLabel = [[UILabel alloc]init];
     UILabel *statusLabel = [[UILabel alloc]init];
    UIButton *bookButton = [[UIButton alloc]init];
   
    
    quoteLabel.textColor = Color2;
    quoteLabel.font = [UIFont WLFontOfSize:14];
    priceLabel.textColor = Color2;
    priceLabel.font = [UIFont WLFontOfSize:17];
    
    carTypeLabel.textColor = Color3;
    carTypeLabel.font = [UIFont WLFontOfSize:14];
    seatCountLabel.textColor = Color3;
    seatCountLabel.font = [UIFont WLFontOfSize:14];
    
    statusLabel.textColor = Color3;
    statusLabel.font = [UIFont WLFontOfSize:14];
    
    [bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bookButton.titleLabel.font = [UIFont WLFontOfSize:14];
    [bookButton setBackgroundImage:[UIImage imageNamed:@"jiedan"] forState:UIControlStateNormal];
    
    
    [bottomView addSubview:quoteLabel];
    [bottomView addSubview:priceLabel];
    [bottomView addSubview:carTypeLabel];
    [bottomView addSubview:carImageView];
    [bottomView addSubview:seatCountLabel];
    [bottomView addSubview:bookButton];
    [bottomView addSubview:statusLabel];
    
    [quoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(ScaleH(17));
        make.left.equalTo(bottomView).offset(ScaleW(12));
    }];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(ScaleH(15));
        make.left.equalTo(quoteLabel.mas_right).offset(ScaleW(5));
    }];
    
    [carTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView).offset(-ScaleH(12));
        make.left.equalTo(bottomView).offset(ScaleW(12));
    }];
    [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carTypeLabel.mas_right).offset(ScaleW(12));
        make.centerY.equalTo(carTypeLabel);
    }];
    [seatCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carImageView.mas_right).offset(5);
        make.centerY.equalTo(carImageView);
    }];
    [bookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(bottomView).offset(- ScaleW(12));
        if (IsiPhone5) {
            make.width.offset(130);
        }else{
            make.width.offset(ScaleW(120));
        }
//        make.height.offset(ScaleH(<#height#>))
    }];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bookButton);
        make.right.equalTo(bookButton.mas_left).offset(- ScaleW(10));
    }];
    
    
    self.startCityLabel = startCityLabel;
    self.visaButton = visaButton;
    self.endCityLabel = endCityLabel;
    self.departureTimeLabel = departureTimeLabel;
    self.fromCityLabel = fromCityLabel;
    self.arrivalTimeLabel = arrivalTimeLabel;
    self.destinationCityLabel = destinationCityLabel;
    self.quoteLabel = quoteLabel;
    self.priceLabel = priceLabel;
    self.carTypeLabel = carTypeLabel;
    self.seatCountLabel = seatCountLabel;
    self.bookButton = bookButton;
    self.statusLabel = statusLabel;
    self.bottomView = bottomView;
    //假数据
    startCityLabel.text = @"深圳市";
    [visaButton setTitle:@"途经3个城市" forState:UIControlStateNormal];
    endCityLabel.text = @"上海市";
    departureTimeLabel.text = @"12月21日";
    fromCityLabel.text = @"深圳市南山区高新科技园创业路";
    arrivalTimeLabel.text = @"12月26日";
    destinationCityLabel.text = @"南京及萨克路299号";
    quoteLabel.text = @"未报价";
    priceLabel.text = @"¥8200.00";
    carTypeLabel.text = @"小汽车";
    seatCountLabel.text = @"47座";
    
}
#pragma mark - 订单模型
- (void)setOrderModel:(WLDriverOrderObject *)orderModel
{
    _orderModel = orderModel;
    self.bid_status = [orderModel.bid objectForKey:@"bid_status"];
    self.bid_price = [orderModel.bid objectForKey:@"bid_price"];
    self.startCityLabel.text = orderModel.start_city;
    self.endCityLabel.text = orderModel.end_city;
    if (orderModel.via_address.length > 0) {
        NSArray *cityArr = [orderModel.via_address componentsSeparatedByString:@","];
        [self.visaButton setTitle:[NSString stringWithFormat:@"途经%zd个城市",cityArr.count] forState:UIControlStateNormal];
    }else
    {
        [self.visaButton setTitle:@"" forState:UIControlStateNormal];
    }
   
    
    self.fromCityLabel.text = orderModel.start_address;
    self.departureTimeLabel.text = [NSString getDateStringWithTime:orderModel.start_at andFormatter:@"MM月dd日"];
    self.seatCountLabel.text = [NSString stringWithFormat:@"%@座",orderModel.car_seat_amount];
    self.arrivalTimeLabel.text = [NSString getDateStringWithTime:orderModel.end_at andFormatter:@"MM月dd日"];
    self.destinationCityLabel.text = orderModel.end_address;
    self.priceLabel.text = [self.bid_price doubleValue]*100 > 0?[NSString stringWithFormat:@"¥ %@",self.bid_price]:@"";
    if ([self.bid_price doubleValue]*100 > 0) {
        self.quoteLabel.textColor = Color1;
        self.quoteLabel.text = @"已报价";
    }else {
        self.quoteLabel.textColor = Color2;
        self.quoteLabel.text = @"未报价";
    }
    switch ([orderModel.car_model integerValue]) {
        case 1://大巴
            self.carTypeLabel.text = @"大巴车";
            break;
        case 2://商务车
            self.carTypeLabel.text = @"商务车";
            break;
        case 4://小汽车
            self.carTypeLabel.text = @"小汽车";
            break;
        default:
            self.carTypeLabel.text = @"其它";
            break;
    }
    self.bookStatus = [KJumpTool getBookOrderStatusWithModel:orderModel];
    
}
#pragma mark - 重写订单状态
- (void)setBookStatus:(WLBookOrderStatus)bookStatus
{
    _bookStatus = bookStatus;
    self.bookButton.enabled = (bookStatus == WLWaitOrderStatus || bookStatus == WLOrderStatusStart ||bookStatus == WLOrderStatusTravel)?YES:NO;
//    self.statusLabel.hidden = (bookStatus == WLOrderStatusStart||bookStatus == WLOrderStatusTravel||bookStatus == WLOrderStatusSettlement)?NO:YES;
    self.statusLabel.hidden = bookStatus == WLOrderStatusTravel?NO:YES;
    [self.bookButton setBackgroundImage:[UIImage imageNamed:(bookStatus == WLWaitOrderStatus || bookStatus == WLOrderStatusStart||bookStatus == WLOrderStatusTravel)?@"jiedan":nil] forState:UIControlStateNormal];
    if(bookStatus == WLWaitOrderStatus || bookStatus == WLOrderStatusStart ||bookStatus == WLOrderStatusTravel){
         [self.bookButton setTitleColor:[WLTools stringToColor:@"#ffffff"] forState:UIControlStateNormal];
    }else if (bookStatus == WLUnpaidStatus){
        [self.bookButton setTitleColor:Color1 forState:UIControlStateNormal];
    }else{
        [self.bookButton setTitleColor:Color3 forState:UIControlStateNormal];
    }
    if (bookStatus == WLOrderStatusStart||bookStatus == WLOrderStatusTravel||bookStatus == WLOrderStatusSettlement||bookStatus == WLOrderStatusFinish) {
        self.quoteLabel.hidden = YES;
        [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView).offset(ScaleH(15));
            make.left.equalTo(self.bottomView).offset(ScaleW(12));
        }];
    }else{
        self.quoteLabel.hidden = NO;
        [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView).offset(ScaleH(15));
            make.left.equalTo(self.quoteLabel.mas_right).offset(ScaleW(5));
        }];
    }

    switch (bookStatus) {
            
        case WLWaitOrderStatus:
            [self achieveCaptchaStartTime:[WLTools setupDifferentTime:self.orderModel.bid_expiry_at]];
            break;
        case WLUnpaidStatus:
            [self.bookButton setTitle:@"待客户确认" forState:UIControlStateNormal];
            break;
        case WLOrderStatusStart:
        {
            self.statusLabel.text = @"客户已付款";
            [self.bookButton setTitle:@"出发" forState:UIControlStateNormal];
            
        }
            break;
        case WLOrderStatusTravel:
        {
            self.statusLabel.text = @"行程中";
            [self.bookButton setTitle:@"结束" forState:UIControlStateNormal];
            
        }
            break;
        case WLOrderStatusSettlement:
        {
            self.statusLabel.text = @"已结束";
            [self.bookButton setTitle:@"已结束" forState:UIControlStateNormal];
        }
            break;
        case WLOrderStatusFinish:
            [self.bookButton setTitle:@"已结束" forState:UIControlStateNormal];
            break;
        case WLFailureOrderStatusOverTime:
            [self.bookButton setTitle:@"报价超时" forState:UIControlStateNormal];
            break;
        case WLFailureOrderStatusUnquoted:
        case WLFailureOrderStatusQuoted:
            [self.bookButton setTitle:@"竞价失败" forState:UIControlStateNormal];
            break;
        case WLFailureOrderStatusUnquotedCanceled:
        case WLFailureOrderStatusQuotedCanceled:
            [self.bookButton setTitle:@"客户已取消" forState:UIControlStateNormal];
            break;
        default:
            
            break;
    }
    
    //重新布局
    [self.bottomView layoutIfNeeded];
}

#pragma mark - 开启获取验证码定时器
- (void)achieveCaptchaStartTime:(double)differentTime
{
    WS(weakSelf);
    __block int timeout = differentTime; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{ //处理关闭后的逻辑
                [weakSelf.bookButton setTitle:@"报价 0:00" forState:UIControlStateNormal];
                if(weakSelf.timeEndCallBack){
                    _timeEndCallBack();
                }
            });
        }
        else
        {
            int minutes = timeout / 61;
            int seconds = timeout % 61;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            NSString *strMinTime = [NSString stringWithFormat:@"%d", minutes];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                if (self.bookStatus == WLWaitOrderStatus) {
                    [self.bookButton setTitle:[NSString stringWithFormat:@"报价 %@:%@",strMinTime, strTime] forState:UIControlStateNormal];
                }
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end




