//
//  WLHotelBillDetailCheckerCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelBillDetailCheckerCell.h"
#define cellIdentifier @"WLHotelBillDetailCheckerCell"

@interface WLHotelBillDetailCheckerCell ()
@property (nonatomic, strong) NSMutableArray *labelArray;
@end

@implementation WLHotelBillDetailCheckerCell
+ (WLHotelBillDetailCheckerCell *)cellWithTableView:(UITableView*)tableView{
    WLHotelBillDetailCheckerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLHotelBillDetailCheckerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        UILabel *nameLabel = self.labelArray[0];
        nameLabel.text = self.detailInfo.companyName;
        
        UILabel *countLabel = self.labelArray[1];
        countLabel.text = self.detailInfo.realName;
        
        UILabel *priceLabel = self.labelArray[2];
        priceLabel.text = self.detailInfo.userMobile;
        
    }
    
}

- (void)setupUI{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:lineView];
    
    NSArray *textArray = @[@"地接社", @"联系人", @"电话"];
    for (int i = 0; i < 6; i++) {
        UILabel *detailLabel = [[UILabel alloc] init];
        CGFloat width = ScreenWidth / 2;
        CGFloat height = ScaleH(35);
        CGFloat beginX = width * (i % 2);
        CGFloat beginY = height * (i / 2);
        detailLabel.textColor = [WLTools stringToColor:@"#b5b5b5"];
        if (i % 2 == 0) {
            beginX = ScaleW(12);
            detailLabel.textAlignment = NSTextAlignmentLeft;
            detailLabel.text = textArray[i / 2];
        }else{
            beginX -= ScaleW(12);
            detailLabel.textAlignment = NSTextAlignmentRight;
            [self.labelArray addObject:detailLabel];
        }
        detailLabel.font = [UIFont WLFontOfSize:14];
        detailLabel.frame = CGRectMake(beginX , beginY , width, height);
        [self addSubview:detailLabel];
    }
    
}
@end
