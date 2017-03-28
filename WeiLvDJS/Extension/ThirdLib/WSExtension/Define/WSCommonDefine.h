//
//  WSCommonDefine.h
//  Tools
//
//  Created by ternence on 16/11/20.
//  Copyright © 2016年 ternence. All rights reserved.
//

#ifndef WSCommonDefine_h
#define WSCommonDefine_h

#define BASE_HEIGTH 1334.0f
#define BASE_WIDTH 750.0f
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
#define ConvertByWidth(length) (length*SCREEN_WIDTH/BASE_WIDTH)
#define ConvertByHeight(length) (length*SCREEN_HEIGHT/BASE_HEIGTH)

#define CHECK_Nil(object)  ((object == nil) ? @"" : object)

#ifdef DEBUG
#define WSLog(...) NSLog(__VA_ARGS__)
#else
#define WSLog(...)
#endif

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] < 8.0)

// 日志输出宏
#define BASE_LOG(cls,sel) WlLog(@"%@-%@",NSStringFromClas(cls),NSStringFromSelector(sel))
#define BASE_ERROR_LOG(cls,sel,error) WlLog(@"ERROR:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),error)
#define BASE_INFO_LOG(cls,sel,info) WlLog(@"INFO:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),info)

// 日志输出函数
#if (DEBUG || TESTCASE)
#define BASE_LOG_FUN(self,_cmd)           BASE_LOG([self class],_cmd)
#define BASE_ERROR_FUN(self,_cmd,error)   BASE_ERROR_LOG([self class],_cmd,error)
#define BASE_INFO_FUN(self,_cmd,info)     BASE_INFO_LOG([self class],_cmd,info)
#else
#define BASE_LOG_FUN(self,_cmd)
#define BASE_ERROR_FUN(self,_cmd,error)
#define BASE_INFO_FUN(self,_cmd,info)
#endif




#endif /* WSCommonDefine_h */
