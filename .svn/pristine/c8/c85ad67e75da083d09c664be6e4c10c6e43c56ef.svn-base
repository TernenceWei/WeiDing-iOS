
//
//  WLGuideWaitOrderTableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideWaitOrderTableViewCell.h"
#import "WLOrderListInfo.h"
#import "WLGuideListInfo.h"
#import "CostomLabel.h"

@interface WLGuideWaitOrderTableViewCell ()

/** 是否为主导游 */
@property(nonatomic, weak)UIImageView *mainGuideView;
/** 距离结束时间 */
@property(nonatomic, weak)UILabel *deadTimeLabel;
/** 线路名称 */
@property(nonatomic, weak)UILabel *lineNameLabel;
/** 定制团 */
@property(nonatomic, weak)UILabel *typeLabel;
/** 导游数量 */
@property(nonatomic, weak)UILabel *guidesLabel;
/** 返利 */
@property(nonatomic, weak)UILabel *rateLabel;
/** 游客人数 */
@property(nonatomic, weak)UILabel *countLabel;
/** 订单编号 */
@property(nonatomic, weak)UILabel *groupLabel;
/** 旅行社 */
@property(nonatomic, weak)UILabel *companyLabel;
/** 开始图片（） */
@property(nonatomic, weak)UIImageView *recieveImageView;
/** 结束图片 */
@property(nonatomic, weak)UIImageView *sendImageView;
/** 开始文字 */
@property(nonatomic, weak)UILabel *recieveLabel;
/** 结束文字 */
@property(nonatomic, weak)UILabel *sendLabel;
/** 导服费人民币符号 */
@property(nonatomic, weak)UILabel *RMBLabel;
/** 导服费数目 */
@property(nonatomic, weak)UILabel *chargeLabel;
/** 导服费 */
@property(nonatomic, weak)UILabel *chargedLabel;
/** 拒单 */
@property(nonatomic, weak)UIButton *denyBtn;
/** 接单 */
@property(nonatomic, weak)UIButton *acceptBtn;
/** 选择按钮的view */
@property(nonatomic, weak)UIView *selectView;
/** 拒绝图片 */
@property(nonatomic, weak)UIImageView *denyImageView;
/** 拒绝文字 */
@property(nonatomic, weak)UILabel *denyLabel;
/** 接受图片 */
@property(nonatomic, weak)UIImageView *acceptImageView;
/** 接收文字 */
@property(nonatomic, weak)UILabel *acceptLabel;

@property(nonatomic, strong)NSString *typeText;

@property(nonatomic, strong)NSString *rateText;

@property(nonatomic, weak)CostomLabel *minLabel;

@property(nonatomic, weak)UILabel *secLabel;

@property (nonatomic, assign) long long timeCount;
@property (nonatomic, strong) NSTimer *timer1;
@end

@implementation WLGuideWaitOrderTableViewCell
{
    dispatch_source_t _timer ;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpBaseView];
        //设置点击cell不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = HEXCOLOR(0xf7f7f8);
    }
    return self;
}

-(void)setOrderInfo:(WLOrderListInfo *)orderInfo{
    _orderInfo = orderInfo;
    self.orderID = self.orderInfo.checkListID;
    self.groupListID = self.orderInfo.groupListID;
    [self setUpBaseView];
    
    self.timeCount = self.orderInfo.expiryDate.longLongValue;
    if (self.timer1 == nil) {
        [self countTime];
        self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
    }
}

- (void)countTime
{
    _minLabel.text = [NSString stringWithFormat:@"%02d",(int)(self.timeCount / 60)];
    _secLabel.text = [NSString stringWithFormat:@"%02d",(int)(self.timeCount - _minLabel.text.longLongValue * 60)];
    if (self.timeCount > 0) {
        self.timeCount --;
    }
}

-(void)setTimeOut{
    //获取时间差的秒数
    double differentSec = [self setupDifferentTime:self.orderInfo.expiryDate];
    NSInteger differentTime = (NSInteger)differentSec;
    //    self.differentSec = differentTime;
    [self achieveCaptchaStartTime:differentTime];
    
}

