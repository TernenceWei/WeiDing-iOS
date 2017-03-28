//
//  WL_Application_AddCarListInfo_TableViewCell.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_AddCarListInfo_TableViewCell.h"

@implementation WL_Application_AddCarListInfo_TableViewCell

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
    CGFloat height,width,cireHeight,topHeight;
    if (ScreenWidth>320) {
        height = 25;
        cireHeight = 50;
        topHeight = 5;
        width = 25;
    }
    else{
        cireHeight = 45;
        topHeight = 5;
        height = 22;
        width = 22;
    }

    //右边标题
    
    _rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(100), 0, ScaleW(ScreenWidth-130), cireHeight)];
    _rightTitle.textAlignment = NSTextAlignmentRight;
    _rightTitle.textColor = Color3;
    _rightTitle.numberOfLines = 1;
    _rightTitle.text = @"";
    _rightTitle.hidden = NO;
    _rightTitle.font = WLFontSize(14);
    [self addSubview:_rightTitle];
    //图片
    
    //跳转按钮
    _nextImage = [[UIImageView alloc] init];
    _nextImage.frame = CGRectMake(ScreenWidth-20, cireHeight/2-9, 11, 18);
    _nextImage.image = [UIImage imageNamed:@"arrow"];
    [self addSubview:_nextImage];
}
-(void)setADdListView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, ScreenWidth, self.height);
    view.backgroundColor = [UIColor redColor];
    [self addSubview:view];
    _nextImage.hidden = YES;
    _rightTitle.hidden = YES;
    view.userInteractionEnabled = YES;
    //增加手势
    UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addListTap)];
    [view addGestureRecognizer:tapClick];
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
