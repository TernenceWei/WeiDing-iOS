//
//  WLWaitingListCell.m
//  WeiLvDJS
//
//  Created by hsliang on 2016/11/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLWaitingListCell.h"
#import "WLDataHotelHandler.h"

#define cellIdentifier @"WLWaitingCell"

@interface WLWaitingListCell ()<UITextFieldDelegate>
{
    UIView * bottomBtnView;
    UIView * middleView;
    UIView * tellMoneyView;
    
    
    UILabel * topTimeLabel;
    UILabel * groupID;
    //
    UILabel * nameLabel;
    UILabel * companyNameLabel;
    UILabel * arriveShowLabel;
    UILabel * leaveShowLabel;
    UILabel * roomTypeLabel;
    UILabel * howRoomTypeLabel;
    UILabel * roomdownMoneyLabel;
    UILabel * howMoneyShowLabel;          //总金额
    UILabel * howOfferLabel;              //有隐藏/显示效果
    
    UIButton * RefusedBtn;
    UIButton * sureBtn;
    
    UISwitch * mySwitch;
    
    UIButton * callBtn;
    UIButton * WchatBtn;
}

@property (nonatomic, strong) UILabel * timeShowLabel; //右侧的倒计时
@property (nonatomic, strong) UITextField * inputLabel;
@property (nonatomic, strong) UITextField * inputHowLabel;

@property (nonatomic, strong) UILabel * endtime; //有效期至

@property (nonatomic, strong) UIButton *refused;

@property (nonatomic, strong) NSTimer * timeGo;
@property (nonatomic, assign) NSInteger timeInterval;


@property (nonatomic, copy)  void(^WCBtnAction)(NSInteger);
@property (nonatomic, copy)  void(^iPhoneBtnAction)(NSInteger);

@property (nonatomic, copy)  void(^sureBtnAction)(WLHotelOrderInfo *);
@property (nonatomic, copy)  void(^reBtnAction)(NSString *);

@property (nonatomic, copy)  void(^ChooseDateBtnAction)();

@end

@implementation WLWaitingListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUI];
    }
    return self;
}

+ (WLWaitingListCell *)cellCreateTableView:(UITableView *)tableView
{
    WLWaitingListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLWaitingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)setUI
{
    UIView * topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(45));
    topView.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    [self addSubview:topView];
    
    UILabel *topViewTopLine = [[UILabel alloc] init];
    topViewTopLine.frame = CGRectMake(0, 0, topView.frame.size.width, ScaleH(0.5));
    topViewTopLine.backgroundColor = [WLTools stringToColor:@"#dce0e8"];
    [topView addSubview:topViewTopLine];
    
    UILabel *topViewBottomLine = [[UILabel alloc] init];
    topViewBottomLine.frame = CGRectMake(0, topView.frame.size.height - ScaleH(1), topView.frame.size.width, ScaleH(0.5));
    topViewBottomLine.backgroundColor = [WLTools stringToColor:@"#dce0e8"];
    [topView addSubview:topViewBottomLine];
// 顶部时间
    topTimeLabel = [[UILabel alloc] init];
    topTimeLabel.frame = CGRectMake((topView.frame.size.width / 2) - ScaleH(70), (topView.frame.size.height / 2) - ScaleH(10), ScaleH(140), ScaleH(20));
    topTimeLabel.backgroundColor = [WLTools stringToColor:@"#dcdcdc"];
    topTimeLabel.layer.cornerRadius = 4.0;
    topTimeLabel.textColor = [UIColor whiteColor];
    topTimeLabel.textAlignment = NSTextAlignmentCenter;
    topTimeLabel.font = [UIFont WLFontOfSize:11];
    topTimeLabel.text = @"2016.08.09 09:00";
    [topView addSubview:topTimeLabel];
    
//
    middleView = [[UIView alloc] init];
    middleView.frame = CGRectMake(0, topView.frame.origin.y + topView.frame.size.height, topView.frame.size.width, ScaleH(250));
    middleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:middleView];
// 团号
    groupID = [[UILabel alloc] init];
    groupID.frame = CGRectMake(ScaleW(13), ScaleH(17), middleView.frame.size.width - ScaleW(30), ScaleH(12));
    groupID.textColor = [WLTools stringToColor:@"#2f2f2f"];
    groupID.textAlignment = NSTextAlignmentLeft;
    groupID.font = [UIFont WLFontOfSize:12];
    //groupID.text = @"团号 20160506056231";
    [middleView addSubview:groupID];
    
