//
//  WLHotelBillListCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/16.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillListCell.h"

#define cellIdentifier @"WLHotelBillListCell"

@interface WLHotelBillListCell ()
@property (nonatomic, strong) NSMutableArray *labelArray;
@end

@implementation WLHotelBillListCell
+ (WLHotelBillListCell *)cellWithTableView:(UITableView*)tableView withLine:(BOOL)withLine{
    WLHotelBillListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLHotelBillListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setupUIWithLine:withLine];
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

- (void)setItemInfo:(WLHotelBillListItemInfo *)itemInfo
{
    _itemInfo = itemInfo;
    if (self.labelArray.count) {
        UILabel *groupNoLabel = self.labelArray[0];
        groupNoLabel.text = [NSString stringWithFormat:@"团号 %@",self.itemInfo.groupNO];
        
        UILabel *pricelabel = self.labelArray[1];
        pricelabel.text = [NSString stringWithFormat:@"¥%@",self.itemInfo.price];
        
        UILabel *datelabel = self.labelArray[2];
        datelabel.text = [NSString stringWithFormat:@"入住时间 %@",[self getTimeTextWithTimeString:self.itemInfo.cDate]];
        
        UILabel *statusLabel = self.labelArray[3];
        statusLabel.text = @"已结账";
    }
}


- (NSString *)getTimeTextWithTimeString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];

    NSInteger month = [dateComps month];
    NSInteger day = [dateComps day];
    return [NSString stringWithFormat:@"%ld月%ld日", month,day];
}

- (void)setupUIWithLine:(BOOL)withLine{

    CGFloat cellHeight = ScaleH(45);
    for (int i = 0; i < 4; i++) {
        UILabel *detailLabel = [[UILabel alloc] init];
        CGFloat width = ScreenWidth / 2 - ScaleW(12);
        CGFloat beginX = ScaleW(12) + width * (i % 2);
        if (i < 2) {
            detailLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
            detailLabel.font = [UIFont WLFontOfSize:16];
            if (i == 0) {
                width += 40;
            }
        }else{
            
            detailLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
            detailLabel.font = [UIFont WLFontOfSize:14];
            if (i == 3) {
                width -= 15;
            }
        }
        if (i % 2 != 0) {
            detailLabel.textAlignment = NSTextAlignmentRight;
        }
        detailLabel.frame = CGRectMake(beginX , cellHeight * (i / 2) , width, cellHeight);
        [self addSubview:detailLabel];
        [self.labelArray addObject:detailLabel];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleH(89), ScreenWidth, 1)];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:lineView];
    
    
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(25), cellHeight, ScaleW(20), cellHeight)];
    [clearButton setImage:[UIImage imageNamed:@"group_indicator"] forState:UIControlStateNormal];
    [self addSubview:clearButton];
}

@end
