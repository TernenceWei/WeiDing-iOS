//
//  WLChargeUpCommonCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpCommonCell.h"

#define cellIdentifier @"WLChargeUpCommonCell"

@interface WLChargeUpCommonCell ()
@property (nonatomic, assign) TouristItemType type;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation WLChargeUpCommonCell

+ (WLChargeUpCommonCell *)cellWithTableView:(UITableView *)tableView type:(TouristItemType)type indexPath:(NSIndexPath *)indexPath{
    WLChargeUpCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLChargeUpCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.type = type;
        cell.indexPath = indexPath;
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
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.frame = CGRectMake(0, 0, 100, 40);
    self.titleLabel.text = @"实际总价";
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.frame = CGRectMake(ScreenWidth - 100, 0, 100, 40);
    self.contentLabel.text = @"3000";
    [self addSubview:self.contentLabel];
}

@end
