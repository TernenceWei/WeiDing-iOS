//
//  WL_AddressBook_SearchRecord_View.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/18.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_AddressBook_SearchRecord_View : WL_BaseView

@property(nonatomic, weak)UIButton *closeButton;
- (instancetype)initWithFrame:(CGRect)frame withArr:(NSMutableArray *)arr;

@end
