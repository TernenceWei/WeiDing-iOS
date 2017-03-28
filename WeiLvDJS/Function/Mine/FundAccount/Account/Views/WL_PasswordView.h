
//
//  WL_PasswordView.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_PasswordView : WL_BaseView

-(instancetype)initWithFrame:(CGRect)frame
               passwordBlock:(void(^)(NSString *password))passwordBlock;

@end
