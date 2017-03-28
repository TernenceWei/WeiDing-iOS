//
//  WSDeviceTool.h
//  Tools
//
//  Created by ternence on 16/11/20.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DeviceType) {
    iPhone,
    iPhone3G,
    iPhone3GS,
    iPhone4,
    iPhone4S,
    iPhone5,
    iPhone5C,
    iPhone5S,
    iPhone6,
    iPhone6plus,
    iPhone6S,
    iPhone6SPlus,
    iPhone7,
    iPhone7Plus,
    iPad,
    iPad2,
    iPad3,
    iPad4,
    iPadAir,
    iPadAir2,
    iPadMini,
    iPadMini2,
    iPadMini3,
    iPodTouch,
    iPodTouch2G,
    iPodTouch3G,
    iPodTouch4G,
    iPodTouch5G,
    iPodTouch6G,
    otherType,
    
};

@interface WSDeviceTool : NSObject

/**获取当前设备型号(枚举)*/
+ (DeviceType)getCurrentDeviceType;

/**获取当前设备型号标识(字符串)*/
+ (NSString *)getCurrentDeviceString;

/**获取当前iOS系统版本*/
+ (NSString *)getCurrentSystemVersion;

/**获取当前设备的磁盘总容量(单位G)*/
+ (double)getCurrentDeviceDiskTotalSize;

/**获取当前设备的磁盘使用容量(单位G)*/
+ (double)getCurrentDeviceDiskUsingSize;

/**获取当前设备的磁盘剩余容量(单位G)*/
+ (double)getCurrentDeviceDiskFreeSize;

/**获取内存总容量(单位M)*/
+ (NSUInteger)getTotalMemory;

/**获取当前使用内存容量(单位M)*/
+ (NSUInteger)getUsingMemory;

/**是否打开定位开关*/
+ (BOOL)locationSwitchIsOn;

/**是否打开后台应用程序刷新开关*/
+ (BOOL)backgroundRefreshSwitchIsOn;

/**获取语言标识*/
+ (NSString*)getLanguageCountryCode;
@end
