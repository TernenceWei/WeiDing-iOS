//
//  WLIncomeCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLIncomeCell.h"

#define cellIdentifier @"WLIncomeCell"

@interface WLIncomeCell ()
@property (nonatomic, strong) UILabel *checkPriceLabel;
@property (nonatomic, strong) UIButton *statusBtn;
@end

@implementation WLIncomeCell
+ (WLIncomeCell *)cellWithTableView:(UITableView*)tableView withIndex:(NSUInteger)index{
    WLIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLIncomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.tag = index;
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

    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(15))];
    topView.backgroundColor = HEXCOLOR(0xeff1fe);
    [self addSubview:topView];
    
    CGFloat beginY = ScaleH(15);
    if (self.tag == 0) {
        topView.hidden = YES;
        beginY = 0;
    }

    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.frame = CGRectMake(ScaleW(12) , beginY, ScreenWidth - 2 * ScaleW(12), ScaleH(30));
    detailLabel.text = self.orderInfo.lineName;
    detailLabel.textColor =HEXCOLOR(0x2f2f2f);
    detailLabel.font = [UIFont WLFontOfSize:14];
    [self addSubview:detailLabel];
    
    UIButton *guideCountBtn = [[UIButton alloc] init];
    NSString *guideCountText = [NSString stringWithFormat:@"%@导",self.orderInfo.guideNums];
    [guideCountBtn setTitle:guideCountText forState:UIControlStateNormal];
    [guideCountBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
    [guideCountBtn setBackgroundImage:[UIImage imageNamed:@"allGroup_guideNum_bg"] forState:UIControlStateNormal];
    guideCountBtn.frame = CGRectMake(ScaleW(12) , CGRectGetMaxY(detailLabel.frame) + ScaleH(5), [self sizeWithString:guideCountText font:[UIFont WLFontOfSize:14]].width + 8, ScaleH(20));
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
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.frame = CGRectMake(ScreenWidth - ScaleW(29) - ScreenWidth / 3 , CGRectGetMaxY(detailLabel.frame), ScreenWidth / 3, ScaleH(30));
    priceLabel.text = [NSString stringWithFormat:@"¥%@",self.orderInfo.income];
    priceLabel.textColor =HEXCOLOR(0xff3d5b);
    priceLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:priceLabel];
    
    UILabel *checkPriceLabel = [[UILabel alloc] init];
    checkPriceLabel.textAlignment = NSTextAlignmentLeft;
    checkPriceLabel.frame = CGRectMake(ScaleW(12) , CGRectGetMaxY(guideCountBtn.frame) + ScaleH(5), ScreenWidth / 3, ScaleH(30));
    checkPriceLabel.text = [NSString stringWithFormat:@"导服费：¥%@",self.orderInfo.checkPrice];
    checkPriceLabel.textColor =HEXCOLOR(0x929fb1);
    checkPriceLabel.font = [UIFont WLFontOfSize:13];
    [self addSubview:checkPriceLabel];
    
    UILabel *shopLabel = [[UILabel alloc] init];
    shopLabel.textAlignment = NSTextAlignmentLeft;
    shopLabel.frame = CGRectMake(CGRectGetMaxX(checkPriceLabel.frame) , CGRectGetMaxY(guideCountBtn.frame) + ScaleH(5), ScreenWidth / 3, ScaleH(30));
    shopLabel.text = [NSString stringWithFormat:@"购物返现：¥%@",self.orderInfo.shoppingRebate];
    shopLabel.textColor =HEXCOLOR(0x929fb1);
    shopLabel.font = [UIFont WLFontOfSize:13];
    [self addSubview:shopLabel];
    
    UILabel *addLabel = [[UILabel alloc] init];
    addLabel.textAlignment = NSTextAlignmentLeft;
    addLabel.frame = CGRectMake(CGRectGetMaxX(shopLabel.frame) , CGRectGetMaxY(guideCountBtn.frame) + ScaleH(5), ScreenWidth / 3, ScaleH(30));
    addLabel.text = [NSString stringWithFormat:@"加点返现：¥%@",self.orderInfo.additionalRebate];
    addLabel.textColor =HEXCOLOR(0x929fb1);
    addLabel.font = [UIFont WLFontOfSize:13];
    [self addSubview:addLabel];
    
    
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setTitle:[self getGroupTimeTextWithString:self.orderInfo.receiveDate] forState:UIControlStateNormal];
    [startBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
    [startBtn setImage:[UIImage imageNamed:@"allGroup_start_icon"] forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(ScaleW(12) , CGRectGetMaxY(checkPriceLabel.frame) + ScaleH(5), ScaleW(100), ScaleH(30));
    startBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(6), 0, 0);
    startBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:startBtn];
    
    UIButton *endBtn = [[UIButton alloc] init];
    [endBtn setTitle:[self getGroupTimeTextWithString:self.orderInfo.sendDate] forState:UIControlStateNormal];
    [endBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
    [endBtn setImage:[UIImage imageNamed:@"allGroup_end_icon"] forState:UIControlStateNormal];
    endBtn.frame = CGRectMake(CGRectGetMaxX(startBtn.frame) + ScaleW(35) , CGRectGetMaxY(checkPriceLabel.frame) + ScaleH(5), ScaleW(100), ScaleH(30));
    endBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    endBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(6), 0, 0);
    endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:endBtn];
    
    UILabel *peopleLabel = [[UILabel alloc] init];
    peopleLabel.textAlignment = NSTextAlignmentRight;
    peopleLabel.frame = CGRectMake(ScreenWidth - ScaleW(116) , CGRectGetMaxY(checkPriceLabel.frame) + ScaleH(5), ScaleW(100), ScaleH(30));
    peopleLabel.text = [NSString stringWithFormat:@"%@人",self.orderInfo.adults];
    peopleLabel.textColor =HEXCOLOR(0xff3b5b);
    peopleLabel.font = [UIFont WLFontOfSize:15];
    [self addSubview:peopleLabel];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), CGRectGetMaxY(startBtn.frame) + ScaleH(10) , ScreenWidth - 2 * ScaleW(12), 2)];
    lineImage.image = [self drawLineByImageView:lineImage];
    [self addSubview:lineImage];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.frame = CGRectMake(ScaleW(12) , CGRectGetMaxY(lineImage.frame) + ScaleH(10), ScreenWidth - 2 * ScaleW(12), ScaleH(30));
    timeLabel.text = [self getTimeText];
    timeLabel.textColor =HEXCOLOR(0xb5b5b5);
    timeLabel.font = [UIFont WLFontOfSize:14];
    [self addSubview:timeLabel];
    
    CGFloat height = ScaleH(215);
    if (topView.hidden) {
        height = ScaleH(200);
    }
    UIImageView *mainView = [[UIImageView alloc] init];
    if (self.orderInfo.mainGuide.boolValue) {
        mainView.image = [UIImage imageNamed:@"allGroup_mainGuide_yes"];
    }else{
        mainView.image = [UIImage imageNamed:@"allGroup_mainGuide_no"];
    }
    
    mainView.frame = CGRectMake(ScreenWidth - ScaleW(30), height - ScaleW(30), ScaleW(30), ScaleW(30));
    [self addSubview:mainView];

    
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
