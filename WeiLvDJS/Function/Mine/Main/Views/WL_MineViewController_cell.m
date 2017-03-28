//
//  WL_MineViewController_cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MineViewController_cell.h"

@interface WL_MineViewController_cell ()

@property (nonatomic,strong) UILabel * showLabel;

@end

@implementation WL_MineViewController_cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //绘制左侧图标
        self.leftImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(12,(50-31)/2,31,31)];
        //self.leftImageVIew.layer.cornerRadius = 31/2;
        self.leftImageVIew.layer.masksToBounds = YES;
    
        self.leftImageVIew.contentMode = UIViewContentModeScaleAspectFit;
       
        [self.contentView addSubview:self.leftImageVIew];
        
        
        //绘制左侧显示标签
        self.nameLabel = [WLTools allocLabel:@"" font:[UIFont WLFontOfSize:14.0] textColor:[WLTools stringToColor:@"#2f2f2f"] frame:CGRectMake(ViewRight(self.leftImageVIew)+10, 0,120,  49.5)textAlignment:0];
        
        [self.contentView addSubview:self.nameLabel];
        
        //标签后面 显示的详情
        self.rightLabel = [WLTools allocLabel:@"" font:WLFontSize(16) textColor:[WLTools stringToColor:@"#333333"] frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _rightLabel.numberOfLines = 1;
        [self addSubview:self.rightLabel];
        
        
        //绘制右侧箭头导航
        self.rightImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-19, (50-16)/2, 9, 15)];
        self.rightImageVIew.image = [UIImage imageNamed:@"arrow"];
        [self.contentView addSubview:self.rightImageVIew];
        
        
        //绘制分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50-0.5, ScreenWidth,0.5)];
        line.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];//bordColor;
        self.line=line;
        
        [self.contentView addSubview:self.line];
        
        _showLabel = [WLTools allocLabel:@"总资产" font:WLFontSize(14) textColor:[WLTools stringToColor:@"#2f2f2f"] frame:CGRectZero textAlignment:NSTextAlignmentRight];
        _showLabel.textColor = [UIColor lightGrayColor];
        _showLabel.font = [UIFont WLFontOfSize:10.0];
        [self addSubview:_showLabel];
    }
    
    return self;
}

- (void)setCellString:(NSString *)MoneyStr isShow:(BOOL)show
{
    if (show) {
        CGSize size =[MoneyStr sizeWithAttributes:@{NSFontAttributeName:WLFontSize(16)}];
        _rightLabel.frame = CGRectMake(_rightImageVIew.frame.origin.x - size.width - ScaleW(15), _nameLabel.frame.origin.y, size.width + ScaleW(15), _nameLabel.frame.size.height);
        _rightLabel.text = [NSString stringWithFormat:@"%@",MoneyStr];
        
        _showLabel.frame = CGRectMake(_rightLabel.frame.origin.x - ScaleW(50), _rightLabel.frame.origin.y + 15, 50, 20);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
