//
//  WLGroupScheduleView.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGroupScheduleView.h"

@interface WLGroupScheduleView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, copy) void (^onBillDetailClickBlock)();
@property (nonatomic, copy) void (^onMessageClickBlock)(NSInteger index);
@property (nonatomic, copy) void (^onScheduleSelectBlock)(NSInteger index);

@property (nonatomic, strong) UIButton *selectedBtn1;
@property (nonatomic, strong) UIButton *selectedBtn2;
@property (nonatomic, strong) NSMutableArray *btnArray1;
@property (nonatomic, strong) NSMutableArray *btnArray2;

@property (nonatomic, strong) WLChargeUpSummaryInfo *summaryInfo;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, copy) void(^onScrollAction)(CGFloat offsetX);
@property (nonatomic, assign) CGFloat offsetX;

@end

@implementation WLGroupScheduleView
- (instancetype)initWithFrame:(CGRect)frame
                selectedIndex:(NSUInteger)index
                      offsetX:(CGFloat)offsetX
                 scrollAction:(void (^)(CGFloat))scrollAction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
       
        self.selectedIndex = index;
        self.onScrollAction = scrollAction;
        self.offsetX = offsetX;
        self.clipsToBounds = YES;
 
    }
    return self;
}

- (NSMutableArray *)btnArray1
{
    if (!_btnArray1) {
        _btnArray1 = [NSMutableArray array];
    }
    return _btnArray1;
}

- (NSMutableArray *)btnArray2
{
    if (!_btnArray2) {
        _btnArray2 = [NSMutableArray array];
    }
    return _btnArray2;
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
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    UIButton *titleBtn = [[UIButton alloc] init];
    [titleBtn setTitle:@"行程报账" forState:UIControlStateNormal];
    [titleBtn setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"group_schedule_icon"] forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(ScaleW(12) , ScaleH(2), ScaleW(100), ScaleH(45));
    titleBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(5), 0, 0);
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:titleBtn];
    
    UIButton *billDetailBtn = [[UIButton alloc] init];
    [billDetailBtn setTitleColor:HEXCOLOR(0x879efa) forState:UIControlStateNormal];
    billDetailBtn.titleLabel.font = [UIFont WLFontOfSize:16];
    [billDetailBtn setExclusiveTouch:YES];
    [billDetailBtn setTitle:@"账单详情" forState:UIControlStateNormal];
    [billDetailBtn addTarget:self action:@selector(billDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    billDetailBtn.frame = CGRectMake(ScreenWidth - ScaleW(110), ScaleH(2), ScaleW(100), ScaleH(45));
    billDetailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:billDetailBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleBtn.frame), ScreenWidth, 1)];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);
    [self addSubview:line];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(titleBtn.frame), ScreenWidth, ScaleH(93));
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    NSUInteger count = self.summaryInfo.tripList.count;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth / 7 * count, ScaleH(93));
    self.scrollView.contentOffset = CGPointMake(self.offsetX, 0);
    
    for (int i = 0; i < count; i++) {
        [self setupLabelWithIndex:i];
    }
    
    for (int i = 0; i < count; i++) {
        [self setupBtnWithIndex:i];
    }

    self.indicatorView = [[UIImageView alloc] init];
    self.indicatorView.image = [UIImage imageNamed:@"allGroup_role_select_angel"];
    self.indicatorView.bounds = CGRectMake(0, 0, ScaleW(16), ScaleW(8));
    [self.scrollView addSubview:self.indicatorView];
    [self updateIndicatorViewCenter];

}

- (void)setNoticeMessage:(NSString *)message
{
    if (![message isEqualToString:@""] && message != nil) {

        UIButton *messageBtn = [[UIButton alloc] init];
        messageBtn.titleLabel.font = [UIFont WLFontOfSize:13];
        [messageBtn setExclusiveTouch:YES];
        [messageBtn setTitle:message forState:UIControlStateNormal];
        [messageBtn setTitleColor:HEXCOLOR(0xfe798c) forState:UIControlStateNormal];
        [messageBtn setImage:[UIImage imageNamed:@"group_notice_ring"] forState:UIControlStateNormal];
        [messageBtn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xfff8d7)] forState:UIControlStateNormal];
        [messageBtn addTarget:self action:@selector(messageBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        messageBtn.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), ScreenWidth, ScaleH(40));
        messageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(22), 0, 0);
        messageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, ScaleW(12), 0, 0);
        messageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:messageBtn];
    }
}

- (void)updateIndicatorViewCenter
{
    self.indicatorView.center = CGPointMake(self.selectedBtn2.center.x, ScaleH(93) - ScaleH(4));
}

- (void)setupLabelWithIndex:(NSUInteger)index
{
    WLChargeUpTripObject *object = self.summaryInfo.tripList[index];
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont WLFontOfSize:14];
    [button setExclusiveTouch:YES];
    [button setTitle:object.dayText forState:UIControlStateNormal];
//    [button setTitle:@"今日" forState:UIControlStateSelected];
    [button setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0x879efa) forState:UIControlStateSelected];
    [button setBackgroundImage:nil forState:UIControlStateSelected];
    [button addTarget:self action:@selector(scheduleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = ScreenWidth / 7;
    CGFloat height = ScaleH(40);
    button.frame = CGRectMake(width * index, ScaleH(2), width, height);
    button.tag = index;
    [self.scrollView addSubview:button];
    [self.btnArray1 addObject:button];
    
    if (index == self.selectedIndex) {
        button.selected = YES;
        self.selectedBtn1 = button;
    }
}

- (void)setupBtnWithIndex:(NSUInteger)index
{
    WLChargeUpTripObject *object = self.summaryInfo.tripList[index];
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont WLFontOfSize:14];
    [button setExclusiveTouch:YES];
    [button setTitle:object.day forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x879efa)] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(scheduleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = ScaleW(30);
    CGFloat totalWidth = ScreenWidth / 7;
    button.frame = CGRectMake(totalWidth * index + (totalWidth - width) / 2, ScaleH(2) + ScaleH(42), width, width);
    button.layer.cornerRadius = width / 2;
    button.layer.masksToBounds = YES;
    button.tag = index;
    [self.scrollView addSubview:button];
    [self.btnArray2 addObject:button];
    
    if (index == self.selectedIndex) {
        button.selected = YES;
        self.selectedBtn2 = button;
    }
}

- (void)billDetailBtnClick
{
    self.onBillDetailClickBlock();
}

- (void)setBillDetailClickBlock:(void (^)())block
{
    self.onBillDetailClickBlock = block;
}

- (void)scheduleBtnClick:(UIButton *)button
{
    self.selectedBtn1.selected = NO;
    self.selectedBtn2.selected = NO;
    for (UIButton *btn in self.btnArray1) {
        if (btn.tag == button.tag) {
            btn.selected = YES;
            self.selectedBtn1 = btn;
        }
    }
    for (UIButton *btn in self.btnArray2) {
        if (btn.tag == button.tag) {
            btn.selected = YES;
            self.selectedBtn2 = btn;
        }
    }
    [self updateIndicatorViewCenter];
    self.onScheduleSelectBlock(button.tag);
}

- (void)setScheduleSelectBlock:(void (^)(NSInteger))block
{
    self.onScheduleSelectBlock = block;
}

- (void)messageBtnDidClicked
{
    self.onMessageClickBlock(2);
}

- (void)setMessageClickBlock:(void (^)(NSInteger))block
{
    self.onMessageClickBlock = block;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.onScrollAction(scrollView.contentOffset.x);
}
@end
