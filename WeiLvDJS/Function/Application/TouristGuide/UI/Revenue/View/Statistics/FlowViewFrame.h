//
//  FlowViewFrame.h
//  PrivacyGuard
//
//  Created by Ternence on 15/8/4.
//  Copyright (c) 2015年 LEO. All rights reserved.
//

#ifndef PrivacyGuard_FlowViewFrame_h
#define PrivacyGuard_FlowViewFrame_h

// 2.获得RGB颜色
#define HHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HHColorWithAlpha(r, g, b, alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(alp)]

// 4.通用UI相关

#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
#define STATUSBAR_HEIGHT      [[UIApplication sharedApplication] statusBarFrame].size.height
#define ConvertByWidth(length) (length*SCREEN_WIDTH/BASE_WIDTH)
#define ConvertByHeight(length) (length*SCREEN_HEIGHT/BASE_HEIGTH)




#define flowGrowingView_bgColor [UIColor clearColor]
#define flowGrowingView_H ConvertByHeight(236)
#define flowGrowingView_topView_H ConvertByHeight(52)
#define flowGrowingView_bottomView_H ConvertByHeight(22)
#define flowGrowingView_growingView_H ConvertByHeight(162)

#define flowGrowingView_topView_leftNotice_X ConvertByWidth(12)
#define flowGrowingView_topView_leftNotice_Y ConvertByHeight(15)
#define flowGrowingView_topView_leftNotice_Color HHColorWithAlpha(255, 255, 255, 0.5)
#define flowGrowingView_topView_leftNotice_font [UIFont fontWithName:@"HelveticaNeue-Light" size:15]
#define flowGrowingView_topView_rightNotice_rightMargin ConvertByWidth(12)

#define flowGrowingView_bottomView_dayTextColor HHColor(255, 255, 255)
#define flowGrowingView_bottomView_dayTextFont [UIFont fontWithName:@"HelveticaNeue-Light" size:11]

#define flowGrowingView_growingView_dividerLine_Color HHColorWithAlpha(255, 255, 255, 0.1)
#define flowGrowingView_growingView_growingLine_Color HHColor(255, 255, 255)
#define flowGrowingView_growingView_flowCount_Color HHColor(255, 255, 255)
#define flowGrowingView_growingView_flowCount_Font [UIFont fontWithName:@"HelveticaNeue-Light" size:11]
#define flowGrowingView_growingView_flowCount_point_margin ConvertByHeight(12)

#define bottomView_H ConvertByHeight(239)
#define bottomView_usedView_H ConvertByHeight(199)
#define bottomView_settingBtn_X ConvertByWidth(24)
#define bottomView_settingBtn_W ConvertByWidth(272)
#define bottomView_settingBtn_H ConvertByHeight(40)
#define bottomView_settingBtn_font [UIFont fontWithName:@"HelveticaNeue-Light" size:16]
#endif
