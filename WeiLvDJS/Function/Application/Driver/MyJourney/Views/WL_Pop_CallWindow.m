//
//  WL_Pop_CallWindow.m
//  WeiLvDJS
//
//  Created by jyc on 16/9/28.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Pop_CallWindow.h"

@interface WL_Pop_CallWindow ()
@property(nonatomic,strong)UILabel *roleDetailLabel;
@property(nonatomic,strong)UILabel *callNameLabel;

@property(nonatomic,strong)UILabel *telphoneNumber;

@end


@implementation WL_Pop_CallWindow

-(instancetype)initWithFrame:(CGRect)frame

{
    if (self =[super initWithFrame:frame]) {
        
       
      self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
      UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRemove)];
    
        
      [self addGestureRecognizer:tap];
        
      [self setUp];
        
    }
    return self;
}

-(void)setUp
{

    UIView *whiteView =[UIView new];
    
    whiteView.backgroundColor =[UIColor whiteColor];
    
    [whiteView setFrame:CGRectMake((ScreenWidth-280)/2, 190, 280, 270)];
    
    whiteView.layer.cornerRadius =3.0;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWhiteView)];
    
    [whiteView addGestureRecognizer:tap];
    
    [self addSubview:whiteView];
    
    UILabel *topLabel =[UILabel new];
    
    [topLabel setFrame:CGRectMake(0, 0, 280, 50)];
    
    topLabel.font =WLFontSize(17);
    
    topLabel.backgroundColor = WLColor(136, 143, 248, 1);
    
    topLabel.textAlignment = NSTextAlignmentCenter;
    
    topLabel.textColor =[UIColor whiteColor];
    
    topLabel.text = @"名片";
    
    [whiteView addSubview:topLabel];
    
    UILabel *left =[[UILabel alloc]initWithFrame:CGRectMake(35, ViewBelow(topLabel)+25, 50, 30)];
    
    left.textColor = BlackColor;
    
    left.font =WLFontSize(14);
    
    left.textAlignment = NSTextAlignmentLeft;
    
    left.text = @"角色";
    
    [whiteView addSubview:left];
    
    self.roleDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(left)+50, ViewY(left), 280-80-80-10, 30)];
    
    self.roleDetailLabel.font =WLFontSize(14);
    
    self.roleDetailLabel.textColor = [WLTools stringToColor:@"#868686"];
    
    self.roleDetailLabel.text = @"主导游";
    
    self.roleDetailLabel.textAlignment = NSTextAlignmentLeft;
    
    [whiteView addSubview:self.roleDetailLabel];
    
    UILabel *center =[[UILabel alloc]initWithFrame:CGRectMake(35, ViewBelow(left)+20, 50, 30)];
    
    center.textColor = BlackColor;
    
    center.font =WLFontSize(14);
    
    center.textAlignment = NSTextAlignmentLeft;
    
    center.text = @"称呼";
    
    [whiteView addSubview:center];
    
    
    self.callNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(center)+50, ViewY(center), 280-80-50-10, 30)];
    
    self.callNameLabel.font =WLFontSize(14);
    
    self.callNameLabel.text =@"张丹";
    
    self.callNameLabel.textColor = [WLTools stringToColor:@"#868686"];
    
    self.callNameLabel.textAlignment = NSTextAlignmentLeft;
    
    [whiteView addSubview:self.callNameLabel];
    
    UILabel *bottom =[[UILabel alloc]initWithFrame:CGRectMake(35, ViewBelow(center)+20, 50, 30)];
    
    bottom.textColor = BlackColor;
    
    bottom.font =WLFontSize(14);
    
    bottom.textAlignment = NSTextAlignmentLeft;
    
    bottom.text = @"电话";
    
    [whiteView addSubview:bottom];

    
    self.telphoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(bottom)+50, ViewY(bottom), 280-80-50-10,30)];
    
    self.telphoneNumber.font =WLFontSize(14);
    
    self.telphoneNumber.textColor = [WLTools stringToColor:@"#868686"];
    
    self.telphoneNumber.textAlignment = NSTextAlignmentLeft;
    
    self.telphoneNumber.text =@"1855235415";
    
    [whiteView addSubview:self.telphoneNumber];
    
    UIButton *callButton =[UIButton new];
    
    [callButton setFrame:CGRectMake(40, ViewBelow(bottom)+20, 70, 25)];
    
    [callButton setTitle:@"拨打电话" forState:UIControlStateNormal];
    
    [callButton setBackgroundColor:[WLTools stringToColor:@"#879efa"]];
    
    callButton.layer.cornerRadius =12.5;
    
    callButton.layer.masksToBounds =YES;
    
    callButton.userInteractionEnabled = YES;
    
    callButton.tag =101;
    
    callButton.titleLabel.font =WLFontSize(14);
    
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [callButton addTarget:self action:@selector(callButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteView addSubview:callButton];
    
    
    UIButton *messageButton =[[UIButton alloc]init];
    
    [messageButton setFrame:CGRectMake(ViewRight(callButton)+60, ViewBelow(bottom)+20, 70, 25)];
    
    messageButton.layer.cornerRadius =12.5;
    
    messageButton.layer.masksToBounds =YES;
    
    [messageButton setTitle:@"发私信" forState:UIControlStateNormal];
    
    [messageButton setBackgroundColor:[WLTools stringToColor:@"#69c95f"]];
    
    messageButton.titleLabel.font =WLFontSize(14);
    
    messageButton.tag =102;
    
    messageButton.userInteractionEnabled =YES;
    
    [messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [messageButton addTarget:self action:@selector(callButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteView addSubview:messageButton];
}


-(void)callButton:(UIButton *)button

{
    
    if (button.tag==101) {
    
        [self showCall];
        
        [self removeFromSuperview];
    
    }else if (button.tag==102)
    {
        [self removeFromSuperview];
    }

}

-(void)tapWhiteView
{
    
}

-(void)tapRemove
{
    
    [self removeFromSuperview];

}

-(void)setGuide_Model:(WL_Application_Driver_OrderDetail_Guide_Model *)guide_Model
{
    
    _guide_Model = guide_Model;
    
    self.isTour = YES;
    
    self.callNameLabel.text = guide_Model.staff_name;
    
    self.telphoneNumber.text =guide_Model.mobile;
    
    self.roleDetailLabel.text =@"主导游";
}
-(void)setDispatcher_Model:(WL_Application_Driver_OrderDetail_Dispatcher_Model *)dispatcher_Model
{
    _dispatcher_Model = dispatcher_Model;
    
    self.isTour = NO;
    
    self.callNameLabel.text = dispatcher_Model.staff_name;
    
    self.telphoneNumber.text =dispatcher_Model.user_mobile;
    
    self.roleDetailLabel.text =@"计调";
}
-(void)showCall
{
    
    if (self.isTour)
    {
       
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.guide_Model.mobile]];
        
        [[UIApplication sharedApplication]openURL:phoneURL];
        
    }else
    {
        
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.dispatcher_Model.user_mobile]];
        
        [[UIApplication sharedApplication]openURL:phoneURL];
    }
    
    
}
@end
