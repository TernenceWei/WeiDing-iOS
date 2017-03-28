//
//  WL_Application_Driver_ChangeInformation_VC.h
//  WeiLvDJS
//
//  Created by liuxin on 16/9/19.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"
@class WL_Application_Driver_ChangeInformation_VC;
@protocol WL_Application_Driver_ChangeInformation_VCDelegate <NSObject>

-(void)changeDriverInformation:(WL_Application_Driver_ChangeInformation_VC *)VC Str:(NSString *)strImage index:(NSIndexPath *)path;

@end
@interface WL_Application_Driver_ChangeInformation_VC : WL_BaseViewController

@property(nonatomic,strong)NSString *sendStr;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSString *infoStr;

@property(nonatomic,assign)id <WL_Application_Driver_ChangeInformation_VCDelegate>delegate;
@end