#pragma mark - 开启获取验证码定时器
//开启定时器
- (void)achieveCaptchaStartTime:(double)differentTime
{
    __block int timeout = differentTime; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        int minutes = timeout / 61;
        int seconds = timeout % 61;
        
        NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
        NSString *strMinTime = [NSString stringWithFormat:@"%d", minutes];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //设置界面的按钮显示 根据自己需求设置
            NSString *sec = [strTime substringWithRange:NSMakeRange(strTime.length-2, 2)];
            self.secLabel.text = sec;
            NSString *min = [strMinTime substringWithRange:NSMakeRange(strMinTime.length-2, 2)];
            self.minLabel.text = min;

        });
        timeout--;
    });
    dispatch_resume(_timer);
}
#pragma mark - 计算当前时间到失效时间之间的间隔
//计算时间差
- (double)setupDifferentTime:(NSString *)failureTime
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    //将服务器返回的字符串转换为NSDate类型
    NSDate *failureDate = [formatter dateFromString:failureTime];
    
    //取出现在的时间
    NSDate *nowDate = [NSDate date];
    double nowTime = [nowDate timeIntervalSince1970];
    NSString *nowSec = [NSString stringWithFormat:@"%.0f", nowTime];
    double failureSec = [failureDate timeIntervalSince1970];
    //将过期时间戳减去现有的时间戳
    double differentSec = failureSec - [nowSec doubleValue];
    return differentSec;
}

//分成三部分
-(void)setUpBaseView{
    /** 矩形的view */
    UIView *baseView = [[UIView alloc] init];
    CGFloat baseWidth = ScaleW(ScreenWidth - 16);
    CGFloat baseLeft = ScaleW(12);
    baseView.frame = CGRectMake(ScaleW(8), ScaleH(38), baseWidth, ScaleH(240));
    baseView.backgroundColor = HEXCOLOR(0xffffff);
    [self addSubview:baseView];
    
    
    
    //距离结束时间
    UILabel *deadtimeLabel = [[UILabel alloc] init];
    deadtimeLabel.font = WLFontSize(14);
    deadtimeLabel.textColor = HEXCOLOR(0x4499ff);
    [baseView addSubview:deadtimeLabel];
    [deadtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(baseView.mas_centerX);
        make.top.equalTo(baseView.mas_top).offset(35);
        make.height.equalTo(@(15));
    }];
    _deadTimeLabel = deadtimeLabel;
    
