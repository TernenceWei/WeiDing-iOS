//
//  SystemDefines.h
//  WeiLv
//  
//  Created by James on 15/12/17.
//  Copyright © 2015年 WeiLv Technology. All rights reserved.
//


/***********************************  日志 ***************************************************************/
//自定义日志输出宏
//#if (DEBUG || TESTCASE)
//    #define WlLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//    #define WlLog(...)
//#endif
#ifdef DEBUG

#define WLString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define WlLog(...) printf(" %s 第%d行: %s\n\n", [WLString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define WlLog(...)
#endif

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
/************************************************************************************************************/


/***********************************  屏幕尺寸、视图坐标 ***************************************************************/
//屏幕相关
#define AppWindow ([UIApplication sharedApplication].keyWindow)
#define WindowContent  ([[UIScreen mainScreen] bounds])
#define ScreenSize      [UIScreen mainScreen].bounds.size
#define ScreenWidth     ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight    ([[UIScreen mainScreen] bounds].size.height)
#define ScreenMaxLength (MAX(ScreenWidth,ScreenHeight))
#define ScreenMinLength (MIN(ScreenWidth,ScrrenHeight))
#define NavHeight (self.navigationController.navigationBar.frame.size.height+20)

//各屏幕尺寸比例
#define autoSizeScaleX  (([[UIScreen mainScreen] bounds].size.height)>480 ? ([[UIScreen mainScreen] bounds].size.width)/320 : 1.0)
#define autoSizeScaleY  (([[UIScreen mainScreen] bounds].size.height)>480 ? ([[UIScreen mainScreen] bounds].size.height)/568 : 1.0)

#define AUTO_IPHONE6_HEIGHT_667 ScreenHeight/667
#define AUTO_IPHONE6_WIDTH_375  ScreenWidth/375

#define ScaleW(width)  width*ScreenWidth/375
#define ScaleH(height) height*ScreenHeight/667

#define RectX(x)                            x*autoSizeScaleX
#define RectY(y)                            y*autoSizeScaleY
#define RectWidth(width)                    width*autoSizeScaleX
#define RectHeight(height)                  height*autoSizeScaleY
#define RectFontSize(x)                     (SCREEN_MAX_LENGTH == 736.0 ? [UIFont systemFontOfSize:x*1.5] : [UIFont systemFontOfSize:x])

//视图布局坐标相关
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewWidth                       self.view.bounds.size.width
#define SelfViewHeight                      self.view.bounds.size.height

#define ViewBelow(v)                        (v.frame.size.height + v.frame.origin.y)
#define ViewRight(v)                        (v.frame.size.width + v.frame.origin.x)

#define ControllerViewHeight              ([[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.navigationController.navigationBar.frame.size.height)

//高度比例(以iPhone6为准)
#define  HeightScale windowContentWidth/375

//距离左边距离
#define Begin_X 10
#define bordColor  [WLTools stringToColor:@"#d8d9dd"]
//[UIColor colorWithRed:219/255.0 green:217/255.0 blue:216/255.0 alpha:1]    //灰色边框
//系统字体对应字号
#define systemFont(x) [UIFont systemFontOfSize:x]
/************************************************************************************************************/



/***********************************  颜色  ***************************************************************/
//颜色
#define WLColor(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

//由十六进制转换成是十进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define BgViewColor  [WLTools stringToColor:@"#f2f2f2"]

#define GrayColor  WLColor(176, 183, 193, 1)

#define BlackColor  [WLTools stringToColor:@"#2f2f2f"]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]


/************************************************************************************************************/

/***********************************  字体  ***************************************************************/
#define WLFontSize(s) [UIFont systemFontOfSize:s]
/************************************************************************************************************/

/***********************************  设备类型判断  ***************************************************************/
#define IsiPad          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsiPhone        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsRetain        ([[UIScreen mainScreen] scale] >= 2.0)

#define IsiPhone4       (IsiPhone && ScreenMaxLength < 568.0)
#define IsiPhone5       (IsiPhone && ScreenMaxLength == 568.0)
#define IsiPhone6       (IsiPhone && ScreenMaxLength == 667.0)
#define IsiPhone6P      (IsiPhone && ScreenMaxLength == 736.0)
/************************************************************************************************************/


/***********************************  图片  ***************************************************************/
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//建议使用前两种宏定义,性能高于后者
/************************************************************************************************************/


/***********************************  版本更新  ***************************************************************/
//YES:检测更新 NO：不检查更新
#define isCheckUpage              @"YES"

//1：立即更新 2：可选更新
#define ForceUpdate                @"1"

//微旅appID
#define WeiLvAppID                 @"1096078343"

//微旅名称
#define WeiLvAppName               @"微旅管家"

//更新版本标题
#define WeiLvAlertViewTitle        @"检查更新"

//更新版本-取消按钮
#define WeiLvCancelButtonTitle     @"稍后更新"

//更新版本-更新按钮
#define WeiLvUpdateButtonTitle     @"立即更新"

/************************************************************************************************************/



/**********************************  常用宏定义  ***************************************************************/
//获取当前iOS系统版本号
#define SystemVersion   [[[UIDevice currentDevice] systemVersion] floatValue]

//获取当前APP版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//沙盒路径
#define GetHomePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

//获取当前window
#define AppWindow ([UIApplication sharedApplication].keyWindow)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

//由角度获取弧度
#define degreesToRadian(x) (M_PI * (x) / 180.0)

//由弧度获取角度
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif
/************************************************************************************************************/



