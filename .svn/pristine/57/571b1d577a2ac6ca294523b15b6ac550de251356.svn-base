//
//  WL_SectionIndexView.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//   右侧索引列表

#import "WL_BaseView.h"

@protocol sectionIndexViewDelegate <NSObject>

-(void)didSelectCellIndex:(NSIndexPath *)indexPath;

@end

@interface WL_SectionIndexView : WL_BaseView

-(instancetype)initWithFrame:(CGRect)frame andSectionArray:(NSMutableArray *)array;

@property(nonatomic,weak)id<sectionIndexViewDelegate> delegate;
@end