// 右侧倒计时
    UIImageView * rightTimeShow = [[UIImageView alloc] init];
    rightTimeShow.frame = CGRectMake(middleView.frame.size.width - ScaleW(135), ScaleH(8), ScaleW(135), ScaleH(28));
    [rightTimeShow setImage:[UIImage imageNamed:@"countdownImg"]];
    [middleView addSubview:rightTimeShow];
    
    _timeShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(27), 0, rightTimeShow.frame.size.width - ScaleW(36), rightTimeShow.frame.size.height)];
    _timeShowLabel.textColor = [UIColor whiteColor];
    _timeShowLabel.text = @"";
    _timeShowLabel.font = [UIFont WLFontOfSize:13];
    _timeShowLabel.textAlignment = NSTextAlignmentRight;
    [rightTimeShow addSubview:_timeShowLabel];
    
// 名字
    nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(groupID.frame.origin.x, groupID.frame.origin.y + groupID.frame.size.height + ScaleH(26), groupID.frame.size.width, ScaleH(16));
    nameLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont WLFontOfSize:16];
    nameLabel.text = @"张三";
    [middleView addSubview:nameLabel];
    
// 公司单位
    companyNameLabel = [[UILabel alloc] init];
    companyNameLabel.frame = CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height + ScaleH(15), groupID.frame.size.width, ScaleH(16));
    companyNameLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    companyNameLabel.textAlignment = NSTextAlignmentLeft;
    companyNameLabel.font = [UIFont WLFontOfSize:13];
    companyNameLabel.text = @"南京哪儿玩有限公司";
    [middleView addSubview:companyNameLabel];
    
