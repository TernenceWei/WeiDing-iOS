//
//  WL_Mine_SetViewController_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_SetViewController_Cell.h"

@implementation WL_Mine_SetViewController_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       
        //绘制左侧显示标签
        self.nameLabel = [UILabel new];
        
        self.nameLabel.textColor = BlackColor;
        
        self.nameLabel.font = WLFontSize(15);
        
        self.nameLabel.textAlignment = NSTextAlignmentLeft;

        [self.contentView addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(12.5);
            
            make.centerY.mas_equalTo(self);
            
        }];
        
       
        self.newimage =[UIImageView new];
        
        [self.contentView addSubview:self.newimage];
        
        [self.newimage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(self);
            
            make.left.mas_equalTo(self.nameLabel.mas_right);
            
        }];
        
        
        self.newimage.hidden=YES;
        
        //绘制右侧箭头导航
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-19, (50-16)/2, 9, 15)];
        self.rightImageView.image = [UIImage imageNamed:@"arrow"];
        [self.contentView addSubview:self.rightImageView];
        
        
        self.rightLabel =[UILabel new];
        
        self.rightLabel.textColor =WLColor(176, 183, 193, 1);
        
        self.rightLabel.font =WLFontSize(15);
        
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        
        //self.rightLabel.text = @"已保护";
        
        [self.contentView addSubview:self.rightLabel];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.right.mas_equalTo(self.rightImageView.mas_left).offset(-10);
            
            make.top.mas_equalTo(0);
            
            make.height.mas_equalTo(50);
            
        }];
        
        self.markImage =[UIImageView new];
        
        //self.markImage.image =[UIImage imageNamed:@"SetProtect"];
        
        [self.contentView addSubview:self.markImage];
        
        self.markImage.hidden =YES;
        
        [self.markImage mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.right.mas_equalTo(self.rightLabel.mas_left).offset(-10);
            
            make.centerY.mas_equalTo(self);
            
        }];
        
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
