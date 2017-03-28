//
//  WL_AddPersonCollectionViewCell.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_AddPersonCollectionViewCell.h"

@implementation WL_AddPersonCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
    }

    return self;
}

-(void)setUp
{
    
    self.headerImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width ,self.frame.size.height)];
    
    self.headerImageView.layer.cornerRadius = self.frame.size.width/2;
    
    //self.headerImageView.backgroundColor =[UIColor redColor];
    
    [self.contentView addSubview:self.headerImageView];
}
@end
