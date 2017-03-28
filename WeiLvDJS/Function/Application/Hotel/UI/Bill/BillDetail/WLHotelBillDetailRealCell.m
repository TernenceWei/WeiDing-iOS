//
//  WLHotelBillDetailRealCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailRealCell.h"
#define cellIdentifier @"WLHotelBillDetailRealCell"

@interface WLHotelBillDetailRealCell ()
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) UIButton *settlementBtn;
@end

@implementation WLHotelBillDetailRealCell
+ (WLHotelBillDetailRealCell *)cellWithTableView:(UITableView*)tableView{
    WLHotelBillDetailRealCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLHotelBillDetailRealCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        nameLabel.text = self.itemInfo.pricelistName;
        
        NSString *price = CHECKNIL(self.itemInfo.actualPrice);
        if ([self.itemInfo.actualPrice isEqualToString:@"0"]) {
            price = @"";
        }else{
            price = [NSString stringWithFormat:@"¥%@", CHECKNIL(self.itemInfo.actualPrice)];
        }
        UILabel *countLabel = self.labelArray[1];
        countLabel.text = [NSString stringWithFormat:@"%@ × %@",price, self.itemInfo.actualCount];
        
        UILabel *priceLabel = self.labelArray[2];
        priceLabel.text = [NSString stringWithFormat:@"¥%@",self.itemInfo.actualCountPrice];
        
        UILabel *dateLabel = self.labelArray[3];
        dateLabel.text = [NSString stringWithFormat:@"结账时间 %@",[self getTimeTextWithTimeString:self.itemInfo.payDate]];
        
        NSString *text = @"现付";
        NSString *imageName = @"hotelBill_cash_bg";
        if (itemInfo.settlementMode == 2) {
            text = @"挂账";
            imageName = @"hotelBill_guazhang_bg";
            [self.settlementBtn setTitleColor:[WLTools stringToColor:@"#79d615"] forState:UIControlStateNormal];
        }
        [self.settlementBtn setTitle:text forState:UIControlStateNormal];
        [self.settlementBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
    }
    
}

- (void)setupUI{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:lineView];
    
    for (int i = 0; i < 4; i++) {
        UILabel *detailLabel = [[UILabel alloc] init];
        CGFloat width = ScreenWidth / 3;
        CGFloat height = ScaleH(44);
        CGFloat beginX = width * (i % 3);
        CGFloat beginY = 0;
        detailLabel.font = [UIFont WLFontOfSize:16];
        detailLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
        if (i == 0) {
            detailLabel.textAlignment = NSTextAlignmentLeft;
            beginX = ScaleW(12);
        }else if (i == 1) {
            detailLabel.textAlignment = NSTextAlignmentCenter;
            
        }else if (i == 2) {
            detailLabel.textAlignment = NSTextAlignmentRight;
            width -= ScaleW(12);
        }else{
            detailLabel.textAlignment = NSTextAlignmentRight;
            detailLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
            width = ScreenWidth - ScaleW(12);
            beginX = 0;
            beginY = height;
            detailLabel.font = [UIFont WLFontOfSize:14];
        }
        detailLabel.frame = CGRectMake(beginX , beginY , width, height);
        [self addSubview:detailLabel];
        [self.labelArray addObject:detailLabel];
        
    }
    
    self.settlementBtn = [[UIButton alloc] init];
    [self.settlementBtn setTitle:@"现付" forState:UIControlStateNormal];
    [self.settlementBtn setTitleColor:[WLTools stringToColor:@"#ff872f"] forState:UIControlStateNormal];
    [self.settlementBtn setBackgroundImage:[UIImage imageNamed:@"hotelBill_cash_bg"] forState:UIControlStateNormal];
    self.settlementBtn.titleLabel.font = WLFontSize(16);
    CGFloat width = [WLUITool sizeWithString:@"现付" font:self.settlementBtn.titleLabel.font].width + ScaleW(10);
    self.settlementBtn.frame = CGRectMake(ScaleW(12), ScaleH((44 + 7)), width, ScaleH(30));
    self.settlementBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:self.settlementBtn];
}

- (NSString *)getTimeTextWithTimeString:(NSString *)timeString
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
    return [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%02ld",(long)year, month,day,hour,minute];
}
@end
