//
//  WSRegexTool.h
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSRegexTool : NSObject
//邮箱格式验证
+(BOOL)judgeEmail:(NSString *)email;

//身份证号验证
+ (BOOL)validateIDCardNumber:(NSString *)value;

//手机号验证
+(BOOL)isMobileNumber:(NSString *)mobileNum;

//符合规定的支付密码
+(BOOL)isPassWordNumber:(NSString *)passWordNumber;

//  判断是否是年月日格式
+(BOOL)isDateYYMMDD:(NSString *)dateStr;

//  判断是否是中文汉字
+(BOOL)IsChinese:(NSString *)str;

//  判断是否是QQ
+(BOOL)isQQ:(NSString *)QQStr;

//  判断是否是座机
+(BOOL)isTelephoneNumber:(NSString *)telephoneNumber;

//  判断是是否是真实姓名
+(BOOL)isRealName:(NSString *)realName;

//  判断是是否是军官证
+(BOOL)isMilitaryOfficer:(NSString *)militaryOfficer;

//  判断是是否是护照
+(BOOL)isPassport:(NSString *)passport;

//  判断是是否是港澳证件

+(BOOL)isHongKong_CardReg:(NSString *)hongKong_CardReg;

//  判断是是否是台湾证件

+(BOOL)isTaiWan:(NSString *)taiWan;
@end
