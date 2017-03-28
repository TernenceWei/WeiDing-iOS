//
//  WLApplicationGuideChangeInformatonViewController.h
//  WeiLvDJS
//
//  Created by whw on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@class WLApplicationGuideChangeInformatonViewController;
//定义一个协议
@protocol WLApplicationGuideChangeInformatonViewControllerDelegate <NSObject>

-(void)changeGuideInformation:(WLApplicationGuideChangeInformatonViewController *)VC str:(NSString *)strImage index:(NSIndexPath *)path;

@end



@interface WLApplicationGuideChangeInformatonViewController : WL_BaseViewController

@property(nonatomic, strong)NSString *senderStr;

@property(nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic, copy)NSString *infoStr;

@property(nonatomic, assign)id<WLApplicationGuideChangeInformatonViewControllerDelegate>delegate;

@end
