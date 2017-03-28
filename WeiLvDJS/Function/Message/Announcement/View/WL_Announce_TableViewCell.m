//
//  WL_Announce_TableViewCell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
// 公告的cell
#import "WL_Announce_TableViewCell.h"

@implementation WL_Announce_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.photoImage =[WLTools allocImageView:CGRectMake(12.5, 0, ScreenWidth-25, 150) image:nil];
        
        self.photoImage.layer.cornerRadius =3.0;
        
        self.photoImage.layer.masksToBounds =YES;
        
        self.photoImage.contentMode = UIViewContentModeScaleToFill;
        
        [self.contentView addSubview:self.photoImage];
        
        self.timeImage =[WLTools allocImageView:CGRectMake(0, 8, 95, 22.5) image:[UIImage imageNamed:@"announcement"]];
        
        [self.photoImage addSubview:self.timeImage];
        
        self.timeLabel =[WLTools allocLabel:@"" font:WLFontSize(12) textColor:[UIColor whiteColor] frame:CGRectMake(7, 4.75, 88, 13) textAlignment:NSTextAlignmentLeft];
        
        [self.timeImage addSubview:self.timeLabel];
        
        self.detailLabel =[WLTools allocLabel:@"" font:WLFontSize(15) textColor:[UIColor whiteColor] frame:CGRectMake(7, 150-40, ScreenWidth-25-14, 30) textAlignment:NSTextAlignmentLeft];
        
        [self.photoImage addSubview:self.detailLabel];
        
    }

    return self;

}

-(void)setModel:(WL_Announce_Model *)model
{
    
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:nil];
    
    NSDate *date = [self.formatter1 dateFromString:model.create_date];
    
    NSString *dateString = [self.formatter2 stringFromDate:date];
    
    self.timeLabel.text = dateString;
    
    self.detailLabel.text = model.title;
    
}

-(NSDateFormatter *)formatter1
{
    if (_formatter1==nil) {
        
        _formatter1 =[[NSDateFormatter alloc]init];
        
        [_formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
  
    return _formatter1;
}

-(NSDateFormatter *)formatter2
{
    if (_formatter2==nil) {
        
        _formatter2 =[[NSDateFormatter alloc]init];
        
        [_formatter2 setDateFormat:@"yyyy.MM.dd"];
    }
    
    return _formatter2;
}

@end
