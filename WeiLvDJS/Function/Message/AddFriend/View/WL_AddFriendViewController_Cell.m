//
//  WL_AddFriendViewController_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddFriendViewController_Cell.h"

@implementation WL_AddFriendViewController_Cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //绘制左侧图标
       // UIImage *mineIcon=[UIImage imageNamed:@"WL_Mine_Customer"];
        self.leftImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(12,(50-35)/2,35,35)];
        self.leftImageVIew.layer.cornerRadius = 35/2;
        self.leftImageVIew.layer.masksToBounds = YES;
        self.leftImageVIew.backgroundColor =[UIColor redColor];
        
        self.leftImageVIew.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.leftImageVIew];
        
        
        //绘制左侧显示标签
        self.nameLabel = [WLTools allocLabel:@"" font:WLFontSize(16) textColor:[WLTools stringToColor:@"#2f2f2f"] frame:CGRectMake(ViewRight(self.leftImageVIew)+10, 0,120,  50)textAlignment:0];
        
        [self addSubview:self.nameLabel];
        
//        //标签后面 显示的详情
//        self.rightLabel=[WLTools allocLabel:@"" font:WLFontSize(16) textColor:[WLTools stringToColor:@"#f45955"] frame:CGRectMake(ViewRight(self.nameLabel), 0, 120, 50)textAlignment:NSTextAlignmentLeft];
//        [self addSubview:self.rightLabel];
        
        
            //绘制右侧箭头导航
        self.rightImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-19, (50-16)/2, 9, 16)];
        self.rightImageVIew.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:self.rightImageVIew];
            
       
        
        //绘制分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewX(self.nameLabel), 50-0.5, ScreenWidth,0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        self.line=line;
        
        [self addSubview:self.line];
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
