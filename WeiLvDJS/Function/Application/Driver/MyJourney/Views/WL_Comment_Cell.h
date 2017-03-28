//
//  WL_Comment_Cell.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/26.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WL_Comment_Cell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong)UIImageView *commentImage;

@property(nonatomic,strong)UILabel *commentLabel;

@property(nonatomic,strong)UITextView *commentTextView;

@property(nonatomic,strong)UILabel *placeHoderLabel;

@end
