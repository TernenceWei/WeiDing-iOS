//
//  WL_CorporateStructure_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_CorporateStructure_Cell.h"

@implementation WL_CorporateStructure_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.nameLabel = [WLTools allocLabel:@"" font:WLFontSize(14) textColor:BlackColor frame:CGRectMake(10, 0,200, 45) textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.rightLabel = [WLTools allocLabel:@"" font:WLFontSize(14) textColor:[WLTools stringToColor:@"#879efa"] frame:CGRectMake(ScreenWidth-25-80, 0, 80, 45) textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:self.rightLabel];
        
        self.arrows =[WLTools allocImageView:CGRectMake(ScreenWidth-15-10, (45-15)/2, 15, 15) image:[UIImage imageNamed:@"arrow"]];
        
        [self.contentView addSubview:self.arrows];
        
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(10, 44.5, ScreenWidth-10, 0.5)];
        
        self.line.backgroundColor = bordColor;
        
        [self.contentView addSubview:self.line];
    }

    return self;
}

-(void)setModel:(WL_DepartmentModel *)model
{
    self.nameLabel.text = model.department_name;
    
    self.rightLabel.text= model.total_staff;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
