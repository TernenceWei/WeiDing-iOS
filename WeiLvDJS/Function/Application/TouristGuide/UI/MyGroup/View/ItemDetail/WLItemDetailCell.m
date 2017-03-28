//
//  WLItemDetailCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLItemDetailCell.h"

#define cellIdentifier @"WLItemDetailCell"

@interface WLItemDetailCell ()

@end

@implementation WLItemDetailCell

+ (WLItemDetailCell *)cellWithTableView:(UITableView*)tableView detail:(NSString *)detail{
    
    WLItemDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLItemDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setupUIWithDetail:detail];
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

- (void)setupUIWithDetail:(NSString *)detail{

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont WLFontOfSize:13];
    label.textColor = HEXCOLOR(0x2f2f2f);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = CHECKNIL(detail);
    label.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
    
    CGFloat width = ScreenWidth - ScaleW(24);
    label.frame = CGRectMake(ScaleW(12), ScaleH(12), width, [WLUITool attributedSizeWithString:label.text constrainedToSize:CGSizeMake(width, MAXFLOAT)].height);
    [self addSubview:label];
    
}

@end
