//
//  WLSetOrderCellTableViewCell.h
//  WeiLvDJS
//
//  Created by xiaobai2268 on 2016/10/31.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLSetOrderCellTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *dateImage;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UIButton *orderButton;

@property(nonatomic,strong)UIButton *rejectButton;


@property(nonatomic,copy)void (^rejectAndOrderButton)(NSString *type);

@end
