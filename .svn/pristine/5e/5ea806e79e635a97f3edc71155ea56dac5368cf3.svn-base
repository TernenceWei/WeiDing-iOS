//
//  WL_Application_TourGuide_Price_TableViewCell3.m
//  WeiLvDJS
//
//  Created by jyc on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_TourGuide_Price_TableViewCell3.h"

@implementation WL_Application_TourGuide_Price_TableViewCell3

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

-(void)creatView{
    CGFloat height = 15;
    _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 15, 15)];
    [_deleteBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [self addSubview:_deleteBtn];
    
    _textView1 = [[XKPEPlaceholderTextView alloc] initWithFrame:CGRectMake(35, 15, 65, height)];
    _textView1.layer.borderColor = [UIColor clearColor].CGColor;
    _textView3.layer.borderWidth = 1;
    [self addSubview:_textView1];
    
    _textView2 = [[XKPEPlaceholderTextView alloc] initWithFrame:CGRectMake(150, 10, 55, 25)];
    _textView2.layer.borderWidth = 1;
    _textView2.layer.masksToBounds = YES;
    
    _textView2.font = [UIFont systemFontOfSize:8];
    _textView2.layer.borderColor = [UIColor grayColor].CGColor;
    _textView2.placeholder = @"请输入";
    [self addSubview:_textView2];

    
    _textView3 = [[XKPEPlaceholderTextView alloc] initWithFrame:CGRectMake(240, 15, 40, height)];
    _textView3.layer.borderWidth = 1;
    _textView3.layer.borderColor = [UIColor clearColor].CGColor;
    [self addSubview:_textView3];
    
    _underline1 = [[UIImageView alloc] initWithFrame:CGRectMake(35, 31, 65, 1)];
    _underline1.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_underline1];
    
    _underline2 = [[UIImageView alloc] initWithFrame:CGRectMake(240, 31, 40, 1)];
    _underline2.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_underline2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
