//
//  WL_Application_TourGuide_Picure_TableViewCell.h
//  WeiLvDJS
//
//  Created by whw on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^ImageViewTapClick)(NSInteger tag);
@interface WL_Application_TourGuide_Picure_TableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *imageView1;
@property(nonatomic, strong)UIImageView *imageView2;
@property(nonatomic, strong)UILabel *label1;
@property(nonatomic, strong)UILabel *label2;

@property(nonatomic,copy)ImageViewTapClick imageViewBack;

-(void)setTextStr:(NSIndexPath *)indexPath;

@end
