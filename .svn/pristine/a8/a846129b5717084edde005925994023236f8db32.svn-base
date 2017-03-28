//
//  WL_SelectReceiver_ContactsCell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_SelectReceiver_ContactsCell.h"

@implementation WL_SelectReceiver_ContactsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.userInteractionEnabled = YES;
        
        self.selectImageView = [WLTools allocButton:@"" textColor:nil nom_bg:[UIImage imageNamed:@"Driver_Order_NoSelected"] hei_bg:[UIImage imageNamed:@"Driver_Order_NoSelected"] frame:CGRectMake(10, 25-10, 20, 20)];
        [self.selectImageView setBackgroundImage:[UIImage imageNamed:@"Driver_Order_Selected"] forState:UIControlStateSelected];
        
       // [self.selectImageView addTarget:self action:@selector(selectTapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *ClickButton =[[UIButton alloc]initWithFrame:self.frame];
        
        [ClickButton addTarget:self action:@selector(selectTapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.selectImageView];
        
        [self.contentView addSubview:ClickButton];
        
        self.logoImageView = [WLTools allocImageView:CGRectMake(ViewRight(self.selectImageView)+10, 5, 40, 40) image:nil];
        
        self.logoImageView.layer.cornerRadius =20.0;
        
        self.logoImageView.layer.masksToBounds =YES;
        
       // self.logoImageView.backgroundColor =[UIColor redColor];
        
        [self.contentView addSubview:self.logoImageView];
        
        self.nameLabel =[WLTools allocLabel:@"小百事" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(ViewRight(self.logoImageView)+10, 0, 150, 50) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.detailLabel = [WLTools allocLabel:@"同组织" font:WLFontSize(14) textColor:[UIColor grayColor] frame:CGRectMake(ScreenWidth-10-100, 0, 100, 50) textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:self.detailLabel];
        
        self.line =[[UILabel alloc]initWithFrame:CGRectMake(ViewX(self.logoImageView), 49.5, ScreenWidth-ViewX(self.logoImageView), 0.5)
                    ];
        
        self.line.backgroundColor =bordColor;
        
        [self.contentView addSubview:self.line];
    }
    return self;
}

-(void)setModel:(WL_UsuallyContactsList_Model *)model
{
    self.nameLabel.text = model.user_name;
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    if ([model.isCompany integerValue]==1 &&[model.isFriend integerValue]==1) {
        
    self.detailLabel.text =@"同公司、好友";
        
    }else if ([model.isCompany integerValue]==1 &&[model.isFriend integerValue]==0)
    {
        self.detailLabel.text =@"同公司";
    }else if ([model.isCompany integerValue]==0 &&[model.isFriend integerValue]==1)
    {
        self.detailLabel.text =@"好友";
    }
    
   
    
}


-(void)selectTapClick:(UIButton *)button

{
    
    self.selectImageView.selected = !self.selectImageView.selected;
    
        if (self.buttonSelectBlock) {
            
            self.buttonSelectBlock(self.path,self.selectImageView);
        }
        
    
}


@end