// 电话图标    _Modelinfo.djCompanyPhone
    callBtn = [[UIButton alloc] init];
    callBtn.frame = CGRectMake(middleView.frame.size.width - ScaleW(62), rightTimeShow.frame.origin.y + rightTimeShow.frame.size.height + ScaleH(16), ScaleW(48), ScaleH(47));
    [callBtn setImage:[UIImage imageNamed:@"phoneImg"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(iPhoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:callBtn];
    
// 微信图标
    WchatBtn = [[UIButton alloc] init];
    WchatBtn.frame = CGRectMake(callBtn.frame.origin.x - ScaleW(62), callBtn.frame.origin.y + ScaleH(3), ScaleW(48), ScaleH(39));
    [WchatBtn setImage:[UIImage imageNamed:@"chatImg"] forState:UIControlStateNormal];
    [WchatBtn addTarget:self action:@selector(WCClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:WchatBtn];
    
// 虚线
    UILabel * xLineLabel = [[UILabel alloc] init];
    xLineLabel.frame = CGRectMake(0, companyNameLabel.frame.origin.y + companyNameLabel.frame.size.height + ScaleH(25), middleView.frame.size.width, ScaleH(0.5));
    xLineLabel.backgroundColor = [UIColor lightGrayColor];
    [middleView addSubview:xLineLabel];
    
// 入住时间
    UILabel * arriveLabel = [[UILabel alloc] init];
    arriveLabel.frame = CGRectMake(companyNameLabel.frame.origin.x, xLineLabel.frame.origin.y + xLineLabel.frame.size.height + ScaleH(25), ScaleW(50), ScaleH(12));
    arriveLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    arriveLabel.textAlignment = NSTextAlignmentLeft;
    arriveLabel.font = [UIFont WLFontOfSize:13];
    arriveLabel.text = @"入住";
    [middleView addSubview:arriveLabel];
    
    arriveShowLabel = [[UILabel alloc] init];
    arriveShowLabel.frame = CGRectMake(arriveLabel.frame.origin.x, arriveLabel.frame.origin.y + arriveLabel.frame.size.height + ScaleH(7), ScaleW(85), ScaleH(16));
    arriveShowLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    arriveShowLabel.textAlignment = NSTextAlignmentLeft;
    arriveShowLabel.font = [UIFont WLFontOfSize:15];
    arriveShowLabel.text = @"09月15日";
    [middleView addSubview:arriveShowLabel];
    
// 离店时间
    UILabel * leaveLabel = [[UILabel alloc] init];
    leaveLabel.frame = CGRectMake(companyNameLabel.frame.origin.x, arriveShowLabel.frame.origin.y + arriveShowLabel.frame.size.height + ScaleH(23), ScaleW(50), ScaleH(12));
    leaveLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    leaveLabel.textAlignment = NSTextAlignmentLeft;
    leaveLabel.font = [UIFont WLFontOfSize:13];
    leaveLabel.text = @"离店";
    [middleView addSubview:leaveLabel];
    
    leaveShowLabel = [[UILabel alloc] init];
    leaveShowLabel.frame = CGRectMake(arriveLabel.frame.origin.x, leaveLabel.frame.origin.y + leaveLabel.frame.size.height + ScaleH(7), ScaleW(85), ScaleH(16));
    leaveShowLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    leaveShowLabel.textAlignment = NSTextAlignmentLeft;
    leaveShowLabel.font = [UIFont WLFontOfSize:15];
    leaveShowLabel.text = @"09月16日";
    [middleView addSubview:leaveShowLabel];
    
// 竖线
    UIImageView * verticalImg = [[UIImageView alloc] init];
    verticalImg.frame = CGRectMake(arriveShowLabel.frame.origin.x + arriveShowLabel.frame.size.width + ScaleW(8), xLineLabel.frame.origin.y + xLineLabel.frame.size.height + ScaleH(49), ScaleW(10), ScaleH(62));
    [verticalImg setImage:[UIImage imageNamed:@"divisionImg"]];
    [middleView addSubview:verticalImg];
    
// 房型
    roomTypeLabel = [[UILabel alloc] init];
    roomTypeLabel.frame = CGRectMake(verticalImg.frame.origin.x + verticalImg.frame.size.width + ScaleW(15), arriveShowLabel.frame.origin.y , ScaleW(200), ScaleH(16));
    roomTypeLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    roomTypeLabel.textAlignment = NSTextAlignmentLeft;
    roomTypeLabel.font = [UIFont WLFontOfSize:15];
    roomTypeLabel.text = @"大床房";
    [middleView addSubview:roomTypeLabel];
    
// 房间数量
    howRoomTypeLabel = [[UILabel alloc] init];
    howRoomTypeLabel.frame = CGRectMake(middleView.frame.size.width - ScaleW(62), roomTypeLabel.frame.origin.y, ScaleW(50), ScaleH(16));
    howRoomTypeLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    howRoomTypeLabel.textAlignment = NSTextAlignmentRight;
    howRoomTypeLabel.font = [UIFont WLFontOfSize:15];
    howRoomTypeLabel.text = @"X8";
    [middleView addSubview:howRoomTypeLabel];
    
// 价格
    roomdownMoneyLabel = [[UILabel alloc] init];
    roomdownMoneyLabel.frame = CGRectMake(roomTypeLabel.frame.origin.x, leaveShowLabel.frame.origin.y + ScaleH(1), ScaleW(100), ScaleH(16));
    roomdownMoneyLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    roomdownMoneyLabel.textAlignment = NSTextAlignmentLeft;
    roomdownMoneyLabel.font = [UIFont WLFontOfSize:13];
    //roomdownMoneyLabel.text = @"￥400";//_Modelinfo.checkPrice;////
    [middleView addSubview:roomdownMoneyLabel];
    
// 总金额
    howMoneyShowLabel = [[UILabel alloc] init];
    howMoneyShowLabel.frame = CGRectMake(middleView.frame.size.width - ScaleW(90), leaveShowLabel.frame.origin.y, ScaleW(80), ScaleH(20));
    howMoneyShowLabel.textColor = [WLTools stringToColor:@"#ff872f"];
    howMoneyShowLabel.textAlignment = NSTextAlignmentRight;
    howMoneyShowLabel.font = [UIFont WLFontOfSize:17];
    //howMoneyShowLabel.text = @"￥0";
    [middleView addSubview:howMoneyShowLabel];
    
    UILabel * howMoneyLabel = [[UILabel alloc] init];
    howMoneyLabel.frame = CGRectMake(howMoneyShowLabel.frame.origin.x - ScaleW(70), howMoneyShowLabel.frame.origin.y + ScaleH(3), ScaleW(70), ScaleH(14));
    howMoneyLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    howMoneyLabel.textAlignment = NSTextAlignmentRight;
    howMoneyLabel.font = [UIFont WLFontOfSize:13];
    howMoneyLabel.text = @"总金额";
    [middleView addSubview:howMoneyLabel];
    
// 填报价价格
    tellMoneyView = [[UIView alloc] init];
    tellMoneyView.frame = CGRectMake(0, middleView.frame.origin.y + middleView.frame.size.height, middleView.frame.size.width, ScaleH(200));
    tellMoneyView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tellMoneyView];
    
    UIImageView * showMoneyView = [[UIImageView alloc] init];
    showMoneyView.frame = CGRectMake(ScaleW(12), ScaleH(10), tellMoneyView.frame.size.width - ScaleW(24), ScaleH(79));
    //showMoneyView.backgroundColor = [WLTools stringToColor:@"#f1f2f6"];
    showMoneyView.userInteractionEnabled = YES;
    [showMoneyView setImage:[UIImage imageNamed:@"inputprice"]];
    [tellMoneyView addSubview:showMoneyView];
    
//报价
    UILabel * offerLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleH(12), ScaleW(50), ScaleH(12))];
    offerLabel.text = @"报价";
    offerLabel.font = [UIFont WLFontOfSize:13];
    offerLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    [showMoneyView addSubview:offerLabel];
    
    howOfferLabel = [[UILabel alloc] initWithFrame:CGRectMake(showMoneyView.frame.size.width - ScaleW(52), offerLabel.frame.origin.y, ScaleW(50), ScaleH(13))];
    howOfferLabel.text = @"数量";
    howOfferLabel.font = [UIFont WLFontOfSize:13];
    howOfferLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    [showMoneyView addSubview:howOfferLabel];
    
