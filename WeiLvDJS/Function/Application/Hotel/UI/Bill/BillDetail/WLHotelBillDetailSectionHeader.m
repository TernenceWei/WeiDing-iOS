//
//  WLHotelBillDetailSectionHeader.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailSectionHeader.h"

@interface WLHotelBillDetailSectionHeader ()
@property (nonatomic, assign) BOOL isPriceHeader;
@property (nonatomic, strong) WLHotelBillDetailInfo *detailInfo;
@end

@implementation WLHotelBillDetailSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
                isPriceHeader:(BOOL)isPriceHeader
                   detailInfo:(WLHotelBillDetailInfo *)detailInfo
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.isPriceHeader = isPriceHeader;
        self.detailInfo = detailInfo;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    if (self.isPriceHeader) {
        
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
        priceTextLabel.frame = CGRectMake(0 , CGRectGetMaxY(groupNoLabel.frame) + ScaleH(40) , ScreenWidth, ScaleH(45));
        priceTextLabel.text = @"结账金额";
        [self addSubview:priceTextLabel];
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.font = [UIFont boldSystemFontOfSize:29];
        priceLabel.frame = CGRectMake(0 , CGRectGetMaxY(priceTextLabel.frame) , ScreenWidth, ScaleH(40));
        priceLabel.contentMode = UIViewContentModeTop;
        priceLabel.text = [NSString stringWithFormat:@"¥%@",self.detailInfo.actualPayPrice];
        [self addSubview:priceLabel];
        
    }else{
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self addSubview:lineView];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.font = [UIFont WLFontOfSize:17];
        detailLabel.frame = CGRectMake(ScaleW(12) , 0 , ScreenWidth, ScaleH(53));
        detailLabel.text = @"下单信息";
        [self addSubview:detailLabel];
    }
}
@end
