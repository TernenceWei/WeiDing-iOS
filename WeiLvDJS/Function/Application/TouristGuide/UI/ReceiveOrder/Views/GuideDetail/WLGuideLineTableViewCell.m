//
//  WLGuideLineTableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/11/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideLineTableViewCell.h"

@interface WLGuideLineTableViewCell()

@end



@implementation WLGuideLineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    
        
    }
    return self;
}


-(void)creatView{
    //    定位图片
    _locateImageView = [[UIImageView alloc] init];
    _locateImageView.image = [UIImage imageNamed:@"day"];
    [self addSubview:_locateImageView];
    [_locateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(12));
        make.top.equalTo(self.mas_top).offset(ScaleH(21));
        make.height.equalTo(@(26));
    }];
    
    _dayshowLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, ScaleW(15), ScaleH(15))];
    _dayshowLabel.textColor = [UIColor whiteColor];
    _dayshowLabel.font = WLFontSize(15);
    [_locateImageView addSubview:_dayshowLabel];
    
    //标题label
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_locateImageView.mas_right).offset(5);
        make.centerY.equalTo(_locateImageView.mas_centerY);
    }];
    titleLabel.font = WLFontSize(15);
    titleLabel.textColor = HEXCOLOR(0x4877e7);
    _titleLabel = titleLabel;
    
    //day图片
    UIImageView *dayImageView = [[UIImageView alloc] init];
    [self addSubview:dayImageView];
    dayImageView.image = [UIImage imageNamed:@"location"];
    if (IsiPhone6P) {
        [dayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_locateImageView.mas_centerX).offset(12);
            make.top.equalTo(titleLabel.mas_bottom).offset(15);
            make.width.equalTo(@(27));
            make.height.equalTo(@(30));
        }];
    }else{
        [dayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_locateImageView.mas_centerX).offset(12);
            make.top.equalTo(titleLabel.mas_bottom).offset(15);
            make.width.equalTo(@(16));
            make.height.equalTo(@(20));
        }];
    }
   

    
    //内容图片
    UILabel *contentLabel = [[UILabel alloc] init];
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dayImageView.mas_right).offset(5);
        make.top.equalTo(dayImageView.mas_top);
        make.right.equalTo(self.mas_right).offset(-ScaleW(12));
    }];
    contentLabel.numberOfLines = 0;
    contentLabel.font = WLFontSize(14);
    contentLabel.textColor = HEXCOLOR(0x6f7378);
    contentLabel.text = @"";
    
    _contentLabel = contentLabel;
    

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentLabel.text length])];
    contentLabel.attributedText = attributedString;
    
    NSDictionary *textAttt = @{NSFontAttributeName : WLFontSize(14)};
    CGSize maxTextSize = CGSizeMake(contentLabel.width, MAXFLOAT);
    CGFloat contentHieght = [contentLabel.text boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttt context:nil].size.height;
    NSLog(@"%f",contentHieght);
    
    CGSize imageSize = CGSizeMake(1, contentHieght+ScaleH(20));
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [HEXCOLOR(0x4877e7) set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _lineImageView = [[UIImageView alloc] init];
    [self addSubview:_lineImageView];
    _lineImageView.image = pressedColorImg;

}

- (void)setDataModel:(NSString *)model dayrow:(NSString *)dayrow height:(CGSize)size
{
    _dayshowLabel.text = dayrow;
    _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, 30 + size.height);
    _contentLabel.text = model;

    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_locateImageView.mas_centerX);
        make.top.equalTo(_locateImageView.mas_bottom);
        make.width.equalTo(@(1));
        if (size.height > 50) {
            make.height.equalTo(@(ScaleH(5) + size.height));
        }
        else
        {
            make.height.equalTo(@(ScaleH(20) + size.height));
        }
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
