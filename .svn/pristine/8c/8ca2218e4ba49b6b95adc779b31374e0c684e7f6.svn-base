//
//  WL_SearchFriend_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SearchFriend_Cell.h"

@implementation WL_SearchFriend_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.logoImageView = [WLTools allocImageView:CGRectMake(12.5, 5, 45, 45) image:nil];
        
        self.logoImageView.layer.cornerRadius =22.5;
        
        self.logoImageView.layer.masksToBounds =YES;
        
        [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
        
        //self.logoImageView.backgroundColor =[UIColor redColor];
        
        [self.contentView addSubview:self.logoImageView];
        
        self.nameLabel =[WLTools allocLabel:@"小白是" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewRight(self.logoImageView)+10,(55-20)/2,ScreenWidth-80, 20) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(70, 54.5,ScreenWidth-70, 0.5)];
        
        self.line.backgroundColor =bordColor;
        
        [self.contentView addSubview:self.line];
        
    }

    return self;
}

-(void)setModel:(WL_MessageList_itemsModel *)model
{
    _model = model;
//    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    self.logoImageView = nil;
    
    self.nameLabel.text = model.message;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
