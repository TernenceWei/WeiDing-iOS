
//
//  WLGuideWaitOrderTableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//


#import "WLGuideReceivedOrderTableViewCell.h"

#import "CostomLabel.h"

@interface WLGuideReceivedOrderTableViewCell ()

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
/**  接单时间 */
@property(nonatomic, weak)UILabel *acceptLabel;


@property(nonatomic, strong)NSString *typeText;

@property(nonatomic, strong)NSString *rateText;



@end

@implementation WLGuideReceivedOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpBaseView];
        
        //设置点击cell不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加baseView
        [self setUpBaseView];
        self.backgroundColor = HEXCOLOR(0xf7f7f8);
    }
    return self;
}

-(void)setOrderInfo:(WLOrderListInfo *)orderInfo{
    _orderInfo = orderInfo;
    self.orderID = self.orderInfo.checkListID;
    self.groupListID = self.orderInfo.groupListID;
    [self setUpBaseView];

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
    
    
    // 导服费
    UILabel *chargedLabel = [[UILabel alloc] init];
    [baseView addSubview:chargedLabel];
    [chargedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView.mas_left).offset(ScaleW(100));
        make.top.equalTo(baseView.mas_top).offset(ScaleH(35));
    }];
    chargedLabel.textColor = HEXCOLOR(0xb5b5b5);
    chargedLabel.font = WLFontSize(13);
    
    chargedLabel.text = @"导服费:";
    
    _chargedLabel = chargedLabel;
    
    //导服费人民币符号
    UILabel *RMBLabel = [[UILabel alloc] init];
    [baseView addSubview:RMBLabel];
    [RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chargedLabel.mas_right).offset(ScaleW(7));
        make.bottom.equalTo(chargedLabel.mas_bottom);
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
    
    
    
    
    //线路名称
    UILabel *lineNameLabel = [[UILabel alloc] init];
    [baseView addSubview:lineNameLabel];
    lineNameLabel.font = WLFontSize(14);
    //    lineNameLabel.text = @"华南沿海双人游，昆明-云南-上海，双飞豪华六天";
    lineNameLabel.text = self.orderInfo.lineName;
    lineNameLabel.textColor = HEXCOLOR(0x2F2F2F);
    [lineNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView.mas_left).offset(baseLeft);
        make.top.equalTo(chargeLabel.mas_bottom).offset(ScaleH(15));
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
    
    
    //    rateLabel.text = @"购返3.00%";
    if (self.orderInfo.maxRate.intValue == self.orderInfo.minRate.intValue) {
        self.rateText = [NSString stringWithFormat:@"购返%@%%",self.orderInfo.minRate];
    }
    else{
        self.rateText = [NSString stringWithFormat:@"购返%@%%-%@%%",self.orderInfo.minRate,self.orderInfo.maxRate];
    }
    
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
    
    //    countLabel.text = @"60人";adults
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
    
    //接单时间
    UILabel *acceptLabel = [[UILabel alloc] init];
    [baseView addSubview:acceptLabel];
    [acceptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recieveImageView.mas_left);
        make.top.equalTo(recieveImageView.mas_bottom).offset(20);
    }];
    acceptLabel.font = WLFontSize(14);
    acceptLabel.textColor = HEXCOLOR(0xB5B5B5);
    
    acceptLabel.text = [NSString stringWithFormat:@"接单时间 %@",self.orderInfo.acceptOrderDate];
    _acceptLabel = acceptLabel;
    
    
    
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
    
    // Configure the view for the selected state
}

@end


