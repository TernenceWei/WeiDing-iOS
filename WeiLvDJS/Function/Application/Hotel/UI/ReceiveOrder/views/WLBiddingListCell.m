//
//  WLBiddingListCell.m
//  WeiLvDJS
//
//  Created by hsliang on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBiddingListCell.h"
#import "WLDataHotelHandler.h"

#define cellIdentifier @"BiddingCell"

@interface WLBiddingListCell ()
{
    BOOL iSOpen;
    UIView * middleView;
    UIView * tellMoneyView;
    UIView * bottomBtnView;
    UIButton * RefusedBtn;
    
    UILabel * groupID;
    
    UIButton * sureBtn;
    
    UILabel * nameLabel;
    UILabel * companyNameLabel;
    UILabel * arriveShowLabel;
    UILabel * leaveShowLabel;
    UILabel * roomTypeLabel;
    UILabel * howRoomTypeLabel;
    UILabel * roomdownMoneyLabel;
    UILabel * howMoneyShowLabel;          //总金额
    UILabel * howOfferLabel;              //有隐藏/显示效果
    
    //解决显示问题
    UIImageView * clockImg;
    UILabel * clockTime;
    UILabel * nolive;
    UILabel * timeout;
    
    UIButton * callBtn;
    UIButton * WchatBtn;
    
    UILabel * groupIDReally; // 团号
    
    UILabel * CacceptOpenLabel; // 愿意接受拆单
    UIView * otherView;
}

@property (nonatomic, strong) UIImageView * downImg;
@property (nonatomic, strong) UIButton * RighttimeShowBtn; //右侧的倒计时
@property (nonatomic, strong) UILabel * endtime; //有效期至

@property (nonatomic, strong) NSTimer * timeGo;
@property (nonatomic, assign) NSInteger timeInterval;

@property (nonatomic, copy)  void(^WCBtnAction)(NSInteger);
@property (nonatomic, copy)  void(^iPhoneBtnAction)(NSInteger);

@property (nonatomic, copy)  void(^qXBtnAction)(NSString *);

@property (nonatomic, copy)  void(^closeVSopenAction)(NSString *);

@end

@implementation WLBiddingListCell

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

+ (WLBiddingListCell *)cellCreateTableView:(UITableView *)tableView
{
    WLBiddingListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLBiddingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)setUI
{
    UIView * topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(10));
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
    
// 距离竞价确认还有  ==开始
    middleView = [[UIView alloc] init];
    middleView.frame = CGRectMake(0, topView.frame.origin.y + topView.frame.size.height, topView.frame.size.width, ScaleH(168));
    middleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:middleView];
// 距离竞价确认还有
    groupID = [[UILabel alloc] init];
    groupID.frame = CGRectMake(ScaleW(13), ScaleH(17), middleView.frame.size.width - ScaleW(30), ScaleH(12));
    groupID.textColor = [WLTools stringToColor:@"#2f2f2f"];
    groupID.textAlignment = NSTextAlignmentLeft;
    groupID.font = [UIFont WLFontOfSize:12];
    //groupID.text = @"距离竞价确认还有";
    [middleView addSubview:groupID];
    
