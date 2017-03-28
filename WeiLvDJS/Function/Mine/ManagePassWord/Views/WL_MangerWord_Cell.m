//
//  WL_MangerWord_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MangerWord_Cell.h"

@implementation WL_MangerWord_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    
    {
        
        //绘制左侧显示标签
        self.nameLabel = [WLTools allocLabel:@"" font:WLFontSize(14) textColor:[WLTools stringToColor:@"#2f2f2f"] frame:CGRectMake(10, 0,120,  50)textAlignment:0];
        
        [self.contentView addSubview:self.nameLabel];
        
        //绘制右侧箭头导航
        self.rightImageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-19, (50-16)/2, 9, 15)];
        self.rightImageView.image = [UIImage imageNamed:@"arrow"];
        
        [self.contentView addSubview:self.rightImageView];
        
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(10, 49.5, ScreenWidth-10, 0.5)];
        self.line.backgroundColor = bordColor;
        
        [self.contentView addSubview:self.line];
        
    }

    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
