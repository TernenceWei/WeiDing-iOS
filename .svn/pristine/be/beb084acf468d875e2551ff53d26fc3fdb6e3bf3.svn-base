//
//  WLGroupSummaryView.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGroupSummaryView.h"
#import "WLUITool.h"

@interface WLPeopleButton ()
@property (nonatomic, copy) void(^OnSelectAction)(NSUInteger tag);
@end

@implementation WLPeopleButton

- (instancetype)initWithFrame:(CGRect)frame
                     nameText:(NSString *)nameText
                     roleText:(NSString *)roleText
                          tag:(NSUInteger)tag
                 selectAction:(void(^)(NSUInteger tag))action
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = ScaleW(40);
        UIButton *topBtn = [[UIButton alloc] init];
        [topBtn setTitle:nameText forState:UIControlStateNormal];
        [topBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [topBtn setBackgroundImage:[UIImage imageWithColor:[self getBgColorWithIndex:tag]] forState:UIControlStateNormal];
        topBtn.frame = CGRectMake((frame.size.width - width) / 2, ScaleH(5), width, width);
        topBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [topBtn addTarget:self action:@selector(titleBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        topBtn.titleLabel.font = [UIFont WLFontOfSize:11];
        [self addSubview:topBtn];
        topBtn.layer.cornerRadius = width / 2;
        topBtn.layer.masksToBounds = YES;
        
        UIButton *titleBtn = [[UIButton alloc] init];
        [titleBtn setTitle:roleText forState:UIControlStateNormal];
        [titleBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
        titleBtn.frame = CGRectMake(0, CGRectGetMaxY(topBtn.frame) + ScaleH(5), frame.size.width, ScaleH(20));
        titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [titleBtn addTarget:self action:@selector(titleBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.titleLabel.font = [UIFont WLFontOfSize:12];
        [self addSubview:titleBtn];
        
        topBtn.tag = tag;
        titleBtn.tag = tag;
        
        self.OnSelectAction = action;
        
        
    }
    return self;
}

- (void)titleBtnDidClicked:(UIButton *)button
{
    self.OnSelectAction(button.tag);
}

- (UIColor *)getBgColorWithIndex:(NSUInteger)index
{
    UIColor *color = HEXCOLOR(0xfe798c);
    NSUInteger temp = index % 6;
    if (temp == 1) {
        color = HEXCOLOR(0x69c95f);
    }else if (temp == 2){
        color = HEXCOLOR(0x879efa);
    }else if (temp == 3){
        color = HEXCOLOR(0xc670db);
    }else if (temp == 4){
        color = HEXCOLOR(0xff7e44);
    }else if (temp == 5){
        color = HEXCOLOR(0x4499ff);
    }
    return color;
}

@end

@interface WLGroupSummaryView ()
@property (nonatomic, strong) UIButton *touristInfoBtn;
@property (nonatomic, copy) void (^onTouristInfoClickBlock)();
@property (nonatomic, copy) void (^onPeopleInfoClickBlock)(NSUInteger tag);
@end

@implementation WLGroupSummaryView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setSummaryInfo:(WLChargeUpSummaryInfo *)summaryInfo
{
    _summaryInfo = summaryInfo;
    [self setupUI];
}

- (void)setupUI
{
    if (self.summaryInfo == nil) {
        return;
    }
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = HEXCOLOR(0x879efa);
    topView.frame = CGRectMake(0, 0, ScreenWidth, ScaleH(175));
    [self addSubview:topView];

    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(ScaleW(10), ScaleH(8), ScreenWidth - 2 * ScaleW(10), topView.bounds.size.height - 2 * ScaleH(8));
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.layer.masksToBounds = YES;
    [topView addSubview:bgView];
    
    CGFloat circleRadius = ScaleW(8);
    CGFloat bgWidth = bgView.bounds.size.width;
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(circleRadius, ScaleH(44) , bgWidth - 2 * circleRadius, 2)];
    lineImage.image = [self drawLineByImageView:lineImage];
    [bgView addSubview:lineImage];
    
    UIImageView *leftCircle = [[UIImageView alloc] initWithFrame:CGRectMake(-circleRadius, ScaleH(44) - circleRadius , 2 * circleRadius, 2 * circleRadius)];
    leftCircle.image = [self drawCircleByImageView:leftCircle];
    [bgView addSubview:leftCircle];
    
    UIImageView *rightCircle = [[UIImageView alloc] initWithFrame:CGRectMake(bgWidth - circleRadius, ScaleH(44) - circleRadius , 2 * circleRadius, 2 * circleRadius)];
    rightCircle.image = [self drawCircleByImageView:rightCircle];
    [bgView addSubview:rightCircle];
    
    
    UILabel *groupNOLabel = [[UILabel alloc] init];
    groupNOLabel.textAlignment = NSTextAlignmentLeft;
    groupNOLabel.text = [NSString stringWithFormat:@"成团单号:%@",self.summaryInfo.groupNO];
    groupNOLabel.font = [UIFont WLFontOfSize:14];
    groupNOLabel.frame = CGRectMake(ScaleW(10) , 0, [WLUITool sizeWithString:groupNOLabel.text font:groupNOLabel.font].width, ScaleH(44));
    groupNOLabel.textColor =HEXCOLOR(0x2f2f2f);
    [bgView addSubview:groupNOLabel];
    
    UIButton *guideCountBtn = [[UIButton alloc] init];
    NSString *guideCountText = [NSString stringWithFormat:@"%@导",self.summaryInfo.guideNums];
    [guideCountBtn setTitle:guideCountText forState:UIControlStateNormal];
    [guideCountBtn setTitleColor:HEXCOLOR(0x4499ff) forState:UIControlStateNormal];
    [guideCountBtn setBackgroundImage:[UIImage imageNamed:@"allGroup_guideNum_bg"] forState:UIControlStateNormal];
    guideCountBtn.frame = CGRectMake(ScaleW(6) + CGRectGetMaxX(groupNOLabel.frame), groupNOLabel.center.y - ScaleH(10), [WLUITool sizeWithString:guideCountText font:[UIFont WLFontOfSize:12]].width + 8, ScaleH(20));
    guideCountBtn.titleLabel.font = [UIFont WLFontOfSize:12];
    guideCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [bgView addSubview:guideCountBtn];
    
    UIButton *typeBtn = [[UIButton alloc] init];
    NSString *rebateText = @"散客";
    if ([self.summaryInfo.type isEqualToString:@"1"]) {
        rebateText = @"定制";
    }
    [typeBtn setTitle:rebateText forState:UIControlStateNormal];
    [typeBtn setTitleColor:HEXCOLOR(0x929fb1) forState:UIControlStateNormal];
    [typeBtn setBackgroundImage:[UIImage imageNamed:@"allGroup_rebate_bg"] forState:UIControlStateNormal];
    typeBtn.titleLabel.font = [UIFont WLFontOfSize:12];
    typeBtn.frame = CGRectMake(CGRectGetMaxX(guideCountBtn.frame) + ScaleW(10) , guideCountBtn.center.y - ScaleH(10), [WLUITool sizeWithString:rebateText font:typeBtn.titleLabel.font].width + 15, ScaleH(20));
    typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [bgView addSubview:typeBtn];
    
    UIButton *mainBtn = [[UIButton alloc] init];
    [mainBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    [mainBtn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x4499ff)] forState:UIControlStateNormal];
    mainBtn.frame = CGRectMake(bgWidth - ScaleW(38) , ScaleH(5), ScaleW(30), ScaleW(30));
    mainBtn.titleLabel.font = [UIFont WLFontOfSize:13];
    NSString *mainTitle = @"副";
    if ([self.summaryInfo.isMainGuide isEqualToString:@"1"]) {
        mainTitle = @"主";
    }
    [mainBtn setTitle:mainTitle forState:UIControlStateNormal];
    mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    mainBtn.layer.cornerRadius = ScaleW(15);
    mainBtn.layer.masksToBounds = YES;
    [bgView addSubview:mainBtn];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.frame = CGRectMake(ScaleW(13) , ScaleH((44)), bgWidth - 2 * ScaleW(13), ScaleH(60));
    detailLabel.text = self.summaryInfo.lineName;
    detailLabel.textColor =HEXCOLOR(0x868686);
    detailLabel.font = [UIFont WLFontOfSize:14];
    detailLabel.numberOfLines = 2;
    [bgView addSubview:detailLabel];
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:detailLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [detailLabel.text length])];
    detailLabel.attributedText = attributedString;
    
    CGFloat timeY = CGRectGetMaxY(detailLabel.frame) + ScaleH(10);
    UIButton *timeBtn = [[UIButton alloc] init];
    NSString *timeText = [[self getScheduleTextWithTimeString:self.summaryInfo.receiveDate] stringByAppendingFormat:@" -- %@",[self getScheduleTextWithTimeString:self.summaryInfo.sendDate]];
    [timeBtn setTitle:timeText forState:UIControlStateNormal];
    [timeBtn setTitleColor:HEXCOLOR(0x879efa) forState:UIControlStateNormal];
    [timeBtn setImage:[UIImage imageNamed:@"group_top_time"] forState:UIControlStateNormal];
    timeBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    timeBtn.frame = CGRectMake(ScaleW(13) , timeY, [WLUITool sizeWithString:timeText font:timeBtn.titleLabel.font].width +    ScaleW(40), ScaleH(30));
    timeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(6), 0, 0);
    timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bgView addSubview:timeBtn];
    
    UILabel *peopleLabel = [[UILabel alloc] init];
    peopleLabel.textAlignment = NSTextAlignmentRight;
    peopleLabel.frame = CGRectMake(CGRectGetMaxX(timeBtn.frame) + ScaleW(16) , timeY, ScaleW(40), ScaleH(30));
    peopleLabel.text = [NSString stringWithFormat:@"%@人",self.summaryInfo.peopleCount];
    peopleLabel.textColor =HEXCOLOR(0x879efa);
    peopleLabel.font = [UIFont WLFontOfSize:15];
    [bgView addSubview:peopleLabel];
    
    self.touristInfoBtn = [[UIButton alloc] init];
    [self.touristInfoBtn setTitleColor:HEXCOLOR(0x879efa) forState:UIControlStateNormal];
    self.touristInfoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.touristInfoBtn setExclusiveTouch:YES];
    [self.touristInfoBtn setTitle:@"游客资料" forState:UIControlStateNormal];
    self.touristInfoBtn.frame = CGRectMake(bgWidth - ScaleW(100), timeY, ScaleW(80), ScaleH(30));
    [self.touristInfoBtn addTarget:self action:@selector(touristInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.touristInfoBtn];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(topView.frame), ScreenWidth, ScaleH(200));
    [self addSubview:bottomView];
    
    UIButton *titleBtn = [[UIButton alloc] init];
    [titleBtn setTitle:@"相关人员" forState:UIControlStateNormal];
    [titleBtn setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"group_nameCard_top_icon"] forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(ScaleW(12) , ScaleH(8), ScaleW(150), ScaleH(30));
    titleBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(5), 0, 0);
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bottomView addSubview:titleBtn];
    
    NSUInteger count = self.summaryInfo.nameCardList.count;
    for (int i = 0; i < count; i++) {
        CGFloat width = ScreenWidth / 4;
        CGFloat height = ScaleH(70);
        CGFloat x = width * (i % 4);
        CGFloat y = height * (i / 4) + ScaleH(40);
        WLChargeUpNameCardObject *object = self.summaryInfo.nameCardList[i];
        WLPeopleButton *button = [[WLPeopleButton alloc] initWithFrame:CGRectMake(x, y, width, height) nameText:object.name roleText:object.roleName tag:i selectAction:^(NSUInteger tag) {
            self.onPeopleInfoClickBlock(tag);
        }];
        [bottomView addSubview:button];
    }
    
    self.clipsToBounds = YES;
}

- (NSString *)getScheduleTextWithTimeString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:  NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    return [NSString stringWithFormat:@"%ld.%ld", month,day];
 
}



- (void)touristInfoBtnClick
{
    self.onTouristInfoClickBlock();
}

- (void)setTouristInfoClickBlock:(void (^)())block
{
    self.onTouristInfoClickBlock = block;
}

- (void)setPeopleInfoClickBlock:(void (^)(NSUInteger))block
{
    self.onPeopleInfoClickBlock = block;
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
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (UIImage *)drawCircleByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(line, 1);
    CGContextAddArc(line, imageView.frame.size.width / 2, imageView.frame.size.width / 2, imageView.frame.size.width / 2, 0, M_PI * 2, 0);
    CGContextSetFillColorWithColor(line, [WLTools stringToColor:@"#879efa"].CGColor);
    CGContextFillPath(line);
    return UIGraphicsGetImageFromCurrentImageContext();
}
@end
