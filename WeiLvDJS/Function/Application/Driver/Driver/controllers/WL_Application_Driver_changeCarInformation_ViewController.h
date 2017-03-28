//
//  WL_Application_Driver_changeCarInformation_ViewController.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/24.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
@class WL_Application_Driver_changeCarInformation_ViewController;
@protocol WL_Application_Driver_changeCarInformation_ViewControllerDelegate <NSObject>

-(void)changeCarInforMation:(WL_Application_Driver_changeCarInformation_ViewController *)VC Str:(NSString *)strImage index:(NSIndexPath *)pathIndex;

@end
@interface WL_Application_Driver_changeCarInformation_ViewController : WL_BaseViewController
@property(nonatomic,copy)NSString *bringStr;
@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,copy)NSString *infoStr;
@property(nonatomic,assign)id<WL_Application_Driver_changeCarInformation_ViewControllerDelegate>delegate;


@end
