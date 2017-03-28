//
//  WLFundAccountCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/12/15.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLFundAccountCellModel : NSObject
@property (nonatomic, strong) NSString *iconImage;
@property (nonatomic, strong) NSString *leftTitle;
@property (nonatomic, strong) NSString *rightTitle;
+ (instancetype)modelWithIconImage:(NSString *)iconImage
                         leftTitle:(NSString *)leftTitle
                        rightTitle:(NSString *)rightTitle;
@end

@interface WLFundAccountCell : UITableViewCell
+ (WLFundAccountCell *)cellWithTableView:(UITableView*)tableView;
@property (nonatomic, strong) WLFundAccountCellModel *cellModel;
- (void)setTitleArray:(NSArray *)titleArray;
@end
