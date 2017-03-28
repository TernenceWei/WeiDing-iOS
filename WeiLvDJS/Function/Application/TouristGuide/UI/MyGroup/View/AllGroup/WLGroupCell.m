//
//  WLGroupCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGroupCell.h"
#import "UIFont+WL.h"

#define cellIdentifier @"WLGroupCell"

@interface WLGroupCell ()
@property (nonatomic, strong) UILabel *checkPriceLabel;
@property (nonatomic, strong) UIButton *statusBtn;
@end

@implementation WLGroupCell
+ (WLGroupCell *)cellWithTableView:(UITableView*)tableView{
    WLGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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

- (void)setOrderInfo:(WLOrderListInfo *)orderInfo
{
    _orderInfo = orderInfo;
    [self setupUI];
}

- (NSString *)getGroupStatusIconImage
{
    GroupStatus status = self.orderInfo.groupListStatus;
    NSString *imageName = @"allGroup_status_unChuTuan";
    if (status == GroupStatusShenHeFailure ) {
        imageName = @"allGroup_status_shenHeShiBai";
    }else if (status == GroupStatusUnShenHe){
        imageName = @"allGroup_status_shenHeZhong";
    }else if (status == GroupStatusUnBaoZhang){
        imageName = @"allGroup_status_unBaoZhang";
    }else if (status == GroupStatusUnJieZhang){
        imageName = @"allGroup_status_weiJieZhang";
    }else if (status == GroupStatusJieZhang){
        imageName = @"allGroup_status_yiJieZhang";
    }else if (status == GroupStatusYiShenHe){
        imageName = @"allGroup_status_yiShenHe";
    }
    return imageName;
}

- (NSString *)getGroupStatusIconTitle
{
    GroupStatus status = self.orderInfo.groupListStatus;
    NSString *imageName = @"未出团";
    if (status == GroupStatusShenHeFailure ) {
        imageName = @"审核失败";
    }else if (status == GroupStatusUnShenHe){
        imageName = @"未审核";
    }else if (status == GroupStatusUnBaoZhang){
        imageName = @"未报账";
    }else if (status == GroupStatusUnJieZhang){
        imageName = @"未结账";
    }else if (status == GroupStatusJieZhang){
        imageName = @"已结账";
    }else if (status == GroupStatusYiShenHe){
        imageName = @"已审核";
    }
    return imageName;
}

- (NSString *)getGroupStatusTimeTextWithTimeString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSInteger year = [dateComps year];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    NSInteger hour = [dateComps hour];
    NSInteger minute = [dateComps minute];
    return [NSString stringWithFormat:@"%ld.%ld.%ld  %ld:%ld",year, month,day,hour,minute];
}

- (NSString *)getTimeText
{
    GroupStatus status = self.orderInfo.groupListStatus;
    NSString *imageName = [NSString stringWithFormat:@"接单时间：%@",[self getGroupStatusTimeTextWithTimeString:self.orderInfo.receiveDate]];
    if (status == GroupStatusShenHeFailure ) {
        imageName = [NSString stringWithFormat:@"审核时间：%@",[self getGroupStatusTimeTextWithTimeString:self.orderInfo.auditDate]];
    }else if (status == GroupStatusUnShenHe){
        imageName = [NSString stringWithFormat:@"提交时间：%@",[self getGroupStatusTimeTextWithTimeString:self.orderInfo.submitDate]];
    }else if (status == GroupStatusUnBaoZhang){
        imageName = [NSString stringWithFormat:@"下团时间：%@",[self getGroupStatusTimeTextWithTimeString:self.orderInfo.endDate]];
    }else if (status == GroupStatusUnJieZhang){
        imageName = [NSString stringWithFormat:@"审核时间：%@",[self getGroupStatusTimeTextWithTimeString:self.orderInfo.auditDate]];
    }else if (status == GroupStatusJieZhang){
        imageName = [NSString stringWithFormat:@"结算时间：%@",[self getGroupStatusTimeTextWithTimeString:self.orderInfo.settlementDate]];
    }else if (status == GroupStatusYiShenHe){
        imageName = [NSString stringWithFormat:@"审核时间：%@",[self getGroupStatusTimeTextWithTimeString:self.orderInfo.auditDate]];
    }
    return imageName;
}

