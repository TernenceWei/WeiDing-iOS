//
//  WL_Application_addListMoney_TableViewCell.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_addListMoney_TableViewCell.h"

@implementation WL_Application_addListMoney_TableViewCell

//- (void)awakeFromNib {
//    // Initialization code
//}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    
    return  self;
}

-(void)creatView
{
    CGFloat heightView;
    if (ScreenWidth>320) {
        
        heightView = 50;
    }
    else
    {
        heightView = 45;
    }
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, ScreenWidth, heightView);
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UIImageView *addImage =[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-107)/2,(heightView-13)/2, 13, 13)];
    
    addImage.image =[UIImage imageNamed:@"addQuote"];
    
    [view addSubview:addImage];
    
    //添加新的报价方式
    UILabel *labelTitle = [[UILabel alloc] init];
    labelTitle.frame = CGRectMake(ViewRight(addImage)+10, 0, 84, heightView);
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.font = WLFontSize(14);
    labelTitle.text = @"添加报价方式";
    labelTitle.textColor = [WLTools stringToColor:@"#4977e7"];
    [view addSubview:labelTitle];
 
    view.userInteractionEnabled = YES;
    //增加手势
    UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addListTap)];
    [view addGestureRecognizer:tapClick];

    }
-(void)setADdListView
{
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)addListTap
{
    if (_addListBlock) {
        self.addListBlock();
    }
}

@end
