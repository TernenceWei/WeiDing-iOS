//
//  WL_Mine_RechargeViewController_Cell.m
//  WeiLv
//
//  Created by lyx on 16/6/27.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "WL_Mine_RechargeViewController_Cell.h"

@implementation WL_Mine_RechargeViewController_Cell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.leftImage =[WLTools allocImageView:CGRectMake(15, 15, 20, 20) image:nil];
        [self.contentView addSubview:self.leftImage];
        
        
        self.typeLabel =[WLTools allocLabel:@"" font:WLFontSize(14) textColor:[WLTools stringToColor:@"#2f2f2f"] frame:CGRectMake(ViewRight(self.leftImage)+10, 18, 100, 14) textAlignment:0];
        [self.contentView addSubview:self.typeLabel];
        
        self.line =[[UILabel alloc]initWithFrame:CGRectMake(0, 50-0.5, ScreenWidth, 0.5)];
        self.line.backgroundColor =bordColor;
        [self.contentView addSubview:self.line];
        
        
    }
    
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
