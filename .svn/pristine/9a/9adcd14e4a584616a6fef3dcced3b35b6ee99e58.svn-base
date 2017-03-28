//
//  WL_AccountHeaderView.h
//  WeiLvDJS
//
//  Created by jyc on 16/9/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"
#import "WLFundAccountObject.h"

@interface WL_AccountHeaderView : WL_BaseView

typedef NS_ENUM(NSInteger, ActionType){
    ActionTypeBack         = 0,//返回
    ActionTypeBalance      = 1,//余额
    ActionTypeFrozenAmount = 2,//冻结金额
};

typedef NS_ENUM(NSInteger, HeaderType){
    HeaderTypeAccountHome         = 0,//资金账户首页
    HeaderTypeFrozenPage          = 1,//冻结页面
};

- (instancetype)initWithFrame:(CGRect)frame
                   headerType:(HeaderType)headerType
                       action:(void(^)(ActionType type))action;

@property (nonatomic, strong) WLFundAccountObject *model;

- (void)refreshFrozenCount:(NSString *)price;
@end
