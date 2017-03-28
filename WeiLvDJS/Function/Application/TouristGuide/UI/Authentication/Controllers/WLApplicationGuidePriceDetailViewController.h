//
//  WLApplicationGuidePriceDetailViewController.h
//  WeiLvDJS
//
//  Created by whw on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@class WLPriceListObject;
@class WLApplicationGuidePriceDetailViewController;
//定义一个协议
@protocol WLApplicationGuidePriceDetailViewControllerDelegate <NSObject>
@optional
-(void)passPriceInformation:(WLApplicationGuidePriceDetailViewController *)VC mode:(NSString *)mode price:(NSUInteger)price unit:(NSString *)unit;
-(void)passPriceInformation:(WLApplicationGuidePriceDetailViewController *)VC obj:(WLPriceListObject *)obj;

@end

@interface WLApplicationGuidePriceDetailViewController : WL_BaseViewController

@property(nonatomic,assign)id<WLApplicationGuidePriceDetailViewControllerDelegate>delegate;

@property(nonatomic, strong)WLPriceListObject *priceList;

@end
