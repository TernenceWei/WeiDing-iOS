//
//  WLApplicationGuidePriceDetailTableViewCell.h
//  WeiLvDJS
//
//  Created by whw on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLApplicationGuidePriceDetailTableViewCell : UITableViewCell


@end

@interface WLApplicationGuidePriceDetailTableViewCell()<UITextViewDelegate>



@property(nonatomic, strong)UILabel *label;

@property(nonatomic, strong) UILabel * chooseTypelabel;

@property(nonatomic, strong)XKPEPlaceholderTextView *textView;

@property (nonatomic, strong) UIImageView *nextImageView;

@end

