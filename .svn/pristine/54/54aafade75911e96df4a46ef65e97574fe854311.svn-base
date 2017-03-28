//
//  WLItemPaymentCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemPaymentCell.h"

#define cellIdentifier @"WLItemPaymentCell"

@interface WLItemPaymentCell ()
@property (nonatomic, strong) WLItemDetailCarObject *carObject;
@end

@implementation WLItemPaymentCell

+ (WLItemPaymentCell *)cellWithTableView:(UITableView*)tableView object:(WLItemDetailCarObject *)object{
    
    WLItemPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLItemPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.carObject = object;
    [cell setupUI];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
    }
    return self;
}

- (void)setupUI{
    
    if (self.carObject == nil) {
        return;
    }
    
    NSArray *textArray = @[@"总额",[NSString stringWithFormat:@"¥%@",CHECKNIL(self.carObject.actualAmount)]];
    for (int i = 0; i < 2; i++) {
        [self setupLabelWithIndex:i text:textArray[i]];
    }
    
}

- (void)setupLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = HEXCOLOR(0x6f7378);
    label.font = [UIFont WLFontOfSize:14];
    CGFloat x = ScaleW(12);
    CGFloat width = ScreenWidth / 2;
    CGFloat height = ScaleH(45);
    if (index % 2 == 0) {
        label.textColor = HEXCOLOR(0x2f2f2f);
        label.textAlignment = NSTextAlignmentLeft;
        
    }else {
        label.textColor = HEXCOLOR(0xff5b3d);
        label.textAlignment = NSTextAlignmentRight;
        x = ScreenWidth - ScaleW(12) - width;
    }
    
    label.frame = CGRectMake(x, height * (index / 2), width, height);
    label.text = text;
    [self addSubview:label];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}
@end