- (void)setupUI{
    
    if (self.orderInfo == nil) {
        return;
    }
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    self.statusBtn = [[UIButton alloc] init];
    [self.statusBtn setTitle:[self getGroupStatusIconTitle] forState:UIControlStateNormal];
    [self.statusBtn setTitleColor:HEXCOLOR(0x2f2f2f) forState:UIControlStateNormal];
    [self.statusBtn setImage:[UIImage imageNamed:[self getGroupStatusIconImage]] forState:UIControlStateNormal];
    self.statusBtn.frame = CGRectMake(ScaleW(13) , ScaleH(15), ScaleW(120), ScaleH(40));
    self.statusBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    self.statusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(13), 0, 0);
    self.statusBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:self.statusBtn];
    
    self.checkPriceLabel = [[UILabel alloc] init];
    self.checkPriceLabel.textAlignment = NSTextAlignmentRight;
    self.checkPriceLabel.frame = CGRectMake(ScreenWidth - ScaleW((180 + 12)) , ScaleH(15), ScaleW(180), ScaleH(40));
    self.checkPriceLabel.attributedText = [self getCheckPriceText];
    [self addSubview:self.checkPriceLabel];
    
    
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setTitle:[self getGroupTimeTextWithString:self.orderInfo.receiveDate] forState:UIControlStateNormal];
    [startBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
    [startBtn setImage:[UIImage imageNamed:@"allGroup_start_icon"] forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(ScaleW(18) , CGRectGetMaxY(self.statusBtn.frame) + ScaleH(5), ScaleW(100), ScaleH(30));
    startBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(6), 0, 0);
    startBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:startBtn];
    
    UIButton *endBtn = [[UIButton alloc] init];
    [endBtn setTitle:[self getGroupTimeTextWithString:self.orderInfo.sendDate] forState:UIControlStateNormal];
    [endBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
    [endBtn setImage:[UIImage imageNamed:@"allGroup_end_icon"] forState:UIControlStateNormal];
    endBtn.frame = CGRectMake(CGRectGetMaxX(startBtn.frame) + ScaleW(35) , CGRectGetMaxY(self.statusBtn.frame) + ScaleH(5), ScaleW(100), ScaleH(30));
    endBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    endBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(6), 0, 0);
    endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:endBtn];
    
    UILabel *peopleLabel = [[UILabel alloc] init];
    peopleLabel.textAlignment = NSTextAlignmentRight;
    peopleLabel.frame = CGRectMake(ScreenWidth - ScaleW(116) , CGRectGetMaxY(self.statusBtn.frame) + ScaleH(5), ScaleW(100), ScaleH(30));
    peopleLabel.text = [NSString stringWithFormat:@"%ld人",(self.orderInfo.adults.integerValue + self.orderInfo.children.integerValue)];
    peopleLabel.textColor =HEXCOLOR(0xff3b5b);
    peopleLabel.font = [UIFont WLFontOfSize:15];
    [self addSubview:peopleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.frame = CGRectMake(ScaleW(18) , CGRectGetMaxY(startBtn.frame) + ScaleH(2), ScreenWidth - 2 * ScaleW(18), ScaleH(30));
    detailLabel.text = self.orderInfo.lineName;
    detailLabel.textColor =HEXCOLOR(0x868686);
    detailLabel.font = [UIFont WLFontOfSize:14];
    [self addSubview:detailLabel];
    
    UIButton *guideCountBtn = [[UIButton alloc] init];
    NSString *guideCountText = [NSString stringWithFormat:@"%@导",self.orderInfo.guideNums];
    [guideCountBtn setTitle:guideCountText forState:UIControlStateNormal];
    [guideCountBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
    [guideCountBtn setBackgroundImage:[UIImage imageNamed:@"allGroup_guideNum_bg"] forState:UIControlStateNormal];
    guideCountBtn.frame = CGRectMake(ScaleW(18) , CGRectGetMaxY(detailLabel.frame) + ScaleH(5), [self sizeWithString:guideCountText font:[UIFont WLFontOfSize:14]].width + 8, ScaleH(20));
    guideCountBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    guideCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:guideCountBtn];
    
    UIButton *rebateBtn = [[UIButton alloc] init];
    [rebateBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
    [rebateBtn setBackgroundImage:[UIImage imageNamed:@"allGroup_rebate_bg"] forState:UIControlStateNormal];
    NSString *rebateText = [self getRebateText];
    rebateBtn.frame = CGRectMake(CGRectGetMaxX(guideCountBtn.frame) + ScaleW(10) , CGRectGetMaxY(detailLabel.frame) + ScaleH(5), [self sizeWithString:rebateText font:[UIFont WLFontOfSize:14]].width + 8, ScaleH(20));
    rebateBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    rebateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:rebateBtn];
    
    if (rebateText == nil) {
        rebateBtn.hidden = YES;
    }else{
        rebateBtn.hidden = NO;
        [rebateBtn setTitle:rebateText forState:UIControlStateNormal];
    }
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(18), CGRectGetMaxY(rebateBtn.frame) + ScaleH(10) , ScreenWidth - 2 * ScaleW(18), 2)];
    lineImage.image = [self drawLineByImageView:lineImage];
    [self addSubview:lineImage];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.frame = CGRectMake(ScaleW(18) , CGRectGetMaxY(guideCountBtn.frame) + ScaleH(15), ScreenWidth - 2 * ScaleW(18), ScaleH(30));
    timeLabel.text = [self getTimeText];
    timeLabel.textColor =HEXCOLOR(0xb5b5b5);
    timeLabel.font = [UIFont WLFontOfSize:14];
    [self addSubview:timeLabel];
    
    UIImageView *mainView = [[UIImageView alloc] init];
    mainView.image = [UIImage imageNamed:@"allGroup_mainGuide_yes"];
    mainView.frame = CGRectMake(ScreenWidth - ScaleW(30), ScaleH(218) - ScaleW(30), ScaleW(30), ScaleW(30));
    [self addSubview:mainView];
    
    UIImageView *failureView = [[UIImageView alloc] init];
    failureView.image = [UIImage imageNamed:@"allGroup_shenHeFailure_icon"];
    failureView.frame = CGRectMake(ScreenWidth - ScaleW((66 + 40)), ScaleH(218) - ScaleW(39) - ScaleH(5), ScaleW(66), ScaleW(39));
    [self addSubview:failureView];
    failureView.hidden = !(self.orderInfo.groupListStatus == GroupStatusShenHeFailure);
    
    
}

