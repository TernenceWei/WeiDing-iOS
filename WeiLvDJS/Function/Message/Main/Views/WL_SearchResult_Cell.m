//
//  WL_SearchResult_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SearchResult_Cell.h"

@implementation WL_SearchResult_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       
        self.nameLabel =[WLTools allocLabel:@"小白是" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(12.5,(44-20)/2,ScreenWidth-25, 20) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(12.5, 44,ScreenWidth-12.5, 0.5)];
        
        self.line.backgroundColor =bordColor;
        
        [self.contentView addSubview:self.line];
        
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