// 右侧倒计时------------------------------------------------------------
    //  竞价中
    clockImg = [[UIImageView alloc] init];
    clockImg.frame = CGRectMake(middleView.frame.size.width - ScaleW(120), ScaleH(15), ScaleW(20), ScaleH(20));
    [clockImg setImage:[UIImage imageNamed:@"clockImg"]];
    clockImg.hidden = YES;
    [middleView addSubview:clockImg];
    
    clockTime = [[UILabel alloc] init];
    clockTime.frame = CGRectMake(clockImg.frame.origin.x + clockImg.frame.size.width + ScaleW(5), clockImg.frame.origin.y, ScaleW(95), ScaleH(20));
    clockTime.font = [UIFont WLFontOfSize:13];
    clockTime.hidden = YES;
    clockTime.textAlignment = NSTextAlignmentLeft;
    [middleView addSubview:clockTime];
    
    // 未结账
    nolive = [[UILabel alloc] init];
    nolive.frame = CGRectMake(middleView.frame.size.width - ScaleW(100), clockImg.frame.origin.y, ScaleW(90), ScaleH(20));
    nolive.font = [UIFont WLFontOfSize:13];
    nolive.textColor = [WLTools stringToColor:@"#ff872f"];
    nolive.hidden = YES;
    //nolive.text = @"未入住";
    nolive.textAlignment = NSTextAlignmentRight;
    [middleView addSubview:nolive];
    
    // 已结账
    _RighttimeShowBtn = [[UIButton alloc] init];
    _RighttimeShowBtn.frame = CGRectMake(middleView.frame.size.width - ScaleW(100), ScaleH(8), ScaleW(100), ScaleH(28));
    _RighttimeShowBtn.hidden = YES;
    [_RighttimeShowBtn setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
    [middleView addSubview:_RighttimeShowBtn];
    
    // 已失效
    timeout = [[UILabel alloc] init];
    timeout.frame = CGRectMake(middleView.frame.size.width - ScaleW(100), clockImg.frame.origin.y, ScaleW(90), ScaleH(20));
    timeout.font = [UIFont WLFontOfSize:13];
    timeout.textColor = [WLTools stringToColor:@"#ff872f"];
    timeout.hidden = YES;
    //timeout.text = @"确认超时";
    timeout.textAlignment = NSTextAlignmentRight;
    [middleView addSubview:timeout];
    
//---------------------------------------------------------------------------

// 横线
    UILabel *rightShowBtnDownLine = [[UILabel alloc] init];
    rightShowBtnDownLine.frame = CGRectMake(0, groupID.frame.origin.y + groupID.frame.size.height + ScaleH(17), topView.frame.size.width, ScaleH(0.5));
    rightShowBtnDownLine.backgroundColor = [WLTools stringToColor:@"#dce0e8"];
    [middleView addSubview:rightShowBtnDownLine];
    
// 入住时间
    UILabel * arriveLabel = [[UILabel alloc] init];
    arriveLabel.frame = CGRectMake(groupID.frame.origin.x, rightShowBtnDownLine.frame.origin.y + rightShowBtnDownLine.frame.size.height + ScaleH(14), ScaleW(50), ScaleH(12));
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
    leaveLabel.frame = CGRectMake(arriveLabel.frame.origin.x, arriveShowLabel.frame.origin.y + arriveShowLabel.frame.size.height + ScaleH(23), ScaleW(50), ScaleH(12));
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
    verticalImg.frame = CGRectMake(arriveShowLabel.frame.origin.x + arriveShowLabel.frame.size.width + ScaleW(8), rightShowBtnDownLine.frame.origin.y + rightShowBtnDownLine.frame.size.height + ScaleH(37), ScaleW(10), ScaleH(62));
    [verticalImg setImage:[UIImage imageNamed:@"divisionImg"]];
    [middleView addSubview:verticalImg];
    
// 房型
    roomTypeLabel = [[UILabel alloc] init];
    roomTypeLabel.frame = CGRectMake(verticalImg.frame.origin.x + verticalImg.frame.size.width + ScaleW(15), arriveShowLabel.frame.origin.y, ScaleW(100), ScaleH(16));
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
    roomdownMoneyLabel.frame = CGRectMake(roomTypeLabel.frame.origin.x, leaveShowLabel.frame.origin.y, ScaleW(100), ScaleH(16));
    roomdownMoneyLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    roomdownMoneyLabel.textAlignment = NSTextAlignmentLeft;
    roomdownMoneyLabel.font = [UIFont WLFontOfSize:13];
    //roomdownMoneyLabel.text = @"￥400";//_Modelinfo.checkPrice;////
    [middleView addSubview:roomdownMoneyLabel];
    
// 总金额
    howMoneyShowLabel = [[UILabel alloc] init];
    howMoneyShowLabel.frame = CGRectMake(middleView.frame.size.width - ScaleW(90), leaveShowLabel.frame.origin.y + ScaleH(1), ScaleW(80), ScaleH(20));
    howMoneyShowLabel.textColor = [UIColor blackColor];//[WLTools stringToColor:@"#ff872f"];
    howMoneyShowLabel.textAlignment = NSTextAlignmentRight;
    howMoneyShowLabel.font = [UIFont WLFontOfSize:17];
    //howMoneyShowLabel.text = @"￥3200";
    [middleView addSubview:howMoneyShowLabel];
    
    UILabel * howMoneyLabel = [[UILabel alloc] init];
    howMoneyLabel.frame = CGRectMake(howMoneyShowLabel.frame.origin.x - ScaleW(70), howMoneyShowLabel.frame.origin.y + ScaleH(3), ScaleW(70), ScaleH(14));
    howMoneyLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    howMoneyLabel.textAlignment = NSTextAlignmentRight;
    howMoneyLabel.font = [UIFont WLFontOfSize:13];
    howMoneyLabel.text = @"总金额";
    [middleView addSubview:howMoneyLabel];
    
// 展开的视图
    tellMoneyView = [[UIView alloc] init];
    tellMoneyView.frame = CGRectMake(0, middleView.frame.origin.y + middleView.frame.size.height, middleView.frame.size.width, ScaleH(250));
    tellMoneyView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tellMoneyView];
    
