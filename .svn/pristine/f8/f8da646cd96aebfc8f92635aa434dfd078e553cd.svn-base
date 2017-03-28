//
//  WLBillSectionHeaderView.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillSectionHeaderView.h"
#import "WLUITool.h"
#import "UIImageView+WebCache.h"

@interface WLBillSectionHeaderView ()
@property(nonatomic, copy) void(^onSelectionAction)();
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *statusBtn;
@property (nonatomic, strong) UILabel *guideNOLabel;
@end

@implementation WLBillSectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame
                 selectAction:(void(^)(WLGuideListInfo *guideInfo))selectionAction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.onSelectionAction = selectionAction;
        
        self.topView = [[UIView alloc] init];
        [self addSubview:self.topView];
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(150))];
        [self addSubview:self.bottomView];
    }
    return self;
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)setDetailInfo:(WLBillDetailInfo *)detailInfo
{

    _detailInfo = detailInfo;
    if (self.statusBtn) {
        [self.statusBtn removeFromSuperview];
        self.statusBtn = nil;
    }
    if (self.guideNOLabel) {
        [self.guideNOLabel removeFromSuperview];
        self.guideNOLabel = nil;
    }
    if (self.detailInfo.failMessage.count) {
        CGFloat topHeight = (self.detailInfo.failMessage.count * 2 + 1) * ScaleH(40) + ScaleH(10);
        self.topView.frame = CGRectMake(0, 0, ScreenWidth, topHeight);
        self.bottomView.frame = CGRectMake(0, topHeight, ScreenWidth, ScaleH(150));
        [self setupNotPassView];
    }

    UILabel *guideNOLabel = [[UILabel alloc] init];
    guideNOLabel.textColor = HEXCOLOR(0x2f2f2f);
    guideNOLabel.font = [UIFont WLFontOfSize:12];
    guideNOLabel.textAlignment = NSTextAlignmentLeft;
    guideNOLabel.text = [NSString stringWithFormat:@"成团单号：%@",self.detailInfo.groupNO];
    guideNOLabel.frame = CGRectMake(ScaleW(12), 0, [WLUITool sizeWithString:guideNOLabel.text font:guideNOLabel.font].width + 5, ScaleH(45));
    [self.bottomView addSubview:guideNOLabel];
    
    UIButton *statusBtn = [[UIButton alloc] init];
    [statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [statusBtn setTitle:[self getStatusTextWithStatus:self.detailInfo.status] forState:UIControlStateNormal];
    statusBtn.titleLabel.font = [UIFont WLFontOfSize:12];
    [statusBtn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x59d68d)] forState:UIControlStateNormal];
    statusBtn.frame = CGRectMake(CGRectGetMaxX(guideNOLabel.frame) + ScaleW(6), ScaleH(10), ScaleW(80), ScaleH(24));
    statusBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.bottomView addSubview:statusBtn];
    statusBtn.layer.cornerRadius = ScaleH(12);
    statusBtn.layer.masksToBounds = YES;
    
    self.guideNOLabel = guideNOLabel;
    self.statusBtn = statusBtn;

}

- (NSString *)getStatusTextWithStatus:(GroupStatus)status
{
    NSString *text = @"待提交";
    if (status == GroupStatusUnShenHe) {
        text = @"审核中";
    }else if (status == GroupStatusUnJieZhang) {
        text = @"已审核";
    }else if (status == GroupStatusJieZhang) {
        text = @"已结账";
    }else if (status == GroupStatusShenHeFailure) {
        text = @"审核失败";
    }
    return text;
}

- (void)setRoleArray:(NSArray *)roleArray
{
    _roleArray = roleArray;

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ScaleH(45), ScreenWidth, ScaleH(95))];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.bottomView addSubview:self.scrollView];
    
    NSUInteger count = roleArray.count;
    CGFloat width = ScreenWidth / count;
    if (count >= 4) {
        width = 100;
    }
    self.scrollView.contentSize = CGSizeMake(width * count, ScaleH(95));
    for (int i = 0; i < count; i++) {
        
        [self setupRoleViwWithIndex:i frame:CGRectMake(width * i, 0, width, ScaleH(95)) locationView:self.scrollView];
    }
    
    self.indicatorView = [[UIImageView alloc] init];
    self.indicatorView.image = [UIImage imageNamed:@"allGroup_role_select_angel"];
    self.indicatorView.bounds = CGRectMake(0, 0, ScaleW(16), ScaleW(8));
    [self.scrollView addSubview:self.indicatorView];
    [self updateIndicatorViewCenter];
    
    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleH((150 - 10)), ScreenWidth, ScaleH(10))];
    marginView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [self.bottomView addSubview:marginView];
    
    
}

- (void)updateIndicatorViewCenter
{
    self.indicatorView.center = CGPointMake(self.selectedBtn.center.x, ScaleH(95) - ScaleW(4));
}

