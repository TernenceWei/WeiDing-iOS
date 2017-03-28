//
//  WL_Mine_PersonInfo_changeInfo_ViewController.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/12.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
@class WL_Mine_PersonInfo_changeInfo_ViewController;
@protocol WL_Mine_PersonInfo_changeInfo_ViewControllerDelegate <NSObject>

-(void)changeBack_infor:(WL_Mine_PersonInfo_changeInfo_ViewController *)Vc Str:(NSString *)strImage index:(NSIndexPath *)Pathindex;

@end

@interface WL_Mine_PersonInfo_changeInfo_ViewController : WLBaseNavigationController
@property(nonatomic,copy)NSString *PersonStr;
@property(nonatomic,strong)NSIndexPath *path;

@property(nonatomic,assign)id<WL_Mine_PersonInfo_changeInfo_ViewControllerDelegate>delegate;
@end
