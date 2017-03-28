//
//  WL_Application_addCarPhoto_TableViewCell.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_Application_addCarPhoto_TableViewCell.h"
#import "WL_Application_CarAddPhoto_CollectionViewCell.h"

@implementation WL_Application_addCarPhoto_TableViewCell

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
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, ScreenWidth-10, 25);
    label.textAlignment = NSTextAlignmentLeft;
    label.font = WLFontSize(12);
    label.text = @"图片信息(至少1张车外整体照片(车牌清晰),1张车内照片)";
    label.textColor = [WLTools stringToColor:@"#868686"];
    [self addSubview:label];
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
    //1.先创建一个UIcollectionViewFlowLayout(是集合视图的核心)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.对layout做一些基本设置
    if (ScreenWidth>320) {
        layout.itemSize = CGSizeMake(60, 60);
        
    }
    else
    {
        layout.itemSize = CGSizeMake(50, 50);
    }
    
    self.PhotoCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 25, ScreenWidth, 80) collectionViewLayout:layout];
    self.PhotoCollectView.backgroundColor = [UIColor whiteColor];
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.PhotoCollectView.showsHorizontalScrollIndicator = NO;
    [self.PhotoCollectView registerClass:[WL_Application_CarAddPhoto_CollectionViewCell class] forCellWithReuseIdentifier:@"CarPhotoCell"];
    [self addSubview:self.PhotoCollectView];
    self.userInteractionEnabled = YES;
    
}
//添加图片
-(void)addUIimageView:(NSMutableArray *)imageArr
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
