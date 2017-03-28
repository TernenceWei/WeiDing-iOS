//
//  WL_Account_MoneyCell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Account_MoneyCell.h"

@implementation WL_Account_MoneyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.balanceLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth-2)/3, 70)];
        self.balanceLabel.font =WLFontSize(14);
        
        self.balanceLabel.textColor = [WLTools stringToColor:@"#4977e7"];
        
        self.balanceLabel.numberOfLines = 0;
        
        
        [self.contentView addSubview:self.balanceLabel];
        
        UIButton *balanceButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth-2)/3, 70)];
        
        [balanceButton addTarget:self action:@selector(balanceButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:balanceButton];
        
        
        UILabel *line1 =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 15, 1, 40)];
        line1.backgroundColor = bordColor;
        
        [self.contentView addSubview:line1];
        
        self.frozen_amount =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3-1, 0, (ScreenWidth-2)/3, 70)];
        
        self.frozen_amount.font =WLFontSize(14);
        
        self.frozen_amount.textColor = [WLTools stringToColor:@"#4977e7"];
        
        self.frozen_amount.numberOfLines = 0;
        
        [self.contentView addSubview:self.frozen_amount];

        
        UIButton *frozen_amountButton =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3-1, 0, (ScreenWidth-2)/3, 70)];
        
        [frozen_amountButton addTarget:self action:@selector(frozen_amountButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:frozen_amountButton];
        
    
        UILabel *line2 =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3*2, 15, 1, 40)];
        line2.backgroundColor = bordColor;
        
        [self.contentView addSubview:line2];
        
        self.awardLabel =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3*2, 0, (ScreenWidth-2)/3, 70)];
        
        self.awardLabel.font =WLFontSize(14);
        
        self.awardLabel.textColor =[WLTools stringToColor:@"#4977e7"];
        
        self.awardLabel.numberOfLines = 0;
        
        [self.contentView addSubview:self.awardLabel];
        
        UIButton *awardButton =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3*2, 0, (ScreenWidth-2)/3, 70)];
        
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

-(void)frozen_amountButton
{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(ClickTypeFrozen_amount);
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
