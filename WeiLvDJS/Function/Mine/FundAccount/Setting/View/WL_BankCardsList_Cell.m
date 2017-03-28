//
//  WL_BankCardsList_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BankCardsList_Cell.h"

@implementation WL_BankCardsList_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bankName =[WLTools allocLabel:@"" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(0, 0, ScreenWidth, 45) textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.bankName];
        
        self.line =[WLTools allocLabel:@"" font:nil textColor:bordColor frame:CGRectMake(0, 45-0.5, ScreenWidth, 0.5) textAlignment:NSTextAlignmentCenter];
        
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
