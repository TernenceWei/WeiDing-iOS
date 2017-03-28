//
//  WL_FundAccount_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_FundAccount_Cell.h"

@implementation WL_FundAccount_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //绘制左侧图标
        
        self.leftImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(12,(50-16)/2,15,16)];
       
        self.leftImageVIew.layer.masksToBounds = YES;
        
        self.leftImageVIew.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:self.leftImageVIew];
        
        
        //绘制左侧显示标签
        self.nameLabel = [WLTools allocLabel:@"" font:WLFontSize(14) textColor:[WLTools stringToColor:@"#2f2f2f"] frame:CGRectMake(ViewRight(self.leftImageVIew)+10, 0,120,  50)textAlignment:0];
        
        [self.contentView addSubview:self.nameLabel];
        
        //绘制右侧箭头导航
        self.rightImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-19, (50-15)/2, 9, 15)];
        self.rightImageVIew.image = [UIImage imageNamed:@"arrow"];
        [self.contentView addSubview:self.rightImageVIew];
        
        //标签后面 显示的详情
        self.rightLabel=[WLTools allocLabel:@"" font:WLFontSize(14) textColor:[WLTools stringToColor:@"#6f7378"] frame:CGRectMake(ScreenWidth-120-24, 0, 120, 50)textAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.rightLabel];
        
        //绘制分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50-0.5, ScreenWidth,0.5)];
        line.backgroundColor = bordColor;
        self.line=line;
        
        [self.contentView addSubview:self.line];
    }
    
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
