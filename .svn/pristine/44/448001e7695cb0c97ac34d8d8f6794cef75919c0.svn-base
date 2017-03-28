//
//  WL_Application_TourGuide_Price_TableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_TourGuide_Price_TableViewCell.h"

@implementation WL_Application_TourGuide_Price_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 60, 15)];
    _leftLabel.text = @"报价方式";
    _leftLabel.textColor = [UIColor darkGrayColor];
    _leftLabel.textAlignment = NSTextAlignmentLeft;
    _leftLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 15, ScreenWidth - 150, 15)];

    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.textColor = [UIColor darkTextColor];
    _rightLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_rightLabel];
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 20, 14, 11, 18)];
    [_rightButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [self addSubview:_rightButton];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

