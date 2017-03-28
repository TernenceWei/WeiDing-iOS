//
//  WSDeviceTool.m
//  Tools
//
//  Created by ternence on 16/11/20.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import "WSDeviceTool.h"
#import "sys/utsname.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <mach/task_info.h>
#include <mach/task.h>
#include <mach/thread_act.h>
#include <mach/vm_map.h>
#include <mach/mach_traps.h>
#include <mach/mach_init.h>
#include <mach/mach_host.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WSDeviceTool ()

@end

@implementation WSDeviceTool

/**
 *  获取当前设备型号(枚举)
 */
+ (DeviceType)getCurrentDeviceType
{
    NSString *deviceString = [self getCurrentDeviceString];
    if ([deviceString isEqualToString:@"iPhone1,1"]) {
        return iPhone;
    }else if ([deviceString isEqualToString:@"iPhone1,2"]){
        return iPhone3G;
    }else if ([deviceString isEqualToString:@"iPhone2,1"]){
        return iPhone3GS;
    }else if ([deviceString isEqualToString:@"iPhone3,1"]||
              [deviceString isEqualToString:@"iPhone3,2"]||
              [deviceString isEqualToString:@"iPhone3,3"]){
        return iPhone4;
    }else if ([deviceString isEqualToString:@"iPhone4,1"]){
        return iPhone4S;
    }else if ([deviceString isEqualToString:@"iPhone5,1"]||
              [deviceString isEqualToString:@"iPhone5,2"]){
        return iPhone5;
    }else if ([deviceString isEqualToString:@"iPhone5,3"]||
              [deviceString isEqualToString:@"iPhone5,4"]){
        return iPhone5C;
    }else if ([deviceString isEqualToString:@"iPhone6,1"]||
              [deviceString isEqualToString:@"iPhone6,2"]){
        return iPhone5S;
    }else if ([deviceString isEqualToString:@"iPhone7,2"]){
        return iPhone6;
    }else if ([deviceString isEqualToString:@"iPhone7,1"]){
        return iPhone6plus;
    }else if ([deviceString isEqualToString:@"iPhone8,2"]){
        return iPhone6SPlus;
    }else if ([deviceString isEqualToString:@"iPhone8,1"]){
        return iPhone6S;
    }else if ([deviceString isEqualToString:@"iPhone9,2"]){
        return iPhone7Plus;
    }else if ([deviceString isEqualToString:@"iPhone9,1"]){
        return iPhone7;
    }else if ([deviceString isEqualToString:@"iPad1,1"]){
        return iPad;
    }else if ([deviceString isEqualToString:@"iPad2,1"]||
              [deviceString isEqualToString:@"iPad2,2"]||
              [deviceString isEqualToString:@"iPad2,3"]||
              [deviceString isEqualToString:@"iPad2,4"]){
        return iPad2;
    }else if ([deviceString isEqualToString:@"iPad3,1"]||
              [deviceString isEqualToString:@"iPad3,2"]||
              [deviceString isEqualToString:@"iPad3,3"]){
        return iPad3;
    }else if ([deviceString isEqualToString:@"iPad3,4"]||
              [deviceString isEqualToString:@"iPad3,5"]||
              [deviceString isEqualToString:@"iPad3,6"]){
        return iPad4;
    }else if ([deviceString isEqualToString:@"iPad4,1"]||
              [deviceString isEqualToString:@"iPad4,2"]||
              [deviceString isEqualToString:@"iPad4,3"]){
        return iPadAir;
    }else if ([deviceString isEqualToString:@"iPad5,3"]||
              [deviceString isEqualToString:@"iPad5,4"]){
        return iPadAir2;
    }else if ([deviceString isEqualToString:@"iPad2,5"]||
              [deviceString isEqualToString:@"iPad2,6"]||
              [deviceString isEqualToString:@"iPad2,7"]){
        return iPadMini;
    }else if ([deviceString isEqualToString:@"iPad4,4"]||
              [deviceString isEqualToString:@"iPad4,5"]||
              [deviceString isEqualToString:@"iPad4,6"]){
        return iPadMini2;
    }else if ([deviceString isEqualToString:@"iPad4,7"]||
              [deviceString isEqualToString:@"iPad4,8"]||
              [deviceString isEqualToString:@"iPad4,9"]){
        return iPadMini3;
    }else if ([deviceString isEqualToString:@"iPod1,1"]){
        return iPodTouch;
    }else if ([deviceString isEqualToString:@"iPod2,1"]){
        return iPodTouch2G;
    }else if ([deviceString isEqualToString:@"iPod3,1"]){
        return iPodTouch3G;
    }else if ([deviceString isEqualToString:@"iPod4,1"]){
        return iPodTouch4G;
    }else if ([deviceString isEqualToString:@"iPod5,1"]){
        return iPodTouch5G;
    }else if ([deviceString isEqualToString:@"iPod7,1"]){
        return iPodTouch6G;
    }else{
        return otherType;
    }
}

/**
 *  获取当前设备型号标识(字符串)
 */
+ (NSString *)getCurrentDeviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

