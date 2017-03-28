//
//  WLMessageSearchView.m
//  WeiLvDJS
//
//  Created by ternence on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLMessageSearchView.h"

@implementation WLMessageSearchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor =[UIColor whiteColor];
        
        UILabel *tipLabel =[WLTools allocLabel:@"在这里可以搜到"
                                          font:WLFontSize(14)
                                     textColor:[UIColor grayColor]
                                         frame:CGRectMake((ScreenWidth-110)/2, 20, 110, 16)
                                 textAlignment:NSTextAlignmentCenter];
        [self addSubview:tipLabel];
        
        UILabel *line  =[WLTools allocLabel:@""
                                       font:nil
                                  textColor:nil
                                      frame:CGRectMake((ScreenWidth-150)/2, ViewBelow(tipLabel)+10, 150, 0.5)
                              textAlignment:NSTextAlignmentCenter];
        line.backgroundColor = bordColor;
        [self addSubview:line];
        
        CGFloat pad1 = (ScreenWidth -120)/3;
        CGFloat pad2 = (ScreenWidth -80)/3;
//        NSArray *titleArray =[NSArray arrayWithObjects:@"联系人",@"私信消息",@"平台公告",@"提醒", nil];
//        NSArray *imageArray =[NSArray arrayWithObjects:@"WDFriend", @"PrivateLetter",@"gonggao",@"Notice",nil];
        NSArray *titleArray =[NSArray arrayWithObjects:@"平台公告",@"提醒", nil];
        NSArray *imageArray =[NSArray arrayWithObjects:@"gonggao",@"Notice",nil];
        for (int i = 0; i < titleArray.count; i++) {
//            UIImageView *im =[[UIImageView alloc]initWithFrame:CGRectMake(50+i*pad1, ViewBelow(line)+15, 30, 26)];
             UIImageView *im =[[UIImageView alloc]initWithFrame:CGRectMake(50+(i+1)*pad1, ViewBelow(line)+15, 30, 26)];
            im.image = [UIImage imageNamed:imageArray[i]];
            [self addSubview:im];
            
//            UILabel *la =[[UILabel alloc]initWithFrame:CGRectMake(40+i*pad2, ViewBelow(im)+10, 60, 15)];
            UILabel *la =[[UILabel alloc]initWithFrame:CGRectMake(40+(i+1)*pad2, ViewBelow(im)+10, 60, 15)];
            la.centerX = im.centerX;
            la.font =WLFontSize(11);
            la.textColor = [UIColor grayColor];
            la.text = titleArray[i];
            la.textAlignment = NSTextAlignmentCenter;
            [self addSubview:la];
            
        }
    }
    return self;
}
@end
