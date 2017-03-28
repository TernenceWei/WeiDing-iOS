//
//  WLOneCardCell.h
//  WeiLvDJS
//
//  Created by ternence on 2017/1/10.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLOneCardCell : UITableViewCell

+ (WLOneCardCell *)cellWithTableView:(UITableView *)tableView;

- (void)setTextArray:(NSArray *)array isinvalid:(BOOL)isinvalid IndexPath:(NSIndexPath *)indexPath;

@end
