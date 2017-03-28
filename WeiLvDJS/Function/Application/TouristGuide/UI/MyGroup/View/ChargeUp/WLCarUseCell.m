//
//  WLCarUseCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLCarUseCell.h"


#define cellIdentifier @"WLCarUseCell"

@interface WLCarUseCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation WLCarUseCell

+ (WLCarUseCell *)cellWithTableView:(UITableView*)tableView{
    WLCarUseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLCarUseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.exclusiveTouch = YES;
        self.multipleTouchEnabled = NO;
    }
    return self;
}

- (void)setupUI{
    
    self.iconView = [[UIImageView alloc] init];
    self.iconView.image = [UIImage imageNamed:@""];
    self.iconView.frame = CGRectMake(0, 0, 20, 20);
    [self addSubview:self.iconView];
    
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.textColor = [UIColor blackColor];
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    self.addressLabel.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.addressLabel.text = @"新华保险大厦";
    [self addSubview:self.addressLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.addressLabel.frame) + 10, ScreenWidth, 40);
    self.timeLabel.text = @"车公庙地铁站";
    [self addSubview:self.timeLabel];
}
@end
