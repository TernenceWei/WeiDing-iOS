//
//  WL_Application_AddCarListInfo_TableViewCell.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^addTapClick)();
@interface WL_Application_AddCarListInfo_TableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *rightTitle;//资料属性的具体值
@property(nonatomic,strong)UIImageView *nextImage;
@property(nonatomic,copy)addTapClick addListBlock;
@property(nonatomic,assign)BOOL isAdd;
-(void)setADdListView;
@end
