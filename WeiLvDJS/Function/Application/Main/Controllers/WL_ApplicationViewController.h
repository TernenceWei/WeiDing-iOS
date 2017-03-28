//
//  WL_ApplicationViewController.h
//  WeiLvDJS
//
//  Created by jyc on 16/8/25.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@interface WL_ApplicationViewController : WL_BaseViewController

/** 当前所选公司id */
@property(nonatomic, copy) NSString *company_id;
/** 1 为首页点击跳转, 其余值为正常跳转 */
@property(nonatomic, assign) NSInteger type;


@end