//    距离结束时间小label
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = HEXCOLOR(0x4499ff);
    [baseView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView.mas_left).offset(ScaleW(110));
        make.top.equalTo(baseView.mas_top).offset(ScaleH(40));
    }];
    label1.textColor = HEXCOLOR(0x4499ff);
    label1.font = WLFontSize(14);
    label1.text = @"距结束:";
    
    //多少分
    CostomLabel *minLabel = [[CostomLabel alloc] init];
    minLabel.textColor = HEXCOLOR(0x4499ff);
    [baseView addSubview:minLabel];
    [minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(ScaleW(8));
        make.centerY.equalTo(label1.mas_centerY);
        make.height.equalTo(@(22));
        make.width.equalTo(@(22));
    }];
    minLabel.textColor = HEXCOLOR(0x4499ff);
    minLabel.font = WLFontSize(13);
    minLabel.layer.borderColor = HEXCOLOR(0x4499ff).CGColor;
    minLabel.layer.borderWidth = 1;
    minLabel.layer.cornerRadius = 2;
    minLabel.textInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    
    _minLabel = minLabel;
    
    //分
    UILabel *minUintLabel = [[UILabel alloc] init];
    minUintLabel.textColor = HEXCOLOR(0x4499ff);
    [baseView addSubview:minUintLabel];
    [minUintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(minLabel.mas_right).offset(ScaleW(5));
        make.centerY.equalTo(label1.mas_centerY);
    }];
    minUintLabel.textColor = HEXCOLOR(0xb5b5b5);
    minUintLabel.font = WLFontSize(14);
    minUintLabel.text = @"分";
    
    //多少秒
    CostomLabel *secLabel = [[CostomLabel alloc] init];
    secLabel.textColor = HEXCOLOR(0x4499ff);
    [baseView addSubview:secLabel];
    [secLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(minUintLabel.mas_right).offset(ScaleW(5));
        make.centerY.equalTo(label1.mas_centerY);
        make.height.equalTo(@(22));
        make.width.equalTo(@(22));
    }];
    secLabel.textColor = HEXCOLOR(0x4499ff);
    secLabel.font = WLFontSize(13);
    secLabel.layer.borderColor = HEXCOLOR(0x4499ff).CGColor;
    secLabel.layer.borderWidth = 1;
    secLabel.layer.cornerRadius = 2;
    secLabel.textInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    _secLabel = secLabel;
    
    
    //秒
    UILabel *secUnitLabel = [[UILabel alloc] init];
    secUnitLabel.textColor = HEXCOLOR(0x4499ff);
    [baseView addSubview:secUnitLabel];
    [secUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secLabel.mas_right).offset(ScaleW(5));
        make.centerY.equalTo(label1.mas_centerY);
    }];
    secUnitLabel.textColor = HEXCOLOR(0xb5b5b5);
    secUnitLabel.font = WLFontSize(14);
    secUnitLabel.text = @"秒";
    
    
    //线路名称
    UILabel *lineNameLabel = [[UILabel alloc] init];
    [baseView addSubview:lineNameLabel];
    lineNameLabel.font = WLFontSize(14);
    lineNameLabel.text = self.orderInfo.lineName;
    lineNameLabel.textColor = HEXCOLOR(0x2F2F2F);
    [lineNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView.mas_left).offset(baseLeft);
        make.top.equalTo(deadtimeLabel.mas_bottom).offset(ScaleH(15));
    }];
    lineNameLabel.textAlignment = NSTextAlignmentLeft;
    
    _lineNameLabel = lineNameLabel;
    
    
    //定制团
    
    UIButton *typeBtn = [[UIButton alloc] init];
    
    if (self.orderInfo.type.integerValue == 0) {
        self.typeText = @"散客团";
        [typeBtn setTitle:self.typeText forState:UIControlStateNormal];
        [typeBtn setTitleColor:HEXCOLOR(0x69c95f) forState:UIControlStateNormal];
        [typeBtn setBackgroundImage:[UIImage imageNamed:@"allGroup_groupType_bg"] forState:UIControlStateNormal];
        [baseView addSubview:typeBtn];
        [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView.mas_left).offset(ScaleW(12));
            make.top.equalTo(lineNameLabel.mas_bottom).offset(ScaleH(20));
        }];
        typeBtn.titleLabel.font = WLFontSize(13);
        typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    else{
        self.typeText = @"定制团";
        [typeBtn setTitle:self.typeText forState:UIControlStateNormal];
        [typeBtn setTitleColor:HEXCOLOR(0x69c95f) forState:UIControlStateNormal];
        [typeBtn setBackgroundImage:[UIImage imageNamed:@"allGroup_groupType_bg"] forState:UIControlStateNormal];
        [baseView addSubview:typeBtn];
        [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView.mas_left).offset(ScaleW(12));
            make.top.equalTo(lineNameLabel.mas_bottom).offset(ScaleH(20));
        }];
        typeBtn.titleLabel.font = WLFontSize(13);
        typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    
    
    UIButton *guidesButton = [[UIButton alloc] init];
    NSString *guidesText =[NSString stringWithFormat:@"%@导",self.orderInfo.guideNums];
    [guidesButton setTitle:guidesText forState:UIControlStateNormal];
    [guidesButton setTitleColor:HEXCOLOR(0x4499ff) forState:UIControlStateNormal];
    [guidesButton setBackgroundImage:[UIImage imageNamed:@"allGroup_guideNum_bg"] forState:UIControlStateNormal];
    [baseView addSubview:guidesButton];
    [guidesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeBtn.mas_right).offset(ScaleW(15));
        make.top.equalTo(typeBtn.mas_top);
    }];
    guidesButton.titleLabel.font = WLFontSize(13);
    guidesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    
    UIButton *reteButton = [[UIButton alloc] init];
    if (self.orderInfo.maxRate.intValue == self.orderInfo.minRate.intValue) {
        self.rateText = [NSString stringWithFormat:@"购返%@%%",self.orderInfo.minRate];
    }
    else{
        self.rateText = [NSString stringWithFormat:@"购返%@%%-%@%%",self.orderInfo.minRate,self.orderInfo.maxRate];
    }
    [reteButton setTitle:self.rateText forState:UIControlStateNormal];
    [reteButton setTitleColor:HEXCOLOR(0xff7e44) forState:UIControlStateNormal];
    [reteButton setBackgroundImage:[UIImage imageNamed:@"allGroup_rebate_bg"] forState:UIControlStateNormal];
    [baseView addSubview:reteButton];
    [reteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guidesButton.mas_right).offset(ScaleW(15));
        make.top.equalTo(guidesButton.mas_top);
    }];
    reteButton.titleLabel.font = WLFontSize(13);
    reteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    if (self.orderInfo.minRate.length == 0 && self.orderInfo.maxRate.length == 0) {
        reteButton.hidden = YES;
    }
    else
    {
        reteButton.hidden = NO;
    }
    
    
    //游客人数
    UILabel *countLabel = [[UILabel alloc] init];
    [baseView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(baseView.mas_right).offset(-ScaleH(20));
        make.top.equalTo(reteButton.mas_top);
    }];
    countLabel.textColor = HEXCOLOR(0x879efa);
    countLabel.font = WLFontSize(14);
    
    //    countLabel.text = @"60人";
    countLabel.text = [NSString stringWithFormat:@"%ld人",[self.orderInfo.adults integerValue] + [self.orderInfo.children integerValue]];
    
    _countLabel = countLabel;
    
    //订单号码
    UILabel *groupLabel = [[UILabel alloc] init];
    [baseView addSubview:groupLabel];
    [groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView.mas_left).offset(baseLeft);
        make.top.equalTo(typeBtn.mas_bottom).offset(ScaleH(15));
    }];
    groupLabel.textColor = HEXCOLOR(0xb5b5b5);
    groupLabel.font = WLFontSize(13);
    
    //    groupLabel.text = @"订单号码：DNJ56865";
    groupLabel.text = [NSString stringWithFormat:@"订单号码：%@",self.orderInfo.groupNumber];
    _groupLabel = groupLabel;
    
    
    //旅行社
    UILabel *companyLabel = [[UILabel alloc] init];
    [baseView addSubview:companyLabel];
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(groupLabel.mas_right).offset(ScaleW(15));
        make.top.equalTo(typeBtn.mas_bottom).offset(ScaleH(15));
    }];
    companyLabel.textColor = HEXCOLOR(0xb5b5b5);
    companyLabel.font = WLFontSize(13);
    
    //    companyLabel.text = @"旅行社：郑州时间地方及时";
    companyLabel.text = [NSString stringWithFormat:@"旅行社：%@",self.orderInfo.companyName];
    
    _companyLabel = companyLabel;
    
    //开始图片/接团
    UIImageView *recieveImageView = [[UIImageView alloc] init];
    [baseView addSubview:recieveImageView];
    [recieveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView.mas_left).offset(baseLeft);
        make.top.equalTo(groupLabel.mas_bottom).offset(ScaleH(25));
    }];
    recieveImageView.image = [UIImage imageNamed:@"start"];
    
    _recieveImageView = recieveImageView;
    
    
    //开始文字
    UILabel *recieveLabel = [[UILabel alloc] init];
    [baseView addSubview:recieveLabel];
    [recieveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recieveImageView.mas_right).offset(ScaleW(8));
        make.top.equalTo(groupLabel.mas_bottom).offset(ScaleH(25));
    }];
    recieveLabel.textColor = HEXCOLOR(0xB5B5B5);
    recieveLabel.font = WLFontSize(14);
    //    recieveLabel.text = @"08月20日";
    NSString *string = self.orderInfo.receiveDate;
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    
    [inputFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormat dateFromString:string];
    
    NSDateFormatter *outputFormat = [[NSDateFormatter alloc] init];
    
    [outputFormat setDateFormat:@"MM月dd日"];
    NSString *outputDate = [outputFormat stringFromDate:inputDate];
    recieveLabel.text = outputDate;
    _recieveLabel = recieveLabel;
    
    //结束图片/送团
    UIImageView *sendImageView = [[UIImageView alloc] init];
    [baseView addSubview:sendImageView];
    [sendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recieveLabel.mas_right).offset(ScaleW(20));
        make.top.equalTo(groupLabel.mas_bottom).offset(ScaleH(25));
    }];
    sendImageView.image = [UIImage imageNamed:@"end"];
    
    _sendImageView = sendImageView;
    
    
    //结束文字
    UILabel *sendLabel = [[UILabel alloc] init];
    [baseView addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendImageView.mas_right).offset(ScaleW(8));
        make.top.equalTo(groupLabel.mas_bottom).offset(ScaleH(25));
    }];
    sendLabel.textColor = HEXCOLOR(0xB5B5B5);
    sendLabel.font = WLFontSize(14);
    
    //    sendLabel.text = @"09月20日";
    NSString *sendStr = self.orderInfo.sendDate;
    NSDateFormatter *inputFormat1 = [[NSDateFormatter alloc] init];
    [inputFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate1 = [inputFormat dateFromString:sendStr];
    
    NSDateFormatter *outputFormat1 = [[NSDateFormatter alloc] init];
    [outputFormat1 setDateFormat:@"MM月dd日"];
    NSString *outputStr = [outputFormat1 stringFromDate:inputDate1];
    sendLabel.text = outputStr;
    
    _sendLabel = sendLabel;
    
    //导服费人民币符号
    UILabel *RMBLabel = [[UILabel alloc] init];
    [baseView addSubview:RMBLabel];
    [RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendLabel.mas_right).offset(ScaleW(62));
        make.top.equalTo(sendLabel.mas_top).offset(ScaleH(4));
    }];
    RMBLabel.textColor = HEXCOLOR(0xff5b3d);
    RMBLabel.font = WLFontSize(15);
    
    RMBLabel.text = @"¥";
    
    _RMBLabel = RMBLabel;
    
    
    // 导服费数目
    UILabel *chargeLabel = [[UILabel alloc] init];
    [baseView addSubview:chargeLabel];
    [chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(RMBLabel.mas_right);
        make.bottom.equalTo(RMBLabel.mas_bottom);
    }];
    chargeLabel.textColor = HEXCOLOR(0xff5b3d);
    chargeLabel.font = WLFontSize(20);
    
    //    chargeLabel.text = @"15000";
    chargeLabel.text = [NSString stringWithFormat:@"%ld",(long)self.orderInfo.checkPrice.integerValue];
    
    _chargeLabel = chargeLabel;
    
    // 导服费
    UILabel *chargedLabel = [[UILabel alloc] init];
    [baseView addSubview:chargedLabel];
    [chargedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(chargeLabel.mas_right);
        make.top.equalTo(chargeLabel.mas_bottom).offset(ScaleH(12));
    }];
    chargedLabel.textColor = HEXCOLOR(0xb5b5b5);
    chargedLabel.font = WLFontSize(13);
    
    chargedLabel.text = @"导服费";
    
    _chargedLabel = chargedLabel;
    
    //底部选择VIEW
    UIView *selectView = [[UIView alloc] init];
    [self addSubview:selectView];
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(baseView.mas_centerX);
        make.centerY.equalTo(baseView.mas_bottom);
        make.left.equalTo(baseView.mas_left).offset(ScaleW(78));
        make.height.equalTo(@(ScaleH(42)));
    }];
    
    selectView.layer.cornerRadius = ScaleH(21);
    selectView.layer.masksToBounds = YES;
    selectView.layer.borderWidth = 1;
    selectView.layer.borderColor = HEXCOLOR(0xeff1fe).CGColor;
    selectView.backgroundColor = HEXCOLOR(0xffffff);
    _selectView = selectView;
    
    
    //拒单按钮
    UIButton *denyBtn = [[UIButton alloc] init];
    [selectView addSubview:denyBtn];
    [denyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectView.mas_left);
        make.centerY.equalTo(selectView.mas_centerY);
        make.width.equalTo(@(ScaleW(112)));
        make.height.equalTo(@(ScaleH(43)));
        
    }];
    [denyBtn setImage:[UIImage imageNamed:@"deny"] forState:UIControlStateNormal];
    [denyBtn setImageEdgeInsets:UIEdgeInsetsMake(ScaleH(13),ScaleW(33),  ScaleH(13), ScaleW(60))];
    
    [denyBtn setTitle:@"拒单" forState:UIControlStateNormal];
    [denyBtn setTitleEdgeInsets:UIEdgeInsetsMake(ScaleH(13),ScaleW(29),  ScaleH(13), ScaleW(22))];
    [denyBtn setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [denyBtn.titleLabel setFont:WLFontSize(15)];
    denyBtn.tag = 100001;
    [denyBtn addTarget:self action:@selector(denyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _denyBtn = denyBtn;
    
    //接单按钮
    UIButton *acceptBtn = [[UIButton alloc] init];
    [selectView addSubview:acceptBtn];
    [acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectView.mas_centerX);
        make.centerY.equalTo(selectView.mas_centerY);
        make.width.equalTo(@(ScaleW(112)));
        make.height.equalTo(@(ScaleH(43)));
    }];
    [acceptBtn setImage:[UIImage imageNamed:@"recieveOrder"] forState:UIControlStateNormal];
    [acceptBtn setImageEdgeInsets:UIEdgeInsetsMake(ScaleH(13),ScaleW(23),  ScaleH(13), ScaleW(60))];
    [acceptBtn setTitle:@"接单" forState:UIControlStateNormal];
    [acceptBtn setTitleEdgeInsets:UIEdgeInsetsMake(ScaleH(13),ScaleW(13),  ScaleH(13), ScaleW(22))];
    [acceptBtn setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [acceptBtn.titleLabel setFont:WLFontSize(15)];
    [acceptBtn addTarget:self action:@selector(acceptBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _acceptBtn = acceptBtn;
    
    //是否为主导游
    UIImageView *mainGuideView = [[UIImageView alloc] init];
    [baseView addSubview:mainGuideView];
    [mainGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(baseView.mas_centerX);
        make.centerY.equalTo(baseView.mas_top);
    }];
    if (self.orderInfo.mainGuide.intValue == 1) {
        mainGuideView.image = [UIImage imageNamed:@"majorGuide"];
    }else if (self.orderInfo.mainGuide.intValue == 0){
        mainGuideView.image = [UIImage imageNamed:@"viceGuide"];
    }
    
    _mainGuideView = mainGuideView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)denyBtnClick{
    if ([self.delegate respondsToSelector:@selector(denyOrder:)]) {
        [self.delegate denyOrder:self.orderInfo];
    }
}

-(void)acceptBtnClick{
    if ([self.delegate respondsToSelector:@selector(acceptOrder:orderInfo:)]) {
        [self.delegate acceptOrder:self orderInfo:self.orderInfo];
    }
}

- (void)dealloc
{
    [self.timer1 invalidate];
    self.timer1 = nil;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.timer1 invalidate];
    self.timer1 = nil;
}
@end