- (void)setupRoleViwWithIndex:(NSUInteger)index frame:(CGRect)frame locationView:(UIView *)locationView
{
    WLGuideListInfo *info = self.roleArray[index];
    CGFloat width = ScaleW(55);
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(frame.size.width * index + (frame.size.width - width) / 2, 0, width, width);
    iconView.layer.cornerRadius = width / 2;
    iconView.backgroundColor = [self getBgColorWithIndex:index];
    iconView.userInteractionEnabled = YES;
    iconView.tag = index;
    [iconView sd_setImageWithURL:[NSURL URLWithString:info.headImage] placeholderImage:nil];
    [locationView addSubview:iconView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [iconView addGestureRecognizer:tapGesture];
    
    UIButton *titleBtn = [[UIButton alloc] init];
    titleBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    [titleBtn setTitle:info.guideName forState:UIControlStateNormal];
    [titleBtn setTitleColor:HEXCOLOR(0x2f2f2f) forState:UIControlStateNormal];
    [titleBtn setTitleColor:HEXCOLOR(0x4877e7) forState:UIControlStateSelected];
    titleBtn.frame = CGRectMake(frame.size.width * index, CGRectGetMaxY(iconView.frame) + ScaleH(8), frame.size.width, ScaleH(20));
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [titleBtn addTarget:self action:@selector(titleBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [locationView addSubview:titleBtn];
    titleBtn.tag = index;
    if (index == 0) {
        titleBtn.selected = YES;
        self.selectedBtn = titleBtn;
    }
    [self.btnArray addObject:titleBtn];
    
    if (info.isMainGuide.boolValue) {
        CGFloat flagWidth = ScaleW(20);
        UIImageView *flagView = [[UIImageView alloc] init];
        flagView.frame = CGRectMake(frame.size.width * index + (frame.size.width - width) / 2 + (width - flagWidth), width - flagWidth, flagWidth, flagWidth);
        flagView.layer.cornerRadius = width / 2;
        flagView.image = [UIImage imageNamed:@"guide_bill_mainGuide_icon"];
        flagView.userInteractionEnabled = YES;
        flagView.tag = index;
        [locationView addSubview:flagView];
    }
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

- (void)setupNotPassView
{
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.textColor = HEXCOLOR(0x2f2f2f);
    leftLabel.font = [UIFont WLFontOfSize:12];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.frame = CGRectMake(ScaleW(12), 0, ScreenWidth / 2, ScaleH(40));
    leftLabel.text = @"未通过原因";
    [self.topView addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.textColor = HEXCOLOR(0x6f7378);
    rightLabel.font = [UIFont WLFontOfSize:12];
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.frame = CGRectMake(ScreenWidth / 2 - ScaleW(12), 0, ScreenWidth / 2, ScaleH(40));
    rightLabel.text = [self getFailTextWithTimeString:self.detailInfo.failDate];
    [self.topView addSubview:rightLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf7f7f8);
    lineView.frame = CGRectMake(ScaleW(12), ScaleH(39), ScreenWidth, 1);
    [self addSubview:lineView];
    
    
    for (int i = 0; i < self.detailInfo.failMessage.count; i ++) {
        WLBillFailMessageInfo *info = self.detailInfo.failMessage[i];
        NSArray *textArray = @[CHECKNIL(info.itemName), CHECKNIL(info.message)];
        for (int j = 0; j < 2; j ++) {
            [self setupNoPassMessageWithYIndex:i index:j text:textArray[j]];
        }
    }
    
    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.bounds.size.height - ScaleH(10), ScreenWidth, ScaleH(10))];
    marginView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [self.topView addSubview:marginView];
}

- (void)setupNoPassMessageWithYIndex:(NSUInteger)yIndex index:(NSUInteger)index text:(NSString *)text
{
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.textColor = HEXCOLOR(0x2f2f2f);
    rightLabel.font = [UIFont WLFontOfSize:13];
    rightLabel.textAlignment = NSTextAlignmentLeft;
    rightLabel.frame = CGRectMake(ScaleW(15), ScaleH(40) + yIndex* ScaleH(80) + ScaleH(40) * index, ScreenWidth - ScaleW(30), ScaleH(40));
    rightLabel.text = text;
    [self.topView addSubview:rightLabel];
}

- (NSString *)getFailTextWithTimeString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:timeString];

    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:date];
    NSInteger year = [dateComps year];
    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    NSInteger hour = [dateComps hour];
    NSInteger minute = [dateComps minute];
    return [NSString stringWithFormat:@"%ld.%ld.%ld %ld:%ld",year, month,day,hour, minute];
    
}

- (void)titleBtnDidClicked:(UIButton *)button
{
    button.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = button;
    [self updateIndicatorViewCenter];
    self.onSelectionAction(self.roleArray[self.selectedBtn.tag]);
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    UIView *view = tapGesture.view;
    UIButton *button = self.btnArray[view.tag];
    [self titleBtnDidClicked:button];
}
@end