//
    UILabel * MoneyofferLabel = [[UILabel alloc] initWithFrame:CGRectMake(offerLabel.frame.origin.x, offerLabel.frame.origin.y + offerLabel.frame.size.height + ScaleH(26), ScaleW(15), ScaleH(12))];
    MoneyofferLabel.text = @"￥";
    MoneyofferLabel.font = [UIFont WLFontOfSize:13];
    MoneyofferLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    [showMoneyView addSubview:MoneyofferLabel];
    
//
    _inputLabel = [[UITextField alloc] initWithFrame:CGRectMake(MoneyofferLabel.frame.origin.x + MoneyofferLabel.frame.size.width, ScaleH(39), ScaleW(140), ScaleH(28))];
    //_inputLabel.text = @"400";
    _inputLabel.delegate = self;
    _inputLabel.tag = 1990;
    _inputLabel.placeholder = @"请输入报价金额";
    _inputLabel.font = [UIFont WLFontOfSize:16];
    _inputLabel.textAlignment = NSTextAlignmentLeft;
    [showMoneyView addSubview:_inputLabel];
    
    _inputHowLabel = [[UITextField alloc] initWithFrame:CGRectMake(showMoneyView.frame.size.width - ScaleW(112), ScaleH(39), ScaleW(100), ScaleH(28))];
    _inputHowLabel.text = @"0";
    _inputHowLabel.delegate = self;
    _inputHowLabel.tag = 19990;
    //_inputLabel.placeholder = @"0";
    _inputHowLabel.font = [UIFont WLFontOfSize:18];
    _inputHowLabel.textAlignment = NSTextAlignmentRight;
    [showMoneyView addSubview:_inputHowLabel];
    
// 接受拆单
    UILabel * acceptOpenLabel = [[UILabel alloc] init];
    acceptOpenLabel.frame = CGRectMake(arriveLabel.frame.origin.x, showMoneyView.frame.origin.y + showMoneyView.frame.size.height + ScaleH(25), ScaleW(200), ScaleH(16));
    acceptOpenLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    acceptOpenLabel.textAlignment = NSTextAlignmentLeft;
    acceptOpenLabel.font = [UIFont WLFontOfSize:16];
    acceptOpenLabel.text = @"接受拆单";
    [tellMoneyView addSubview:acceptOpenLabel];

