
//
//  WLGuideOrderLineView.m
//  WeiLvDJS
//
//  Created by whw on 16/10/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideOrderLineView.h"


@interface WLGuideOrderLineView()

@property(nonatomic, weak)UILabel *topLabel;

@property(nonatomic, strong)UIImageView *pickImageView;

@property(nonatomic, strong)UIImageView *sendImageView;

@property(nonatomic, strong)UILabel *pickLabel;

@property(nonatomic, strong)UILabel *pickTimeLabel;

@property(nonatomic, strong)UILabel *sendLabel;

@property(nonatomic, strong)UILabel *sendTimeLabel;

@property(nonatomic, strong)UIButton *line1Button;

@property(nonatomic, strong)UIButton *line2Button;

@end

@implementation WLGuideOrderLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLOR(0xffffff);
        self.layer.cornerRadius = 8;
        [self creatView];
    }
    return self;
}

-(void)creatView{
    UILabel *topLabel = [[UILabel  alloc] init];
    [self addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(8));
        make.top.equalTo(self.mas_top).offset(ScaleH(12));
        make.right.equalTo(self.mas_right).offset(-ScaleW(8));
    }];
    
    topLabel.font = WLFontSize(18);
    topLabel.textColor = HEXCOLOR(0x2f2f2f);
    topLabel.numberOfLines = 0;
    topLabel.text = @"【常州恐龙园2天1晚自由行特卖】住常州恐龙维景大酒店 + 玩恐龙园";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:topLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [topLabel.text length])];
    topLabel.attributedText = attributedString;
    
    _topLabel = topLabel;
    
//    UIImageView *lineImageView = [[UIImageView alloc] init];
//    [self addSubview:lineImageView];
//    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(8);
//        make.top.equalTo(self.mas_top).offset(150);
//        make.height.equalTo(@(5));
//    }];
//    lineImageView.image = [self drawLineByImageView:lineImageView];
    
  
   
    
    self.pickImageView = [[UIImageView alloc] init];
    [self addSubview:self.pickImageView];
    [self.pickImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(7));
        make.top.equalTo(self.topLabel.mas_bottom).offset(ScaleH(25));
    }];
    [self.pickImageView setImage:[UIImage imageNamed:@"recieveLocate"]];
//
    self.pickLabel = [[UILabel alloc] init];
    [self addSubview:self.pickLabel];
    [self.pickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pickImageView.mas_right).offset(ScaleW(10));
        make.top.equalTo(self.pickImageView.mas_top);
    }];
     self.pickLabel.font = WLFontSize(14);
    self.pickLabel.textColor = HEXCOLOR(0x868686);
    self.pickLabel.text = @"深圳市 南山区 腾讯大厦楼下公交牌站";
//
//    
    self.pickTimeLabel = [[UILabel alloc] init];
    [self addSubview:self.pickTimeLabel];
    [self.pickTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pickLabel.mas_left);
        make.top.equalTo(self.pickLabel.mas_bottom).offset(ScaleH(18));
    }];
    self.pickTimeLabel.font = WLFontSize(13);
    self.pickTimeLabel.textColor = HEXCOLOR(0xb5b5b5);
    self.pickTimeLabel.text = @"2016年10月8日 16：20";
    
//
    self.sendImageView = [[UIImageView alloc] init];
    [self addSubview:self.sendImageView];
    [self.sendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(7));
        make.top.equalTo(self.pickImageView.mas_bottom).offset(ScaleH(50));
    }];
    [self.sendImageView setImage:[UIImage imageNamed:@"sendLocate"]];
    
    self.sendLabel = [[UILabel alloc] init];
    [self addSubview:self.sendLabel];
    [self.sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sendImageView.mas_right).offset(ScaleW(10));
        make.top.equalTo(self.sendImageView.mas_top);
    }];
    self.sendLabel.font = WLFontSize(14);
    self.sendLabel.textColor = HEXCOLOR(0x868686);
    self.sendLabel.text = @"深圳市 南山区 腾讯大厦楼下公交牌站";
    
    
    self.sendTimeLabel = [[UILabel alloc] init];
    [self addSubview:self.sendTimeLabel];
    [self.sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sendLabel.mas_left);
        make.top.equalTo(self.sendLabel.mas_bottom).offset(ScaleH(18));
    }];
    self.sendTimeLabel.font = WLFontSize(13);
    self.sendTimeLabel.textColor = HEXCOLOR(0xb5b5b5);
    self.sendTimeLabel.text = @"2016年10月8日 16：20";

    
    self.line1Button = [[UIButton alloc] init];
    [self addSubview:self.line1Button];
    [self.line1Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-ScaleW(22));
        make.bottom.equalTo(self.mas_bottom).offset(-ScaleH(10));
    }];
    self.line1Button.adjustsImageWhenHighlighted = NO;//高亮时颜色不变
    [_line1Button setImage:[UIImage imageNamed:@"activate"] forState:UIControlStateNormal];
    [_line1Button setImage:[UIImage imageNamed:@"activate"] forState:UIControlStateHighlighted];
    [_line1Button setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [_line1Button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateHighlighted];
    [_line1Button setTitle:@"线路一" forState:UIControlStateNormal];
    [_line1Button.titleLabel setFont:WLFontSize(14)];
    [_line1Button setTitleEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(115), 0, 0)];
    
    self.line2Button = [[UIButton alloc] init];
    [self addSubview:self.line2Button];
    [self.line2Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(ScaleW(40));
        make.bottom.equalTo(self.mas_bottom).offset(-ScaleH(10));
    }];
    self.line2Button.adjustsImageWhenHighlighted = NO;//高亮时颜色不变
    [_line2Button setImage:[UIImage imageNamed:@"activate"] forState:UIControlStateNormal];
    [_line2Button setImage:[UIImage imageNamed:@"activate"] forState:UIControlStateHighlighted];
    [_line2Button setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
    [_line2Button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateHighlighted];
    [_line2Button setTitle:@"线路二" forState:UIControlStateNormal];
    [_line2Button.titleLabel setFont:WLFontSize(14)];
    [_line2Button setTitleEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(115), 0, 0)];

    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(8), ScaleH(140) , ScaleW(350), 2)];
    lineImage.image = [self drawLineByImageView:lineImage];
    [self addSubview:lineImage];
    
}

- (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度  1是高度
    CGFloat lengths[] = {9,6};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor blackColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0);    //开始画线
    CGContextAddLineToPoint(line, ScreenWidth - 10, 2.0);
    CGContextStrokePath(line);
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end









