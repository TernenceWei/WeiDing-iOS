//
//  WL_SetOrder_Cell.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WL_SetOrder_Cell : UITableViewCell

@property(nonatomic,strong)UIImageView *dateImage;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UIButton *orderButton;

@property(nonatomic,strong)UIButton *rejectButton;


@property(nonatomic,copy)void (^rejectAndOrderButton)(NSString *type);



@end