// 开关
    mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(showMoneyView.frame.size.width - ScaleW(42),acceptOpenLabel.frame.origin.y - ScaleH(10),0.0,0.9)];
    mySwitch.onTintColor = [WLTools stringToColor:@"#4877e7"];
    //[mySwitch setOn:YES];
    [mySwitch addTarget:self action:@selector(MySwitchAction:) forControlEvents:UIControlEventValueChanged];
    [tellMoneyView addSubview:mySwitch];
    
// 横线
    UILabel * acceptOpenline = [[UILabel alloc] init];
    acceptOpenline.frame = CGRectMake(0, acceptOpenLabel.frame.origin.y + acceptOpenLabel.frame.size.height + ScaleH(15), tellMoneyView.frame.size.width, ScaleH(0.5));
    acceptOpenline.backgroundColor = [UIColor lightGrayColor];
    [tellMoneyView addSubview:acceptOpenline];
    
// 报价有效期
    UILabel * validityDayLabel = [[UILabel alloc] init];
    validityDayLabel.frame = CGRectMake(arriveLabel.frame.origin.x, acceptOpenline.frame.origin.y + acceptOpenline.frame.size.height + ScaleH(15), ScaleW(150), ScaleH(16));
    validityDayLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    validityDayLabel.textAlignment = NSTextAlignmentLeft;
    validityDayLabel.font = [UIFont WLFontOfSize:16];
    validityDayLabel.text = @"报价有效期至";
    [tellMoneyView addSubview:validityDayLabel];
    
    _endtime = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(130), validityDayLabel.frame.origin.y, tellMoneyView.frame.size.width - ScaleW(150), validityDayLabel.frame.size.height)];
    _endtime.text = @"2016.09.06 14:00";
    _endtime.textAlignment = NSTextAlignmentRight;
    _endtime.textColor = [WLTools stringToColor:@"#2f2f2f"];
    [tellMoneyView addSubview:_endtime];
    
    _endtime.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDate)];
    [_endtime addGestureRecognizer:tap];
    
    UILabel * validityDayline = [[UILabel alloc] init];
    validityDayline.frame = CGRectMake(0, validityDayLabel.frame.origin.y + validityDayLabel.frame.size.height + ScaleH(15), tellMoneyView.frame.size.width, ScaleH(0.5));
    validityDayline.backgroundColor = [UIColor lightGrayColor];
    [tellMoneyView addSubview:validityDayline];
    
//
    
// 不接单
    bottomBtnView = [[UIView alloc] init];
    bottomBtnView.frame = CGRectMake(0, tellMoneyView.frame.origin.y + tellMoneyView.frame.size.height, ScreenWidth, ScaleH(75));
    bottomBtnView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomBtnView];
    
    RefusedBtn = [[UIButton alloc] init];
    RefusedBtn.frame = CGRectMake(ScaleW(12), ScaleH(16), (bottomBtnView.frame.size.width - ScaleW(36))/3, ScaleH(41));
    [RefusedBtn setTitle:@"不接单" forState:UIControlStateNormal];
    RefusedBtn.titleLabel.font = [UIFont WLFontOfSize:16];
    [RefusedBtn setTitleColor:[WLTools stringToColor:@"#4877e7"] forState:UIControlStateNormal];
    [RefusedBtn setBackgroundImage:[UIImage imageNamed:@"refuseImg"] forState:UIControlStateNormal];
    [RefusedBtn addTarget:self action:@selector(RefusedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtnView addSubview:RefusedBtn];
    
    sureBtn = [[UIButton alloc] init];
    sureBtn.frame = CGRectMake(RefusedBtn.frame.origin.x + RefusedBtn.frame.size.width + ScaleW(12), RefusedBtn.frame.origin.y, RefusedBtn.frame.size.width * 2, RefusedBtn.frame.size.height);
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont WLFontOfSize:16];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"notarizeImg"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtnView addSubview:sureBtn];
}

