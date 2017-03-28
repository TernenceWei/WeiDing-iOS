//
//  WLHotelBillDetailPriceCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailPriceCell.h"
#define cellIdentifier @"WLHotelBillDetailPriceCell"

@interface WLHotelBillDetailPriceCell ()
@property (nonatomic, strong) WLHotelBillDetailInfo *detailInfo;
@end

@implementation WLHotelBillDetailPriceCell
+ (WLHotelBillDetailPriceCell *)cellWithTableView:(UITableView*)tableView detailInfo:(WLHotelBillDetailInfo *)detailInfo{
    WLHotelBillDetailPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLHotelBillDetailPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.detailInfo = detailInfo;
    [cell setupUI];
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



- (void)setupUI{
    
    if (self.detailInfo == nil) {
        return;
    }
    UILabel *groupNoLabel = [[UILabel alloc] init];
    groupNoLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    groupNoLabel.textAlignment = NSTextAlignmentLeft;
    groupNoLabel.font = [UIFont WLFontOfSize:16];
    groupNoLabel.frame = CGRectMake(ScaleW(12) , 0 , ScreenWidth, ScaleH(45));
    groupNoLabel.text = [NSString stringWithFormat:@"团号 %@",self.detailInfo.groupNO];
    [self addSubview:groupNoLabel];
    
    UILabel *priceTextLabel = [[UILabel alloc] init];
    priceTextLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
    priceTextLabel.textAlignment = NSTextAlignmentCenter;
    priceTextLabel.font = [UIFont WLFontOfSize:14];
    priceTextLabel.frame = CGRectMake(0 , CGRectGetMaxY(groupNoLabel.frame) + ScaleH(45) , ScreenWidth, ScaleH(45));
    priceTextLabel.text = @"结账金额";
    [self addSubview:priceTextLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.font = [UIFont boldSystemFontOfSize:29];
    priceLabel.frame = CGRectMake(0 , CGRectGetMaxY(priceTextLabel.frame) - ScaleH(10) , ScreenWidth, ScaleH(40));
    priceLabel.contentMode = UIViewContentModeTop;
    priceLabel.text = [NSString stringWithFormat:@"¥%@",self.detailInfo.actualPayPrice];
    [self addSubview:priceLabel];
}
@end
