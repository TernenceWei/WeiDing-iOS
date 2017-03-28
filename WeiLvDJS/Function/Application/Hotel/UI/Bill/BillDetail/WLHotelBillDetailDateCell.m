//
//  WLHotelBillDetailDateCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailDateCell.h"

#define cellIdentifier @"WLHotelBillDetailDateCell"

@interface WLHotelBillDetailDateCell ()
@property (nonatomic, strong) NSMutableArray *labelArray;
@end

@implementation WLHotelBillDetailDateCell
+ (WLHotelBillDetailDateCell *)cellWithTableView:(UITableView*)tableView{
    WLHotelBillDetailDateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLHotelBillDetailDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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

- (void)setDetailInfo:(WLHotelBillDetailInfo *)detailInfo
{
    _detailInfo = detailInfo;
    if (self.labelArray.count) {
        UILabel *comeDate = self.labelArray[0];
        comeDate.text = self.detailInfo.whichDate;
        
        UILabel *levDate = self.labelArray[1];
        levDate.text = self.detailInfo.checkoutDate;
    }
    
}

- (void)setupUI{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:lineView];
    
    CGFloat cellHeight = ScaleH(42);
    for (int i = 0; i < 4; i++) {
        UILabel *detailLabel = [[UILabel alloc] init];
        CGFloat width = ScreenWidth / 2 - ScaleW(12);
        CGFloat beginX = ScaleW(12) + width * (i % 2);
        detailLabel.textColor = [WLTools stringToColor:@"#2f2f2f"];
        detailLabel.frame = CGRectMake(beginX , cellHeight * (i / 2) , width, cellHeight);
        if (i % 2 == 0) {
            detailLabel.textAlignment = NSTextAlignmentLeft;
            if (i == 0) {
                detailLabel.text = @"入住时间";
            }else{
                detailLabel.text = @"离店时间";
            }
        }else{
            detailLabel.textAlignment = NSTextAlignmentRight;
            [self.labelArray addObject:detailLabel];
        }
        [self addSubview:detailLabel];
        
    }
}
@end
