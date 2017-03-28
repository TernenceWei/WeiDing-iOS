//
//  WL_ContactIndex_View.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_ContactIndex_View : WL_BaseView

//数据源
@property (nonatomic,strong)NSArray *dataSource;

@property (nonatomic,copy) void(^SelectIndex)(NSInteger index);

@end