+ (NSString *)getCurrentDeviceStringForDeviceInfomationDetailPage
{
    DeviceType deviceType = [self getCurrentDeviceType];
    NSString *string;
    switch (deviceType) {
        case iPhone:
            string = @"iPhone";
            break;
        case iPhone3G:
            string = @"iPhone 3G";
            break;
        case iPhone3GS:
            string = @"iPhone 3GS";
            break;
        case iPhone4:
            string = @"iPhone 4";
            break;
        case iPhone4S:
            string = @"iPhone 4S";
            break;
        case iPhone5:
            string = @"iPhone 5";
            break;
        case iPhone5C:
            string = @"iPhone 5C";
            break;
        case iPhone5S:
            string = @"iPhone 5S";
            break;
        case iPhone6:
            string = @"iPhone 6";
            break;
        case iPhone6plus:
            string = @"iPhone 6 Plus";
            break;
        case iPhone6S:
            string = @"iPhone 6S";
            break;
        case iPhone6SPlus:
            string = @"iPhone 6S Plus";
            break;
        case iPhone7:
            string = @"iPhone 6S";
            break;
        case iPhone7Plus:
            string = @"iPhone 6S Plus";
            break;
        case iPad:
            string = @"iPad";
            break;
        case iPad2:
            string = @"iPad 2";
            break;
        case iPad3:
            string = @"iPad 3";
            break;
        case iPad4:
            string = @"iPad 4";
            break;
        case iPadAir:
            string = @"iPad Air";
            break;
        case iPadAir2:
            string = @"iPad Air2";
            break;
        case iPadMini:
            string = @"iPad Mini";
            break;
        case iPadMini2:
            string = @"iPad Mini2";
            break;
        case iPadMini3:
            string = @"iPad Mini3";
            break;
        case iPodTouch:
            string = @"iPod Touch";
            break;
        case iPodTouch2G:
            string = @"iPod Touch2G";
            break;
        case iPodTouch3G:
            string = @"iPod Touch3G";
            break;
        case iPodTouch4G:
            string = @"iPod Touch4G";
            break;
        case iPodTouch5G:
            string = @"iPod Touch5G";
            break;
        case iPodTouch6G:
            string = @"iPod Touch6G";
            break;
        case otherType:
            string = @"iPhone 8";
    }
    return string;
}

/**
 *  获取当前iOS系统版本
 */
+ (NSString *)getCurrentSystemVersion
{
    NSString *systemVision = [[UIDevice currentDevice] systemVersion];
    return systemVision;
}

/**
 *  获取当前设备的磁盘总容量(单位G)
 */
+ (double)getCurrentDeviceDiskTotalSize
{
    NSDictionary *diskDict = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    double totalSize = ((NSNumber*)[diskDict objectForKey:NSFileSystemSize]).doubleValue / 1024.0 * 1024.0 * 1024.0;
    return totalSize;
}

/**
 *  获取当前设备的磁盘剩余容量(单位G)
 */
+ (double)getCurrentDeviceDiskFreeSize
{
    NSDictionary *diskDict = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return ((NSNumber*)[diskDict objectForKey:NSFileSystemFreeSize]).doubleValue / 1024.0 * 1024.0 * 1024.0;
}

/**
 *  获取当前设备的磁盘使用容量(单位G)
 */
+ (double)getCurrentDeviceDiskUsingSize
{
    
    return ([self getCurrentDeviceDiskTotalSize] - [self getCurrentDeviceDiskFreeSize]);
}

/**
 *  获取内存总容量(单位M)
 */
+ (NSUInteger)getTotalMemory
{
    return [self getSysInfo:HW_PHYSMEM] / 1024.0 / 1024.0;
}

/**
 *  获取当前使用内存容量(单位M)
 */
+ (NSUInteger)getUsingMemory
{
    return [self getSysInfo:HW_USERMEM] / 1024.0 / 1024.0;
}

+ (NSUInteger)getSysInfo: (uint) typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

/**
 *  是否打开定位开关
 */
+ (BOOL)locationSwitchIsOn
{
    return [CLLocationManager locationServicesEnabled];
    
}

/**
 *  是否打开后台应用程序刷新开关
 */
+ (BOOL)backgroundRefreshSwitchIsOn
{
    if ([UIApplication sharedApplication].backgroundRefreshStatus == UIBackgroundRefreshStatusAvailable) {
        return true;
    }else{
        return false;
    }
}


+ (NSString*)getLanguageCountryCode{
    NSString* countryCode = nil;
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countrycode = [locale localeIdentifier];
    NSRange range = [countrycode rangeOfString:@"_"];
    if (range.location != NSNotFound) {
        NSUInteger location = range.location;
        countryCode = [countrycode substringFromIndex:location+1];
        countryCode = [countryCode lowercaseString];
    }
    
    countryCode = [countryCode uppercaseString];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSRange LanguageRange = [currentLanguage rangeOfString:@"-"];
    if (LanguageRange.location != NSNotFound) {
        NSUInteger location = LanguageRange.location;
        currentLanguage = [currentLanguage substringToIndex:location];
    }
    //系统版本 英文       简体       繁体       繁体香港  繁体台湾  印地语
    //iOS9    en-CN   zh-Hans-CN  zh-Hant-CN zh-HK   zh-TW    hi-CN
    //iOS8    en      zh-Hans    zh-Hant     zh-HK      无      hi
    
    NSString *special = [languages objectAtIndex:0];
    if ([special rangeOfString:@"zh-Hans"].location != NSNotFound) {
        return  @"zh-CN"; // 特殊处理 只要设置为简体就返回为 @"zh-CN" 服务器返回为简体中文文案
    } else if ([special rangeOfString:@"zh-"].location != NSNotFound) {
        return  @"zh-HK"; // 特殊处理 设置为繁体就返回  @"zh-HK" 服务器返回为英文文案
    }
    
    return  [NSString stringWithFormat:@"%@-%@",currentLanguage,countryCode];
}

@end
