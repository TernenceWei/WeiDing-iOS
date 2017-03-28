//
//  WL_Application_TourGuide_Price_TableViewCell2.m
//  WeiLvDJS
//
//  Created by jyc on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_TourGuide_Price_TableViewCell2.h"

@implementation WL_Application_TourGuide_Price_TableViewCell2

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
    CGFloat height = 15;
    
    _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 11, 18)];
    [_deleteBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    
    [self addSubview:_deleteBtn];
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 50, height)];
    _label1.textAlignment = NSTextAlignmentLeft;
    _label1.textColor = [UIColor darkTextColor];
    _label1.font = [UIFont systemFontOfSize:12];
    _label1.text = @"按天计价";
    
    [self addSubview:_label1];
    
    _textView = [[XKPEPlaceholderTextView alloc] initWithFrame:CGRectMake(150, 10, 55, 25)];
    _textView.placeholder = @"请输入";
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _textView.font = [UIFont systemFontOfSize:12];
    [self addSubview:_textView];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(240, 15, 30, height)];
    _label2.textAlignment = NSTextAlignmentLeft;
    _label2.textColor = [UIColor darkTextColor];
    _label2.font = [UIFont systemFontOfSize:12];
    _label2.text = @"天";
    
    [self addSubview:_label2];
                 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
