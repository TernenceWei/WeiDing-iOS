//
//  WL_Application_TourGuide_Price_TableViewCell1.m
//  WeiLvDJS
//
//  Created by jyc on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_TourGuide_Price_TableViewCell1.h"

@implementation WL_Application_TourGuide_Price_TableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 30, 15)];
    _label1.textColor = [UIColor darkTextColor];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.font = [UIFont systemFontOfSize:12];
    _label1.text = @"单价";
    
    [self addSubview:_label1];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(150, 15, 60, 15)];
    _label2.textColor = [UIColor darkTextColor];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.font = [UIFont systemFontOfSize:12];
    _label2.text = @"单价/元";
    
    [self addSubview:_label2];
    
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(210, 15, 30, 15)];
    _label3.textColor = [UIColor darkTextColor];
    _label3.textAlignment = NSTextAlignmentCenter;
    _label3.font = [UIFont systemFontOfSize:12];
    _label3.text = @"单位";
    
    [self addSubview:_label3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
