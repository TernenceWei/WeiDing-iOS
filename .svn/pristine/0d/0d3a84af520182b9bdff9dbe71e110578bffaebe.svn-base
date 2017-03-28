//
//  WLHotelItemCell.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelItemCell.h"


#define cellIdentifier @"WLHotelItemCell"

@interface WLHotelItemCell ()
@property (nonatomic, assign) TouristItemType type;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UILabel *fourthLabel;
@end

@implementation WLHotelItemCell

+ (WLHotelItemCell *)cellWithTableView:(UITableView *)tableView type:(TouristItemType)type indexPath:(NSIndexPath *)indexPath{
    WLHotelItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WLHotelItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    
}
@end