// 客户 + 线
    UILabel * customerLabel = [[UILabel alloc] init];
    customerLabel.frame = CGRectMake(groupID.frame.origin.x, ScaleH(5), ScaleW(35), ScaleH(12));
    customerLabel.text = @"客户";
    customerLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    customerLabel.textAlignment = NSTextAlignmentLeft;
    customerLabel.font = [UIFont WLFontOfSize:13];
    [tellMoneyView addSubview:customerLabel];
    
    UILabel * customerLabelRightLine = [[UILabel alloc] init];
    customerLabelRightLine.frame = CGRectMake(customerLabel.frame.origin.x + customerLabel.frame.size.width + ScaleW(9), customerLabel.frame.origin.y + ScaleH(6), tellMoneyView.frame.size.width - customerLabel.frame.origin.x - customerLabel.frame.size.width - ScaleW(9), ScaleH(0.5));
    customerLabelRightLine.backgroundColor = [WLTools stringToColor:@"#dce0e8"];
    [tellMoneyView addSubview:customerLabelRightLine];
    
    
// 团号
    groupIDReally = [[UILabel alloc] init];
    groupIDReally.frame = CGRectMake(customerLabel.frame.origin.x, customerLabel.frame.origin.y + customerLabel.frame.size.height + ScaleH(20), (middleView.frame.size.width / 2), ScaleH(12));
    groupIDReally.textColor = [WLTools stringToColor:@"#2f2f2f"];
    groupIDReally.textAlignment = NSTextAlignmentLeft;
    groupIDReally.font = [UIFont WLFontOfSize:14];
    //groupIDReally.text = @"团号 20160506056231";
    [tellMoneyView addSubview:groupIDReally];
    
// 名字
    nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(groupID.frame.origin.x, groupIDReally.frame.origin.y + groupIDReally.frame.size.height + ScaleH(26), groupID.frame.size.width, ScaleH(16));
    nameLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont WLFontOfSize:16];
    nameLabel.text = @"张三";
    [tellMoneyView addSubview:nameLabel];
    
// 公司单位
    companyNameLabel = [[UILabel alloc] init];
    companyNameLabel.frame = CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height + ScaleH(15), groupID.frame.size.width, ScaleH(16));
    companyNameLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    companyNameLabel.textAlignment = NSTextAlignmentLeft;
    companyNameLabel.font = [UIFont WLFontOfSize:13];
    companyNameLabel.text = @"南京哪儿玩有限公司";
    [tellMoneyView addSubview:companyNameLabel];
    
