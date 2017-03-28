//
//  WL_AddFriendViewController_Cell.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/2.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WL_AddFriendViewController_Cell : UITableViewCell

@property (nonatomic,strong) UIImageView *leftImageVIew;
@property (nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong)UILabel *rightLabel;

@property(nonatomic,strong)UIImageView *rightImageVIew;
@property(nonatomic,strong)UIView *line;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie;



@end
