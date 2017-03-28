//
//  WL_Application_Driver_inforMation_TableViewCell2.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//
//[应用]->[司机]->[司机资料驾照和身份证]
#import <UIKit/UIKit.h>
typedef void (^ImageViewTapClick)(NSInteger tag);
@interface WL_Application_Driver_inforMation_TableViewCell2 : UITableViewCell
@property(nonatomic,strong)UIImageView *imageView1;//第一张
@property(nonatomic,strong)UIImageView *imageView2;//第二张
@property(nonatomic,strong)UILabel *label1;//
@property(nonatomic,strong)UILabel *label2;//
@property(nonatomic,copy)ImageViewTapClick imageViewBack;
-(void)setTextStr:(NSIndexPath *)path;

@end
