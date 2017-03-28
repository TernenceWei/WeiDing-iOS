//
//  WL_Application_TourGuide_BasicInfo_TableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_TourGuide_BasicInfo_TableViewCell.h"

@implementation WL_Application_TourGuide_BasicInfo_TableViewCell

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
    CGFloat height,width,cireHeight,topHeight;
    if (ScreenWidth > 320) {
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
    self.titleName = [[UILabel alloc]initWithFrame:CGRectMake(13,height - 10, ScreenWidth - 50, 20)];
    _titleName.textAlignment = NSTextAlignmentLeft;
    _titleName.textColor = [WLTools stringToColor:@"#6f7378"];
    _titleName.font = WLFontSize(14);
    [self addSubview:_titleName];
    
    //右边标题
    _rightTitleName = [[UILabel alloc]initWithFrame:CGRectMake(50, height - 10, ScreenWidth - 80, 20)];
    _rightTitleName.textAlignment = NSTextAlignmentRight;
    _rightTitleName.textColor = [UIColor grayColor];
    _rightTitleName.text = @"右边";
    _rightTitleName.hidden = NO;
    _rightTitleName.font = [UIFont systemFontOfSize:14];
    [self addSubview:_rightTitleName];
    
    //跳转按钮
    _nextImageView = [[UIImageView alloc] init];
    _nextImageView.frame = CGRectMake(ScreenWidth - 20, height - 9, 11, 18);
    _nextImageView.image = [UIImage imageNamed:@"arrow"];
    [self addSubview:_nextImageView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
