//
//  WL_TransferRecordCell.m
//  WeiLvDJS
//
//  Created by jyc on 16/10/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_TransferRecordCell.h"

@implementation WL_TransferRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.typeLabel =[WLTools allocLabel:@"提现" font:WLFontSize(15) textColor:WLColor(47, 47, 47, 1) frame:CGRectMake(12.5, 13, 100, 16) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.typeLabel];
        
        
        self.numberLabel = [WLTools allocLabel:@"＋1180.03" font:WLFontSize(15) textColor:WLColor(47, 47, 47, 1) frame:CGRectMake(ScreenWidth-10-150, ViewY(self.typeLabel), 150, 16) textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:self.numberLabel];
        
        
        self.groupLabel = [WLTools allocLabel:@"＋1180.03" font:WLFontSize(12) textColor:WLColor(111, 115, 120, 1) frame:CGRectMake(12.5, ViewBelow(self.typeLabel)+10,ScreenWidth-10-12.5, 16) textAlignment:NSTextAlignmentLeft];
        
        self.groupLabel.numberOfLines = 1;
        
        [self.contentView addSubview:self.groupLabel];
        
        
        self.dateLabel =[WLTools allocLabel:@"2016-12-02" font:WLFontSize(12) textColor:WLColor(111, 115, 120, 1) frame:CGRectMake(12.5, ViewBelow(self.groupLabel)+5, 200, 14) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.dateLabel];
        
        
        self.statusLabel =[WLTools allocLabel:@"银行处理中" font:WLFontSize(12) textColor:WLColor(111, 115, 120, 1) frame:CGRectMake(ScreenWidth-10-200, ViewY(self.dateLabel), 200, 14) textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:self.statusLabel];
        
        
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(0, 84.5, ScreenWidth, 0.5)];
        
        self.line.backgroundColor= bordColor;
        
        [self.contentView addSubview:self.line];
    }
    
    return self;
    
}

-(void)setModel:(WL_TradeRecord_Model *)model
{
    
    
    NSString *typeString;
    
    if ([model.finance_type isEqualToString:@"5"]) {
        
        typeString = @"转账-备用金";
        
    }else if ([model.finance_type isEqualToString:@"6"])
    {
        typeString = @"转账-团费结算";
        
    }
    
    
    NSString *statusString;
    
    if ([model.finance_status isEqualToString:@"0"]) {
        
        statusString =@"审核中";
        
    }else if ([model.finance_status isEqualToString:@"1"])
    {
        statusString =@"成功";
    }else if ([model.finance_status isEqualToString:@"2"])
    {
        statusString =@"撤销";
        
    }else if ([model.finance_status isEqualToString:@"3"])
    {
        statusString =@"拒绝";
    }
    
    self.typeLabel.text = typeString;
    
    if ([model.is_income isEqualToString:@"0"]) {
        
        self.numberLabel.text =[NSString stringWithFormat:@"＋%0.2f",[model.amount floatValue]];
    }else if ([model.is_income isEqualToString:@"1"])
    {
        self.numberLabel.text =[NSString stringWithFormat:@"－%0.2f",[model.amount floatValue]];
    }
    
    
    self.dateLabel.text = model.create_date;
    
    self.groupLabel.text  =[NSString stringWithFormat:@"团号 %@",model.remark];
    
    self.statusLabel.text = statusString;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