- (CGSize)sizeWithString:(NSString*)title font:(UIFont*)font
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [title sizeWithAttributes:attrs];
}

- (NSString *)getRebateText
{
    if(![self.orderInfo.minRate isEqualToString:@"0"] && ![self.orderInfo.maxRate isEqualToString:@"0"]){
        return [NSString stringWithFormat:@"购返:%@--%@",self.orderInfo.minRate,self.orderInfo.maxRate];
    }else if([self.orderInfo.minRate isEqualToString:@"0"] && ![self.orderInfo.maxRate isEqualToString:@"0"]){
        return [NSString stringWithFormat:@"购返:%@",self.orderInfo.maxRate];
    }else if(![self.orderInfo.minRate isEqualToString:@"0"] && [self.orderInfo.maxRate isEqualToString:@"0"]){
        return [NSString stringWithFormat:@"购返:%@",self.orderInfo.minRate];
    }
    return nil;
}

- (NSString *)getGroupTimeTextWithString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
   
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    return [NSString stringWithFormat:@"%ld月%ld日",month,day];
    
}

- (NSAttributedString *)getCheckPriceText
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = HEXCOLOR(0xff3b5b);
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"¥" attributes:attrs];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string1];
    
    NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
    attrs2[NSForegroundColorAttributeName] = HEXCOLOR(0xff3b5b);
    attrs2[NSFontAttributeName] = [UIFont WLFontOfSize:20];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:self.orderInfo.checkPrice attributes:attrs2];
    [mutableString  appendAttributedString:string2];
    
    NSMutableDictionary *attrs3 = [NSMutableDictionary dictionary];
    attrs3[NSForegroundColorAttributeName] = HEXCOLOR(0x929fb1);
    attrs3[NSFontAttributeName] = [UIFont WLFontOfSize:13];
    NSAttributedString *string3 = [[NSAttributedString alloc] initWithString:@"（导服费）" attributes:attrs3];
    [mutableString  appendAttributedString:string3];
    
    return mutableString;
    
}

- (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度  1是高度
    CGFloat lengths[] = {9,6};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [WLTools stringToColor:@"#d8d9dd"].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0);    //开始画线
    CGContextAddLineToPoint(line, ScreenWidth - 10, 2.0);
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}
@end
