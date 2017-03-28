//
//  WL_Mine_HeaderView.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/6.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_HeaderView.h"

@interface WL_Mine_HeaderView()

@property(nonatomic,strong)UIView *whiteCircle; // 白色环圈
@property (nonatomic, strong) UIImageView * codeImg; // 二维码图标
@property (nonatomic, strong) UIImageView * goImg; // 箭头

@end

@implementation WL_Mine_HeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
       
        self.backgroundColor = [WLTools stringToColor:@"#303a4c"];
        
        [self createUI];
    }

    return self;
}

-(UIView *)whiteCircle
{
    
    if (_whiteCircle==nil) {
        
        _whiteCircle = [UIView new];
        
        _whiteCircle.backgroundColor =[UIColor whiteColor];

    }
    return _whiteCircle;
}

-(UIImageView *)photoImage
{
    if (_photoImage==nil) {
        
        _photoImage =[UIImageView new];
        
    }
    return _photoImage;
}

-(UIButton *)codeButton
{
    if (_codeButton==nil) {
        
        _codeButton =[UIButton new];
    }
    return _codeButton;

}
-(void)createUI
{
    [self addSubview:self.codeButton];
    
    [self addSubview:self.whiteCircle];
    
    [self.whiteCircle mas_makeConstraints:^(MASConstraintMaker *make){
      
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(120);
        //make.top.mas_equalTo(self.titlelabel.mas_bottom).offset(15);

        make.size.mas_equalTo(CGSizeMake(ScaleW(106), ScaleH(106)));
        
    }];
    
    self.whiteCircle.layer.masksToBounds = YES;
    self.whiteCircle.layer.cornerRadius = ScaleW(53);
    
    [self addSubview:self.photoImage];
    
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.size.mas_equalTo(CGSizeMake(ScaleW(105), ScaleH(105)));
        
        make.center.mas_equalTo(self.whiteCircle);
        
    }];
    self.photoImage.layer.masksToBounds =YES;
    
    if (IsiPhone4||IsiPhone5)
    {
        self.photoImage.layer.cornerRadius = 46;
    }
    else
    {
        self.photoImage.layer.cornerRadius = 52.5;
    }
    
    //[self.photoImage sd_setImageWithURL:[NSURL URLWithString:[WLUserTools getUserPhoto]] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    [self.photoImage setImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
    
    self.imageClickButton =[UIButton new];
    
    [self.imageClickButton addTarget:self action:@selector(imageClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.imageClickButton];
    
    [self.imageClickButton mas_makeConstraints:^(MASConstraintMaker *make){
       
        make.size.mas_equalTo(CGSizeMake(126, 126));
        
        make.center.mas_equalTo(self.photoImage);
        
    }];
    
    // 名字
    //[self addSubview:self.codeButton];
    _codeButton.backgroundColor = [UIColor whiteColor];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.mas_equalTo(self.whiteCircle.mas_bottom).offset(-20);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(self);
    }];
    
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    
   [self layoutIfNeeded];
    
    [_codeButton setTitleEdgeInsets:UIEdgeInsetsMake(0,-20, 0, 20)];
   
    [_codeButton setImageEdgeInsets:UIEdgeInsetsMake(0, _codeButton.width-15, 0, 0)];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_whiteCircle.frame.origin.x, ScaleH(30), _codeButton.frame.size.width - ScaleW(50), ScaleH(20))];
    _nameLabel.text = @"";
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [_codeButton addSubview:_nameLabel];
    
    _goImg = [[UIImageView alloc] initWithFrame:CGRectMake(_codeButton.frame.size.width - ScaleW(20), _nameLabel.frame.origin.y, ScaleW(10), ScaleH(15))];
    [_goImg setImage:[UIImage imageNamed:@"arrow"]];
    [_codeButton addSubview:_goImg];
    
// 描述
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_whiteCircle.frame.origin.x + _whiteCircle.frame.size.width + ScaleW(10), _whiteCircle.frame.origin.y + (_whiteCircle.frame.size.height / 3), self.width - _whiteCircle.frame.origin.x - _whiteCircle.frame.size.width - ScaleW(20), 50)];
    _contentLabel.text = @"";
    _contentLabel.numberOfLines = 2;
    _contentLabel.font = WLFontSize(14);
    _contentLabel.textColor = [UIColor whiteColor];
    [self addSubview:_contentLabel];
    
// 二维码
    _codeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - ScaleW(50), ScaleH(30), ScaleW(40), ScaleH(40))];
    _codeImgBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_codeImgBtn];
    
    _codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(10), ScaleW(30), ScaleH(30))];
    [_codeImg setImage:[UIImage imageNamed:@"WLMineQrCode"]];
    [_codeImgBtn addSubview:_codeImg];
}



@end
