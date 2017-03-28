//
//  WL_Personinfo_TableViewCell.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Personinfo_TableViewCell.h"

@implementation WL_Personinfo_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    
    return  self;
}

-(void)creatView
{
    //左边标题
    _titleName = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, ScreenWidth-50, 50)];
    _titleName.textAlignment = NSTextAlignmentLeft;
    _titleName.textColor = [WLTools stringToColor:@"#333333"];
    //_titleName.backgroundColor = [UIColor redColor];
    _titleName.font = WLFontSize(17);
    [self addSubview:_titleName];
    //右边标题
    
    _rightTitleName = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, ScreenWidth-105, 50)];
    _rightTitleName.textAlignment = NSTextAlignmentRight;
    _rightTitleName.textColor = [UIColor grayColor];
    _rightTitleName.text = @"";
    //_rightTitleName.hidden = NO;
    _rightTitleName.font = WLFontSize(17);
    [self addSubview:_rightTitleName];
    //图片
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.frame = CGRectMake(ScreenWidth-25*2.2, 50/2-25/2, 25, 25);
    [self addSubview:_rightImageView];
    //_rightImageView.hidden = YES;
//跳转按钮
    _nextImageView = [[UIImageView alloc] init];
    _nextImageView.frame = CGRectMake(ScreenWidth-20, (self.frame.size.height / 2)-7, 11, 18);
    _nextImageView.image = [UIImage imageNamed:@"arrow"];
    [self addSubview:_nextImageView];
    //头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.frame = CGRectMake(ScreenWidth-50*1.5, 60/2-50/2 , 50, 50);
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 25;
    [self addSubview:_headImageView];
    
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _lineLabel.backgroundColor = [WLTools stringToColor:@"#e4e4e4"];
    [self addSubview:_lineLabel];
}
-(void)changeViewPath:(NSIndexPath *)path and:(NSString *)modelImg
{
// 箭头显示效果
    if (path.section == 0 && path.row == 3) {
        _nextImageView.hidden = YES;
    }
    else if (path.section == 0 && path.row == 0) {
        _nextImageView.hidden = YES;
    }
    else if (path.section != 0)
    {
        _nextImageView.hidden = YES;
    }
    else
    {
        _nextImageView.hidden = NO;
        if (path.row == 0) {
            _nextImageView.frame = CGRectMake(ScreenWidth-20, (self.frame.size.height / 2) - 2, 11, 18);
        }
    }
    
// 头像显示效果
    if (path.row == 0) {
        _lineLabel.frame = CGRectMake(0, 59.5, ScreenWidth, 0.5);
        _rightTitleName.hidden = YES;
        _headImageView.hidden = NO;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",modelImg]] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
        
        if ((path.section != 0) && path.row == 0) {
            _headImageView.frame = CGRectMake(13, 10 , 45, 45);
            _headImageView.layer.cornerRadius = 22.5;
            _titleName.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 15, 0, ScreenWidth-50, 60);
        }
        else
        {
            _rightTitleName.hidden = YES;
            _titleName.frame = CGRectMake(13, 5, ScreenWidth-50, 50);
            _headImageView.frame = CGRectMake(ScreenWidth-50*1.5, 60/2-50/2 , 50, 50);
        }
    }
    else
    {
        _lineLabel.frame = CGRectMake(0, 49.5, ScreenWidth, 0.5);
        _rightTitleName.hidden = NO;
        _headImageView.hidden = YES;
        _titleName.frame = CGRectMake(13, 0, ScreenWidth-50, 50);
        _headImageView.frame = CGRectMake(ScreenWidth-50*1.5, 60/2-50/2 , 50, 50);
    }
    
//二维码
    if ((path.section == 0 && path.row == 2)){
        
        _rightImageView.hidden = NO;
        _rightTitleName.hidden = YES;
        
        
        _rightImageView.image = [UIImage imageNamed:@"WLPersonInfoCode"];
    }
    else
    {
        _rightImageView.hidden = YES;
        _rightTitleName.hidden = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
