//
//  WL_SelectReceiver_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SelectReceiver_Cell.h"

@implementation WL_SelectReceiver_Cell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.leftImage = [WLTools allocImageView:CGRectMake(10, (50-40)/2, 40, 40) image:[UIImage imageNamed:@"WeiDingFriends"]];
        
        [self.contentView addSubview:self.leftImage];
        
        self.nameLabel = [WLTools allocLabel:@"微叮好友" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewRight(self.leftImage)+8, 0, 200, 50) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.arrowImageView =[WLTools allocImageView:CGRectMake(ScreenWidth-15-10, (50-15)/2, 15, 15) image:[UIImage imageNamed:@"arrow"]];
        
        [self.contentView addSubview:self.arrowImageView];
        
        self.numberLabel = [WLTools allocLabel:@"2人" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake(ScreenWidth-25-50, 0, 50, 50) textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:self.numberLabel];
        
        self.line =[[UILabel alloc]initWithFrame:CGRectMake(10, 49.5, ScreenWidth-10, 0.5)];
        
        self.line.backgroundColor =bordColor;
        
        [self.contentView addSubview:self.line];
        
  
    }

    return self;
}

-(void)setModel:(WL_CompanyList_Model *)model
{
    self.nameLabel.text = model.company_name;
    
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:model.company_logo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    self.numberLabel.text =[NSString stringWithFormat:@"%@人",model.count];
 
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
