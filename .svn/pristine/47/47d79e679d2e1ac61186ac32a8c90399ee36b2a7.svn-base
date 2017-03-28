//
//  WLRebateCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLRebateCell.h"

#define cellIdentifier @"WLRebateCell"

@interface WLRebateCell ()

@property (nonatomic, strong) WLChargeUpRoleObject *object;
@property (nonatomic, strong) UILabel *secondLabel;
@end

@implementation WLRebateCell

+ (WLRebateCell *)cellWithTableView:(UITableView *)tableView
                         roleObject:(WLChargeUpRoleObject *)roleObject{
    WLRebateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLRebateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.object = roleObject;
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
    if (self.object == nil) {
        return;
    }
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont WLFontOfSize:14];
        CGFloat x = ScaleW(12);
        CGFloat width = ScreenWidth / 2;
        CGFloat height = ScaleH(45);
        label.textColor = HEXCOLOR(0x2f2f2f);
        label.textAlignment = NSTextAlignmentLeft;

        if (i == 1) {
            x = ScreenWidth - ScaleW(12) - width;
            label.textColor = HEXCOLOR(0x868686);
            label.textAlignment = NSTextAlignmentRight;
            
        }
        label.frame = CGRectMake(x, 0, width, height);
        if (i == 0) {
            NSString *firstTitle = self.object.rate;
            if (![firstTitle isEqualToString:@""] && firstTitle != nil) {
                firstTitle = [@"返点"  stringByAppendingString:self.object.rate];
            }
            label.text = [firstTitle stringByAppendingString:@"%"];
        }else{
            self.secondLabel = label;
        }
        [self addSubview:label];
    }
}

- (void)setTotalReturnPrice:(NSString *)returnprice
{
    NSString *price =  [NSString stringWithFormat:@"%.1f", returnprice.intValue * self.object.rate.intValue * 0.01];
    NSString *secondTitle = returnprice;
    if (![secondTitle isEqualToString:@""] && secondTitle != nil) {
        secondTitle = [[@"待返现¥"  stringByAppendingString:price] stringByAppendingString:@"元"];
    }
    self.secondLabel.text = secondTitle;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *subV in self.subviews) {
        [subV removeFromSuperview];
    }
}
@end
