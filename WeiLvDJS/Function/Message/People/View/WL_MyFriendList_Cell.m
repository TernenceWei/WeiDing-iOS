//
//  WL_MyFriendList_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_MyFriendList_Cell.h"

@implementation WL_MyFriendList_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectImageView = [WLTools allocButton:@"" textColor:nil nom_bg:[UIImage imageNamed:@"Driver_Order_NoSelected"] hei_bg:[UIImage imageNamed:@"Driver_Order_NoSelected"] frame:CGRectMake(10, (65-20)/2, 20, 20)];
        [self.selectImageView setBackgroundImage:[UIImage imageNamed:@"Driver_Order_Selected"] forState:UIControlStateSelected];
        
        //[self.selectImageView addTarget:self action:@selector(selectTapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *ClickButton =[[UIButton alloc]initWithFrame:self.frame];
        
        [ClickButton addTarget:self action:@selector(selectTapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView addSubview:self.selectImageView];
        
        [self.contentView  addSubview:ClickButton];
        
        self.logoImageView = [WLTools allocImageView:CGRectMake(ViewRight(self.selectImageView)+10, 10, 45, 45) image:nil];
        
        self.logoImageView.layer.cornerRadius =22.5;
        
        self.logoImageView.layer.masksToBounds =YES;
        
        [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
        
        //self.logoImageView.backgroundColor =[UIColor redColor];
        
        [self.contentView addSubview:self.logoImageView];
        
        self.nameLabel =[WLTools allocLabel:@"小白是" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewRight(self.logoImageView)+10,ViewY(self.logoImageView), 150, 20) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.telPhone = [WLTools allocLabel:@"13585487841" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake(ViewX(self.nameLabel),ViewBelow(self.nameLabel)+10, 200, 20) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.telPhone];

        self.line = [[UILabel alloc]initWithFrame:CGRectMake(95, 64.5,ScreenWidth-95, 0.5)];
        
        self.line.backgroundColor =bordColor;
        
        [self.contentView addSubview:self.line];
        
    }
    
    return self;
}

-(void)selectTapClick:(UIButton *)button

{
    self.selectImageView.selected = !self.selectImageView.selected;
    
    if (self.buttonSelectBlock) {
        
        self.buttonSelectBlock(self.path,self.selectImageView);
    }

    
}


-(void)setModel:(WL_AddressBook_MyFriend_Model *)model
{
    self.nameLabel.text = model.title;
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    self.telPhone.text = model.user_mobile;
}

-(void)setSearchResult:(WL_SearchResultModel *)searchResult

{
    self.nameLabel.text = searchResult.user_name;
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:searchResult.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    self.telPhone.text = searchResult.position_name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