- (void)setModelInfo:(WLHotelOrderInfo *)modelInfo
{
    _modelInfo = modelInfo;
    topTimeLabel.text = modelInfo.sendOrderDate;
    
    howMoneyShowLabel.text = @"";
    _inputLabel.text = @"";
    _inputHowLabel.text = @"";
    
    groupID.text = [NSString stringWithFormat:@"团号 %@",modelInfo.groupNO];
    if (_timeGo == nil) {
        _timeGo = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimeGo) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timeGo forMode:NSRunLoopCommonModes];
    }
    _timeInterval = [WLDataHotelHandler getcountdownData:modelInfo.expiryDate];
    //_timeShowLabel.text = modelInfo.expiryDate;
    nameLabel.text = modelInfo.realName;
    companyNameLabel.text = modelInfo.djCompany;
    arriveShowLabel.text = [WLDataHotelHandler getYMStringWithYMDString:modelInfo.whichDate];
    leaveShowLabel.text = [WLDataHotelHandler getYMStringWithYMDString:modelInfo.checkoutDate];
    roomTypeLabel.text = modelInfo.priceListName;
    howRoomTypeLabel.text = [NSString stringWithFormat:@"X%@",modelInfo.checkCount];
    roomdownMoneyLabel.text = [NSString stringWithFormat:@"￥%@",modelInfo.checkPrice];
    
    _endtime.text = [WLDataHotelHandler getYMDHMStringWithYMDHMSString:modelInfo.dispatchExpiryDate];       //报价有效期
    
    RefusedBtn.tag = [modelInfo.checkListID integerValue];
    sureBtn.tag = [modelInfo.checkListID integerValue];
    
    if (modelInfo.isBidding) {
        roomdownMoneyLabel.hidden = YES;
        
        tellMoneyView.hidden = NO;
        bottomBtnView.frame = CGRectMake(0, tellMoneyView.frame.origin.y + tellMoneyView.frame.size.height, ScreenWidth, ScaleH(75));
    }
    else
    {
        tellMoneyView.hidden = YES;
        bottomBtnView.frame = CGRectMake(0, middleView.frame.origin.y + middleView.frame.size.height, ScreenWidth, ScaleH(75));
        
        roomdownMoneyLabel.hidden = NO;
        howMoneyShowLabel.text = [NSString stringWithFormat:@"￥%@",modelInfo.checkPriceCount];
    }
    
    callBtn.tag = [modelInfo.userMobile integerValue];
    WchatBtn.tag = 1111; //这里可以接私信要传的信息
    /** 是否接受拆单(派单着决定) */
    if(self.modelInfo.isSplitSend)//接受拆单
    {
        howOfferLabel.hidden = NO;
        _inputHowLabel.hidden = NO;
    }else if(self.modelInfo.isSplitSend == NO)
    {
        howOfferLabel.hidden = YES;
        _inputHowLabel.hidden = YES;
    }
    //是否接受拆单(接单者决定)
    mySwitch.on = modelInfo.isSplitAccept;
    
}

//- (void)setCellModel:(WLHotelOrderInfo *)modelInfo
//{
//    topTimeLabel.text = modelInfo.sendOrderDate;
//    groupID.text = [NSString stringWithFormat:@"团号 %@",modelInfo.groupNO];
//    if (_timeGo == nil) {
//        _timeGo = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimeGo) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timeGo forMode:NSRunLoopCommonModes];
//    }
//    _timeInterval = [WLDataHotelHandler getcountdownData:modelInfo.expiryDate];
//    //_timeShowLabel.text = modelInfo.expiryDate;
//    nameLabel.text = modelInfo.realName;
//    companyNameLabel.text = modelInfo.djCompany;
//    arriveShowLabel.text = [WLDataHotelHandler getYMStringWithYMDString:modelInfo.whichDate];
//    leaveShowLabel.text = [WLDataHotelHandler getYMStringWithYMDString:modelInfo.checkoutDate];
//    roomTypeLabel.text = modelInfo.priceListName;
//    howRoomTypeLabel.text = [NSString stringWithFormat:@"X%@",modelInfo.checkCount];
//    roomdownMoneyLabel.text = [NSString stringWithFormat:@"￥%@",modelInfo.checkPrice];
//    
//    _endtime.text = [WLDataHotelHandler getYMDHMStringWithYMDHMSString:modelInfo.dispatchExpiryDate];       //报价有效期
//    
//    RefusedBtn.tag = [modelInfo.checkListID integerValue];
//    sureBtn.tag = [modelInfo.checkListID integerValue];
//    
//    if (modelInfo.isBidding) {
//        roomdownMoneyLabel.hidden = YES;
//        
//        tellMoneyView.hidden = NO;
//        bottomBtnView.frame = CGRectMake(0, tellMoneyView.frame.origin.y + tellMoneyView.frame.size.height, ScreenWidth, ScaleH(75));
//    }
//    else
//    {
//        tellMoneyView.hidden = YES;
//        bottomBtnView.frame = CGRectMake(0, middleView.frame.origin.y + middleView.frame.size.height, ScreenWidth, ScaleH(75));
//
//        roomdownMoneyLabel.hidden = NO;
//        howMoneyShowLabel.text = [NSString stringWithFormat:@"￥%@",modelInfo.checkPriceCount];
//    }
//    
//    callBtn.tag = [modelInfo.userMobile integerValue];
//    WchatBtn.tag = 1111; //这里可以接私信要传的信息
//}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.modelInfo.isSplitSend)//接受拆单
    {
        if([_inputHowLabel.text integerValue] < 0)
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"数量输入错误"];
            return;
        }
        howMoneyShowLabel.text = [NSString stringWithFormat:@"￥%ld",[_inputLabel.text integerValue] * [_inputHowLabel.text integerValue]];
        
    }else if(self.modelInfo.isSplitSend == NO)
    {
        
        howMoneyShowLabel.text = [NSString stringWithFormat:@"￥%ld",[_inputLabel.text integerValue] * [self.modelInfo.checkCount integerValue]];
    }
    
    //howMoneyShowLabel.text = [NSString stringWithFormat:@"￥%ld",[_inputLabel.text integerValue] * [_inputHowLabel.text integerValue]];
    
}

