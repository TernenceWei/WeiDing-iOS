//
//  WL_Application_Driver_AcceptOrderTipView.h
//  WeiLvDJS
//
//  Created by whw on 16/12/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WL_Application_Driver_AcceptOrderTipView : UIView

/**< 底部选择按钮的回调 */
@property (nonatomic, copy) void(^seletedCallBack)(BOOL isAccept);
@end
