//
//  WLBillItemCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLBillItemCell.h"

#define cellIdentifier @"WLBillItemCell"

@interface WLBillItemCell ()

@end

@implementation WLBillItemCell

+ (WLBillItemCell *)cellWithTableView:(UITableView*)tableView{
    
    WLBillItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLBillItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
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

- (void)setType:(BillItemCellType)type
{
    _type = type;
}

- (void)setTextArray:(NSArray *)textArray
{
    _textArray = textArray;
    NSArray *subViews = self.subviews;
    for (UILabel *label in subViews) {
        [label removeFromSuperview];
    }
    
    for (int i = 0; i < self.textArray.count; i++) {
        [self setupLabelWithIndex:i];
    }
}


- (void)setupLabelWithIndex:(NSUInteger)index
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    if (self.type == BillItemCellTypeTitle) {

        label.textColor = HEXCOLOR(0x2f2f2f);

    }else if (self.type == BillItemCellTypeHotel){
        if (index == 3) {
            label.textColor = HEXCOLOR(0xff5b3d);
        }
    }else if (self.type == BillItemCellTypeCar){
        if (index == 3 || index == 2) {
            label.textColor = HEXCOLOR(0xff5b3d);
        }
    }else if (self.type == BillItemCellTypeShop){
        if (index == 3 || index == 2 || index == 4) {
            label.textColor = HEXCOLOR(0xff5b3d);
        }
    }
    CGFloat width = ScreenWidth / self.textArray.count;
    CGFloat height = ScaleH(45);
    label.frame = CGRectMake(width * (index % self.textArray.count), 0, width, height);
    label.text = self.textArray[index];
    [self addSubview:label];
}

@end
