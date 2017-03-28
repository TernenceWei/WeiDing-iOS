//
//  WL_Application_TourGuide_Picure_TableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_TourGuide_Picure_TableViewCell.h"

@implementation WL_Application_TourGuide_Picure_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    return self;
}
- (void)creatView{
    CGFloat topHeight,boreHeight,labelHeight;
    if (IsiPhone4||IsiPhone5) {
        topHeight = 3;
        boreHeight = 80;
        labelHeight = 15;
    }
    else
    {
        topHeight = 5;
        boreHeight = 85;
        labelHeight = 17;
    }
    //证件正面
    _imageView1 = [[UIImageView alloc] init];
    _imageView1.userInteractionEnabled = YES;
    _imageView1.image = [UIImage imageNamed:@"WLPersonInfoIDCardFont"];
    _imageView1.layer.cornerRadius = 5;
    _imageView1.tag = 1;
    _imageView1.layer.masksToBounds = YES;
    
    [self addSubview:_imageView1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_imageView1 addGestureRecognizer:tap1];
    
    //证件背面
    _imageView2 = [[UIImageView alloc] init];
    _imageView2.userInteractionEnabled = YES;
    _imageView2.image = [UIImage imageNamed:@"WLPersonInfoIDCardBack"];
    _imageView2.layer.cornerRadius = 5;
    _imageView2.layer.masksToBounds = YES;
    _imageView2.tag =2;
    [self addSubview:_imageView2];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_imageView2 addGestureRecognizer:tap2];
    if (IsiPhone4||IsiPhone5) {
        _imageView1.frame = CGRectMake(120-20, topHeight, (ScreenWidth-180+20+30)/2, boreHeight);
        _imageView2.frame = CGRectMake(ScreenWidth/2+35+15, topHeight, (ScreenWidth-180+20+30)/2, boreHeight);
    }
    else
    {
        _imageView1.frame = CGRectMake(120, topHeight, (ScreenWidth-180)/2, boreHeight);
        _imageView2.frame = CGRectMake(ScreenWidth/2+60, topHeight, (ScreenWidth-180)/2, boreHeight);
    }

    
    _label1 = [[UILabel alloc] init];
    _label1.frame = CGRectMake(_imageView1.frame.origin.x, _imageView1.frame.origin.y+boreHeight+topHeight, _imageView1.frame.size.width, labelHeight-2);
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.textColor = [WLTools stringToColor:@"#4977e7"];
    _label1.font = WLFontSize(12);
    
    [self addSubview:_label1];
    
    
    _label2 = [[UILabel alloc] init];
    _label2.frame = CGRectMake(_imageView2.frame.origin.x, _imageView2.frame.origin.y+boreHeight+topHeight, _imageView2.frame.size.width, labelHeight-2);
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.textColor = [WLTools stringToColor:@"#4977e7"];
    _label2.font = WLFontSize(12);
    
    [self addSubview:_label2];
}

- (void)setTextStr:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        _label1.text = @"身份证正面照";
        _label2.text = @"身份证背面照";

    }else
    {
        _label1.text = @"导游证正面照";
        _label2.text = @"导游证背面照";

    }
}

-(void)tapClick:(UIGestureRecognizer *)tap{
    
    UIImageView *imageView = (UIImageView *)tap.view;
    if (_imageViewBack) {
        self.imageViewBack(imageView.tag);
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

