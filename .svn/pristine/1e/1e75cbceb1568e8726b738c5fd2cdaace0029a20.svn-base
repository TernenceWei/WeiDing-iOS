//
//  RegexTools.h
//  WeiLv
//
//  Created by lyx on 16/5/23.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexTools : NSObject

#pragma mark - 邮箱格式验证
+(BOOL)judgeEmail:(NSString *)email;

#pragma mark - 身份证号验证
+ (BOOL)validateIDCardNumber:(NSString *)value;

#pragma mark - 手机号验证
+(BOOL)isMobileNumber:(NSString *)mobileNum;

#pragma mark - 符合规定的支付密码
+(BOOL)isPassWordNumber:(NSString *)passWordNumber;

#pragma mark  判断是否是年月日格式
+(BOOL)isDateYYMMDD:(NSString *)dateStr;

#pragma mark  判断是否是中文汉字
+(BOOL)IsChinese:(NSString *)str;

#pragma mark  判断是否是QQ
+(BOOL)isQQ:(NSString *)QQStr;

#pragma mark  判断是否是座机
+(BOOL)isTelephoneNumber:(NSString *)telephoneNumber;

#pragma mark  判断是是否是真实姓名
+(BOOL)isRealName:(NSString *)realName;

#pragma mark  判断是是否是军官证
+(BOOL)isMilitaryOfficer:(NSString *)militaryOfficer;

#pragma mark  判断是是否是护照
+(BOOL)isPassport:(NSString *)passport;

#pragma mark  判断是是否是港澳证件

+(BOOL)isHongKong_CardReg:(NSString *)hongKong_CardReg;

#pragma mark  判断是是否是台湾证件

+(BOOL)isTaiWan:(NSString *)taiWan;

#pragma mark 判断是否全是数字
+(BOOL)isAllNumber:(NSString *)allNumberStr;
@end
