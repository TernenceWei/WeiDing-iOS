//
//  WLBillSummaryCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillSummaryCell.h"
#import "WLBillSummaryView.h"

#define cellIdentifier @"WLBillSummaryCell"

@interface WLBillSummaryCell ()
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, assign) BOOL mainGuideType;
@property (nonatomic, copy)  void(^onEditAction)();

@end

@implementation WLBillSummaryCell

+ (WLBillSummaryCell *)cellWithTableView:(UITableView*)tableView
                           mainGuideType:(BOOL)mainGuideType{
    WLBillSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLBillSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.mainGuideType = mainGuideType;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setBillInfo:(WLBillDetailInfo *)billInfo
{
    _billInfo = billInfo;
    [self setupUI];
}

- (void)setupUI{
    if (self.billInfo == nil) {
        return;
    }
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }

    CGFloat titleWidth = ScreenWidth / 3;
    UILabel *checkPriceTextLabel = [[UILabel alloc] init];
    checkPriceTextLabel.textColor = HEXCOLOR(0x2f2f2f);
    checkPriceTextLabel.font = [UIFont WLFontOfSize:14];
    checkPriceTextLabel.textAlignment = NSTextAlignmentLeft;
    checkPriceTextLabel.frame = CGRectMake(ScaleW(12), 0, titleWidth, ScaleH(50));
    checkPriceTextLabel.text = @"导服费（元）";
    [self addSubview:checkPriceTextLabel];

    UILabel *checkPriceLabel = [[UILabel alloc] init];
    checkPriceLabel.textColor = HEXCOLOR(0xff5b3d);
    checkPriceLabel.font = [UIFont WLFontOfSize:14];
    checkPriceLabel.textAlignment = NSTextAlignmentCenter;
    checkPriceLabel.frame = CGRectMake(titleWidth, 0, titleWidth, ScaleH(50));
    checkPriceLabel.text = self.billInfo.serviceFree;
    [self addSubview:checkPriceLabel];
    
    if (self.mainGuideType) {
    
        NSString *checkPriceTitle = @"备用金（元）";
        NSArray *checkPriceArray = @[@"收款",@"现付",@"超额",[NSString stringWithFormat:@"%@",self.billInfo.imprestShouKuan],[NSString stringWithFormat:@"%@",self.billInfo.imprestXianFu],[NSString stringWithFormat:@"%@",self.billInfo.imprestChaoE]];
        WLBillSummaryView *checkPriceView = [[WLBillSummaryView alloc] initWithFrame:CGRectMake(0, ScaleH(50), ScreenWidth, ScaleH(100)) title:checkPriceTitle textArray:checkPriceArray];
        [self addSubview:checkPriceView];
        
    }
    
    NSString *shopTitle = @"购物返现（元）";
    NSArray *shopArray = @[@"消费",@"返点",@"应返现",[NSString stringWithFormat:@"%@",self.billInfo.shopSpend],[NSString stringWithFormat:@"%@",self.billInfo.shopRebate],[NSString stringWithFormat:@"%@",self.billInfo.shopBack]];
    CGFloat shopHeight = ScaleH(50);
    if (self.mainGuideType) {
        shopHeight = ScaleH(150);
    }
    WLBillSummaryView *shopView = [[WLBillSummaryView alloc] initWithFrame:CGRectMake(0, shopHeight, ScreenWidth, ScaleH(100)) title:shopTitle textArray:shopArray];
    [self addSubview:shopView];
    
    NSString *additionalTitle = @"加点项目（元）";
    NSArray *additionalArray = @[@"总结余",@"个人结余",@"个人应返现",[NSString stringWithFormat:@"%@",self.billInfo.additionalTotal],[NSString stringWithFormat:@"%@",self.billInfo.additionalPerson],[NSString stringWithFormat:@"%@",self.billInfo.additionalBack]];
    WLBillSummaryView *additionalView = [[WLBillSummaryView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shopView.frame), ScreenWidth, ScaleH(100)) title:additionalTitle textArray:additionalArray];
    [self addSubview:additionalView];
    
    CGFloat textHeight = CGRectGetMaxY(additionalView.frame);
    UILabel *remainTextLabel = [[UILabel alloc] init];
    remainTextLabel.textColor = HEXCOLOR(0x2f2f2f);
    remainTextLabel.font = [UIFont WLFontOfSize:14];
    remainTextLabel.textAlignment = NSTextAlignmentLeft;
    remainTextLabel.frame = CGRectMake(ScaleW(12), textHeight, titleWidth + 100, ScaleH(50));
    remainTextLabel.text = @"剩余待结算（元）";
    [self addSubview:remainTextLabel];
    
    UILabel *remainLabel = [[UILabel alloc] init];
    remainLabel.textColor = HEXCOLOR(0xff5b3d);
    remainLabel.font = [UIFont WLFontOfSize:14];
    remainLabel.textAlignment = NSTextAlignmentCenter;
    remainLabel.frame = CGRectMake(titleWidth, textHeight, titleWidth, ScaleH(50));
    remainLabel.text = [NSString stringWithFormat:@"%@",self.billInfo.settle];
    [self addSubview:remainLabel];

    UIButton *editBtn = [[UIButton alloc] init];
    [editBtn setTitle:@"重新编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:HEXCOLOR(0x4877e7) forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    editBtn.frame = CGRectMake(titleWidth * 2 - ScaleW(12), textHeight, titleWidth, ScaleH(50));
    editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [editBtn addTarget:self action:@selector(editBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:editBtn];
    
    if (self.billInfo.status == GroupStatusYiShenHe || self.billInfo.status == GroupStatusUnJieZhang || self.billInfo.status == GroupStatusJieZhang || self.billInfo.status == GroupStatusUnShenHe) {
        editBtn.hidden = YES;
    }else{
        editBtn.hidden = NO;
    }
    
    NSUInteger lineCount = 3;
    if (self.mainGuideType) {
        lineCount = 4;
    }
    for (int i = 0; i < lineCount; i ++) {
        [self setupLineWithIndex:i];
    }
    
}

- (void)setupLineWithIndex:(NSUInteger)index
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xd8d9dd);
    line.frame = CGRectMake(ScaleW(12), ScaleH(50) + ScaleH(100) * index, ScreenWidth, 1);
    [self addSubview:line];
}

- (void)editBtnDidClicked
{
    self.onEditAction();
}

- (void)setEditAction:(void (^)())action
{
    self.onEditAction = action;
}
@end
