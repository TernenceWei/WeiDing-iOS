//
//  WL_Application_Driver_inforMation_TableViewCell1.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_inforMation_TableViewCell1.h"

@implementation WL_Application_Driver_inforMation_TableViewCell1

//- (void)awakeFromNib {
//    // Initialization code
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    
    return  self;
}

-(void)creatView
{
    CGFloat height,width,cireHeight,topHeight;
    if (ScreenWidth>320) {
        height = 25;
        cireHeight = 50;
        topHeight = 5;
        width = 25;
    }
    else{
        cireHeight = 45;
        topHeight = 5;
        height = 22;
        width = 22;
    }
    //左边标题
    _titleName = [[UILabel alloc] initWithFrame:CGRectMake(13, height-10, 70, 20)];
    _titleName.textAlignment = NSTextAlignmentLeft;
   
    _titleName.textColor =  [WLTools stringToColor:@"#333333"];
    
    _titleName.font = WLFontSize(17);
   
    [self addSubview:_titleName];
    //右边标题
    
    _rightTitleName = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_titleName) - 10,0,ScreenWidth-73-25, cireHeight)];
    _rightTitleName.textAlignment = NSTextAlignmentRight;
    _rightTitleName.textColor = [WLTools stringToColor:@"#6f7378"];
    _rightTitleName.numberOfLines = 2;
    _rightTitleName.text = @"";
    _rightTitleName.hidden = NO;
    _rightTitleName.font = WLFontSize(17);
    [self addSubview:_rightTitleName];
    //图片
    
    //跳转按钮
    _nextImageView = [[UIImageView alloc] init];
    _nextImageView.frame = CGRectMake(ScreenWidth-20, height-9, 11, 18);
    _nextImageView.image = [UIImage imageNamed:@"arrow"];
    [self addSubview:_nextImageView];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