- (void)WCClick:(UIButton *)sender
{
    _WCBtnAction(sender.tag);
}

- (void)wCClickAction:(void (^)(NSInteger))action
{
    _WCBtnAction = action;
}

- (void)iPhoneClick:(UIButton *)sender
{
    _iPhoneBtnAction(sender.tag);
}

- (void)iPhoneAction:(void (^)(NSInteger))action
{
    _iPhoneBtnAction = action;
}

// 确认 、发报价
- (void)sureBtnClick:(UIButton *)sender
{
    WLHotelOrderInfo * sendModel = [[WLHotelOrderInfo alloc] init];
    sendModel.checkListID = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    sendModel.forcastPrice = [NSString stringWithFormat:@"%@",_inputLabel.text];
    sendModel.forcastCount = [NSString stringWithFormat:@"%@",_inputHowLabel.text];
    if ([mySwitch isOn]) {
        sendModel.isSplitAccept = 1;
    }
    else
    {
        sendModel.isSplitAccept = 0;
    }
    //-----------
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate* date = [formatter dateFromString:_endtime.text];
    
    NSTimeInterval HSLtimeStamp= [date timeIntervalSince1970];
    //-----------
    sendModel.dispatchExpiryDate = [NSString stringWithFormat:@"%ld",(long)HSLtimeStamp];
    
    _sureBtnAction(sendModel);
}

- (void)sureBtnClickAction:(void (^)(WLHotelOrderInfo *))action
{
    _sureBtnAction = action;
}

- (void)MySwitchAction:(UISwitch *)sender
{
    self.modelInfo.isSplitAccept = sender.isOn;
    
}

// 不接单
- (void)RefusedBtnClick:(UIButton *)sender
{
    _reBtnAction([NSString stringWithFormat:@"%ld",(long)sender.tag]);
}

- (void)RefusedBtnClickAction:(void (^)(NSString *))action
{
    _reBtnAction = action;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_inputLabel resignFirstResponder];
    [_inputHowLabel resignFirstResponder];
    
    return YES;
}

- (void)chooseDate
{
    _ChooseDateBtnAction();
}

- (void)ChooseDateClickAction:(void (^)())action
{
    _ChooseDateBtnAction = action;
}

- (void)showTimeGo
{
    _timeShowLabel.text = [NSString stringWithFormat:@"%ld天 %02ld:%02ld:%02ld",_timeInterval/(3600 * 24),(_timeInterval%(3600 * 24))/3600,((_timeInterval%(3600 * 24))%3600)/60,((_timeInterval%(3600 * 24))%3600)%60];

    if (_timeInterval > 0) {
        _timeInterval --;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
