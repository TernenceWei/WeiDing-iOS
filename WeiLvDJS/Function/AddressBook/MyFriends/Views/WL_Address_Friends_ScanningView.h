//
//  WL_Address_Friends_ScanningView.h
//  WeiLvDJS
//
//  Created by whw on 16/12/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface WL_Address_Friends_ScanningView : UIView
/** 是否授权 */
@property (nonatomic, assign) BOOL isRestrict;
/** 设置动画 */
- (void)scanning;
/** 移除动画 */
- (void)removeScanningAnimations;
@end