// 电话图标
    callBtn = [[UIButton alloc] init];
    callBtn.frame = CGRectMake(middleView.frame.size.width - ScaleW(62), customerLabelRightLine.frame.origin.y + customerLabelRightLine.frame.size.height + ScaleH(50), ScaleW(48), ScaleH(47));
    [callBtn setImage:[UIImage imageNamed:@"phoneImg"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(iPhoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [tellMoneyView addSubview:callBtn];
    
// 微信图标
    WchatBtn = [[UIButton alloc] init];
    WchatBtn.frame = CGRectMake(callBtn.frame.origin.x - ScaleW(62), callBtn.frame.origin.y + ScaleH(4), ScaleW(48), ScaleH(39));
    [WchatBtn setImage:[UIImage imageNamed:@"chatImg"] forState:UIControlStateNormal];
    [WchatBtn addTarget:self action:@selector(WCClick:) forControlEvents:UIControlEventTouchUpInside];
    [tellMoneyView addSubview:WchatBtn];
    
// 其他========不是竞价单要隐藏
    otherView = [[UIView alloc] init];
    otherView.frame = CGRectMake(0, companyNameLabel.frame.origin.y + companyNameLabel.frame.size.height + ScaleH(28), tellMoneyView.frame.size.width, ScaleH(100));
    otherView.backgroundColor = [UIColor whiteColor];
    [tellMoneyView addSubview:otherView];
    
//其他 + 线
    UILabel * otherLabel = [[UILabel alloc] init];
    otherLabel.frame = CGRectMake(groupID.frame.origin.x, ScaleH(5), ScaleW(35), ScaleH(12));
    otherLabel.text = @"其他";
    otherLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    otherLabel.textAlignment = NSTextAlignmentLeft;
    otherLabel.font = [UIFont WLFontOfSize:13];
    [otherView addSubview:otherLabel];
    
    UILabel * otherLabelRightLine = [[UILabel alloc] init];
    otherLabelRightLine.frame = CGRectMake(otherLabel.frame.origin.x + otherLabel.frame.size.width + ScaleW(9), otherLabel.frame.origin.y + ScaleH(6), customerLabelRightLine.frame.size.width, ScaleH(0.5));
    otherLabelRightLine.backgroundColor = [WLTools stringToColor:@"#dce0e8"];
    [otherView addSubview:otherLabelRightLine];
    
// 接受拆单
    UILabel * acceptOpenLabel = [[UILabel alloc] init];
    acceptOpenLabel.frame = CGRectMake(arriveLabel.frame.origin.x, otherLabel.frame.origin.y + otherLabel.frame.size.height + ScaleH(24), ScaleW(200), ScaleH(16));
    acceptOpenLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    acceptOpenLabel.textAlignment = NSTextAlignmentLeft;
    acceptOpenLabel.font = [UIFont WLFontOfSize:16];
    acceptOpenLabel.text = @"接受拆单";
    [otherView addSubview:acceptOpenLabel];
    
// 愿意接受拆单
    CacceptOpenLabel = [[UILabel alloc] init];
    CacceptOpenLabel.frame = CGRectMake(tellMoneyView.frame.size.width - ScaleW(212), acceptOpenLabel.frame.origin.y, ScaleW(200), ScaleH(16));
    CacceptOpenLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    CacceptOpenLabel.textAlignment = NSTextAlignmentRight;
    CacceptOpenLabel.font = [UIFont WLFontOfSize:16];
    //CacceptOpenLabel.text = @"愿意接受拆单";
    [otherView addSubview:CacceptOpenLabel];
    
// 报价有效期
    UILabel * validityDayLabel = [[UILabel alloc] init];
    validityDayLabel.frame = CGRectMake(arriveLabel.frame.origin.x, acceptOpenLabel.frame.origin.y + acceptOpenLabel.frame.size.height + ScaleH(18), ScaleW(200), ScaleH(16));
    validityDayLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    validityDayLabel.textAlignment = NSTextAlignmentLeft;
    validityDayLabel.font = [UIFont WLFontOfSize:16];
    validityDayLabel.text = @"报价有效期至";
    [otherView addSubview:validityDayLabel];
    
// 报价有效期(时间)
    _endtime = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(130), validityDayLabel.frame.origin.y, tellMoneyView.frame.size.width - ScaleW(150), validityDayLabel.frame.size.height)];
    //_endtime.text = @"2016.09.06 14:00";
    _endtime.textAlignment = NSTextAlignmentRight;
    _endtime.font = [UIFont WLFontOfSize:16];
    _endtime.textColor = [WLTools stringToColor:@"#b5b5b5"];
    [otherView addSubview:_endtime];
    
    // 不接单
    bottomBtnView = [[UIView alloc] init];
    bottomBtnView.frame = CGRectMake(0, tellMoneyView.frame.origin.y + tellMoneyView.frame.size.height, ScreenWidth, ScaleH(52));
    bottomBtnView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomBtnView];
    
    UILabel * linelineLabel = [[UILabel alloc] init];
    linelineLabel.frame = CGRectMake(0, 0, bottomBtnView.frame.size.width, ScaleH(0.5));
    linelineLabel.backgroundColor = [WLTools stringToColor:@"#dce0e8"];
    [bottomBtnView addSubview:linelineLabel];
    
    RefusedBtn = [[UIButton alloc] init];
    RefusedBtn.frame = CGRectMake(ScaleW(12), ScaleH(16), ScaleW(100), ScaleH(19));
    [RefusedBtn setTitle:@"查看订单详情" forState:UIControlStateNormal];
    RefusedBtn.titleLabel.font = [UIFont WLFontOfSize:12];
    [RefusedBtn setTitleColor:[WLTools stringToColor:@"#4877e7"] forState:UIControlStateNormal];
    //RefusedBtn.tag = [modelInfo.iSopen integerValue];
    [RefusedBtn addTarget:self action:@selector(RefusedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtnView addSubview:RefusedBtn];
    
    sureBtn = [[UIButton alloc] init];
    sureBtn.frame = CGRectMake(bottomBtnView.frame.size.width - ScaleW(95), ScaleH(13), ScaleW(83), ScaleH(29));
    //[sureBtn setTitle:@"取消报价" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont WLFontOfSize:13];
    [sureBtn setTitleColor:[WLTools stringToColor:@"#2f2f2f"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"withdrawanofferImg"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtnView addSubview:sureBtn];
    
    _downImg = [[UIImageView alloc] initWithFrame:CGRectMake(RefusedBtn.frame.origin.x + RefusedBtn.frame.size.width, RefusedBtn.frame.origin.y + ScaleH(5), ScaleW(19), ScaleH(13))];
    [_downImg setImage:[UIImage imageNamed:@"DetailDisclosureButtonImg"]];
    [bottomBtnView addSubview:_downImg];
}

- (void)setCellModel:(WLHotelOrderInfo *)modelInfo Nstatus:(HotelListStatus)SNstatus
{
    // 是否竞价单
    if (modelInfo.isSplitSend) {
        
        CacceptOpenLabel.text = @"愿意接受拆单";
    }
    else
    {
        CacceptOpenLabel.text = @"不愿意接受拆单";
    }
    if (modelInfo.isBidding) {
        otherView.hidden = NO;
        tellMoneyView.frame = CGRectMake(0, middleView.frame.origin.y + middleView.frame.size.height, middleView.frame.size.width, ScaleH(250));
    }
    else
    {
        otherView.hidden = YES;
        tellMoneyView.frame = CGRectMake(0, middleView.frame.origin.y + middleView.frame.size.height, middleView.frame.size.width, ScaleH(130));
    }
    
// 展开，闭合开关
    RefusedBtn.tag = [modelInfo.isOpen integerValue];
    
    if ([modelInfo.isOpen isEqualToString:@"1"]) {
        tellMoneyView.hidden = YES;
        [_downImg setImage:[UIImage imageNamed:@"DetailDisclosureButtonImg"]];
        bottomBtnView.frame = CGRectMake(0, middleView.frame.origin.y + middleView.frame.size.height, ScreenWidth, ScaleH(52));
    }
    else if ([modelInfo.isOpen isEqualToString:@"0"])
    {
        tellMoneyView.hidden = NO;
        [_downImg setImage:[UIImage imageNamed:@"PackupthebuttonImg"]];
        if (modelInfo.isBidding) {
            bottomBtnView.frame = CGRectMake(0, tellMoneyView.frame.origin.y + tellMoneyView.frame.size.height, ScreenWidth, ScaleH(52));
        }
        else
        {
            bottomBtnView.frame = CGRectMake(0, tellMoneyView.frame.origin.y + tellMoneyView.frame.size.height, ScreenWidth, ScaleH(52));
        }
    }

// 按钮
    [_RighttimeShowBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    if (SNstatus == HotelListStatusBidding)
    {
        groupID.hidden = NO;
        groupID.text = @"距离竞价确认还有";
        // 右侧倒计时
        clockImg.hidden = NO;
        clockTime.hidden = NO;
        nolive.hidden = YES;
        _RighttimeShowBtn.hidden = YES;
        timeout.hidden = YES;
        
        if (_timeGo == nil) {
            _timeGo = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimeGo) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timeGo forMode:NSRunLoopCommonModes];
        }
        _timeInterval = [WLDataHotelHandler getcountdownData:modelInfo.expiryDate];
        
        roomdownMoneyLabel.hidden = YES;
        [sureBtn setTitle:@"取消报价" forState:UIControlStateNormal];
    }
    if (SNstatus == HotelListStatusUnSettle)
    {
        groupID.hidden = NO;
        clockImg.hidden = YES;
        clockTime.hidden = YES;
        nolive.hidden = NO;
        _RighttimeShowBtn.hidden = YES;
        timeout.hidden = YES;
        
        if (modelInfo.rz_status) {
            nolive.text = @"已入住";
        }
        else
        {
            nolive.text = @"未入住";
        }
        
        groupID.text = [NSString stringWithFormat:@"订单号 %@",modelInfo.orderNO];
        sureBtn.hidden = YES;
    }
    if (SNstatus == HotelListStatusAlreadySettle)
    {
        groupID.hidden = NO;
        clockImg.hidden = YES;
        clockTime.hidden = YES;
        nolive.hidden = YES;
        _RighttimeShowBtn.hidden = NO;
        timeout.hidden = YES;
        
        groupID.text = [NSString stringWithFormat:@"订单号 %@",modelInfo.orderNO];
        //
        [_RighttimeShowBtn setImage:[UIImage imageNamed:@"completeImg"] forState:UIControlStateNormal];
        
        sureBtn.hidden = YES;
    }
    if (SNstatus == HotelListStatusOutOfDate)
    {
        groupID.hidden = YES;
        clockImg.hidden = YES;
        clockTime.hidden = YES;
        nolive.hidden = YES;
        _RighttimeShowBtn.hidden = YES;
        timeout.hidden = NO;
        // 右侧倒计时
        
        sureBtn.hidden = NO;
        [sureBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        //roomdownMoneyLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
        
        if (modelInfo.type_status == 0) {
            timeout.text = @"未确认";
        }
        else if (modelInfo.type_status == 1)
        {
            timeout.text = @"超时";
        }
        else if (modelInfo.type_status == 2)
        {
            timeout.text = @"竞价失败";
        }
        else if (modelInfo.type_status == 3)
        {
            timeout.text = @"订单被取消";
        }
        else if (modelInfo.type_status == 4)
        {
            timeout.text = @"拒绝接单";
        }
        else if (modelInfo.type_status == 5)
        {
            timeout.text = @"取消报价";
        }
        else if (modelInfo.type_status == 6)
        {
            timeout.text = @"已确认";
        }
        
    }
    roomdownMoneyLabel.hidden = NO;
    
    // 数据
    sureBtn.tag = [modelInfo.checkListID integerValue];
    
    //groupID.text = [NSString stringWithFormat:@"团号 %@",modelInfo.groupNO];
    nameLabel.text = modelInfo.realName;
    companyNameLabel.text = modelInfo.djCompany;
    arriveShowLabel.text = [WLDataHotelHandler getYMStringWithYMDString:modelInfo.whichDate];
    leaveShowLabel.text = [WLDataHotelHandler getYMStringWithYMDString:modelInfo.checkoutDate];
    roomTypeLabel.text = modelInfo.priceListName;
    howRoomTypeLabel.text = [NSString stringWithFormat:@"X%@",modelInfo.checkCount];
    roomdownMoneyLabel.text = [NSString stringWithFormat:@"￥%@",modelInfo.checkPrice];
    
    groupIDReally.text = [NSString stringWithFormat:@"团号 %@",modelInfo.groupNO]; // 团号
    
    howMoneyShowLabel.text =[NSString stringWithFormat:@"￥%@",modelInfo.checkPriceCount] ;
    _endtime.text = [WLDataHotelHandler getYMDHMStringWithYMDHMSString:modelInfo.dispatchExpiryDate];       //报价有效期
}

//- (void)prepareForReuse
//{
//    [super prepareForReuse];
//    groupID.hidden = NO;
//    sureBtn.hidden = NO;
//    _RighttimeShowBtn.hidden = NO;
//}

- (void)sureBtnClick:(UIButton *)sender
{
    _qXBtnAction([NSString stringWithFormat:@"%ld",(long)sender.tag]);
}

- (void)qXBtnClickAction:(void (^)(NSString *))action
{
    _qXBtnAction = action;
}

// 是否展开
- (void)RefusedBtnClick:(UIButton *)sender
{
    NSString * ooStr = [[NSString alloc] init];
    
    if (sender.tag == 0) {
        iSOpen = NO;
        ooStr = @"1";
    }
    else
    {
        iSOpen = YES;
        ooStr = @"0";
    }
    
    _closeVSopenAction(ooStr);
}

- (void)closeVSopenClickAction:(void (^)(NSString *))action
{
    _closeVSopenAction = action;
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

- (void)showTimeGo
{

    _RighttimeShowBtn.hidden = NO;

    clockTime.text = [NSString stringWithFormat:@"%ld天%02ld:%02ld:%02ld",_timeInterval/(3600 * 24),(_timeInterval%(3600 * 24))/3600,((_timeInterval%(3600 * 24))%3600)/60,((_timeInterval%(3600 * 24))%3600)%60];
    
    if (_timeInterval > 0) {
        _timeInterval --;
    }
    else
    {
        [_timeGo invalidate];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
