//
//  WL_Application_TourGuide_Remark_TableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_TourGuide_Remark_TableViewCell.h"

@implementation WL_Application_TourGuide_Remark_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatinputTextView];
    }
    return self;
}

-(void)creatinputTextView{
    CGFloat height;
    if (IsiPhone4 || IsiPhone5) {
        height = 85;
    }
    else{
        height = 100;
    }
    _inputTextView = [[XKPEPlaceholderTextView alloc] init];
    _inputTextView.frame = CGRectMake(10, 10, ScreenWidth - 20, height);
    _inputTextView.layer.borderWidth = 1;
    _inputTextView.layer.masksToBounds = YES;
    _inputTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _inputTextView.layer.cornerRadius = 5;
    
    _inputTextView.font = WLFontSize(14);
    
    [self addSubview:_inputTextView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
