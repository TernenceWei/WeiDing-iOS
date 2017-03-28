//
//  WL_Application_Driver_inforMation_TableViewCell2.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_Driver_inforMation_TableViewCell2.h"

@implementation WL_Application_Driver_inforMation_TableViewCell2

//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    //第一张
    _imageView1 = [[UIImageView alloc] init];
    _imageView1.userInteractionEnabled = YES;
    _imageView1.image = [UIImage imageNamed:@"upload"];
    _imageView1.layer.cornerRadius = 5;
    _imageView1.layer.masksToBounds = YES;
    _imageView1.tag = 101;
    [self addSubview:_imageView1];
    // 选择的事件
    UITapGestureRecognizer *tapDownGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    
    [_imageView1 addGestureRecognizer:tapDownGesture1];

    //第二张
    _imageView2 = [[UIImageView alloc] init];
    _imageView2.userInteractionEnabled = YES;
    _imageView2.image = [UIImage imageNamed:@"upload"];
    _imageView2.layer.cornerRadius = 5;
    _imageView2.layer.masksToBounds = YES;
    _imageView2.tag = 102;
    [self addSubview:_imageView2];
    UITapGestureRecognizer *tapDownGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    

    [_imageView2 addGestureRecognizer:tapDownGesture2];
    
    if (IsiPhone4||IsiPhone5) {
        _imageView1.frame = CGRectMake(120-20, topHeight, (ScreenWidth-180+20+30)/2, boreHeight);
        _imageView2.frame = CGRectMake(ScreenWidth/2+35+15, topHeight, (ScreenWidth-180+20+30)/2, boreHeight);
    }
    else
    {
       _imageView1.frame = CGRectMake(120, topHeight, (ScreenWidth-180)/2, boreHeight);
        _imageView2.frame = CGRectMake(ScreenWidth/2+60, topHeight, (ScreenWidth-180)/2, boreHeight);
    }
    //标题
    _label1 = [[UILabel alloc] init];
    _label1.frame = CGRectMake(_imageView1.frame.origin.x, _imageView1.frame.origin.y+boreHeight+topHeight, _imageView1.frame.size.width, labelHeight-2);
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.textColor = Color3;
    _label1.font = WLFontSize(14);
    
    [self addSubview:_label1];
    //背面照
    _label2 = [[UILabel alloc] init];
    _label2.frame = CGRectMake(_imageView2.frame.origin.x, _imageView2.frame.origin.y+boreHeight+topHeight, _imageView2.frame.size.width, labelHeight-2);
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.textColor = Color3;
    _label2.font = WLFontSize(14);
    
    [self addSubview:_label2];

}
#pragma mark----手势点击事件
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    if (_imageViewBack) {
        self.imageViewBack(imageView.tag);
    }
}
-(void)setTextStr:(NSIndexPath *)path
{
    if (path.section==1) {
      _label1.text = @"身份证正面照";
     _label2.text = @"身份证背面照";
    }
    else
    {
        _label1.text = @"驾驶证正面照";
        _label2.text = @"驾驶证背面照";
    }
}
@end
