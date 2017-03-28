//
//  WL_Application_Driver_Bill_BillList_Cell.m
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_Bill_Settlement_Cell.h"
#import "WL_Application_Driver_Bill_Model.h"

@interface WL_Application_Driver_Bill_Settlement_Cell ()
/** 出发时间Lable */
@property(nonatomic, weak) UILabel *startTimeLable;
/** 已结清图片 */
@property(nonatomic, weak)UIImageView *settlementOrderImageView;
/** 结束时间Lable */
@property(nonatomic, weak) UILabel *endTimeLable;
/** 出团人数Lable */
@property(nonatomic, weak) UILabel *personCountLable;
/** 出发城市Lable */
@property(nonatomic, weak) UILabel *fromCityLable;
/** 结束城市Lable */
@property(nonatomic, weak) UILabel *endCityLable;
/** 订单金额Lable */
@property(nonatomic, weak) UILabel *amountLable;
/** 已支付金额Lable */
@property(nonatomic, weak) UILabel *receiptedLable;
/** 来源车队Lable */
@property(nonatomic, weak) UILabel *companyNameLable;
/** 订单编号Lable */
@property(nonatomic, weak) UILabel *orderNumLable;
/** 未支付余额Lable */
@property(nonatomic, weak) UILabel *balanceLable;
@end

@interface WL_Application_Driver_Bill_Settlement_Cell ()

/** 未支付余额标题Lable */
@property(nonatomic, weak) UILabel *balanceTitleLable;

@end


@implementation WL_Application_Driver_Bill_Settlement_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupContentViewToBillListCell];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


#pragma mark - 设置账单列表内容View
- (void)setupContentViewToBillListCell
{
    //出团日期Lable
    UILabel *toursTimeLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:toursTimeLable];
    //设置属性
    toursTimeLable.text = @"出团日期";
    toursTimeLable.font = WLFontSize(15);
    toursTimeLable.textColor = [WLTools stringToColor:@"#2f2f2f"];
    //添加约束
    [toursTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12.5 * AUTO_IPHONE6_WIDTH_375);
        make.top.equalTo(self.contentView.mas_top).offset(20);
    }];
    
    //出发日期Lable
    UILabel *startTimeLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:startTimeLable];
    //设置属性
    startTimeLable.font = WLFontSize(15);
    startTimeLable.textAlignment = NSTextAlignmentLeft;
    startTimeLable.textColor = [WLTools stringToColor:@"#879efa"];
    //添加约束
    [startTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toursTimeLable.mas_left);
        make.top.equalTo(toursTimeLable.mas_bottom).offset(25);
    }];
    self.startTimeLable = startTimeLable;
    //测试数据
//    startTimeLable.text = @"10月20日";
//    startTimeLable.backgroundColor = [UIColor greenColor];
//
    //结束日期Lable
    UILabel *endTimeLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:endTimeLable];
    //设置属性
    endTimeLable.font = WLFontSize(15);
    endTimeLable.textColor = startTimeLable.textColor;
    endTimeLable.textAlignment = NSTextAlignmentLeft;
    //添加约束
    [endTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startTimeLable.mas_left);
        make.top.equalTo(startTimeLable.mas_bottom).offset(30);
    }];
    self.endTimeLable = endTimeLable;
    //测试数据
//    endTimeLable.text = @"10月20日";
//    endTimeLable.backgroundColor = [UIColor greenColor];
//
    //出团人数Lable
    UILabel *personCountLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:personCountLable];
    //设置属性
    personCountLable.textColor = [WLTools stringToColor:@"#00aaff"];
    personCountLable.font = WLFontSize(15);
    //添加约束
    [personCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toursTimeLable.mas_right).offset(70 * AUTO_IPHONE6_WIDTH_375);
        make.centerY.equalTo(toursTimeLable.mas_centerY);
    }];
    self.personCountLable = personCountLable;
    //测试数据
