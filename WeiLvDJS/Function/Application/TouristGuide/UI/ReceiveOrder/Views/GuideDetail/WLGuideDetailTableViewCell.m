//
//  WLGuideDetailTableViewCell.m
//  WeiLvDJS
//
//  Created by whw on 16/10/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLGuideDetailTableViewCell.h"

@interface WLGuideDetailTableViewCell()
@property(nonatomic, strong)WLSubLineInfo *lineInfo;
@property(nonatomic, strong)WLGroupDetailInfo *detailInfo;

@property(nonatomic, strong)UILabel *topLabel;

@property(nonatomic, strong)UILabel *peopleNumLabel;

@property(nonatomic, strong)UILabel *pickLabel;

@property(nonatomic, strong)UILabel *pickTimeLabel;

@property(nonatomic, strong)UILabel *sendLabel;

@property(nonatomic, strong)UILabel *sendTimeLabel;

@property(nonatomic, strong)UIButton *line1Button;

@property(nonatomic, strong)UIButton *line2Button;

@property(nonatomic, strong)UIImageView *lineImageView;
@property(nonatomic, strong)UIButton *selectedButton;
@end

@implementation WLGuideDetailTableViewCell

-(instancetype)initWithFrame:(CGRect)frame detailInfo:(WLGroupDetailInfo *)detailInfo selectAction:(void (^)())selectAction{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(0xf7f7f8);
        self.detailInfo = detailInfo;

        [self creatView];
        
    }
    return self;
}

- (void)setLineInfo:(WLSubLineInfo *)lineInfo
{
    _lineInfo = lineInfo;
    
    _topLabel.text = self.lineInfo.lineName;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_topLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_topLabel.text length])];
    _topLabel.attributedText = attributedString;
    
    _peopleNumLabel.text = self.lineInfo.peopleCount;
    _pickLabel.text = self.lineInfo.comeAddress;
    _pickTimeLabel.text = self.lineInfo.comeDate;
    _sendLabel.text = self.lineInfo.backAddress;
    _sendTimeLabel.text = self.lineInfo.backDate;
    
}


