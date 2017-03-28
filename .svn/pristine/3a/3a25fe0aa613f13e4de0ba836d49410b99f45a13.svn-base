//
//  WL_Application_Driver_inforMation_TableViewCell3.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/20.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_inforMation_TableViewCell3.h"
//#import "XKPEPlaceholderTextView.h"
@implementation WL_Application_Driver_inforMation_TableViewCell3

//- (void)awakeFromNib {
//    // Initialization code
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatInputTextView];
    }
    
    return  self;
}
-(void)creatInputTextView
{
    CGFloat height;
    if (IsiPhone4||IsiPhone5) {
        height = 85;
    }
    else
    {
        height = 100;
        
    }
    _inputTextView = [[XKPEPlaceholderTextView alloc] init];
    _inputTextView.frame = CGRectMake(10, 10, ScreenWidth-20, height-10);
    _inputTextView.layer.borderWidth = 0.5;
    _inputTextView.layer.masksToBounds = YES;
    _inputTextView.layer.borderColor = [UIColor grayColor].CGColor;
    _inputTextView.layer.cornerRadius = 5;
   _inputTextView.textColor = [WLTools stringToColor:@"#2f2f2f"];
    _inputTextView.placeholderColor = [WLTools stringToColor:@"#868686"];
    _inputTextView.font = WLFontSize(14);
    [self addSubview:_inputTextView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