//    personCountLable.text = @"50人";
//
    //出发地址前小图标
    UIImageView *fromIconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Driver_Bill_FromCity"]];
    //添加到父控件
    [self.contentView addSubview:fromIconImage];
    //添加约束
    [fromIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCountLable.mas_left);
        make.centerY.equalTo(startTimeLable.mas_centerY);
    }];
    
    //出发地址Lable
    UILabel *fromCityLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:fromCityLable];
    //设置属性
    fromCityLable.textColor = toursTimeLable.textColor;
    fromCityLable.font = toursTimeLable.font;
    //添加约束
    [fromCityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fromIconImage.mas_right).offset(5 * AUTO_IPHONE6_WIDTH_375);
        make.centerY.equalTo(fromIconImage.mas_centerY);
    }];
    self.fromCityLable = fromCityLable;
    
    //结束地址前小图标
    UIImageView *endIconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Driver_Bill_EndCity"]];
    //添加到父控件
    [self.contentView addSubview:endIconImage];
    //添加约束
    [endIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personCountLable.mas_left);
        make.centerY.equalTo(endTimeLable.mas_centerY);
    }];
    
    //结束小图标与开始小图标之间的蓝色竖线
    UIView *blueLineView = [[UIView alloc] init];
    //添加到父控件
    [self.contentView addSubview:blueLineView];
    //设置属性
    blueLineView.backgroundColor = [WLTools stringToColor:@"#dcf2fa"];
    //添加约束
    if (IsiPhone6P)
    {
        [blueLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(fromIconImage.mas_bottom).offset(-0.5);
            make.bottom.equalTo(endIconImage.mas_top);
            make.centerX.equalTo(fromIconImage.mas_centerX);
            make.width.equalTo(@3);
        }];
    }
    else
    {
        [blueLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(fromIconImage.mas_bottom).offset(-0.5);
            make.bottom.equalTo(endIconImage.mas_top);
            make.centerX.equalTo(fromIconImage.mas_centerX).offset(0.5);
            make.width.equalTo(@3);
        }];
    }
    
    
    //结束地址Lable
    UILabel *endCityLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:endCityLable];
    //设置属性
    endCityLable.textColor = fromCityLable.textColor;
    endCityLable.font = fromCityLable.font;
    //添加约束
    [endCityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fromCityLable.mas_left);
        make.centerY.equalTo(endIconImage.mas_centerY);
    }];
    self.endCityLable = endCityLable;
    

    
    //订单金额Lable
    UILabel *amountLable = [[UILabel alloc] init];
    [self.contentView addSubview:amountLable];
    //设置属性
    amountLable.font = WLFontSize(15);
    amountLable.textAlignment = NSTextAlignmentRight;
    amountLable.textColor = [WLTools stringToColor:@"#ff5b3d"];
    [amountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5 * AUTO_IPHONE6_WIDTH_375);
        make.centerY.equalTo(fromCityLable.mas_centerY);
    }];
    self.amountLable = amountLable;
    
    
