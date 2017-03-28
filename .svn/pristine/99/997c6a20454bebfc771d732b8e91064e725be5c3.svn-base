//
//  WL_Mine_CapitalCell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/7.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MineViewController_CapitalCell.h"

@implementation WL_MineViewController_CapitalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.balanceLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth-1)/2, 70)];
        self.balanceLabel.font =WLFontSize(18);
        
        self.balanceLabel.textColor = [WLTools stringToColor:@"#4977e7"];
        
        self.balanceLabel.numberOfLines = 0;
        
    
        [self.contentView addSubview:self.balanceLabel];
        
        UIButton *balanceButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth-1)/2, 70)];
        
        [balanceButton addTarget:self action:@selector(balanceButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:balanceButton];
        
        
        UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 15, 1, 40)];
        line.backgroundColor = bordColor;
        
        [self.contentView addSubview:line];
        
        
        self.awardLabel =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-1, 0, (ScreenWidth-1)/2, 70)];
        
        self.awardLabel.font =WLFontSize(18);
        
        self.awardLabel.textColor =[WLTools stringToColor:@"#4977e7"];
        
        
        self.awardLabel.numberOfLines = 0;
        
        [self.contentView addSubview:self.awardLabel];
        
        UIButton *awardButton =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-1, 0, (ScreenWidth-1)/2, 70)];
        
        [awardButton addTarget:self action:@selector(awardButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:awardButton];

    }
    
    
    return  self;
}


-(void)balanceButton
{
    
    if (self.buttonClickBlock) {
        
        self.buttonClickBlock(ClickTypeBalance);
    }
}

-(void)awardButton
{
    if (self.buttonClickBlock) {
        
        self.buttonClickBlock(ClickTypeAward);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
