//
//  WL_Mine_personInfo_changeSex_view.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"
typedef void(^titleTapClick)(NSString *);

@interface WL_Mine_personInfo_changeSex_view : WL_BaseView

@property(nonatomic,assign)BOOL isSEX;
//弹出框
@property(nonatomic,strong)UIView *alertView;
//选择标题
@property(nonatomic,strong)UILabel *titleLabel;

//选择内容
@property(nonatomic,strong) UILabel *nameOfCompanyfrist;

@property(nonatomic,strong) UILabel *nameOfCompanysecond;

@property(nonatomic,copy)titleTapClick titleBlick;

-(void)setView:(NSMutableArray *)arr;
-(void)hiddenFromSuperView;//隐藏
-(void)showFromSuperView;//显示


@end
