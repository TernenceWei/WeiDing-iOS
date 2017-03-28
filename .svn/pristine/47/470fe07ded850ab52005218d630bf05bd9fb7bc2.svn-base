//
//  WLCarItemTopCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCarItemTopCell.h"

#define cellIdentifier @"WLCarItemTopCell"

@interface WLCarItemTopCell ()
@property (nonatomic, strong) WLItemDetailCarObject *carObject;
@end

@implementation WLCarItemTopCell

+ (WLCarItemTopCell *)cellWithTableView:(UITableView*)tableView object:(WLItemDetailCarObject *)object{
    
    WLCarItemTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarItemTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    
    NSArray *textArray = @[@"车辆品牌",CHECKNIL(self.carObject.carBrand),@"车牌地点",[CHECKNIL(self.carObject.carProvince) stringByAppendingString:CHECKNIL(self.carObject.carCity)]];
    for (int i = 0; i < 4; i++) {
        [self setupLabelWithIndex:i text:textArray[i]];
    }
    
    NSUInteger linecount = 1;
    if (self.carObject.photolist.count) {
        linecount = 2;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ScaleH(90), ScreenWidth, ScaleH(100))];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        NSUInteger count = self.carObject.photolist.count;
        CGFloat width = ScaleH(90);
        scrollView.contentSize = CGSizeMake(width * count + ScaleH(10) + ScaleH(5) * (count - 1), ScaleH(100));
        
        for (int i = 0; i < count; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            //        imageView.image = self.totalImageArray[i];
            imageView.frame = CGRectMake(ScaleH(10) + (width + ScaleH(5)) * i, ScaleH(5), width, width);
            [scrollView addSubview:imageView];
        }

    }
    for (int i = 0; i < linecount; i++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HEXCOLOR(0xd8d9dd);
        line.frame = CGRectMake(ScaleW(12), ScaleH(45) * (i + 1), ScreenWidth, 1);
        [self addSubview:line];
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
        label.textColor = HEXCOLOR(0x868686);
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
