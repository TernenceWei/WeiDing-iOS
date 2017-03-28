//
//  WL_Mine_personInfo_changeSex_view.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Mine_personInfo_changeSex_view.h"

@implementation WL_Mine_personInfo_changeSex_view

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        // [self setView];
    }
    return self;
}

-(void)setView:(NSMutableArray *)arr
{
    CGFloat height;
    if (IsiPhone4||IsiPhone5) {
        height = 44;
    }
    else
    {
        height = 50;
    }
    if (arr.count==0) {
        self.hidden = YES;
        return;
    }
    //弹出框
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*0.1, ScreenHeight/2-76, ScreenWidth*0.8, height+arr.count*height)];
    _alertView.layer.masksToBounds = YES;
    _alertView.layer.cornerRadius = 3.0;
    _alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_alertView];
    self.alertView.center = self.center;
    //选择标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 0, _alertView.frame.size.width, height);
    _titleLabel.text = _isSEX==YES?@"选择性别":@"请选择公司";
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [WLTools stringToColor:@"#00cc99"];
    [_alertView addSubview:_titleLabel];
    //蓝色割线
    UILabel *line1 = [[UILabel alloc] init];
    line1.frame = CGRectMake(0, height+0.5, _alertView.frame.size.width, 0.5);
    line1.backgroundColor = [WLTools stringToColor:@"#00cc99"];
    
    [_alertView addSubview:line1];
    //要选择属性
    for (int i=0; i<arr.count; i++) {
        
        //        UIButton *label = [UIButton buttonWithType:UIButtonTypeSystem];
        //        label.frame = CGRectMake(0, 48+i*52, _alertView.width, 52);
        //        //label.textAlignment = NSTextAlignmentCenter;
        //        [label setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        //        [label setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //        [self.alertView addSubview:label];
        //        [label addTarget:self action:@selector(labelTapDownClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, height+i*height, _alertView.width, height);
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.text = [arr objectAtIndex:i];
        label.textColor = [UIColor grayColor];
        label.font = WLFontSize(17);
        [self.alertView addSubview:label];
        // 选择的事件
        UITapGestureRecognizer *tapDownGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChoseClick:)];
        [label addGestureRecognizer:tapDownGesture];
        
        if (i<arr.count-1) {
            UILabel *line1 = [[UILabel alloc] init];
            line1.frame = CGRectMake(0, height+(i+1)*height-1, _alertView.frame.size.width, 0.3);
            line1.backgroundColor = [UIColor grayColor];
            [_alertView addSubview:line1];
            
        }
        
    }
    
    
    //选择内容
    
    //点击空白的事件
    UITapGestureRecognizer *tapBackView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenFromSuperView)];
    [self addGestureRecognizer:tapBackView];
}

-(void)tapChoseClick:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    if (_titleBlick) {
        self.titleBlick(label.text);
    }
    
    NSLog(@"++++++++++++%@++++++++++++++",label.text);
}

-(void)labelTapDownClick:(UIButton *)btn
{
    if (_titleBlick) {
        self.titleBlick(btn.currentTitle);
    }
    //    NSLog(@"------%@----",btn.titleLabel.text);
    //    NSLog(@"------被点击的属性名是%@----",btn.currentTitle);
    
}

-(void)hiddenFromSuperView
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [self.layer addAnimation:animation forKey:nil];
    self.hidden = YES;
}
-(void)showFromSuperView
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [self.layer addAnimation:animation forKey:nil];
    self.hidden = NO;
    
}

@end