//    //订单金额标题Lable
//    UILabel *amountTitleLable = [[UILabel alloc] init];
//    [self.contentView addSubview:amountTitleLable];
//    //设置属性
//    amountTitleLable.text = @"总额:";
//    amountTitleLable.textColor = [WLTools stringToColor:@"#929fb1"];
//    amountTitleLable.font = WLFontSize(12);
//    [amountTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(amountLable.mas_left).offset(-5);
//        make.centerY.equalTo(amountLable.mas_centerY);
//    }];
    
    //已支付金额Lable
    UILabel *receiptedLable = [[UILabel alloc] init];
    [self.contentView addSubview:receiptedLable];
    //设置属性
    receiptedLable.font = WLFontSize(15);
    receiptedLable.textAlignment = NSTextAlignmentRight;
    receiptedLable.textColor = [WLTools stringToColor:@"#ff5b3d"];
    [receiptedLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5 * AUTO_IPHONE6_WIDTH_375);
        make.centerY.equalTo(endCityLable.mas_centerY);
    }];
    self.receiptedLable = receiptedLable;
    
    //已支付金额标题Lable
    UILabel *receiptedTitleLable = [[UILabel alloc] init];
    [self.contentView addSubview:receiptedTitleLable];
    //设置属性
    receiptedTitleLable.text = @"已支付:";
    receiptedTitleLable.textColor = [WLTools stringToColor:@"#929fb1"];
    receiptedTitleLable.font = WLFontSize(12);
    [receiptedTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(receiptedLable.mas_left).offset(-5);
        make.centerY.equalTo(receiptedLable.mas_centerY);
    }];
    
    //金额标题Lable
    UILabel *moneyTitleLable = [[UILabel alloc] init];
    //添加到父控件
    [self.contentView addSubview:moneyTitleLable];
    //设置属性
    moneyTitleLable.font = toursTimeLable.font;
    moneyTitleLable.textColor = toursTimeLable.textColor;
    moneyTitleLable.textAlignment = NSTextAlignmentRight;
    moneyTitleLable.text = @"实际金额";
    //添加约束
    [moneyTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-14 * AUTO_IPHONE6_WIDTH_375);
        make.centerY.equalTo(toursTimeLable.mas_centerY);
    }];

    //画虚线
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(10 * AUTO_IPHONE6_WIDTH_375, 136, ScreenWidth, 2)];
    lineImage.image = [self drawLineByImageView:lineImage];
    [self.contentView addSubview:lineImage];
    
    //来源车队Lable
    UILabel *companyNameLable = [[UILabel alloc] init];
    [self.contentView addSubview:companyNameLable];
    //设置属性
    companyNameLable.textColor = [WLTools stringToColor:@"#B5B5B5"];
    companyNameLable.font = WLFontSize(13);
    companyNameLable.textAlignment = NSTextAlignmentLeft;
    //添加约束
    [companyNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toursTimeLable.mas_left);
        make.top.equalTo(lineImage.mas_bottom).offset(13);
    }];
    self.companyNameLable = companyNameLable;

    
    //订单编号Lable
    UILabel *orderNumLable = [[UILabel alloc] init];
    [self.contentView addSubview:orderNumLable];
    //设置属性
    orderNumLable.textColor = [WLTools stringToColor:@"#B5B5B5"];
    orderNumLable.font = WLFontSize(13);
    orderNumLable.textAlignment = NSTextAlignmentLeft;
    //添加约束
    [orderNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toursTimeLable.mas_left);
        make.top.equalTo(companyNameLable.mas_bottom).offset(19);
    }];
    self.orderNumLable = orderNumLable;
    
    //未支付余额Lable
    UILabel *balanceLable = [[UILabel alloc] init];
    [self.contentView addSubview:balanceLable];
    //设置属性
    balanceLable.textAlignment = NSTextAlignmentRight;
    balanceLable.font = WLFontSize(20);
    balanceLable.textColor = receiptedLable.textColor;
    //添加约束
    [balanceLable mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.right.equalTo(receiptedLable.mas_right);
        make.centerY.equalTo(companyNameLable.mas_centerY);
    }];
    self.balanceLable = balanceLable;
    
    //未支付余额标题Lable
    UILabel *balanceTitleLable = [[UILabel alloc] init];
    [self.contentView addSubview:balanceTitleLable];
    //设置属性
    balanceTitleLable.textAlignment = NSTextAlignmentRight;
    balanceTitleLable.font = WLFontSize(12);
    balanceTitleLable.textColor = receiptedTitleLable.textColor;
    //添加约束
    [balanceTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(balanceLable.mas_left).offset(-5);
        make.centerY.equalTo(companyNameLable.mas_centerY);
    }];
    balanceTitleLable.text = @"待支付:";
    self.balanceTitleLable = balanceTitleLable;
    
    //已结清图片
    UIImageView *settlementOrderImageView = [[UIImageView alloc] init];
    //添加到父控件
    [self.contentView addSubview:settlementOrderImageView];
    //设置属性
    settlementOrderImageView.image = [UIImage imageNamed:@"Driver_Order_Settle"];
    //添加约束
    [settlementOrderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        make.top.equalTo(lineImage.mas_bottom);
    }];
    settlementOrderImageView.hidden = YES;
    self.settlementOrderImageView = settlementOrderImageView;


}



