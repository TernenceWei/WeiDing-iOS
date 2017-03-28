//
//  WLHotelBillDetailCheckCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailCheckCell.h"
#define cellIdentifier @"WLHotelBillDetailCheckCell"

@interface WLHotelBillDetailCheckCell ()
@property (nonatomic, strong) NSMutableArray *labelArray;
@end

@implementation WLHotelBillDetailCheckCell
+ (WLHotelBillDetailCheckCell *)cellWithTableView:(UITableView*)tableView{
    WLHotelBillDetailCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLHotelBillDetailCheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
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

- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

- (void)setItemInfo:(WLHotelBillDetailItemInfo *)itemInfo
{
    _itemInfo = itemInfo;
    if (self.labelArray.count) {
        UILabel *nameLabel = self.labelArray[0];
        nameLabel.text = [NSString stringWithFormat:@"订单号%@",self.itemInfo.orderNO];
        
        UILabel *countLabel = self.labelArray[1];
        countLabel.text = self.itemInfo.pricelistName;
        
        NSString *price = CHECKNIL(self.itemInfo.checkPrice);
        if ([self.itemInfo.checkPrice isEqualToString:@"0"]) {
            price = @"";
        }else{
            price = [NSString stringWithFormat:@"¥%@", CHECKNIL(self.itemInfo.checkPrice)];
        }
        UILabel *priceLabel = self.labelArray[2];
        priceLabel.text = [NSString stringWithFormat:@"%@ × %@",price, self.itemInfo.checkCount];
        
        UILabel *dateLabel = self.labelArray[3];
        dateLabel.text = [NSString stringWithFormat:@"¥%@",self.itemInfo.checkCountPrice];

    }
    
}

- (void)setupUI{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:lineView];
    
    for (int i = 0; i < 4; i++) {
        UILabel *detailLabel = [[UILabel alloc] init];
        CGFloat width = ScreenWidth / 3;
        CGFloat height = ScaleH(42);
        CGFloat beginX = width * ((i-1) % 3);
        CGFloat beginY = height;
        detailLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
        if (i == 0) {
            width = ScreenWidth;
            beginX = ScaleW(12);
            beginY = 0;
            detailLabel.textAlignment = NSTextAlignmentLeft;
            
        }else if (i == 1) {
            detailLabel.textAlignment = NSTextAlignmentLeft;
            beginX = ScaleW(12);
            
        }else if (i == 2) {
            detailLabel.textAlignment = NSTextAlignmentCenter;

        }else{
            detailLabel.textAlignment = NSTextAlignmentRight;
            beginX -= ScaleW(12);
            
        }
        detailLabel.font = [UIFont WLFontOfSize:14];
        detailLabel.frame = CGRectMake(beginX , beginY , width, height);
        [self addSubview:detailLabel];
        [self.labelArray addObject:detailLabel];
        
    }
    
}
@end
