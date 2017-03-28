//
//  WLCarBookingDetailPaymentCell.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/20.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarBookingDetailPaymentCell.h"
#import "WLCarBookingDetailViewMode.h"
#define cellIdentifier @"WLCarBookingDetailPaymentCell"

@interface WLCarBookingDetailPaymentCell ()

@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, copy) void(^onClickAction)();

@end

@implementation WLCarBookingDetailPaymentCell
- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

+ (WLCarBookingDetailPaymentCell *)cellWithTableView:(UITableView*)tableView
                                         clickAction:(void (^)())clickAction{
    
    WLCarBookingDetailPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarBookingDetailPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.onClickAction = clickAction;
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

- (void)setObject:(WLCarBookingOrderDetailObject *)object
{
    _object = object;
    if (object == nil) {
        return;
    }
    [self setupUI];
}

- (void)setupUI{
    
    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat topHeight = ScaleH(5);
    if (self.object.reception_status.integerValue == 1) {//已接单
        
        NSString *payStatusString = @"待付款";
        if (self.object.pay_status.integerValue != 0) {
            payStatusString = @"已付款";
        }
        UILabel *payStatusLabel = [UILabel labelWithText:payStatusString textColor:Color3 fontSize:15];
        payStatusLabel.textAlignment = NSTextAlignmentCenter;
        payStatusLabel.frame = CGRectMake(0, ScaleH(20), ScreenWidth, ScaleH(20));
        [self.contentView addSubview:payStatusLabel];
        
        UILabel *priceLabel = [UILabel labelWithText:[NSString stringWithFormat:@"¥%@",self.object.order_price] textColor:Color2 fontSize:16];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.frame = CGRectMake(0, payStatusLabel.bottom, ScreenWidth, ScaleH(45));
        [self.contentView addSubview:priceLabel];
        
        topHeight = ScaleH(100);
        
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        detailBtn.frame = CGRectMake(0, ScaleH(40), ScreenWidth - ScaleW(12), ScaleH(45));
        [detailBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [detailBtn setTitle:@"费用明细" forState:UIControlStateNormal];
        [detailBtn setTitleColor:Color1 forState:UIControlStateNormal];
        detailBtn.titleLabel.font = [UIFont WLFontOfSize:15];
        detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:detailBtn];
    }
    
    
    
    NSArray *timeArray = [WLCarBookingDetailViewMode getPaymentCellTimeArray:self.object];
    for (int i = 0; i <timeArray.count; i++) {
        
        UILabel *label = [UILabel labelWithText:timeArray[i] textColor:Color3 fontSize:15];
        label.textAlignment = NSTextAlignmentLeft;
        label.frame = CGRectMake(ScaleW(12), topHeight + ScaleH(30) * i, ScreenWidth, ScaleH(30));
        [self.contentView addSubview:label];
    }
}

- (void)buttonClick
{
    self.onClickAction();
}
@end