#pragma mark - 画曲线
- (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度  1是高度
    CGFloat lengths[] = {4,3};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [WLTools stringToColor:@"#d8d9dd"].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0);    //开始画线
    CGContextAddLineToPoint(line, ScreenWidth - 10, 2.0);
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}


- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 17;
//    frame.origin.y += 17;
    [super setFrame:frame];
}

- (void)setBillModel:(WL_Application_Driver_Bill_Model *)billModel
{
    _billModel = billModel;
    //赋值
    //出发时间
    NSString *departureTimeToMon = [billModel.start_time substringWithRange:NSMakeRange(5, 2)];
    NSString *departureTimeToDay = [billModel.start_time substringWithRange:NSMakeRange(8, 2)];
    self.startTimeLable.text = [NSString stringWithFormat:@"%@月%@日", departureTimeToMon, departureTimeToDay];
    //结束时间
    NSString *endTimeToMon = [billModel.end_time substringWithRange:NSMakeRange(5, 2)];
    NSString *endTimeToDay = [billModel.end_time substringWithRange:NSMakeRange(8, 2)];
    self.endTimeLable.text = [NSString stringWithFormat:@"%@月%@日", endTimeToMon, endTimeToDay];
    //出团人数
    self.personCountLable.text = [NSString stringWithFormat:@"%@座", billModel.persons_count];
    //出发城市
    self.fromCityLable.text = billModel.start_name;
    //结束城市
    self.endCityLable.text = billModel.end_name;
    //实际金额
    NSString *amountStr;
    if ([billModel.amount containsString:@"."])
    {
        NSRange pointRange = [billModel.actual_amount rangeOfString:@"."];
        amountStr = [billModel.actual_amount substringToIndex:pointRange.location];
    }
    else
    {
        amountStr = billModel.actual_amount;
    }
    switch (amountStr.integerValue) {
        case 0:
            self.amountLable.text = @"待导游记账";
            self.amountLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
            break;
            
        default:
            self.amountLable.text = [NSString stringWithFormat:@"¥%@", amountStr];
            self.amountLable.textColor = [WLTools stringToColor:@"#ff5555"];
            break;
    }

    //已支付金额
    NSString *receiptedAmount;
    if ([billModel.receipted_amount containsString:@"."])
    {
        NSRange pointRange = [billModel.receipted_amount rangeOfString:@"."];
        receiptedAmount = [billModel.receipted_amount substringToIndex:pointRange.location];
    }
    else
    {
        receiptedAmount = billModel.receipted_amount;
    }
    
    self.receiptedLable.text = [NSString stringWithFormat:@"¥%@", receiptedAmount];;
    
    if (billModel.actual_amount.integerValue == 0)
    {
        self.balanceLable.text = @"待导游记账";
        self.balanceLable.textColor = [WLTools stringToColor:@"#b5b5b5"];
        self.balanceLable.font = WLFontSize(14);
    }
    else
    {
        //未支付余额Lable
        NSInteger nonPayment = [billModel.actual_amount integerValue] - [billModel.receipted_amount integerValue];
        self.balanceLable.text = [NSString stringWithFormat:@"¥%zd", nonPayment];
    }
    
    
    
    

    
    
    
    //来源车队
    self.companyNameLable.text = [NSString stringWithFormat:@"来源车队: %@", billModel.company_name];
    //订单编号
    self.orderNumLable.text = [NSString stringWithFormat:@"订单编号: %@", billModel.order_number];
    
    
    
    

        

   

}

@end
