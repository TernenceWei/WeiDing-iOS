//
//  WLCarBookingDetailView.m
//  WeiLvDJS
//
//  Created by ternence on 2017/2/9.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingDetailView.h"
#import "WLCarBookingDetailOrderCell.h"
#import "WLCarBookingDetailViewMode.h"

@interface WLCarBookingDetailView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLCarBookingOrderDetailObject *object;
@property (nonatomic, assign) BOOL isFold;
@property (nonatomic, strong) UIButton *foldBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, copy) void(^lookImgAction)();
@property (nonatomic, assign) BOOL iSChooseVC;
@end

@implementation WLCarBookingDetailView

- (instancetype)initWithiSchoose:(BOOL)iSCVC Object:(WLCarBookingOrderDetailObject *)object
{
    self = [super init];
    if (self) {
        self.object = object;
        self.isFold = YES;
        if (iSCVC) {
            _iSChooseVC = YES;
        }
        else
        {
            _iSChooseVC = NO;
        }
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.frame = CGRectMake(0, - ScreenHeight, ScreenWidth, ScreenHeight);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    if (_iSChooseVC) {
        self.tableView.frame = CGRectMake(0, 0, ScreenWidth, [self getTableViewHeight] - ScaleH(40));
    }
    else
    {
        self.tableView.frame = CGRectMake(0, 0, ScreenWidth, [self getTableViewHeight]);
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BgViewColor;
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    [self addSubview:self.tableView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, ScreenWidth, ScaleH(45))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    line.backgroundColor = bordColor;
    [bgView addSubview:line];
    
    self.foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.foldBtn.frame = CGRectMake(ScaleW(155), 0, ScaleW(50), ScaleH(45));
    [self.foldBtn setTitle:@"收起" forState:UIControlStateNormal];
    [self.foldBtn setTitleColor:Color1 forState:UIControlStateNormal];
    self.foldBtn.titleLabel.font = [UIFont WLFontOfSize:15];
    self.foldBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.foldBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.foldBtn];
    
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.frame = CGRectMake(self.foldBtn.right, self.foldBtn.centerY - ScaleW(6), ScaleW(14), ScaleW(12));
    [arrowBtn setImage:[UIImage imageNamed:@"shouqi"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:arrowBtn];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [bgView addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tapGesture];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    WLCarBookingDetailOrderCell *cell = [WLCarBookingDetailOrderCell cellWithTableView:tableView isFold:self.isFold foldAction:^(BOOL isFold) {
        
        weakSelf.isFold = !weakSelf.isFold;
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        weakSelf.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        if (_iSChooseVC) {
            weakSelf.tableView.frame = CGRectMake(0, 0, ScreenWidth, [weakSelf getTableViewHeight] - ScaleH(40));
        }
        else
        {
            weakSelf.tableView.frame = CGRectMake(0, 0, ScreenWidth, [weakSelf getTableViewHeight]);
        }
        weakSelf.bgView.frame = CGRectMake(0, weakSelf.tableView.bottom, ScreenWidth, ScaleH(45));
        
    }];
    
    [cell lookImgClickAction:^{
        
        _lookImgAction();
    }];
    
    if (_iSChooseVC) {
        cell.iSChooseVC = YES;
    }
    else
    {
        cell.iSChooseVC = NO;
    }
    
    cell.object = self.object;
    return cell;

}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_iSChooseVC) {
        return [self getTableViewHeight] -  ScaleH(40);
    }
    return [self getTableViewHeight];

}

- (CGFloat)getTableViewHeight
{
    if (([self.object.memo isEqualToString:@""] || self.object.memo == nil) && self.object.trip_image.count != 0) {
        _object.memo = @"查看行程详情";
    }
    return [WLCarBookingDetailViewMode getOrderCellHeightWithObject:self.object isFold:self.isFold];
}


- (void)show {

    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }];
}

-(void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, - ScreenHeight, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)lookImgAction:(void (^)())action
{
    _lookImgAction = action;
}

@end
