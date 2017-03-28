//
//  WL_Contacts_subTittle_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Contacts_subTittle_Cell.h"

@implementation WL_Contacts_subTittle_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.leftLabel = [WLTools allocLabel:@"" font:WLFontSize(15) textColor:BlackColor frame:CGRectMake(10, 0, 150, 50) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.leftLabel];
        
        self.rightLabel =[WLTools allocLabel:@"" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake(ScreenWidth-25-80, 0, 80, 50) textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:self.rightLabel];
        
        self.line =[[UILabel alloc]initWithFrame:CGRectMake(0, 49.5, ScreenWidth, 0.5)];
        
        self.line.backgroundColor = bordColor;
        
        [self.contentView addSubview:self.line];
        
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
