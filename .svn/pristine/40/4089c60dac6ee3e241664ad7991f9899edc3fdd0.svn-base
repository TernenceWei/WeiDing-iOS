//
//  WL_NotSet_Cell.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_NotSet_Cell.h"

@implementation WL_NotSet_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.noLabel =[UILabel new];
        
        self.noLabel.font =WLFontSize(16);
        
        self.noLabel.textColor =[WLTools stringToColor:@"#6f7378"];
        
        self.noLabel.text = @"无任何行程信息";
        
        [self.contentView addSubview:self.noLabel];
        
        [self.noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            
            make.center.mas_equalTo(self.contentView);
            
        }];
        
        
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
