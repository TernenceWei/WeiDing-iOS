//
//  WL_Application_Car_Company_TableViewCell.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WL_Application_carListInformation_Bom_model;
typedef void (^HeadImageTapClick)(NSIndexPath *indexPath);
@interface WL_Application_Car_Company_TableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *HeadImageView;//选择标示
@property(nonatomic,strong)UILabel *companyTitle;//公司
@property(nonatomic,strong)UILabel *isFristImageView;//首次提交与否
@property(nonatomic,strong)NSIndexPath *index;
@property(nonatomic,copy)HeadImageTapClick HeadimageViewBack;
@property(nonatomic,assign)BOOL isADD;
-(void)setBom_model:(WL_Application_carListInformation_Bom_model *)model_bom with:(NSMutableArray *)titleArr isChange:(BOOL)isChange;
@end