-(void)creatView{

    if (!_detailInfo) {
        return;
    }
    
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(165))];
    backgroundImageView.image = [UIImage imageNamed:@"triangle"];
    [self addSubview:backgroundImageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(12), 0, ScreenWidth - ScaleW(22), ScaleH(275))];
    view.backgroundColor = HEXCOLOR(0xffffff);
    view.layer.cornerRadius = 8;
    [self addSubview:view];
    
    UILabel *topLabel = [[UILabel  alloc] init];
    [view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(ScaleW(8));
        make.top.equalTo(view.mas_top).offset(ScaleH(12));
        make.right.equalTo(view.mas_right).offset(-ScaleW(8));
    }];
    
    topLabel.font = WLFontSize(18);
    topLabel.textColor = HEXCOLOR(0x2f2f2f);
    topLabel.numberOfLines = 0;
    _topLabel = topLabel;
    
    UILabel *peopleNumLabel = [[UILabel alloc] init];
    [view addSubview:peopleNumLabel];
    [peopleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-ScaleW(20));
        make.bottom.equalTo(_topLabel.mas_bottom);
    }];
    peopleNumLabel.font = WLFontSize(15);
    peopleNumLabel.textColor = HEXCOLOR(0xfe798c);
    peopleNumLabel.text = @"80+4";
    _peopleNumLabel = peopleNumLabel;

    
    UIImageView *pickImageView = [[UIImageView alloc] init];
    [self addSubview:pickImageView];
    [pickImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(ScaleW(7));
        make.top.equalTo(topLabel.mas_bottom).offset(ScaleH(25));
    }];
    [pickImageView setImage:[UIImage imageNamed:@"recieveLocate"]];
    //
    UILabel *pickLabel = [[UILabel alloc] init];
    [self addSubview:pickLabel];
    [pickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pickImageView.mas_right).offset(ScaleW(10));
        make.top.equalTo(pickImageView.mas_top);
    }];
    pickLabel.font = WLFontSize(14);
    pickLabel.textColor = HEXCOLOR(0x868686);
    _pickLabel = pickLabel;
    //
    //
    UILabel *pickTimeLabel = [[UILabel alloc] init];
    [self addSubview:pickTimeLabel];
    [pickTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pickLabel.mas_left);
        make.top.equalTo(pickLabel.mas_bottom).offset(ScaleH(18));
    }];
    pickTimeLabel.font = WLFontSize(13);
    pickTimeLabel.textColor = HEXCOLOR(0xb5b5b5);
    _pickTimeLabel = pickTimeLabel;
    
    //
    UIImageView *sendImageView = [[UIImageView alloc] init];
    [self addSubview:sendImageView];
    [sendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(ScaleW(7));
        make.top.equalTo(pickImageView.mas_bottom).offset(ScaleH(50));
    }];
    [sendImageView setImage:[UIImage imageNamed:@"sendLocate"]];
    
    UILabel *sendLabel = [[UILabel alloc] init];
    [self addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendImageView.mas_right).offset(ScaleW(10));
        make.top.equalTo(sendImageView.mas_top);
    }];
    sendLabel.font = WLFontSize(14);
    sendLabel.textColor = HEXCOLOR(0x868686);
    _sendLabel = sendLabel;
    
    
    UILabel *sendTimeLabel = [[UILabel alloc] init];
    [self addSubview:sendTimeLabel];
    [sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendLabel.mas_left);
        make.top.equalTo(sendLabel.mas_bottom).offset(ScaleH(18));
    }];
    sendTimeLabel.font = WLFontSize(13);
    sendTimeLabel.textColor = HEXCOLOR(0xb5b5b5);
    _sendTimeLabel = sendTimeLabel;
    
    if (self.detailInfo.lineArray.count != 0) {
        self.lineInfo = [self.detailInfo.lineArray objectAtIndex:0];
    }

    for (int i = 0; i < self.detailInfo.lineArray.count; i++) {

        UIButton *line2Button = [[UIButton alloc] init];
        CGFloat width = ScaleW(70);
        CGFloat x = ScreenWidth - ScaleW(20) - width * (self.detailInfo.lineArray.count - i);
        line2Button.frame = CGRectMake(x,  ScaleH(240), width, ScaleH(20));
        [view addSubview:line2Button];
        line2Button.adjustsImageWhenHighlighted = NO;//高亮时颜色不变
        [line2Button setBackgroundImage:[UIImage imageNamed:@"activate"] forState:UIControlStateSelected];
        [line2Button setTitleColor:HEXCOLOR(0x868686) forState:UIControlStateNormal];
        [line2Button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateSelected];
        [line2Button setTitle:[self getBtnTitleWithIndex:i] forState:UIControlStateNormal];
        [line2Button.titleLabel setFont:WLFontSize(14)];
        line2Button.tag = i;
        [line2Button addTarget:self action:@selector(changeLineInfo:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            line2Button.selected = YES;
            self.selectedButton = line2Button;
        }
    }
    
    UIImageView *lineImageView = [[UIImageView alloc] init];
    CGFloat lineWidth = ScaleH(120);
    lineImageView.frame = CGRectMake(7, lineWidth, view.width - 7, 2);
    lineImageView.image = [self drawLineByImageView:lineImageView];
    [view addSubview:lineImageView];
    _lineImageView = lineImageView;

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


-(void)changeLineInfo:(UIButton *)button{
    if (self.detailInfo.lineArray.count >= 2) {
        
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
        self.lineInfo = [self.detailInfo.lineArray objectAtIndex:button.tag];
        
        
    }
}

- (NSString *)getBtnTitleWithIndex:(NSUInteger)index
{
    NSString *title = @"线路一";
    if (index == 1) {
        title = @"线路二";
    }else if (index == 2) {
        title = @"线路三";
    }else if (index == 3) {
        title = @"线路四";
    }else if (index == 4) {
        title = @"线路五";
    }else if (index == 5) {
        title = @"线路六";
    }else if (index == 6) {
        title = @"线路七";
    }
    return title;
}
@end
