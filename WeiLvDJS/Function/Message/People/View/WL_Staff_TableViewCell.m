//
//  WL_Staff_TableViewCell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Staff_TableViewCell.h"

@implementation WL_Staff_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.selectImageView = [WLTools allocButton:@"" textColor:nil nom_bg:[UIImage imageNamed:@"Driver_Order_NoSelected"] hei_bg:[UIImage imageNamed:@"Driver_Order_NoSelected"] frame:CGRectMake(10, (60-20)/2, 20, 20)];
        [self.selectImageView setBackgroundImage:[UIImage imageNamed:@"Driver_Order_Selected"] forState:UIControlStateSelected];
        
        //[self.selectImageView addTarget:self action:@selector(selectTapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *ClickButton =[[UIButton alloc]initWithFrame:self.frame];
        
        [ClickButton addTarget:self action:@selector(selectTapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.selectImageView];
        
        [self.contentView  addSubview:ClickButton];
        
        self.logoImageView = [WLTools allocImageView:CGRectMake(ViewRight(self.selectImageView)+10, 10, 40, 40) image:nil];
        
        self.logoImageView.layer.cornerRadius =20;
        
        self.logoImageView.layer.masksToBounds =YES;
        
        
        
        [self.contentView addSubview:self.logoImageView];
        
        self.nameLabel =[WLTools allocLabel:@"小白是" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewRight(self.logoImageView)+10,ViewY(self.logoImageView)-2, 150, 20) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.positionLabel = [WLTools allocLabel:@"13585487841" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake(ViewX(self.nameLabel),ViewBelow(self.nameLabel)+2, 200, 20) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.positionLabel];
        
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(10, 59.5,ScreenWidth-10,0.5)];
        
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

-(void)setModel:(WL_StaffModel *)model
{
    
    self.nameLabel.text = model.real_name;
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    self.positionLabel.text = model.department_name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
