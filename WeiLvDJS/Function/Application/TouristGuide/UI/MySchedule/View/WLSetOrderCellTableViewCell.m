//
//  WLSetOrderCellTableViewCell.m
//  WeiLvDJS
//
//  Created by xiaobai2268 on 2016/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLSetOrderCellTableViewCell.h"

@implementation WLSetOrderCellTableViewCell

//- (void)awakeFromNib {
//    // Initialization code
//}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier


{
    
    if (self =[super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        
        self.dateImage =[UIImageView new];

        self.dateImage.image = [UIImage imageNamed:@"tripCalendar"];
        
        [self.contentView addSubview:self.dateImage];
        
        [self.dateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.size.mas_equalTo(CGSizeMake(15, 15));
            
            make.top.mas_equalTo(15);
            
        }];
        
        self.dateLabel =[UILabel new];
        
        self.dateLabel.font =WLFontSize(12);
        
        self.dateLabel.textColor = BlackColor;
        
        [self.contentView addSubview:self.dateLabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.dateImage.mas_right).mas_equalTo(10);
            
            make.top.mas_equalTo(15);
            
            make.height.mas_equalTo(15);
            
        }];
        
        self.dateLabel .text = @"2016-8-11  星期三";
        
        UILabel *line =[UILabel new];
        
        line.backgroundColor = bordColor;
        
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(45);
            
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 0.5));
            
        }];
        
        
        self.orderButton =[UIButton new];
        
        [self.orderButton setBackgroundImage:[UIImage imageNamed:@"orderUnselect"] forState:UIControlStateNormal];
        
        [self.orderButton setBackgroundImage:[UIImage imageNamed:@"orderSelect"] forState:UIControlStateSelected];
        
        
        [self.orderButton addTarget:self action:@selector(orderButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView addSubview:self.orderButton];
        
        [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(25);
            
            make.top.mas_equalTo(line.mas_bottom).mas_equalTo(25);
            
        }];
        
        self.rejectButton =[UIButton new];
        
        [self.rejectButton setBackgroundImage:[UIImage imageNamed:@"rejectOrderUnSelect"] forState:UIControlStateNormal];
        
        [self.rejectButton setBackgroundImage:[UIImage imageNamed:@"rejectOrderSelect"] forState:UIControlStateSelected];
        
        
        [self.rejectButton addTarget:self action:@selector(rejectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.rejectButton];
        
        [self.rejectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-25);
            
            make.top.mas_equalTo(self.orderButton.mas_top);
            
        }];
    }
    
    
    return self;
    
}


-(void)rejectButton:(UIButton *)button
{
    
    button.selected = YES;
    
    self.orderButton.selected =NO;
    
    if (self.rejectAndOrderButton) {
        
        self.rejectAndOrderButton(@"reject");
        
    }
}


-(void)orderButton:(UIButton *)button

{
    button.selected =YES;
    
    self.rejectButton.selected=NO;
    
    if (self.rejectAndOrderButton) {
        
        self.rejectAndOrderButton(@"order");
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
