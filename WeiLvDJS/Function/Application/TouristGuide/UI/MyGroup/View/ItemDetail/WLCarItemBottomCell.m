//
//  WLCarItemBottomCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCarItemBottomCell.h"

#define cellIdentifier @"WLCarItemBottomCell"

@interface WLCarItemBottomCell ()
@property (nonatomic, strong) WLItemDetailCarObject *carObject;
@end

@implementation WLCarItemBottomCell

+ (WLCarItemBottomCell *)cellWithTableView:(UITableView*)tableView object:(WLItemDetailCarObject *)object{
    
    WLCarItemBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarItemBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
  
    NSArray *btnTextArray = @[self.carObject.startAddress,self.carObject.endAddress];
    for (int i = 0; i < 2; i++) {
        
        [self setupCarBtnWithIndex:i text:btnTextArray[i]];
    }
    NSArray *labeltextArray = @[self.carObject.startTime,self.carObject.endTime];
    for (int i = 0; i < 2; i++) {
        
        [self setupCarLabelWithIndex:i text:labeltextArray[i]];
    }
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(12), ScaleH(58), ScreenWidth, 2)];
    line1.image = [self drawLineByImageView:line1];
    [self addSubview:line1];

}

- (void)setupCarBtnWithIndex:(NSUInteger)index text:(NSString *)text
{
    UIButton *addBtn = [[UIButton alloc] init];
    NSString *iconName = @"chargeup_car_startIcon";
    if (index == 1) {
        iconName = @"chargeup_car_endIcon";
    }
    [addBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [addBtn setTitle:text forState:UIControlStateNormal];
    [addBtn setTitleColor:HEXCOLOR(0x2f2f2f) forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont WLFontOfSize:14];
    addBtn.frame = CGRectMake(ScaleW(12), ScaleH(60) * index, ScreenWidth, ScaleH(30));
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(6), 0, 0);
    [self addSubview:addBtn];
    
}

- (void)setupCarLabelWithIndex:(NSUInteger)index text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont WLFontOfSize:14];
    CGFloat width = ScreenWidth;
    CGFloat height = ScaleH(30);
    label.textColor = HEXCOLOR(0x868686);
    label.textAlignment = NSTextAlignmentLeft;
    CGFloat x = ScaleW(35);
    CGFloat y = ScaleH(30) + ScaleH(60) * index;
    label.frame = CGRectMake(x, y, width, height);
    label.text = text;
    [self addSubview:label];
}

- (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {9,6};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [WLTools stringToColor:@"#d8d9dd"].CGColor);
    CGContextSetLineDash(line, 0, lengths, 1);
    CGContextMoveToPoint(line, 0.0, 2.0);
    CGContextAddLineToPoint(line, ScreenWidth - 10, 2.0);
    CGContextStrokePath(line);
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}
@end
