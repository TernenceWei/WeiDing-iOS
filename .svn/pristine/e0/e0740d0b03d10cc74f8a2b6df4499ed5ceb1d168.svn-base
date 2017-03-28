//
//  WLApplicationGuideShowPriceTableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationGuideShowPriceTableViewCell.h"

@implementation WLApplicationGuideShowPriceTableViewCell

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

-(void)creatView{
    _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
    _leftLabel.font = [UIFont systemFontOfSize:14];
    _leftLabel.textAlignment = NSTextAlignmentLeft;

    [self addSubview:_leftLabel];
    
    _midLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 80, 20)];
    _midLabel.font = [UIFont systemFontOfSize:14];
    _midLabel.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_midLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
